from sqlalchemy.orm import Session
from sqlalchemy import text
from app.ml_services.predictor import predict_student_risk


def recalculate_student_risk(student_id: int, db: Session):

    # --------------------------------
    # 1. Calculate Attendance %
    # --------------------------------

    attendance = db.execute(
        text("""
        SELECT
            COUNT(*) as total_days,
            SUM(CASE WHEN status='PRESENT' THEN 1 ELSE 0 END) as present_days
        FROM attendance
        WHERE student_id = :sid
        """),
        {"sid": student_id}
    ).fetchone()

    total_days = attendance.total_days or 0
    present_days = attendance.present_days or 0

    if total_days == 0:
        attendance_percent = 100
    else:
        attendance_percent = (present_days / total_days) * 100

    absences = total_days - present_days


    # --------------------------------
    # 2. Calculate Marks %
    # --------------------------------

    marks = db.execute(
        text("""
        SELECT
            SUM(marks) as total_marks,
            SUM(max_marks) as total_max
        FROM marks
        WHERE student_id = :sid
        """),
        {"sid": student_id}
    ).fetchone()

    if marks.total_max:
        marks_percent = (marks.total_marks / marks.total_max) * 100
    else:
        marks_percent = 0

    g1 = marks_percent
    g2 = marks_percent


    # --------------------------------
    # 3. Other Features
    # --------------------------------

    studytime = 2
    failures = 0


    # --------------------------------
    # 4. Predict Risk
    # --------------------------------

    result = predict_student_risk(
        studytime,
        failures,
        absences,
        g1,
        g2
    )

    probs = result["probabilities"]


    # --------------------------------
    # 5. Save or Update Risk
    # --------------------------------

    existing = db.execute(
        text("""
        SELECT id FROM student_risk
        WHERE student_id = :sid
        """),
        {"sid": student_id}
    ).fetchone()


    if existing:

        db.execute(
            text("""
            UPDATE student_risk
            SET risk_level=:risk,
                prob_at_risk=:p0,
                prob_average=:p1,
                prob_good=:p2,
                updated_at=NOW()
            WHERE student_id=:sid
            """),
            {
                "sid": student_id,
                "risk": result["risk"],
                "p0": float(probs[0]),
                "p1": float(probs[1]),
                "p2": float(probs[2]),
            }
        )

    else:

        db.execute(
            text("""
            INSERT INTO student_risk
            (student_id, risk_level, prob_at_risk, prob_average, prob_good)
            VALUES (:sid, :risk, :p0, :p1, :p2)
            """),
            {
                "sid": student_id,
                "risk": result["risk"],
                "p0": float(probs[0]),
                "p1": float(probs[1]),
                "p2": float(probs[2]),
            }
        )

    db.commit()