import { useEffect, useState } from "react";
import AdminNavbar from "../components/AdminNavbar";
import {
  getPendingTeachers,
  approveTeacher,
  getApprovedTeachers,
  createDepartment,
  changeAdmin,
  changeAdminPassword
} from "../services/adminService";

export default function AdminDashboard() {
  const [view, setView] = useState("pending");

  const [pending, setPending] = useState([]);
  const [approved, setApproved] = useState([]);

  const [deptName, setDeptName] = useState("");

  const [newAdminEmail, setNewAdminEmail] = useState("");
  const [adminPassword, setAdminPassword] = useState("");

  const [oldPassword, setOldPassword] = useState("");
  const [newPassword, setNewPassword] = useState("");

  useEffect(() => {
    if (view === "pending") {
      getPendingTeachers().then(res => setPending(res.data));
    }
    if (view === "approved") {
      getApprovedTeachers().then(res => setApproved(res.data));
    }
  }, [view]);

  const handleApprove = (id, approvedStatus) => {
    approveTeacher(id, approvedStatus).then(() => {
      setPending(pending.filter(t => t.id !== id));
    });
  };

  const handleCreateDept = () => {
    if (!deptName.trim()) return alert("Enter department name");
    createDepartment(deptName).then(() => {
      alert("Department created");
      setDeptName("");
    });
  };

  const handleChangeAdmin = () => {
    if (!newAdminEmail || !adminPassword)
      return alert("All fields required");

    if (!window.confirm("This will deactivate current admin. Continue?")) return;

    changeAdmin({
      new_admin_email: newAdminEmail,
      current_admin_password: adminPassword
    }).then(() => {
      alert("Admin changed. Login again.");
      localStorage.clear();
      window.location.href = "/";
    });
  };

  const handleChangePassword = () => {
    if (!oldPassword || !newPassword)
      return alert("All fields required");

    changeAdminPassword({
      old_password: oldPassword,
      new_password: newPassword
    }).then(() => {
      alert("Password updated");
      setOldPassword("");
      setNewPassword("");
    });
  };

  return (
    <>
      <AdminNavbar />

      <div className="container mt-4">
        <h2>Admin Dashboard</h2>

        <div className="btn-group my-3">
          <button className="btn btn-outline-primary" onClick={() => setView("pending")}>Pending Teachers</button>
          <button className="btn btn-outline-success" onClick={() => setView("approved")}>Approved Teachers</button>
          <button className="btn btn-outline-dark" onClick={() => setView("department")}>Create Department</button>
          <button className="btn btn-outline-danger" onClick={() => setView("admin")}>Change Admin</button>
          <button className="btn btn-outline-warning" onClick={() => setView("password")}>Change Password</button>
        </div>

        {/* PENDING TEACHERS */}
        {view === "pending" && (
          <>
            <h4>Pending Teachers</h4>
            <table className="table table-bordered">
              <thead className="table-dark">
                <tr>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                {pending.map(t => (
                  <tr key={t.id}>
                    <td>{t.username}</td>
                    <td>{t.email}</td>
                    <td>
                      <button className="btn btn-success btn-sm me-2"
                        onClick={() => handleApprove(t.id, true)}>Approve</button>
                      <button className="btn btn-danger btn-sm"
                        onClick={() => handleApprove(t.id, false)}>Reject</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </>
        )}

        {/* APPROVED TEACHERS */}
        {view === "approved" && (
          <>
            <h4>Approved Teachers</h4>
            <ul className="list-group">
              {approved.map(t => (
                <li key={t.id} className="list-group-item">
                  {t.username} ({t.email})
                </li>
              ))}
            </ul>
          </>
        )}

        {/* CREATE DEPARTMENT */}
        {view === "department" && (
          <>
            <h4>Create Department</h4>
            <input className="form-control mb-2"
              placeholder="Department name"
              value={deptName}
              onChange={e => setDeptName(e.target.value)} />
            <button className="btn btn-primary" onClick={handleCreateDept}>
              Create
            </button>
          </>
        )}

        {/* CHANGE ADMIN */}
        {view === "admin" && (
          <>
            <h4>Change Admin</h4>
            <input className="form-control mb-2"
              placeholder="New Admin Email"
              value={newAdminEmail}
              onChange={e => setNewAdminEmail(e.target.value)} />
            <input type="password" className="form-control mb-2"
              placeholder="Current Admin Password"
              value={adminPassword}
              onChange={e => setAdminPassword(e.target.value)} />
            <button className="btn btn-danger" onClick={handleChangeAdmin}>
              Change Admin
            </button>
          </>
        )}

        {/* CHANGE PASSWORD */}
        {view === "password" && (
          <>
            <h4>Change Password</h4>
            <input type="password" className="form-control mb-2"
              placeholder="Current Password"
              value={oldPassword}
              onChange={e => setOldPassword(e.target.value)} />
            <input type="password" className="form-control mb-2"
              placeholder="New Password"
              value={newPassword}
              onChange={e => setNewPassword(e.target.value)} />
            <button className="btn btn-warning" onClick={handleChangePassword}>
              Update Password
            </button>
          </>
        )}
      </div>
    </>
  );
}
