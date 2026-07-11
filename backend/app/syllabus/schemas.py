from pydantic import BaseModel
from typing import Optional

class SyllabusCreate(BaseModel):
    course_id: int
    subject_name: str
    syllabus_text: Optional[str] = None
