from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from app.quizzes.schemas import QuizCreate, QuizResponse

router = APIRouter(prefix="/quizzes", tags=["Quizzes"])


@router.post("/", response_model=QuizResponse)
def create_quiz(quiz: QuizCreate, db: Session = Depends(get_db)):
    """
    Teacher creates a quiz (manual for now, AI later)
    """

    query = text("""
        INSERT INTO quizzes (title, topic, time_limit_minutes, total_marks)
        VALUES (:title, :topic, :time_limit_minutes, :total_marks)
        RETURNING id, title, topic, time_limit_minutes, total_marks, created_at
    """)

    result = db.execute(query, {
        "title": quiz.title,
        "topic": quiz.topic,
        "time_limit_minutes": quiz.time_limit_minutes,
        "total_marks": quiz.total_marks
    }).fetchone()

    db.commit()

    return result
