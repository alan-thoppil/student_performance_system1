import React, { useState } from "react";
import API from "../../services/api";
import { useNavigate } from "react-router-dom";

export default function Syllabus() {

  const navigate = useNavigate();

  const [courseId, setCourseId] = useState("");
  const [syllabus, setSyllabus] = useState([]);
  const [searched, setSearched] = useState(false);

  const loadSyllabus = async () => {

    if (!courseId) {
      alert("Enter Course ID");
      return;
    }

    try {

      const res = await API.get(`/teacher/syllabus/${courseId}`);

      setSyllabus(res.data);
      setSearched(true);

    } catch {

      alert("Failed to load syllabus");

    }

  };

  return (

    <div className="container mt-4">

      <div className="d-flex justify-content-between mb-4">

        <h2>Course Syllabus</h2>

        <button
          className="btn btn-secondary"
          onClick={() => navigate("/student")}
        >
          Back
        </button>

      </div>


      {/* Search Section */}

      <div className="row mb-4">

        <div className="col-md-10">

          <input
            className="form-control"
            placeholder="Enter Course ID"
            value={courseId}
            onChange={(e) => setCourseId(e.target.value)}
          />

        </div>

        <div className="col-md-2">

          <button
            className="btn btn-primary w-100"
            onClick={loadSyllabus}
          >
            Load
          </button>

        </div>

      </div>


      {/* If searched but nothing found */}

      {searched && syllabus.length === 0 && (

        <div className="alert alert-warning">
          No syllabus found for this course
        </div>

      )}


      {/* Syllabus Cards */}

      <div className="row">

        {syllabus.map((item, index) => (

          <div className="col-md-6 mb-4" key={index}>

            <div className="card shadow-sm h-100">

              <div className="card-body">

                <h5 className="card-title">
                  📘 {item.subject_name}
                </h5>

                {item.syllabus_text && (

                  <p className="card-text">
                    {item.syllabus_text}
                  </p>

                )}

                {item.file_path && (

                  <div className="mt-3">

                    <a
                      href={`http://127.0.0.1:8000/${item.file_path}`}
                      target="_blank"
                      rel="noreferrer"
                      className="btn btn-outline-primary btn-sm me-2"
                    >
                      View PDF
                    </a>

                    <a
                      href={`http://127.0.0.1:8000/${item.file_path}`}
                      download
                      className="btn btn-primary btn-sm"
                    >
                      Download
                    </a>

                  </div>

                )}

              </div>

            </div>

          </div>

        ))}

      </div>

    </div>

  );

}