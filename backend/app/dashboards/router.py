from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text
from typing import List

from database import get_db
from app.auth.dependencies import role_required
from app.dashboards.schemas import (
    StudentDashboardResponse,
    TeacherDashboardResponse,
    MarkItem,
)

router = APIRouter(
    prefix="/dashboard",
    tags=["Dashboards"]
)

# =================================================
# 🎓 STUDENT DASHBOARD (SECURE)
# =================================================
@router.get("/student/me", response_model=StudentDashboardResponse)
def get_student_dashboard(
    user=Depends(role_required("student")),
    db: Session = Depends(get_db)
):
    student_id = user["user_id"]

    # 1️⃣ Student details
    student = db.execute(
        text("""
            SELECT id AS student_id, student_name, course
            FROM students
            WHERE id = :student_id
        """),
        {"student_id": student_id}
    ).fetchone()

    if not student:
        raise HTTPException(status_code=404, detail="Student not found")

    # 2️⃣ Performance records
    records = db.execute(
        text("""
            SELECT subject, exam_type, marks, max_marks
            FROM performance
            WHERE student_id = :student_id
            ORDER BY created_at
        """),
        {"student_id": student_id}
    ).fetchall()

    if not records:
        raise HTTPException(status_code=404, detail="No performance data found")

    # 3️⃣ Metrics
    total_percentage = 0
    trend: List[float] = []
    marks_list: List[MarkItem] = []

    for r in records:
        percentage = (r.marks / r.max_marks) * 100
        total_percentage += percentage
        trend.append(round(percentage, 2))

        marks_list.append(
            MarkItem(
                subject=r.subject,
                exam_type=r.exam_type,
                marks=r.marks,
                max_marks=r.max_marks
            )
        )

    average_percentage = round(total_percentage / len(records), 2)

    if average_percentage < 40:
        risk_level = "At Risk"
    elif average_percentage < 70:
        risk_level = "Average"
    else:
        risk_level = "Good"

    return {
        "student_id": student.student_id,
        "student_name": student.student_name,
        "course": student.course,
        "average_percentage": average_percentage,
        "risk_level": risk_level,
        "marks": marks_list,
        "trend": trend
    }

# =================================================
# 👩‍🏫 TEACHER DASHBOARD (SECURE)
# =================================================
@router.get("/teacher", response_model=TeacherDashboardResponse)
def get_teacher_dashboard(
    user=Depends(role_required("teacher")),
    db: Session = Depends(get_db)
):

    # 1️⃣ Total students
    total_students = db.execute(
        text("SELECT COUNT(*) FROM students")
    ).scalar()

    # 2️⃣ Risk summary
    risk_data = db.execute(
        text("""
            SELECT
                CASE
                    WHEN AVG((marks / max_marks) * 100) < 40 THEN 'At Risk'
                    WHEN AVG((marks / max_marks) * 100) < 70 THEN 'Average'
                    ELSE 'Good'
                END AS risk_level
            FROM performance
            GROUP BY student_id
        """)
    ).fetchall()

    risk_summary = {"At Risk": 0, "Average": 0, "Good": 0}
    for r in risk_data:
        risk_summary[r.risk_level] += 1

    # 3️⃣ Subject-wise performance
    subject_data = db.execute(
        text("""
            SELECT subject,
                   AVG((marks / max_marks) * 100) AS avg_percentage
            FROM performance
            GROUP BY subject
        """)
    ).fetchall()

    return {
        "total_students": total_students,
        "risk_summary": {
            "at_risk": risk_summary["At Risk"],
            "average": risk_summary["Average"],
            "good": risk_summary["Good"]
        },
        "subject_performance": [
            {
                "subject": s.subject,
                "average_percentage": round(s.avg_percentage, 2)
            }
            for s in subject_data
        ]
    }
