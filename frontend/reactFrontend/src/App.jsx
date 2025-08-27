import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import React from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import HomePage from "./HomePage.jsx";
import AboutPage from "./AboutPage.jsx";
import ContactPage from "./ContactPage.jsx";
import SwipePage from "./SwipePage.jsx";
import ClientPage from "./ClientPage.jsx";

function App() {
    return (
        <Router>
            <nav>
                <ul>
                    <li><Link to='/clients'>Diese Firmen vertrauen uns</Link></li>
                    <li><Link to='/swipe'>Swipen hierrr!!</Link></li>
                    <li><Link to="/about">About</Link></li>
                    <li><Link to="/contact">Contact</Link></li>
                    <li><Link to="/">Home</Link></li>
                </ul>
            </nav>

            <Routes>
                <Route path="/clients" element={<ClientPage />} />
                <Route path="/swipe" element={<SwipePage/>} />
                <Route path="/contact" element={<ContactPage/>} />
                <Route path="/" element={<HomePage/>} />
                <Route path="/about" element={<AboutPage/>} />
            </Routes>
        </Router>
    );
}


export default App;
