import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

import { AuthProvider } from "./components/KeycloakContext.js"; // wherever your function lives

ReactDOM.createRoot(document.getElementById('root')).render(
    <AuthProvider>
        <App/>
    </AuthProvider>
);

