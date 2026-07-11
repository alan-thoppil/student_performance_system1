from fastapi import APIRouter
from app.chatbot.schemas import ChatbotRequest, ChatbotResponse
from app.chatbot.services import chatbot_logic

router = APIRouter(
    prefix="/chatbot",
    tags=["Chatbot"]
)


@router.post("/ask", response_model=ChatbotResponse)
def ask_chatbot(data: ChatbotRequest):
    """
    Unified chatbot endpoint:
    - NLP explanations
    - SHAP & LIME explanations
    - Study planner
    - System guidance
    """
    return chatbot_logic(data)
