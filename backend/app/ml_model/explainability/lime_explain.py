import numpy as np
import pandas as pd
import torch
import torch.nn as nn
import joblib
from lime.lime_tabular import LimeTabularExplainer

# -------------------------
# Paths
# -------------------------
DATA_PATH = "../dataset/processed/student_processed_balanced.csv"
MODEL_PATH = "../models/dnn_risk_model_pso.pt"
SCALER_PATH = "../models/scaler_pso.pkl"

# -------------------------
# Load dataset
# -------------------------
df = pd.read_csv(DATA_PATH)

FEATURES = ["studytime", "failures", "absences", "G1", "G2"]
X = df[FEATURES].values

# -------------------------
# Load scaler
# -------------------------
scaler = joblib.load(SCALER_PATH)
X_scaled = scaler.transform(X)

# -------------------------
# Define model (MUST MATCH TRAINING)
# -------------------------
class RiskDNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(5, 26),   # ← MUST match PSO result
            nn.ReLU(),
            nn.Dropout(0.2569),
            nn.Linear(26, 16),
            nn.ReLU(),
            nn.Linear(16, 3)
        )

    def forward(self, x):
        return self.net(x)

model = RiskDNN()
model.load_state_dict(torch.load(MODEL_PATH, map_location="cpu"))
model.eval()

# -------------------------
# Prediction function for LIME
# -------------------------
def predict_fn(data):
    data = torch.tensor(data, dtype=torch.float32)
    with torch.no_grad():
        logits = model(data)
        probs = torch.softmax(logits, dim=1)
    return probs.numpy()

# -------------------------
# Create LIME explainer
# -------------------------
explainer = LimeTabularExplainer(
    training_data=X_scaled,
    feature_names=FEATURES,
    class_names=["At Risk", "Average", "Good"],
    mode="classification"
)

# -------------------------
# Sample student (CHANGE VALUES HERE)
# -------------------------
sample_student = np.array([[2, 2, 12, 8, 9]])  # studytime, failures, absences, G1, G2
sample_scaled = scaler.transform(sample_student)

# -------------------------
# Explain prediction
# -------------------------
exp = explainer.explain_instance(
    sample_scaled[0],
    predict_fn,
    num_features=5
)

print("\n🧠 LIME Explanation:")
for feature, weight in exp.as_list():
    print(f"{feature}: {weight:.4f}")
