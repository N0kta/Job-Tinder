import React from 'react';
import CardItem from "./CardItem";
import "./Cards.css"

function Cards() {
    return (
        <div className="cards">
            <h1>schau dir diese wunderbaren jobs an!!</h1>
            <div className="cards__container">
                <div className="cards__wrapper">
                    <div className="cards__items">
                        <CardItem
                        src="/images/img.jpg"
                        text="Unsere Partner stecken voller Wunder"
                        label="Partner"
                        path0="/bibliothek"
                        />
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Cards;