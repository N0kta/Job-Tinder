import React, { createContext, useState, useEffect } from "react";
import { startTokenRefreshSchedule, parseJwt } from "../static/js/keycloak.js";

export const AuthContext = createContext();

export function AuthProvider({ children }) {
  const [role, setRole] = useState(false);

  useEffect(() => {
    async function initAuth() {
      await startTokenRefreshSchedule(); // wait for first token refresh / login
      const payload = parseJwt(localStorage.getItem("access_token"))
      setRole(payload.role); // now tokens are ready
    }

    initAuth();
  }, []);

  return (
    <AuthContext.Provider value={{ role }}>
      {children}
    </AuthContext.Provider>
  );
}
