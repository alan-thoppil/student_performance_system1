# =========================================================
# schemas.py
# Quiz-related request & response models
# =========================================================

from pydantic import BaseModel
from typing import List
from datetime import datetime


# ---------------------------------------------------------
# Teacher → Quiz Generation Request
# ---------------------------------------------------------
class QuizCreateRequest(BaseModel):
    """
    Data sent by teacher to generate a quiz
    """
    subject: str
    topic: str
    start_time: datetime
    end_time: datetime


# ---------------------------------------------------------
# Quiz Creation Response
# ---------------------------------------------------------
class QuizCreateResponse(BaseModel):
    """
    Returned after quiz is created
    """
    quiz_id: int
    subject: str
    topic: str
    total_questions: int
    start_time: datetime
    end_time: datetime
