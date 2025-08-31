import './App.css';
import Navbar from './components/Navbar.js';
import {BrowserRouter as Router, Routes, Route} from "react-router-dom";
import Home from './components/pages/Home';
import Swiping from "./components/pages/Swiping";
import Bibliothek from "./components/pages/Bibliothek";


function App() {
  return (
    <div className="App">
        <Router>
        <Navbar />
            <Routes>
                <Route path={'/'} element={<Home/>} />
                <Route path={'/swipe'} element={<Swiping/>} />
                <Route path={'/bibliothek'} element={<Bibliothek/>} />
            </Routes>
        </Router>
    </div>
  );
}

export default App;
