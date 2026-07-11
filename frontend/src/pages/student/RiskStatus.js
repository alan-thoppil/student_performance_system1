import React from "react";

export default function RiskStatus() {

  return (
    <div className="container mt-4">

      <h3>Risk Prediction</h3>

      <div className="alert alert-danger mt-3">
        Risk Status: HIGH
      </div>

      <p>This prediction is generated using the ML model.</p>

    </div>
  );
}