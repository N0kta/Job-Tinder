const app_url = "https://jobtinder.local"
const keycloak_url="https://jobtinder.local/keycloak"
const redirect_uri=app_url+"/auth/callback"
const client_id="jobtinder-app"
const realm = "FastAPI";


function generateRandomString(length) {
    const array = new Uint32Array(length);
    window.crypto.getRandomValues(array);
    return Array.from(array, dec => ("0" + dec.toString(16)).slice(-2)).join("");
}

async function sha256(plain) {
    const encoder = new TextEncoder();
    const data = encoder.encode(plain);
    const hash = await window.crypto.subtle.digest("SHA-256", data);
    return btoa(String.fromCharCode(...new Uint8Array(hash)))
        .replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

async function createPKCECodes() {
    const verifier = generateRandomString(64);
    const challenge = await sha256(verifier);
    localStorage.setItem("pkce_verifier", verifier);
    return challenge;
}

async function redirectToLogin() {
    const challenge = await createPKCECodes();
    const url = keycloak_url+`/realms/FastAPI/protocol/openid-connect/auth` +
        `?client_id=${client_id}` +
        `&response_type=code` +
        `&scope=openid` +
        `&redirect_uri=${redirect_uri}` +
        `&code_challenge=${challenge}` +
        `&code_challenge_method=S256`;

    window.location.href = url;
}


async function getTokensWithCode(code) {
    const verifier = localStorage.getItem("pkce_verifier");

    // Exchange code for tokens directly with Keycloak
    const response = await fetch(keycloak_url+"/realms/FastAPI/protocol/openid-connect/token", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
        grant_type: "authorization_code",
        client_id: client_id,
        code: code,
        redirect_uri: redirect_uri,
        code_verifier: verifier,
        })
    });

    const tokens = await response.json();

    // Store tokens in memory or cookie
    localStorage.clear();
    localStorage.setItem("access_token", tokens.access_token);
    localStorage.setItem("refresh_token", tokens.refresh_token);
    localStorage.setItem("id_token", tokens.id_token);

    window.history.replaceState({}, document.title, redirect_uri); 
}

async function refreshTokens() {
    const refresh_token = localStorage.getItem("refresh_token");
    if (!refresh_token) return null;

    const response = await fetch(keycloak_url + "/realms/FastAPI/protocol/openid-connect/token", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
        grant_type: "refresh_token",
        client_id: client_id,
        refresh_token: refresh_token,
        }),
    });

    if (!response.ok) {
        console.error("Refresh failed");
        return null;
    }

    const tokens = await response.json();
    localStorage.setItem("access_token", tokens.access_token);
    localStorage.setItem("refresh_token", tokens.refresh_token);
    localStorage.setItem("id_token", tokens.id_token);
}

function parseJwt(token) {
    try {
        return JSON.parse(atob(token.split('.')[1]));
    } catch (e) {
        return null;
    }
}

async function startTokenRefreshSchedule() {
    const params = new URLSearchParams(window.location.search);
    const code = params.get("code");
    if (code) {
        await getTokensWithCode(code)
    }
    
    const access_token = localStorage.getItem("access_token")
    if (access_token == "undefined") {
        console.log("Du muss wieder log innen")
        return
    }
    const payload = parseJwt(access_token)
    const refreshTime = payload.exp*1000 - Date.now() - 5000
    if (refreshTime > 0) {
        console.log("Scheduling token refresh in", (refreshTime) / 1000, "seconds");
        setTimeout(
            () => {refreshTokens().then(startTokenRefreshSchedule)},
            refreshTime)
    } else {
        refreshTokens().then(startTokenRefreshSchedule)
    }
}

async function fetchProtected() {
    const token = localStorage.getItem("access_token");

    const response = await fetch(app_url+"/protected", {
        headers: { Authorization: `Bearer ${token}` }
    });

    const data = await response.json();
    console.log("Protected data:", data);
}

function logout() {
    const idToken = localStorage.getItem("id_token");
    localStorage.clear();

    // Redirect to Keycloak logout endpoint
    window.location.href =
        `${keycloak_url}/realms/FastAPI/protocol/openid-connect/logout` +
        `?id_token_hint=${encodeURIComponent(idToken)}` +
        `&post_logout_redirect_uri=${encodeURIComponent(redirect_uri)}`;
}

export { startTokenRefreshSchedule, logout, fetchProtected, redirectToLogin };
