import React, { useState } from "react";
import API from "../../services/api";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function StudyMaterials() {

  const [title, setTitle] = useState("");
  const [classId, setClassId] = useState("");
  const [type, setType] = useState("pdf");
  const [file, setFile] = useState(null);
  const [link, setLink] = useState("");
  const [textContent, setTextContent] = useState("");

  const uploadMaterial = async () => {

    try {

      const formData = new FormData();

      formData.append("title", title);
      formData.append("class_id", classId);
      formData.append("material_type", type);

      if (type === "pdf" || type === "csv") {
        formData.append("file", file);
      }

      if (type === "video") {
        formData.append("video_url", link);
      }

      if (type === "text") {
        formData.append("text_content", textContent);
      }
      const teacherId = localStorage.getItem("user_id") || 1;
      
      await API.post("/teacher/upload-material", formData, {
        headers: { 
          "Content-Type": "multipart/form-data",
          "X-User-ID": teacherId
        }
      });

      alert("Material uploaded successfully");

      setTitle("");
      setClassId("");
      setFile(null);
      setLink("");
      setTextContent("");

    } catch (err) {

      alert(err.response?.data?.detail || "Upload failed");

    }
  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">

        <h3>Upload Study Material</h3>

        <input
          className="form-control mb-2"
          placeholder="Title"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
        />

        <input
          className="form-control mb-2"
          placeholder="Class ID (example: CS01)"
          value={classId}
          onChange={(e) => setClassId(e.target.value)}
        />

        <select
          className="form-control mb-3"
          value={type}
          onChange={(e) => setType(e.target.value)}
        >
          <option value="pdf">PDF</option>
          <option value="csv">CSV</option>
          <option value="video">YouTube Video</option>
          <option value="text">Text Notes</option>
        </select>

        {(type === "pdf" || type === "csv") && (
          <input
            type="file"
            className="form-control mb-3"
            onChange={(e) => setFile(e.target.files[0])}
          />
        )}

        {type === "video" && (
          <input
            className="form-control mb-3"
            placeholder="Paste YouTube link"
            value={link}
            onChange={(e) => setLink(e.target.value)}
          />
        )}

        {type === "text" && (
          <textarea
            className="form-control mb-3"
            rows="5"
            placeholder="Enter notes here"
            value={textContent}
            onChange={(e) => setTextContent(e.target.value)}
          />
        )}

        <button
          className="btn btn-primary"
          onClick={uploadMaterial}
        >
          Upload Material
        </button>

      </div>
    </>
  );
}