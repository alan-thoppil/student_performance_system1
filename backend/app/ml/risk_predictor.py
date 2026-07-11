import torch
import torch.nn as nn
import numpy as np
import joblib

MODEL_PATH = "models/dnn_risk_model.pt"
SCALER_PATH = "models/scaler.pkl"


# -----------------------------
# Model Definition
# -----------------------------
class RiskDNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(5, 32),
            nn.ReLU(),
            nn.Dropout(0.3),
            nn.Linear(32, 16),
            nn.ReLU(),
            nn.Dropout(0.2),
            nn.Linear(16, 3)
        )

    def forward(self, x):
        return self.net(x)


# -----------------------------
# Load Model
# -----------------------------
model = RiskDNN()
model.load_state_dict(torch.load(MODEL_PATH))
model.eval()

scaler = joblib.load(SCALER_PATH)


# -----------------------------
# Prediction Function
# -----------------------------
def predict_student_risk(studytime, failures, absences, g1, g2):

    student = np.array([[studytime, failures, absences, g1, g2]])

    student_scaled = scaler.transform(student)

    tensor = torch.tensor(student_scaled, dtype=torch.float32)

    with torch.no_grad():

        output = model(tensor)

        probs = torch.softmax(output, dim=1)

        risk_class = torch.argmax(probs, dim=1).item()

    labels = {
        0: "At Risk",
        1: "Average",
        2: "Good"
    }

    return {
        "risk_level": labels[risk_class],
        "probabilities": probs.numpy().tolist()[0]
    }