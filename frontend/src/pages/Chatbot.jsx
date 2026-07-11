import React, { useState } from "react";
import API from "../services/api";

function Chatbot() {
  const [message, setMessage] = useState("");
  const [reply, setReply] = useState("");

  const askBot = async () => {
    const res = await API.post("/chatbot/ask", {
      role: "student",
      message,
      context: "Machine Learning",
    });

    setReply(res.data.reply);
  };

  return (
    <div style={{ padding: 40 }}>
      <h2>Academic Chatbot</h2>

      <textarea
        rows="4"
        cols="50"
        placeholder="Ask something..."
        onChange={(e) => setMessage(e.target.value)}
      />
      <br /><br />

      <button onClick={askBot}>Ask</button>

      <p><b>Reply:</b></p>
      <p>{reply}</p>
    </div>
  );
}

export default Chatbot;
