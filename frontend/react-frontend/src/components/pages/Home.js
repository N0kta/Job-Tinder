import '../../App.css'
import HeroSection from "../HeroSection";
import Cards from "../Cards";
import Footer from "../Footer";
import { useEffect, useState } from "react";

function Home() {


    return (
        <>
            <HeroSection/>
            <Cards/>
            <Footer/>
        </>
    )
}

export default Home;
