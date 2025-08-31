const app_uri = "https://jobtinder.local/api/jobs"

async function fetchData(url) {
    const token = localStorage.getItem("access_token");
    const headers = {
        'Content-Type': 'application/json'
    };
    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    try {
        const response = await fetch(app_uri+url, { headers });
        if (!response.ok) {
            const errorText = await response.text();
            throw new Error(`HTTP error! status: ${response.status} - ${errorText}`);
        }
        return await response.json();
    } catch (error) {
        console.error("Fetch error:", error);
        throw error;
    }
}

//Retrieves all jobs created by the authenticated employer.
async function getEmployerJobs() {
    return fetchData("/library");
}

//Retrieves all applications for the authenticated seeker.
async function getSeekerApplications() {
    return fetchData("/applications");
}

//Retrieves all applications for a specific job, for the employer who owns it.
async function getJobApplicationsForEmployer(jobId) {
    return fetchData(`/applications/${jobId}`);
}

//Retrieves all chat rooms that the authenticated user is a participant of.
async function getUserChatRooms() {
    return fetchData("/chat_rooms");
}

//Retrieves all messages for a specific chat room, if the user is a participant.
async function getChatRoomMessages(chatRoomId) {
    return fetchData(`/chat_rooms/${chatRoomId}/messages`);
}

//Retrieves all public templates. No authentication is required.
async function getPublicTemplates() {
    return fetchData("/templates");
}

//Retrieves all templates created by the authenticated user.
async function getUserTemplates() {
    return fetchData("/templates/user");
}

export { getEmployerJobs, getSeekerApplications, getJobApplicationsForEmployer, getUserChatRooms, getChatRoomMessages, getPublicTemplates, getUserTemplates }
