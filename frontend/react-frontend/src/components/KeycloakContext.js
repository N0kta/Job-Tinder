import React, { createContext, useState, useEffect } from "react";
import { startTokenRefreshSchedule } from "../static/js/keycloak.js";

export const AuthContext = createContext();

export function AuthProvider({ children }) {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    async function initAuth() {
      await startTokenRefreshSchedule(); // wait for first token refresh / login
      setReady(true); // now tokens are ready
    }

    initAuth();
  }, []);

  return (
    <AuthContext.Provider value={{ ready }}>
      {children}
    </AuthContext.Provider>
  );
}
