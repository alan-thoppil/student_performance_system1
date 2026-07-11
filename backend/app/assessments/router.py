# =========================================================
# router.py
# Quiz creation (Teacher side)
# =========================================================

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text
from database import get_db

from app.assessments.schemas import QuizCreateRequest, QuizCreateResponse
from app.assessments.openai_utils import generate_mcq_quiz


router = APIRouter(
    prefix="/assessments",
    tags=["Assessments"]
)


@router.post("/create-quiz", response_model=QuizCreateResponse)
def create_quiz(request: QuizCreateRequest, db: Session = Depends(get_db)):
    """
    Teacher creates a quiz by giving subject + topic.
    """

    # 1️⃣ Generate MCQ questions using OpenAI
    try:
        questions = generate_mcq_quiz(
            subject=request.subject,
            topic=request.topic
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    total_questions = len(questions)

    # 2️⃣ Insert quiz metadata
    query = text("""
        INSERT INTO quizzes (subject, topic, start_time, end_time, total_questions)
        VALUES (:subject, :topic, :start_time, :end_time, :total_questions)
        RETURNING id
    """)

    result = db.execute(query, {
        "subject": request.subject,
        "topic": request.topic,
        "start_time": request.start_time,
        "end_time": request.end_time,
        "total_questions": total_questions
    }).fetchone()

    db.commit()

    return {
        "quiz_id": result.id,
        "subject": request.subject,
        "topic": request.topic,
        "total_questions": total_questions,
        "start_time": request.start_time,
        "end_time": request.end_time
    }
