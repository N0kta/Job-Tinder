import React from 'react';
import {Button} from "./Button";
import './Footer.css';
import {Link} from "react-router-dom";

function Footer() {
    return (
        <div className="footer-container">
            <section className="footer-subscription">
                <p className="footer-subscription-heading">
                    erhalte unseren Newsletter
                </p>
                <p className="footer-subscription-text">
                    du kannst dich jederzeit abmelden
                </p>
                <div className="input-areas">
                    <form>
                        <input type="email" name="email" placeholder="Email" className="footer-input"/>
                    </form>
                    <Button buttonStyle='btn--outline'> Abonnieren </Button>
                </div>
            </section>
            <div className="footer-links">
                <div className="footer-link-wrapper">
                    <div className="footer-link-items">
                        <h2>Über uns</h2>
                        <Link to='/sign-up'>So geht's</Link>
                        <Link to='/'>Partner</Link>
                    </div>
                </div>
            </div>
            <section className="social-media">
                <div className="social-media-wrap">
                    <div className="footer-logo">
                        <Link to='/' className='social-logo'>
                            JOBBER <i className='fab fa-typo3'/>
                        </Link>
                    </div>
                    <small className="website-rights">JOBBER 2025</small>
                    <div className='social-icons'>
                        <Link to='/' className='social-icon-link'
                        traget='_blank'
                        aria-label='GitHub'>
                            <i className='fab fa-github'/>
                        </Link>
                        <Link to='/' className='social-icon-link'
                        traget='_blank'
                        aria-label='Instagram'>
                        <i className='fab fa-instagram'/>
                        </Link>
                        <Link to='/' className='social-icon-link'
                              traget='_blank'
                              aria-label='Twitter'>
                            <i className='fab fa-twitter'/>
                        </Link>
                        <Link to='/' className='social-icon-link'
                              traget='_blank'
                              aria-label='LinkedIn'>
                            <i className='fab fa-linkedin'/>
                        </Link>
                    </div>
                </div>
            </section>
        </div>
    )
}

export default Footer;