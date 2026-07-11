import React, { useEffect, useState } from "react";
import axios from "axios";

function StudyMaterials() {

  const [materials, setMaterials] = useState([]);

  useEffect(() => {
    fetchMaterials();
  }, []);

  const fetchMaterials = async () => {
    try {

      const student_id = localStorage.getItem("user_id");

      if (!student_id) {
        console.log("Student ID not found in localStorage");
        return;
      }

      const res = await axios.get(
        `http://127.0.0.1:8000/student-dashboard/materials/${student_id}`
      );

      setMaterials(res.data);

    } catch (error) {
      console.log("Error fetching materials:", error);
    }
  };

  return (
    <div style={{ padding: "40px" }}>

      <h2 style={{ marginBottom: "30px" }}>Study Materials</h2>

      {materials.length === 0 ? (
        <p>No materials uploaded yet</p>
      ) : (

        <div
          style={{
            display: "grid",
            gridTemplateColumns: "repeat(auto-fill, minmax(280px, 1fr))",
            gap: "20px"
          }}
        >

          {materials.map((m) => (

            <div
              key={m.id}
              style={{
                background: "#ffffff",
                padding: "20px",
                borderRadius: "10px",
                boxShadow: "0 2px 8px rgba(0,0,0,0.1)"
              }}
            >

              <h4>{m.title}</h4>

              <p style={{ fontSize: "14px", color: "#555" }}>
                Type: {m.material_type}
              </p>

              {/* VIDEO */}
              {m.material_type === "video" && m.file_url && (

                <iframe
                  width="100%"
                  height="180"
                  src={m.file_url.replace("youtu.be/", "www.youtube.com/embed/")}
                  title="Video"
                  frameBorder="0"
                  allowFullScreen
                  style={{ marginTop: "10px", borderRadius: "6px" }}
                />

              )}

              {/* PDF */}
              {m.material_type === "pdf" && m.file_url && (

                <a
                  href={`http://127.0.0.1:8000/${m.file_url}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{
                    display: "inline-block",
                    marginTop: "10px",
                    color: "#007bff",
                    textDecoration: "none",
                    fontWeight: "bold"
                  }}
                >
                  📄 Open PDF
                </a>

              )}

              {/* CSV */}
              {m.material_type === "csv" && m.file_url && (

                <a
                  href={`http://127.0.0.1:8000/${m.file_url}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{
                    display: "inline-block",
                    marginTop: "10px",
                    color: "#28a745",
                    textDecoration: "none",
                    fontWeight: "bold"
                  }}
                >
                  📊 Download CSV
                </a>

              )}

              {/* GENERIC FILE */}
              {m.material_type === "file" && m.file_url && (

                <a
                  href={`http://127.0.0.1:8000/${m.file_url}`}
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{
                    display: "inline-block",
                    marginTop: "10px",
                    color: "#007bff",
                    textDecoration: "none",
                    fontWeight: "bold"
                  }}
                >
                  📂 View Material
                </a>

              )}

              {/* TEXT NOTES */}
              {m.material_type === "text" && (

                <div
                  style={{
                    marginTop: "10px",
                    padding: "10px",
                    background: "#f5f5f5",
                    borderRadius: "6px"
                  }}
                >
                  {m.text_content}
                </div>

              )}

            </div>

          ))}

        </div>

      )}

    </div>
  );
}

export default StudyMaterials;