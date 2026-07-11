import React, { useState } from "react";

function CreateQuiz() {
  const [title, setTitle] = useState("");
  const [syllabus, setSyllabus] = useState("");
  const [difficulty, setDifficulty] = useState("easy");
  const [numQuestions, setNumQuestions] = useState(5);

  const [quizData, setQuizData] = useState(null);
  const [loading, setLoading] = useState(false);

  // -----------------------------------------
  // GENERATE QUIZ
  // -----------------------------------------
  const handleGenerate = async () => {

    if (!title || !syllabus) {
      alert("Please enter title and syllabus");
      return;
    }

    setLoading(true);

    try {

      const response = await fetch(
        "http://127.0.0.1:8000/teacher/generate-quiz",
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            title: title,
            syllabus_text: syllabus,
            difficulty: difficulty,
            num_questions: parseInt(numQuestions)
          })
        }
      );

      const data = await response.json();

      if (!response.ok) {
        alert(data.detail || "Quiz generation failed");
        return;
      }

      setQuizData(data);

    } catch (error) {
      console.error("Error generating quiz:", error);
      alert("Failed to generate quiz");
    }

    setLoading(false);
  };


  // -----------------------------------------
  // PROCEED (ACTIVATE QUIZ)
  // -----------------------------------------
  const handleProceed = async () => {

    try {

      const response = await fetch(
        `http://127.0.0.1:8000/teacher/activate-quiz/${quizData.quiz_id}`,
        {
          method: "PATCH"
        }
      );

      if (!response.ok) {
        alert("Failed to activate quiz");
        return;
      }

      alert("Quiz successfully sent to students 🚀");

    } catch (error) {
      console.error(error);
      alert("Error activating quiz");
    }

  };


  return (
    <div style={{ padding: "30px", maxWidth: "800px", margin: "auto" }}>

      <h2>AI Quiz Generator</h2>

      {/* Quiz Title */}
      <div style={{ marginBottom: "20px" }}>
        <input
          type="text"
          placeholder="Quiz Title"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          style={{ width: "100%", padding: "10px" }}
        />
      </div>

      {/* Syllabus */}
      <div style={{ marginBottom: "20px" }}>
        <textarea
          placeholder="Enter syllabus or topic description..."
          rows="5"
          value={syllabus}
          onChange={(e) => setSyllabus(e.target.value)}
          style={{ width: "100%", padding: "10px" }}
        />
      </div>

      {/* Difficulty */}
      <div style={{ marginBottom: "20px" }}>
        <label>Difficulty: </label>

        <select
          value={difficulty}
          onChange={(e) => setDifficulty(e.target.value)}
        >
          <option value="easy">Easy</option>
          <option value="medium">Medium</option>
          <option value="hard">Hard</option>
        </select>
      </div>

      {/* Number of Questions */}
      <div style={{ marginBottom: "20px" }}>
        <label>Number of Questions: </label>

        <input
          type="number"
          value={numQuestions}
          min="1"
          max="20"
          onChange={(e) => setNumQuestions(e.target.value)}
        />
      </div>

      {/* Generate Button */}
      <button onClick={handleGenerate} disabled={loading}>
        {loading ? "Generating..." : "Generate Quiz"}
      </button>


      {/* Generated Questions */}
      {quizData && quizData.questions && (

        <div style={{ marginTop: "40px" }}>

          <h3>Generated Questions</h3>

          {quizData.questions.map((q, index) => (

            <div key={index} style={{ marginBottom: "25px" }}>

              <strong>
                {index + 1}. {q.question_text}
              </strong>

              <ul>
                {q.options.map((opt, i) => (
                  <li key={i}>{opt}</li>
                ))}
              </ul>

              <p style={{ color: "gray" }}>
                Hint: {q.hint}
              </p>

              <hr />

            </div>

          ))}

          {/* Proceed Button */}
          <button
            onClick={handleProceed}
            style={{
              padding: "10px 20px",
              backgroundColor: "green",
              color: "white",
              border: "none",
              cursor: "pointer"
            }}
          >
            Proceed (Send Quiz to Students)
          </button>

        </div>

      )}

    </div>
  );
}

export default CreateQuiz;