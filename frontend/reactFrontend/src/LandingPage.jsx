import { useState } from "react";
import { Menu, X } from "lucide-react";
import { motion } from "framer-motion";

export default function LandingPage() {
    const [menuOpen, setMenuOpen] = useState(false);

    return (
        <div className="min-h-screen flex flex-col bg-gray-50 text-gray-800">
            {/* Navbar */}
            <nav className="w-full flex items-center justify-between px-6 py-4 bg-white shadow-md fixed top-0 z-50">
                <h1 className="text-2xl font-bold text-indigo-600">JobTinder</h1>

                {/* Desktop Menu */}
                <div className="hidden md:flex space-x-8 items-center">
                    <a href="#features" className="hover:text-indigo-600">Features</a>
                    <a href="#about" className="hover:text-indigo-600">Über Uns</a>
                    <a href="#contact" className="hover:text-indigo-600">Kontakt</a>
                    <button className="px-4 py-2 rounded-xl bg-indigo-600 text-white hover:bg-indigo-700 transition">
                        Login
                    </button>
                    <button className="px-4 py-2 rounded-xl border border-indigo-600 text-indigo-600 hover:bg-indigo-50 transition">
                        Registrieren
                    </button>
                </div>

                {/* Mobile Menu Button */}
                <button onClick={() => setMenuOpen(!menuOpen)} className="md:hidden">
                    {menuOpen ? <X size={28} /> : <Menu size={28} />}
                </button>
            </nav>

            {/* Mobile Menu */}
            {menuOpen && (
                <motion.div
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, y: -20 }}
                    className="absolute top-16 left-0 w-full bg-white shadow-md flex flex-col items-center space-y-4 py-6 md:hidden z-40"
                >
                    <a href="#features" className="hover:text-indigo-600">Features</a>
                    <a href="#about" className="hover:text-indigo-600">Über Uns</a>
                    <a href="#contact" className="hover:text-indigo-600">Kontakt</a>
                    <button className="px-4 py-2 rounded-xl bg-indigo-600 text-white hover:bg-indigo-700 transition">
                        Login
                    </button>
                    <button className="px-4 py-2 rounded-xl border border-indigo-600 text-indigo-600 hover:bg-indigo-50 transition">
                        Registrieren
                    </button>
                </motion.div>
            )}

            {/* Hero Section */}
            <section className="flex flex-col md:flex-row items-center justify-between flex-1 px-8 md:px-20 mt-24">
                <div className="max-w-lg text-center md:text-left space-y-6">
                    <motion.h2
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.6 }}
                        className="text-4xl md:text-5xl font-extrabold text-gray-900"
                    >
                        Finde deinen Traumjob. Einfach swipen.
                    </motion.h2>
                    <p className="text-lg text-gray-600">
                        JobTinder verbindet dich mit den besten Unternehmen – schnell, unkompliziert und modern.
                    </p>
                    <div className="flex flex-col md:flex-row gap-4 md:gap-6 justify-center md:justify-start">
                        <button className="px-6 py-3 rounded-xl bg-indigo-600 text-white hover:bg-indigo-700 transition text-lg font-medium">
                            Jetzt registrieren
                        </button>
                        <button className="px-6 py-3 rounded-xl border border-indigo-600 text-indigo-600 hover:bg-indigo-50 transition text-lg font-medium">
                            Login
                        </button>
                    </div>
                </div>

                <motion.img
                    initial={{ opacity: 0, x: 50 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.6 }}
                    src="https://illustrations.popsy.co/violet/job-hunt.svg"
                    alt="Job search illustration"
                    className="w-full md:w-1/2 max-w-md mt-12 md:mt-0"
                />
            </section>

            {/* Footer */}
            <footer className="bg-white py-6 text-center text-gray-500 mt-12 border-t">
                © {new Date().getFullYear()} JobTinder. Alle Rechte vorbehalten.
            </footer>
        </div>
    );
}
