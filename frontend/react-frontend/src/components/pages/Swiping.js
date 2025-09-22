import React, { useEffect, useState, useContext } from 'react'
import '../../App.css'

import '../../static/js/userGet.js'
import { getEmployerJobs } from '../../static/js/userGet.js';

import { AuthContext } from '../../components/KeycloakContext.js';

//import TinderCard from "../TinderCard.js"
import TinderCard from 'react-tinder-card'


export default function Swiping() {
    const [data, setData] = useState([]); // store jobs here
    const [loading, setLoading] = useState(true);
    const { role } = useContext(AuthContext); // wait for tokens

    let test = "nichts"


    useEffect(() => {
        if (!role && role==="employer") return;
        async function fetchJobs() {
            const jobs = await getEmployerJobs(); // wait for the API call
            setData(jobs); // save to state
        }

        fetchJobs();
    }, [role]); // empty deps = run once on mount
    useEffect(() => {
        console.log("this should be full: ")
        console.log(data)
        console.log(role)
    }, [data])
    if (role === "employer") {
        test="du bist nicht wilkommen"
    } else {
        test="Hier wartet dein Traumjob"
    }

  const [currentIndex, setCurrentIndex] = useState(data.length - 1);

    const swiped = (direction, cardId) => {
        console.log("Swiped " + direction + " on " + cardId);
        setCurrentIndex((prev) => prev - 1);
    };

    const outOfFrame = (job) => {
        console.log(job.title + " left the screen");
    };
    return (
    <div>
        <div
  style={{
    position: "relative",
    width: "100vw",       // full viewport width
    height: "100vh",      // full viewport height
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
  }}
>

  {data.map((job, index) => (
    <TinderCard
  key={job.id}
  onSwipe={(dir) => swiped(dir, job.id)}
  preventSwipe={["up", "down"]}
  style={{ width: "400px", height: "auto" }} // ensure TinderCard wrapper matches
>

      <div
  style={{
    position: "absolute",
    width: "400px",       // fixed width
    maxWidth: "400px",
    minHeight: "250px",
    maxHeight: "80vh",
    background: "white",
    borderRadius: "16px",
    boxShadow: "0px 8px 20px rgba(0,0,0,0.25)",
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-between",
    padding: "24px",
    boxSizing: "border-box",
    zIndex: data.length - index,
  }}
>

        <h2 style={{ marginBottom: "10px" }}>{job.titel}</h2>
        <p style={{
          marginBottom: "15px",
          overflowY: "auto",            // 🔹 scroll if description is long
          flex: 1,
        }}>
          {job.description}
        </p>
        <small style={{ color: "#666" }}>
          Posted: {new Date(job.created_at).toLocaleDateString()}
        </small>
      </div>
    </TinderCard>
  ))}
</div>



    </div>)
}