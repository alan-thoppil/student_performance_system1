# =========================================================
# router.py
# Student dashboard APIs
# =========================================================

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from app.student.schemas import (
    StudentProfile,
    StudentMark,
    RiskStatus
)

router = APIRouter(
    prefix="/student-dashboard",
    tags=["Student Dashboard"]
)

# ---------------------------------------------------------
# 1️⃣ Student Profile
# ---------------------------------------------------------
@router.get("/profile/{student_id}", response_model=StudentProfile)
def get_student_profile(student_id: int, db: Session = Depends(get_db)):
    query = text("""
        SELECT
            id AS student_id,
            student_name,
            register_number,
            course
        FROM students
        WHERE id = :student_id
    """)

    result = db.execute(query, {"student_id": student_id}).fetchone()

    if not result:
        raise HTTPException(status_code=404, detail="Student not found")

    return result


# ---------------------------------------------------------
# 2️⃣ Student Marks
# ---------------------------------------------------------
@router.get("/marks/{student_id}", response_model=list[StudentMark])
def get_student_marks(student_id: int, db: Session = Depends(get_db)):
    query = text("""
        SELECT
            subject,
            exam_type,
            marks,
            max_marks
        FROM performance
        WHERE student_id = :student_id
    """)

    result = db.execute(query, {"student_id": student_id}).fetchall()

    if not result:
        raise HTTPException(status_code=404, detail="No marks found")

    return result


# ---------------------------------------------------------
# 3️⃣ Risk Status (Rule-based)
# ---------------------------------------------------------
@router.get("/risk/{student_id}", response_model=RiskStatus)
def get_risk_status(student_id: int, db: Session = Depends(get_db)):
    query = text("""
        SELECT
            AVG((marks / max_marks) * 100) AS avg_percentage
        FROM performance
        WHERE student_id = :student_id
    """)

    result = db.execute(query, {"student_id": student_id}).fetchone()

    if not result or result.avg_percentage is None:
        raise HTTPException(status_code=404, detail="Insufficient data")

    avg = result.avg_percentage

    if avg < 40:
        risk = "At Risk"
    elif avg < 70:
        risk = "Average"
    else:
        risk = "Good"

    return {
        "student_id": student_id,
        "risk_level": risk,
        "average_percentage": round(avg, 2)
    }
