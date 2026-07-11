import TeacherNavbar from "../../components/TeacherNavbar";

export default function Predictions() {
  return (
    <>
      <TeacherNavbar />

      <div className="container mt-4">
        <h3>Student Predictions</h3>
        <p>
          Student risk prediction results (ML output) will be shown here.
        </p>
      </div>
    </>
  );
}
