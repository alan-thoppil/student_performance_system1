# =========================================================
# router.py
# Teacher dashboard APIs
# =========================================================

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from app.teacher.schemas import StudentSummary, StudentPerformance

router = APIRouter(
    prefix="/teacher",
    tags=["Teacher Dashboard"]
)

# ---------------------------------------------------------
# 1️⃣ View all students
# ---------------------------------------------------------
@router.get("/students", response_model=list[StudentSummary])
def get_all_students(db: Session = Depends(get_db)):
    query = text("""
        SELECT
            id AS student_id,
            student_name,
            register_number,
            course
        FROM students
        ORDER BY student_name
    """)

    result = db.execute(query).fetchall()
    return result


# ---------------------------------------------------------
# 2️⃣ View one student performance
# ---------------------------------------------------------
@router.get("/students/{student_id}/performance", response_model=list[StudentPerformance])
def get_student_performance(student_id: int, db: Session = Depends(get_db)):
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
        raise HTTPException(status_code=404, detail="No performance data found")

    return result
