import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function AddMarksLogin() {

  const [classId, setClassId] = useState("");
  const navigate = useNavigate();

  const openMarks = () => {

    if (!classId) {
      alert("Enter Class ID");
      return;
    }

    localStorage.setItem("class_id", classId);

    navigate("/teacher/add-marks");

  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">

        <h2>Enter Class For Marks</h2>

        <input
          className="form-control mt-3"
          placeholder="Example: CS01"
          value={classId}
          onChange={(e)=>setClassId(e.target.value)}
        />

        <button
          className="btn btn-primary mt-3"
          onClick={openMarks}
        >
          Open Marks Page
        </button>

      </div>
    </>
  );
}