from pydantic import BaseModel
from typing import Optional

# -------- Input Schema --------
class StudentCreate(BaseModel):
    user_id: int                 # ID from users table
    student_name: str
    register_number: str
    course: Optional[str] = None


# -------- Response Schema --------
class StudentResponse(BaseModel):
    id: int
    user_id: int
    student_name: str
    register_number: str
    course: Optional[str]

    class Config:
        from_attributes = True
from pydantic import BaseModel

# =========================
# Student Profile Schemas
# =========================

class StudentCreate(BaseModel):
    user_id: int
    student_name: str
    register_number: str
    course: str


class StudentResponse(BaseModel):
    id: int
    user_id: int
    student_name: str
    register_number: str
    course: str

    class Config:
        from_attributes = True
