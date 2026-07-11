import { useNavigate } from "react-router-dom";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function TeacherDashboard() {

  const navigate = useNavigate();   // ✅ INSIDE component

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">
        <h2>Teacher Dashboard</h2>

        <div className="mt-3">
          <button
            className="btn btn-primary me-2"
            onClick={() => navigate("/teacher/create-quiz")}
          >
            Create AI Quiz
          </button>

          <button
            className="btn btn-secondary"
            onClick={() => navigate("/teacher/students")}
          >
            Manage Students
          </button>
        </div>

        <div className="mt-4">
          <p>✔ Upload marks (manual / CSV)</p>
          <p>✔ Risk prediction & explainability</p>
          <p>✔ AI quiz generation</p>
        </div>
      </div>
    </>
  );
}
