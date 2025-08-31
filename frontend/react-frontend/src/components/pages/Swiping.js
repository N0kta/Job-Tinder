import React, { useEffect, useState, useContext } from 'react'
import '../../App.css'

import '../../static/js/userGet.js'
import { getEmployerJobs } from '../../static/js/userGet.js';

import { AuthContext } from '../../components/KeycloakContext.js';

//import TinderCard from "../TinderCard.js"
import TinderCard from 'react-tinder-card'


export default function Swiping() {
    const [data, setData] = useState("kasekuchen"); // store jobs here
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
     const cards = [
    { id: 1, text: "Job 1 - Backend Developer" },
    { id: 2, text: "Job 2 - Frontend Developer" },
    { id: 3, text: "Job 3 - Data Scientist" },
  ];

  const [currentIndex, setCurrentIndex] = useState(cards.length - 1);

    const swiped = (direction, cardId) => {
        console.log("Swiped " + direction + " on " + cardId);
        setCurrentIndex((prev) => prev - 1);
    };

    const outOfFrame = (job) => {
        console.log(job.title + " left the screen");
    };
    return (
    <div>
        <h1 className='swiping'>{test}</h1>
        <div
        style={{
            position: "relative",
            width: "300px",
            height: "400px",
            margin: "50px auto",
        }}
        >
        {cards.map((card, index) => (
            <TinderCard
            key={card.id}
            onSwipe={(dir) => swiped(dir, card.text)}
            preventSwipe={["up", "down"]}
            >
            <div
                style={{
                position: "absolute",
                width: "100%",
                height: "100%",
                background: "white",
                borderRadius: "10px",
                boxShadow: "0px 5px 15px rgba(0,0,0,0.2)",
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                fontSize: "20px",
                fontWeight: "bold",
                top: 0,
                left: 0,
                zIndex: index,
                }}
            >
                {card.text}
            </div>
            </TinderCard>
        ))}
        </div>
    </div>)
}