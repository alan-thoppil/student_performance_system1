import React from "react";
import { useNavigate } from "react-router-dom";

export default function StudentNavbar() {

  const navigate = useNavigate();

  const logout = () => {
    localStorage.clear();
    navigate("/");
  };

  return (
    <nav className="navbar navbar-expand-lg navbar-dark bg-primary">

      <div className="container-fluid">

        {/* LEFT */}
        <span className="navbar-brand">
          Student Panel
        </span>

        {/* RIGHT BUTTONS */}
        <div className="ms-auto d-flex">

          <button
            className="btn btn-light me-2"
            onClick={() => navigate("/student/dashboard")}
          >
            Dashboard
          </button>

          <button
            className="btn btn-light me-2"
            onClick={() => navigate("/student/materials")}
          >
            Study Materials
          </button>

          <button
            className="btn btn-light me-2"
            onClick={() => navigate("/student/syllabus")}
          >
            Syllabus
          </button>

          <button
            className="btn btn-warning me-2"
            onClick={() => navigate("/student/change-password")}
          >
            Change Password
          </button>

          <button
            className="btn btn-danger"
            onClick={logout}
          >
            Logout
          </button>

        </div>

      </div>
    </nav>
  );
}