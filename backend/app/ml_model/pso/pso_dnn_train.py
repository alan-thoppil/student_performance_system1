import numpy as np
import pandas as pd
import torch
import torch.nn as nn
import torch.optim as optim
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from torch.utils.data import DataLoader, Dataset
import joblib
import random

# -------------------------
# Load dataset
# -------------------------
df = pd.read_csv("../dataset/processed/student_processed_balanced.csv")

X = df[["studytime", "failures", "absences", "G1", "G2"]].values
y = df["risk_label"].values

X_train, X_val, y_train, y_val = train_test_split(
    X, y, test_size=0.2, stratify=y, random_state=42
)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_val = scaler.transform(X_val)

joblib.dump(scaler, "../models/scaler_pso.pkl")

# -------------------------
# Dataset class
# -------------------------
class StudentDataset(Dataset):
    def __init__(self, X, y):
        self.X = torch.tensor(X, dtype=torch.float32)
        self.y = torch.tensor(y, dtype=torch.long)

    def __len__(self):
        return len(self.X)

    def __getitem__(self, idx):
        return self.X[idx], self.y[idx]

train_ds = StudentDataset(X_train, y_train)
val_ds = StudentDataset(X_val, y_val)

# -------------------------
# DNN Model
# -------------------------
class RiskDNN(nn.Module):
    def __init__(self, hidden_size, dropout):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(5, hidden_size),
            nn.ReLU(),
            nn.Dropout(dropout),
            nn.Linear(hidden_size, 16),
            nn.ReLU(),
            nn.Linear(16, 3)
        )

    def forward(self, x):
        return self.net(x)

# -------------------------
# Fitness function (PSO)
# -------------------------
def evaluate_particle(params):
    lr, hidden_size, dropout = params
    hidden_size = int(hidden_size)

    model = RiskDNN(hidden_size, dropout)
    optimizer = optim.Adam(model.parameters(), lr=lr)
    criterion = nn.CrossEntropyLoss()

    loader = DataLoader(train_ds, batch_size=16, shuffle=True)

    # Train for few epochs only (PSO rule)
    for _ in range(10):
        for xb, yb in loader:
            optimizer.zero_grad()
            loss = criterion(model(xb), yb)
            loss.backward()
            optimizer.step()

    # Validation accuracy
    model.eval()
    correct, total = 0, 0
    with torch.no_grad():
        for xb, yb in DataLoader(val_ds, batch_size=16):
            preds = model(xb)
            _, pred = torch.max(preds, 1)
            total += yb.size(0)
            correct += (pred == yb).sum().item()

    return correct / total

# -------------------------
# PSO parameters
# -------------------------
NUM_PARTICLES = 6
ITERATIONS = 5

# search ranges
LR_RANGE = (0.0005, 0.01)
HIDDEN_RANGE = (16, 64)
DROPOUT_RANGE = (0.1, 0.5)

# Initialize particles
particles = []
for _ in range(NUM_PARTICLES):
    particle = [
        random.uniform(*LR_RANGE),
        random.uniform(*HIDDEN_RANGE),
        random.uniform(*DROPOUT_RANGE)
    ]
    particles.append(particle)

best_particle = None
best_score = 0

# -------------------------
# PSO loop
# -------------------------
for iteration in range(ITERATIONS):
    print(f"\n🌀 PSO Iteration {iteration+1}")

    for particle in particles:
        score = evaluate_particle(particle)
        print(f"Particle {particle} → Accuracy: {score:.4f}")

        if score > best_score:
            best_score = score
            best_particle = particle

print("\n✅ Best PSO Parameters Found")
print(f"Learning rate: {best_particle[0]}")
print(f"Hidden units: {int(best_particle[1])}")
print(f"Dropout: {best_particle[2]}")
print(f"Validation Accuracy: {best_score:.4f}")

# -------------------------
# Train FINAL model with best params
# -------------------------
final_model = RiskDNN(int(best_particle[1]), best_particle[2])
optimizer = optim.Adam(final_model.parameters(), lr=best_particle[0])
criterion = nn.CrossEntropyLoss()

train_loader = DataLoader(train_ds, batch_size=16, shuffle=True)

for epoch in range(50):
    for xb, yb in train_loader:
        optimizer.zero_grad()
        loss = criterion(final_model(xb), yb)
        loss.backward()
        optimizer.step()

torch.save(final_model.state_dict(), "../models/dnn_risk_model_pso.pt")
print("\n🎯 PSO-Optimized DNN saved successfully")
