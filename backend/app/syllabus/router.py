from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlalchemy.orm import Session
from sqlalchemy import text
import pdfplumber

from database import get_db
from app.syllabus.schemas import SyllabusCreate

router = APIRouter(
    prefix="/syllabus",
    tags=["Syllabus"]
)

# ----------------------------------------
# TEXT / DESCRIPTION BASED SYLLABUS UPLOAD
# ----------------------------------------
@router.post("/upload-text")
def upload_syllabus_text(
    data: SyllabusCreate,
    teacher_id: int,  # later from JWT
    db: Session = Depends(get_db)
):
    if not data.syllabus_text or not data.syllabus_text.strip():
        raise HTTPException(status_code=400, detail="Syllabus text is required")

    try:
        query = text("""
            INSERT INTO syllabus 
            (teacher_id, course_id, subject_name, syllabus_text, source_type)
            VALUES 
            (:teacher_id, :course_id, :subject_name, :syllabus_text, 'text')
            RETURNING id
        """)
        result = db.execute(query, {
            "teacher_id": teacher_id,
            "course_id": data.course_id,
            "subject_name": data.subject_name,
            "syllabus_text": data.syllabus_text
        })
        db.commit()

        return {
            "message": "Syllabus (text) uploaded successfully",
            "syllabus_id": result.scalar()
        }

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


# ----------------------------------------
# PDF BASED SYLLABUS UPLOAD
# ----------------------------------------
@router.post("/upload-pdf")
def upload_syllabus_pdf(
    course_id: int,
    subject_name: str,
    teacher_id: int,  # later from JWT
    file: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    if not file.filename.lower().endswith(".pdf"):
        raise HTTPException(status_code=400, detail="Only PDF files are allowed")

    extracted_text = ""

    try:
        with pdfplumber.open(file.file) as pdf:
            for page in pdf.pages:
                text_page = page.extract_text()
                if text_page:
                    extracted_text += text_page + "\n"

        if not extracted_text.strip():
            raise HTTPException(status_code=400, detail="No readable text found in PDF")

        query = text("""
            INSERT INTO syllabus 
            (teacher_id, course_id, subject_name, syllabus_text, source_type)
            VALUES 
            (:teacher_id, :course_id, :subject_name, :syllabus_text, 'pdf')
            RETURNING id
        """)
        result = db.execute(query, {
            "teacher_id": teacher_id,
            "course_id": course_id,
            "subject_name": subject_name,
            "syllabus_text": extracted_text
        })
        db.commit()

        return {
            "message": "Syllabus (PDF) uploaded successfully",
            "syllabus_id": result.scalar()
        }

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))
