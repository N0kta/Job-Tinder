import React, { useEffect, useState, useContext } from 'react'
import '../../App.css'

import '../../static/js/userGet.js'
import { getEmployerJobs } from '../../static/js/userGet.js';

import { AuthContext } from '../../components/KeycloakContext.js';

//import TinderCard from "../TinderCard.js"
import TinderCard from 'react-tinder-card'
import { animated } from '@react-spring/web'
export default function Swiping() {
    const [data, setData] = useState("kasekuchen"); // store jobs here
    const [loading, setLoading] = useState(true);

      const { ready } = useContext(AuthContext); // wait for tokens

    useEffect(() => {
        if (!ready) return;
        async function fetchJobs() {
            const jobs = await getEmployerJobs(); // wait for the API call
            setData(jobs); // save to state
        }

        fetchJobs();
    }, [ready]); // empty deps = run once on mount
    useEffect(() => {
        console.log("this should be full: ")
        console.log(data)
    }, [data])
    
    return (
    <div>
        <h1 className='swiping'>Hier wartet dein Traumjob</h1>
        <TinderCard onSwipe={(direction) => console.log("swiped: "+ direction)} onCardLeftScreen={() => console.log("card left screen")} preventSwipe={['right', 'left']}>Hello, World!</TinderCard>
    </div>)
}