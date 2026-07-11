# =========================================================
# openai_utils.py
# Handles quiz generation using OpenAI
# =========================================================

"""
Responsibilities:
- Call OpenAI ONLY when quiz generation is requested
- Generate MCQ quizzes
- Return structured JSON

Important:
- OpenAI client is NOT created at import time
"""

import os
import json
from openai import OpenAI


# ---------------------------------------------------------
# Function: get_openai_client
# ---------------------------------------------------------
def get_openai_client():
    """
    Creates OpenAI client safely.
    App will NOT crash if key is missing until API is used.
    """
    api_key = os.getenv("OPENAI_API_KEY")

    if not api_key:
        raise RuntimeError(
            "OPENAI_API_KEY is not set. "
            "Set it before using quiz generation."
        )

    return OpenAI(api_key=api_key)


# ---------------------------------------------------------
# Function: generate_mcq_quiz
# ---------------------------------------------------------
def generate_mcq_quiz(subject: str, topic: str, difficulty: str = "medium"):
    """
    Generates a 10-question MCQ quiz using OpenAI.
    """

    prompt = f"""
Create EXACTLY 10 MCQ questions.

Subject: {subject}
Topic: {topic}
Difficulty: {difficulty}

Rules:
- 4 options per question
- Only ONE correct answer
- Return VALID JSON only

Format:
[
  {{
    "question": "...",
    "options": [
      {{ "text": "...", "is_correct": true }},
      {{ "text": "...", "is_correct": false }},
      {{ "text": "...", "is_correct": false }},
      {{ "text": "...", "is_correct": false }}
    ]
  }}
]
"""

    client = get_openai_client()

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
            {"role": "system", "content": "You are an academic quiz generator."},
            {"role": "user", "content": prompt}
        ],
        temperature=0.4
    )

    raw_output = response.choices[0].message.content

    try:
        return json.loads(raw_output)
    except json.JSONDecodeError:
        raise ValueError("OpenAI returned invalid JSON")
