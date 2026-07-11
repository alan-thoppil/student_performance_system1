from pydantic import BaseModel
from datetime import datetime

class PerformanceCreate(BaseModel):
    student_id: int
    subject: str
    exam_type: str
    marks: float
    max_marks: float

class PerformanceResponse(BaseModel):
    id: int
    student_id: int
    subject: str
    exam_type: str
    marks: float
    max_marks: float
    created_at: datetime

    class Config:
        from_attributes = True
