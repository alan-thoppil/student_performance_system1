from pydantic import BaseModel
from typing import List, Optional

# -------------------------
# Student dashboard schemas
# -------------------------

class MarkItem(BaseModel):
    subject: str
    exam_type: str
    marks: float
    max_marks: float

class StudentDashboardResponse(BaseModel):
    student_id: int
    student_name: str
    course: Optional[str]
    average_percentage: float
    risk_level: str
    marks: List[MarkItem]
    trend: List[float]

# -------------------------
# Teacher dashboard schemas
# -------------------------

class RiskSummary(BaseModel):
    at_risk: int
    average: int
    good: int

class SubjectPerformance(BaseModel):
    subject: str
    average_percentage: float

class TeacherDashboardResponse(BaseModel):
    total_students: int
    risk_summary: RiskSummary
    subject_performance: List[SubjectPerformance]
