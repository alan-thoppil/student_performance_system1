from pydantic import BaseModel

class TeacherApprovalRequest(BaseModel):
    teacher_id: int
    approved: bool

class DepartmentCreate(BaseModel):
    name: str

class PendingTeacherResponse(BaseModel):
    id: int
    username: str
    email: str
    status: str
