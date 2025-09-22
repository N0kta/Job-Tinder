import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../../components/KeycloakContext.js";
import { getJobs, getEmployerJobs, getSeekerApplications, getJobApplicationsForEmployer } from "../../static/js/userGet.js";

export default function Bibliothek() {
  const { role } = useContext(AuthContext);
  const [items, setItems] = useState([]);
  const [selectedJob, setSelectedJob] = useState(null);
  const [jobApplications, setJobApplications] = useState([]);

  // Fetch seeker applications
  useEffect(() => {
    async function fetchData() {
      if (role === "seeker") {
        const apps = await getSeekerApplications();
        setItems(apps);
      } else if (role === "employer") {
        const jobs = await getEmployerJobs();
        setItems(jobs);
      }
    }
    fetchData();

  }, [role]);

  // Fetch applications for a specific job (when clicked)
  const handleJobClick = async (jobId) => {
    if (role !== "employer") return;
    setSelectedJob(jobId);
    const apps = await getJobApplicationsForEmployer(jobId);
    setJobApplications(apps);
  };
  console.log(items)
  return (
    <div style={{ padding: "20px" }}>
      <h1>Bibliothek</h1>

      {role === "seeker" && (
        <>
          <h2>Your Applications</h2>
          <div
            style={{
              display: "grid",
              gridTemplateColumns: "repeat(auto-fill, minmax(300px, 1fr))",
              gap: "20px",
              marginTop: "20px",
            }}
          >
            {items.map((app) => (
              <div
                key={app.id}
                style={{
                  background: "white",
                  borderRadius: "12px",
                  padding: "16px",
                  boxShadow: "0px 4px 10px rgba(0,0,0,0.1)",
                }}
              >
                <h3>{app.id ?? "No id"}</h3>
                <h3>{app.job_id ?? "No Job id"}</h3>
                <p>{app.cv_text ?? "No cv_text"}</p>
                <p>{app.status ?? "No Status"}</p>
                <small>Applied on: {new Date(app.created_at).toLocaleDateString()}</small>
              </div>
            ))}
          </div>
        </>
      )}

      {role === "employer" && (
        <>
          {!selectedJob ? (
            <>
              <h2>Your Jobs</h2>
              <div
                style={{
                  display: "grid",
                  gridTemplateColumns: "repeat(auto-fill, minmax(300px, 1fr))",
                  gap: "20px",
                  marginTop: "20px",
                }}
              >
                {items.map((job) => (
                  <div
                    key={job.id}
                    style={{
                      background: "white",
                      borderRadius: "12px",
                      padding: "16px",
                      boxShadow: "0px 4px 10px rgba(0,0,0,0.1)",
                      cursor: "pointer",
                    }}
                    onClick={() => handleJobClick(job.id)}
                  >
                    <h3>{job.titel}</h3>
                    <p>{job.description}</p>
                    <small>Posted: {new Date(job.created_at).toLocaleDateString()}</small>
                  </div>
                ))}
              </div>
            </>
          ) : (
            <>
              <button
                style={{
                  marginBottom: "20px",
                  padding: "8px 16px",
                  borderRadius: "8px",
                  border: "1px solid #ccc",
                  cursor: "pointer",
                }}
                onClick={() => setSelectedJob(null)}
              >
                ← Back to Jobs
              </button>

              <h2>Applications for Job #{selectedJob}</h2>
              <div
                style={{
                  display: "grid",
                  gridTemplateColumns: "repeat(auto-fill, minmax(300px, 1fr))",
                  gap: "20px",
                  marginTop: "20px",
                }}
              >
                {jobApplications.map((app) => (
                  <div
                    key={app.id}
                    style={{
                      background: "white",
                      borderRadius: "12px",
                      padding: "16px",
                      boxShadow: "0px 4px 10px rgba(0,0,0,0.1)",
                    }}
                  >
                    <h3>Applicant: {app.seeker?.username ?? "Unknown User"}</h3>
                    <p>{app.cv_text}</p>
                    <small>Applied on: {new Date(app.created_at).toLocaleDateString()}</small>
                  </div>
                ))}
              </div>
            </>
          )}
        </>
      )}
    </div>
  );
}
