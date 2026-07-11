import React from "react";

function Dashboard() {
  const role = localStorage.getItem("role");

  return (
    <div style={{ padding: 40 }}>
      <h2>Dashboard</h2>
      <p>Role: {role}</p>

      <ul>
        <li><a href="/prediction">Prediction & Explainability</a></li>
        <li><a href="/chatbot">Academic Chatbot</a></li>
      </ul>
    </div>
  );
}

export default Dashboard;
