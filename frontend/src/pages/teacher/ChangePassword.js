import React, { useState } from "react";
import axios from "axios";

function ChangePassword() {

  const [current, setCurrent] = useState("");
  const [newpass, setNewpass] = useState("");

  const changePassword = async () => {

    try {

      const user_id = localStorage.getItem("user_id");

      await axios.post("http://127.0.0.1:8000/teacher/change-password",
        new URLSearchParams({
          user_id: user_id,
          current_password: current,
          new_password: newpass
        })
      );

      alert("Password changed successfully");

    } catch {
      alert("Failed to change password");
    }
  };

  return (
    <div className="container mt-5">

      <h3>Change Password</h3>

      <input
        type="password"
        placeholder="Current Password"
        className="form-control mb-3"
        onChange={(e)=>setCurrent(e.target.value)}
      />

      <input
        type="password"
        placeholder="New Password"
        className="form-control mb-3"
        onChange={(e)=>setNewpass(e.target.value)}
      />

      <button className="btn btn-primary" onClick={changePassword}>
        Change Password
      </button>

    </div>
  );
}

export default ChangePassword;