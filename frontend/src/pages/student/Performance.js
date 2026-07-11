import React, { useEffect, useState } from "react";
import axios from "axios";

function Performance() {

  const [marks,setMarks] = useState([]);
  const [attendance,setAttendance] = useState(0);
  const [risk,setRisk] = useState("");

  const student = JSON.parse(localStorage.getItem("user"));
  const studentId = student?.id;

  useEffect(()=>{
    if(studentId){
      fetchMarks();
      fetchAnalytics();
      fetchRisk();
    }
  },[studentId]);


  const fetchMarks = async () => {

    try{

      const res = await axios.get(
        `http://127.0.0.1:8000/student-dashboard/marks/${studentId}`
      );

      setMarks(res.data);

    }catch(err){
      console.log("Marks error",err);
    }

  };


  const fetchAnalytics = async () => {

    try{

      const res = await axios.get(
        `http://127.0.0.1:8000/student-dashboard/analytics/${studentId}`
      );

      setAttendance(res.data.attendance);

    }catch(err){

      console.log(err);

    }

  };


  const fetchRisk = async () => {

    try{

      const res = await axios.get(
        `http://127.0.0.1:8000/student-dashboard/risk/${studentId}`
      );

      setRisk(res.data.risk_level);

    }catch(err){

      console.log(err);

    }

  };


  const averageMarks = () => {

    if(marks.length === 0) return 0;

    const total = marks.reduce(
      (sum,m)=>sum + (m.marks/m.max_marks)*100,
      0
    );

    return (total/marks.length).toFixed(2);

  };


  const getPercentage = (m) => {
    return ((m.marks / m.max_marks) * 100).toFixed(1);
  };


  const getGrade = (percent) => {

    if(percent >= 90) return "A+";
    if(percent >= 80) return "A";
    if(percent >= 70) return "B";
    if(percent >= 60) return "C";
    if(percent >= 50) return "D";

    return "F";

  };


  return (

    <div style={{padding:"40px"}}>

      <h2>Student Performance Report</h2>

      {/* Summary Cards */}

      <div style={{
        display:"flex",
        gap:"30px",
        marginTop:"30px"
      }}>

        <div style={{
          flex:1,
          background:"#e3f2fd",
          padding:"20px",
          borderRadius:"10px"
        }}>
          <h3>Average Marks</h3>
          <h2>{averageMarks()}%</h2>
        </div>

        <div style={{
          flex:1,
          background:"#e8f5e9",
          padding:"20px",
          borderRadius:"10px"
        }}>
          <h3>Attendance</h3>
          <h2>{attendance}%</h2>
        </div>

        <div style={{
          flex:1,
          background:"#fff3cd",
          padding:"20px",
          borderRadius:"10px"
        }}>
          <h3>Risk Level</h3>
          <h2>{risk}</h2>
        </div>

      </div>


      {/* Marks Table */}

      <h3 style={{marginTop:"40px"}}>Exam Marks</h3>

      <table
        style={{
          width:"100%",
          marginTop:"10px",
          borderCollapse:"collapse"
        }}
      >

        <thead>
          <tr style={{background:"#f5f5f5"}}>
            <th>Subject</th>
            <th>Exam</th>
            <th>Marks</th>
            <th>Max</th>
            <th>Percentage</th>
            <th>Grade</th>
          </tr>
        </thead>

        <tbody>

          {marks.map((m,index)=>{

            const percent = getPercentage(m);
            const grade = getGrade(percent);

            return(

              <tr key={index} style={{textAlign:"center"}}>

                <td>{m.subject}</td>
                <td>{m.exam_type}</td>
                <td>{m.marks}</td>
                <td>{m.max_marks}</td>
                <td>{percent}%</td>
                <td>{grade}</td>

              </tr>

            )

          })}

        </tbody>

      </table>

    </div>

  );

}

export default Performance;