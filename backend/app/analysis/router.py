# =========================
# analysis/router.py
# =========================

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from app.analysis.schemas import RiskAnalysisResponse

router = APIRouter(
    prefix="/analysis",
    tags=["Performance Analysis"]
)


@router.get("/student/{student_id}", response_model=RiskAnalysisResponse)
def analyze_student(student_id: int, db: Session = Depends(get_db)):
    """
    Analyze student performance and predict risk level
    """

    records = db.execute(
        text("""
            SELECT marks, max_marks
            FROM performance
            WHERE student_id = :student_id
        """),
        {"student_id": student_id}
    ).fetchall()

    if not records:
        raise HTTPException(status_code=404, detail="No performance data found")

    total_percentage = 0
    for r in records:
        total_percentage += (r.marks / r.max_marks) * 100

    average_percentage = total_percentage / len(records)

    if average_percentage < 40:
        risk_level = "At Risk"
    elif average_percentage < 70:
        risk_level = "Average"
    else:
        risk_level = "Good"

    return {
        "student_id": student_id,
        "average_percentage": round(average_percentage, 2),
        "risk_level": risk_level
    }
