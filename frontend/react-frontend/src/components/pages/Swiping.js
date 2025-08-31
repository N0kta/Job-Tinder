import React, { useEffect, useState, useContext } from 'react'
import '../../App.css'

import '../../static/js/userGet.js'
import { getEmployerJobs } from '../../static/js/userGet.js';

import { AuthContext } from '../../components/KeycloakContext.js';

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
    
    return <h1 className='swiping'>Hier wartet dein Traumjob</h1>
}