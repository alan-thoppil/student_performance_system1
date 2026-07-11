# =========================================================
# schemas.py
# Student dashboard response models
# =========================================================

from pydantic import BaseModel
from typing import Optional


class StudentProfile(BaseModel):
    student_id: int
    student_name: str
    register_number: str
    course: Optional[str]


class StudentMark(BaseModel):
    subject: str
    exam_type: str
    marks: float
    max_marks: float


class RiskStatus(BaseModel):
    student_id: int
    risk_level: str
    average_percentage: float
