function swipe(jobId, direction) {
    fetch(`/jobs/swipe`, { method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({
        direction: direction,
        job_id: jobId
    })
})
        .then(res => res.json()) // Parse JSON from FastAPI
        .then(data => {
            document.getElementById("server-response").textContent = data.message;
        })
        .catch(err => {
            document.getElementById("server-response").textContent = "Error: " + err;
        });
}