from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text

from database import get_db
from app.users.schemas import StudentCreate, StudentResponse

# Router for student-related APIs
router = APIRouter(
    prefix="/students",
    tags=["Students"]
)

@router.post("/", response_model=StudentResponse)
def create_student(student: StudentCreate, db: Session = Depends(get_db)):
    """
    Create a student profile linked to an existing user
    """

    # STEP 1: Check if student profile already exists for this user
    check_query = text(
        "SELECT id FROM students WHERE user_id = :user_id"
    )
    existing_student = db.execute(
        check_query,
        {"user_id": student.user_id}
    ).fetchone()

    if existing_student:
        raise HTTPException(
            status_code=400,
            detail="Student profile already exists for this user"
        )

    # STEP 2: Insert new student record
    insert_query = text("""
        INSERT INTO students (user_id, student_name, register_number, course)
        VALUES (:user_id, :student_name, :register_number, :course)
        RETURNING id, user_id, student_name, register_number, course
    """)

    new_student = db.execute(
        insert_query,
        {
            "user_id": student.user_id,
            "student_name": student.student_name,
            "register_number": student.register_number,
            "course": student.course
        }
    ).fetchone()

    # STEP 3: Commit transaction
    db.commit()

    # STEP 4: Return created student profile
    return new_student
