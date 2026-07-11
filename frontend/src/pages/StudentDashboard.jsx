import React from "react";
import { useNavigate } from "react-router-dom";

function StudentDashboard() {
  const navigate = useNavigate();

  return (
    <div className="container mt-5">
      <h2 className="mb-4">Student Dashboard</h2>

      <div className="row g-3">

        {/* View Performance */}
        <div className="col-md-6">
          <button
            className="btn btn-primary w-100 p-3"
            onClick={() => navigate("/student/performance")}
          >
            📊 View Performance
          </button>
        </div>

        {/* View Risk Status */}
        <div className="col-md-6">
          <button
            className="btn btn-warning w-100 p-3"
            onClick={() => navigate("/student/risk")}
          >
            ⚠️ View Risk Status
          </button>
        </div>

        {/* Take Quiz */}
        <div className="col-md-6">
          <button
            className="btn btn-success w-100 p-3"
            onClick={() => navigate("/student/quiz")}
          >
            📝 Take Quiz
          </button>
        </div>

        {/* View Recommendations */}
        <div className="col-md-6">
          <button
            className="btn btn-info w-100 p-3"
            onClick={() => navigate("/student/recommendations")}
          >
            💡 View Recommendations
          </button>
        </div>

      </div>
    </div>
  );
}

export default StudentDashboard;