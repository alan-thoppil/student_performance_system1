import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function ClassLogin() {

  const [classId, setClassId] = useState("");
  const navigate = useNavigate();

  const openClass = () => {

    if (!classId) {
      alert("Enter class ID");
      return;
    }

    localStorage.setItem("class_id", classId);

    // THIS MUST GO TO STUDENTS PAGE
    navigate("/teacher/students");
  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">

        <h2>Enter Class ID</h2>

        <input
          className="form-control mt-3"
          placeholder="Example: CS01"
          value={classId}
          onChange={(e) => setClassId(e.target.value)}
        />

        <button
          className="btn btn-primary mt-3"
          onClick={openClass}
        >
          Open Class
        </button>

      </div>
    </>
  );
}