import { useState } from "react";
import TeacherNavbar from "../../components/TeacherNavbar";

export default function UploadSyllabus() {
  const [text, setText] = useState("");

  const submit = () => {
    alert("Syllabus saved (backend will be connected later)");
    setText("");
  };

  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">
        <h3>Upload Syllabus</h3>

        <textarea
          className="form-control"
          rows="6"
          placeholder="Paste syllabus content here"
          value={text}
          onChange={e => setText(e.target.value)}
        />

        <button className="btn btn-primary mt-3" onClick={submit}>
          Save Syllabus
        </button>
      </div>
    </>
  );
}
