import React, {useState, useEffect} from 'react';
import {Link} from 'react-router-dom';
import {Button} from "./Button.js";
import './Navbar.css';
import '../static/js/keycloak.js'

import {redirectToLogin} from "../static/js/keycloak";

function Navbar() {
    const [click, setClick] = useState(false);
    const [button, setButton] = useState(true);

    const handleClick = () => setClick(!click);
    const closeMobileMenu = () => setClick(false);

    const showButton = () => {
        if(window.innerWidth <= 960) {
            setButton(false);
        } else {
            setButton(true);
        }
    };

    useEffect(() => {
        showButton();
    }, []);

    window.addEventListener('resize', showButton);

    return (
        <>
            <nav className="navbar">
                <div className="navbar-container">
                    <Link to="/" className={"navbar-logo"} onClick={closeMobileMenu}>
                        JOBBER<i className="fab fa-typo3"></i>
                    </Link>
                    <div className="menu-icon" onClick={handleClick}>
                        <i className={click ? 'fas fa-times' : 'fas fa-bars'}></i>
                    </div>
                    <ul className={click ? 'nav-menu active' : 'nav-menu'}>
                        <li className="nav-item">
                            <Link to="/" className='nav-links' onClick={closeMobileMenu}>
                                Home
                            </Link>
                        </li>
                        <li className="nav-item">
                            <Link to="/swipe" className='nav-links' onClick={closeMobileMenu}>
                                Swipen
                            </Link>
                        </li>
                        <li className="nav-item">
                            <Link to="/bibliothek" className='nav-links' onClick={closeMobileMenu}>
                                Bibliothek
                            </Link>
                        </li>
                        <li className="nav-item">
                            <Link to="/sign-up" className='nav-links-mobile' onClick={() => redirectToLogin()}>
                                Registrieren
                            </Link>
                        </li>
                    </ul>
                    {button && <Button buttonStyle='btn--outline' onClick={() => redirectToLogin()}>SIGN UP</Button>}
                </div>
            </nav>
        </>
    )
}

export default Navbar;