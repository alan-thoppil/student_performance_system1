import React, { useEffect, useState } from "react";
import axios from "axios";

function Attendance() {

  const [attendance,setAttendance] = useState([]);
  const [weeks,setWeeks] = useState([]);
  const [monthName,setMonthName] = useState("");
  const [monthlyPercentage,setMonthlyPercentage] = useState(0);

  useEffect(() => {

    generateWeeks();

    const fetchAttendance = async () => {

      try {

        const token = localStorage.getItem("token");
        const studentId = localStorage.getItem("user_id");

        const res = await axios.get(
          `http://127.0.0.1:8000/student-dashboard/attendance/${studentId}`,
          {
            headers:{
              Authorization:`Bearer ${token}`
            }
          }
        );

        const cleaned = res.data.map(a => ({
          ...a,
          date: new Date(a.date).toISOString().split("T")[0]
        }));

        setAttendance(cleaned);

        calculateMonthlyPercentage(cleaned);

      } catch(err) {

        console.log("Attendance error",err);
        setAttendance([]);

      }

    };

    fetchAttendance();

  }, []);


  const generateWeeks = () => {

    const today = new Date();
    const year = today.getFullYear();
    const month = today.getMonth();

    const monthLabel =
      today.toLocaleDateString("en-US",{month:"long"});

    setMonthName(monthLabel);

    const daysInMonth =
      new Date(year,month+1,0).getDate();

    let days=[];

    for(let i=1;i<=daysInMonth;i++){

      const d = new Date(year,month,i);

      // only show today and past days
      if(d > today) continue;

      days.push({
        date:d.toISOString().split("T")[0],
        day:d.toLocaleDateString("en-US",{weekday:"short"}).toUpperCase(),
        displayDate:d.toLocaleDateString("en-US",{month:"short",day:"2-digit"})
      });

    }

    let grouped=[];

    for(let i=0;i<days.length;i+=7){

      const week = days.slice(i,i+7);

      grouped.push({
        days:week,
        start:week[0].displayDate,
        end:week[week.length-1].displayDate
      });

    }

    setWeeks(grouped);

  };


  const calculateMonthlyPercentage = (data) => {

    const total = data.length;

    const present =
      data.filter(a=>a.status==="present").length;

    const percent =
      total ? Math.round((present/total)*100) : 0;

    setMonthlyPercentage(percent);

  };


  const calculateWeeklyPercentage = (weekDays) => {

    const weekRecords = attendance.filter(a =>
      weekDays.some(d => d.date === a.date)
    );

    const total = weekRecords.length;

    const present =
      weekRecords.filter(a=>a.status==="present").length;

    return total
      ? Math.round((present/total)*100)
      : 0;

  };


  const getStatus = (date,period) => {

    const record = attendance.find(
      a => a.date === date && Number(a.period) === Number(period)
    );

    if(!record) return "U";

    return record.status === "present"
      ? "P"
      : "A";

  };


  const getColor = (s) => {

    if(s==="P") return "#2BBBAD";
    if(s==="A") return "#E74C3C";

    return "#E5E7EB";

  };


  return (

    <div style={{padding:"20px"}}>

      <h2>
        {monthName} Attendance ({monthlyPercentage}%)
      </h2>

      <div style={{
        display:"grid",
        gridTemplateColumns:"1fr 1fr",
        gap:"18px",
        marginTop:"20px"
      }}>

        {weeks.map((week,index)=>{

          const weekPercent =
            calculateWeeklyPercentage(week.days);

          return(

            <div
              key={index}
              style={{
                border:"1px solid #ddd",
                borderRadius:"8px",
                padding:"10px"
              }}
            >

              <h4>
                Week {index+1}
                {" "}
                ({week.start} – {week.end})
                {" "}
                {weekPercent}%
              </h4>

              {week.days.map((day,i)=>(

                <div
                  key={i}
                  style={{
                    display:"flex",
                    justifyContent:"space-between",
                    alignItems:"center",
                    margin:"4px 0"
                  }}
                >

                  <div
                    style={{
                      width:"110px",
                      fontWeight:"600",
                      fontSize:"14px"
                    }}
                  >
                    {day.day} {day.displayDate}
                  </div>


                  <div style={{
                    display:"flex",
                    gap:"4px"
                  }}>

                    {[1,2,3,4,5].map((p)=>{

                      const status =
                        getStatus(day.date,p);

                      return(

                        <div
                          key={p}
                          style={{
                            width:"24px",
                            height:"24px",
                            borderRadius:"50%",
                            background:getColor(status),
                            display:"flex",
                            alignItems:"center",
                            justifyContent:"center",
                            fontSize:"11px",
                            color:"#fff",
                            fontWeight:"bold"
                          }}
                        >
                          {status}
                        </div>

                      );

                    })}

                  </div>

                </div>

              ))}

            </div>

          )

        })}

      </div>

    </div>

  );

}

export default Attendance;