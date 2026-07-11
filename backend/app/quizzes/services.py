import os
import json
import fitz
from google import genai
from dotenv import load_dotenv

load_dotenv()

client = genai.Client(
    api_key=os.getenv("GEMINI_KEY"),
    http_options={"api_version": "v1"}
)



def extract_pdf_text(file_path: str):
    doc = fitz.open(file_path)
    return " ".join([page.get_text() for page in doc])


def generate_quiz_from_ai(syllabus_text: str, difficulty: str, num_q: int):

    prompt = f"""
    You are an expert exam question setter.

    Generate {num_q} multiple choice questions 
    based ONLY on the following syllabus.

    Difficulty level: {difficulty}

    Rules:
    - Each question must have 4 options
    - correct_answer must be A, B, C, or D
    - Include a short helpful hint
    - Return STRICT JSON format like below:

    [
      {{
        "question_text": "...",
        "options": ["...", "...", "...", "..."],
        "correct_answer": "A",
        "hint": "..."
      }}
    ]

    SYLLABUS:
    {syllabus_text[:4000]}
    """

    response = client.models.generate_content(
      model="gemini-1.0-pro",
        contents=prompt,
    )

    clean_text = response.text.replace("```json", "").replace("```", "").strip()

    return json.loads(clean_text)
