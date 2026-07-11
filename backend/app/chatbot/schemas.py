from pydantic import BaseModel
from typing import Optional, Literal, List, Dict


class ChatbotRequest(BaseModel):
    role: Literal["student", "teacher"]
    message: str

    # Optional context
    context: Optional[str] = None

    # Optional ML explanation inputs
    prediction: Optional[str] = None  # e.g. "High Risk"
    shap_values: Optional[Dict[str, float]] = None
    lime_explanation: Optional[List[str]] = None

    # Optional performance inputs
    weak_topics: Optional[List[str]] = None
    strong_topics: Optional[List[str]] = None
    available_hours_per_day: Optional[int] = 2


class ChatbotResponse(BaseModel):
    reply: str
    confidence: float
    sources: List[str]
