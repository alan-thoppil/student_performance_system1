from pydantic import BaseModel
from typing import List
from datetime import datetime

# -------- Quiz Creation --------
class QuizCreate(BaseModel):
    title: str
    topic: str
    time_limit_minutes: int
    total_marks: int

# -------- Quiz Response --------
class QuizResponse(BaseModel):
    id: int
    title: str
    topic: str
    time_limit_minutes: int
    total_marks: int
    created_at: datetime
