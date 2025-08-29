import React from 'react';
import {Button} from "./Button";
import './HeroSection.css';
import '../App.css';

function HeroSection() {
    return (
        <div className="hero-container">
            <video src="/videos/video-1.mp4" autoPlay loop muted playsInline/>
            <h1>DEIN TRAUMJOB. HIER.</h1>
            <p>worauf wartest du?</p>
            <div className="hero-btns">
                <Button className="btns"
                        buttonStyle="btn--outline"
                        buttonClass="btn--large"
                        >
                    Hier Klicken!
                </Button>
                <Button className="btns"
                        buttonStyle="btn--primary"
                        buttonClass="btn--large"
                >
                    Trailer angucken <i className={'far fa-play-circle'} />
                </Button>
            </div>
        </div>
    )
}

export default HeroSection;

