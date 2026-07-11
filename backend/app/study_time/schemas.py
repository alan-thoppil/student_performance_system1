from pydantic import BaseModel


class StudyStart(BaseModel):
    student_id: int
    material_id: int


class StudyEnd(BaseModel):
    student_id: int
    material_id: int