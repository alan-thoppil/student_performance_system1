def chatbot_logic(data):
    """
    Handles:
    - SHAP & LIME explanations
    - Personalized study planner
    - System guidance
    - General NLP / theory explanation (rule-based for now)
    """

    message = data.message.lower()

    # ---------------------------------
    # 1. SHAP + LIME Explanation
    # ---------------------------------
    if data.prediction and (data.shap_values or data.lime_explanation):
        reply = f"📊 **Prediction Result:** {data.prediction}\n\n"

        if data.shap_values:
            reply += "🔍 **SHAP Explanation (global impact):**\n"
            for feature, value in data.shap_values.items():
                reply += f"- {feature}: impact score {value}\n"

        if data.lime_explanation:
            reply += "\n📌 **LIME Explanation (local reasoning):**\n"
            for rule in data.lime_explanation:
                reply += f"- {rule}\n"

        return {
            "reply": reply,
            "confidence": 0.90,
            "sources": ["shap", "lime"]
        }

    # ---------------------------------
    # 2. Study Planner
    # ---------------------------------
    if "study" in message or data.weak_topics:
        hours = data.available_hours_per_day or 2
        reply = f"📚 **Personalized Study Plan** ({hours} hrs/day)\n\n"

        if data.weak_topics:
            reply += "🔴 Focus more on:\n"
            for topic in data.weak_topics:
                reply += f"- {topic}\n"

        if data.strong_topics:
            reply += "\n🟢 Light revision for:\n"
            for topic in data.strong_topics:
                reply += f"- {topic}\n"

        reply += "\n✅ Revise weak topics first and practice daily."

        return {
            "reply": reply,
            "confidence": 0.88,
            "sources": ["study-planner"]
        }

    # ---------------------------------
    # 3. System Help
    # ---------------------------------
    if "system" in message or "what can" in message:
        reply = (
            "🧠 **System Capabilities:**\n"
            "- Student performance prediction using ML\n"
            "- Explainable AI using SHAP & LIME\n"
            "- AI-based quiz generation\n"
            "- Personalized study planning\n"
            "- Educational chatbot assistance"
        )

        return {
            "reply": reply,
            "confidence": 0.95,
            "sources": ["system-info"]
        }

    # ---------------------------------
    # 4. General NLP / Theory Explanation (Fallback)
    # ---------------------------------
    return {
        "reply": f"I will explain this topic based on {data.context or 'your syllabus'}.\n\nAsk me more specific questions if needed 😊",
        "confidence": 0.85,
        "sources": ["nlp-rule-based"]
    }
