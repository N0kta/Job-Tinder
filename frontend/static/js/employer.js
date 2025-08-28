async function createNewJob() {
  const jobData = {
    titel: "Senior Software Engineer",
    description: "Develop and maintain web applications using modern frameworks.",
  };

  // 1. Retrieve the access token from local storage
  const accessToken = localStorage.getItem("access_token");

  // Optional: Add a check to ensure the token exists
  if (!accessToken) {
    console.error("No access token found. Please log in.");
    return;
  }

  try {
    const response = await fetch("http://your-fastapi-backend-url/jobs/", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        // 2. Add the Authorization header
        "Authorization": `Bearer ${accessToken}`
      },
      body: JSON.stringify(jobData),
    });

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const createdJob = await response.json();
    console.log("Job created successfully:", createdJob);
    return createdJob;

  } catch (error) {
    console.error("Error creating job:", error);
  }
}