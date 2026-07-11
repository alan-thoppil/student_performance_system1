import { Link } from "react-router-dom";

export default function TeacherNavbar() {
  return (
    <nav className="navbar navbar-dark bg-primary px-3">
      <Link className="navbar-brand" to="/teacher">
        Teacher Panel
      </Link>

      <div>
        <Link className="btn btn-light btn-sm me-2" to="/teacher/students">Students</Link>
        <Link className="btn btn-light btn-sm me-2" to="/teacher/predictions">Predictions</Link>
        <Link className="btn btn-light btn-sm me-2" to="/teacher/explainability">Explainability</Link>
        <Link className="btn btn-light btn-sm me-2" to="/teacher/upload-syllabus">Syllabus</Link>
        <Link className="btn btn-light btn-sm me-2" to="/teacher/quiz">Quiz</Link>
        <button
          className="btn btn-danger btn-sm"
          onClick={() => {
            localStorage.clear();
            window.location.href = "/";
          }}
        >
          Logout
        </button>
      </div>
    </nav>
  );
}
