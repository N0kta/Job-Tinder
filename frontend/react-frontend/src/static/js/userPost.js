const app_uri = "https://jobtinder.local/api/jobs"

async function createPostRequest(data, path, successMessage = "Created Object: ", errorMessage = "Error: ") {
 const accessToken = localStorage.getItem("access_token");
  if (!accessToken) {
    console.error("No access token found. Please log in.");
    return;
  }

  const requestOptions = {
    method: "POST",
    headers: {
      "Authorization": `Bearer ${accessToken}`
    }
  };

  if (data !== null) {
    requestOptions.headers["Content-Type"] = "application/json";
    requestOptions.body = JSON.stringify(data);
  }

  try {
    const response = await fetch(app_uri + path, requestOptions);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const createdPost = await response.json();
    console.log(successMessage, createdPost);
    return createdPost;
  } catch (error) {
    console.error(errorMessage, error);
  }
}

async function createJob(titel, description) {
  const jobData = {
    titel: titel,
    description: description
  };
  await createPostRequest(jobData, "/library", "Created New Job: ", "Couldnt create Job: ")
}

async function createApplication(jobId, cvText) {
  const applicationData = {
    job_id: jobId,
    cv_text: cvText
  };
  await createPostRequest(applicationData, "/swipe", "Created New Application: ", "Couldnt create Application: ")
}

async function createChatRoom() {
  await createPostRequest(null, "/hire", "Created New ChatRoom: ", "Couldnt create ChatRoom: ")
}

async function createMessage(chatRoomId, messageContent) {
  const messageData = {
    chat_room_id: chatRoomId,
    content: messageContent
  };
  await createPostRequest(messageData, "/messages", "Created New Message: ", "Couldnt create Message: ")
}

async function createTemplate(type, name, structure) {
  const templateData = {
    type: type,
    name: name,
    structure: structure
  };
  await createPostRequest(templateData, "/template", "Created New Template: ", "Couldnt create Template: ")
}

async function acceptApplication(application_id) {
  await createPostRequest(null, `/applications/${application_id}/accept`, "Accepted seeker Application: ", "Couldnt accept Application: ")
}

export { createJob, createApplication, createChatRoom, createMessage, createTemplate, acceptApplication };
