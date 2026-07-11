import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import API from "../../services/api";

export default function StudentDashboard() {

  const navigate = useNavigate();

  const [student, setStudent] = useState({});
  const [attendance, setAttendance] = useState(0);
  const [prediction, setPrediction] = useState("");

  const studentId = localStorage.getItem("user_id") || "";

  useEffect(() => {

    if (!studentId || studentId === "undefined") {
      console.log("Student ID missing");
      return;
    }

    const loadProfile = async () => {
      try {
        const res = await API.get(`/student-dashboard/profile/${studentId}`);
        setStudent(res.data);
      } catch (err) {
        console.log("Profile error:", err);
      }
    };

    const loadAnalytics = async () => {
      try {
        const res = await API.get(`/student-dashboard/analytics/${studentId}`);

        setAttendance(res.data.attendance_percentage || 0);
        setPrediction(res.data.risk_prediction || "");

      } catch (err) {
        console.log("Analytics error:", err);
      }
    };

    loadProfile();
    loadAnalytics();

  }, [studentId]);

  const logout = () => {

    localStorage.removeItem("token");
    localStorage.removeItem("role");
    localStorage.removeItem("user_id");

    navigate("/");

  };

  return (

    <div className="container mt-3">

      {/* TOP BAR */}

      <div className="d-flex justify-content-between align-items-center mb-4">

        <h3>Student Dashboard</h3>

        <div>

          <span className="me-3">
            👤 {student.student_name || "Student"}
          </span>

          <button
            className="btn btn-warning btn-sm me-2"
            onClick={() => navigate("/student/change-password")}
          >
            Change Password
          </button>

          <button
            className="btn btn-danger btn-sm"
            onClick={logout}
          >
            Logout
          </button>

        </div>

      </div>


      {/* PROFILE */}

      <div className="card p-3 mb-4">

        <h5>Profile</h5>

        <p><b>Name:</b> {student.student_name || "-"}</p>
        <p><b>Register Number:</b> {student.register_number || "-"}</p>
        <p><b>Course:</b> {student.course || "-"}</p>

      </div>


      {/* ANALYTICS */}

      <div className="row mb-4">

        {/* ATTENDANCE */}

        <div className="col-md-6">

          <div className="card p-3">

            <h5>Attendance</h5>

            <div className="progress mt-3">

              <div
                className="progress-bar bg-success"
                style={{ width: `${attendance}%` }}
              >
                {attendance}%
              </div>

            </div>

          </div>

        </div>


        {/* RISK PREDICTION */}

        <div className="col-md-6">

          <div className="card p-3">

            <h5>Risk Prediction</h5>

            <div className="mt-3">

              {prediction === "High" && (
                <div className="alert alert-danger">
                  High Risk
                </div>
              )}

              {prediction === "Medium" && (
                <div className="alert alert-warning">
                  Medium Risk
                </div>
              )}

              {prediction === "Low" && (
                <div className="alert alert-success">
                  Low Risk
                </div>
              )}

              {!prediction && (
                <div className="text-muted">
                  No prediction yet
                </div>
              )}

            </div>

          </div>

        </div>

      </div>


      {/* DASHBOARD BUTTONS */}

      <div className="row g-3">

        <div className="col-md-4">
          <button
            className="btn btn-primary w-100 p-3"
            onClick={() => navigate("/student/performance")}
          >
            Performance
          </button>
        </div>

        <div className="col-md-4">
          <button
            className="btn btn-danger w-100 p-3"
            onClick={() => navigate("/student/risk")}
          >
            Risk Prediction
          </button>
        </div>

        <div className="col-md-4">
          <button
            className="btn btn-warning w-100 p-3"
            onClick={() => navigate("/student/explain")}
          >
            Explainability
          </button>
        </div>

        <div className="col-md-4">
          <button
            className="btn btn-success w-100 p-3"
            onClick={() => navigate("/student/attendance")}
          >
            Attendance
          </button>
        </div>

        <div className="col-md-4">
          <button
            className="btn btn-dark w-100 p-3"
            onClick={() => navigate("/student/materials")}
          >
            Study Materials
          </button>
        </div>

        <div className="col-md-4">
          <button
            className="btn btn-secondary w-100 p-3"
            onClick={() => navigate("/student/quiz")}
          >
            Quiz
          </button>
        </div>

        <div className="col-md-4">
          <button
            className="btn btn-info w-100 p-3"
            onClick={() => navigate("/student/syllabus")}
          >
            Syllabus
          </button>
        </div>

        <div className="col-md-4">
          <button
            className="btn btn-info w-100 p-3"
            onClick={() => navigate("/student/recommendations")}
          >
            Recommendations
          </button>
        </div>

      </div>

    </div>

  );

}