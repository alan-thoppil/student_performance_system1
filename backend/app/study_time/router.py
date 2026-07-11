from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import text
from database import get_db

router = APIRouter(prefix="/study", tags=["Study Time"])


@router.post("/start")
def start_study(student_id: int, material_id: int, db: Session = Depends(get_db)):

    db.execute(
        text("""
        INSERT INTO study_sessions (student_id, material_id, start_time)
        VALUES (:sid, :mid, NOW())
        """),
        {"sid": student_id, "mid": material_id}
    )

    db.commit()

    return {"message": "Study session started"}
@router.post("/end")
def end_study(student_id: int, material_id: int, db: Session = Depends(get_db)):

    db.execute(
        text("""
        UPDATE study_sessions
        SET end_time = NOW()
        WHERE student_id=:sid
        AND material_id=:mid
        AND end_time IS NULL
        """),
        {"sid": student_id, "mid": material_id}
    )

    db.commit()

    return {"message": "Study session ended"}