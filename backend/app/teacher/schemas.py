# =========================================================
# schemas.py
# Teacher dashboard response models
# =========================================================

from pydantic import BaseModel
from typing import List, Optional


class StudentSummary(BaseModel):
    """
    Minimal student details shown to teacher
    """
    student_id: int
    student_name: str
    register_number: str
    course: Optional[str]


class StudentPerformance(BaseModel):
    """
    Student academic performance record
    """
    subject: str
    exam_type: str
    marks: float
    max_marks: float
