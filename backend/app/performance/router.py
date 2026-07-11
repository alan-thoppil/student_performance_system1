from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text
from typing import List

from database import get_db
from app.performance.schemas import PerformanceCreate, PerformanceResponse

router = APIRouter(
    prefix="/performance",
    tags=["Performance"]
)

@router.post("/", response_model=PerformanceResponse)
def add_performance(data: PerformanceCreate, db: Session = Depends(get_db)):
    student = db.execute(
        text("SELECT id FROM students WHERE id = :id"),
        {"id": data.student_id}
    ).fetchone()

    if not student:
        raise HTTPException(status_code=404, detail="Student not found")

    result = db.execute(
        text("""
            INSERT INTO performance (student_id, subject, exam_type, marks, max_marks)
            VALUES (:student_id, :subject, :exam_type, :marks, :max_marks)
            RETURNING id, student_id, subject, exam_type, marks, max_marks, created_at
        """),
        data.dict()
    ).fetchone()

    db.commit()
    return result

@router.get("/{student_id}", response_model=List[PerformanceResponse])
def get_performance(student_id: int, db: Session = Depends(get_db)):
    records = db.execute(
        text("""
            SELECT id, student_id, subject, exam_type, marks, max_marks, created_at
            FROM performance
            WHERE student_id = :student_id
            ORDER BY created_at DESC
        """),
        {"student_id": student_id}
    ).fetchall()

    return records
