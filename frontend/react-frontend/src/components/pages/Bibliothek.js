import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../../components/KeycloakContext.js";
import {
  getJobs,
  getEmployerJobs,
  getSeekerApplications,
  getJobApplicationsForEmployer
} from "../../static/js/userGet.js";
import TinderCard from "react-tinder-card";
import { acceptApplication } from "../../static/js/userPost.js"; // adjust path if needed
import { useNavigate } from "react-router-dom";

export default function Bibliothek() {
  const navigate = useNavigate();

  const { role } = useContext(AuthContext);
  const [items, setItems] = useState([]);
  const [selectedJob, setSelectedJob] = useState(null);
  const [jobApplications, setJobApplications] = useState([]);
  console.log(jobApplications)
  // Fetch seeker applications or employer jobs
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

  // Fetch applications for a specific job
  const handleJobClick = async (jobId) => {
    if (role !== "employer") return;
    setSelectedJob(jobId);
    const apps = await getJobApplicationsForEmployer(jobId);
    setJobApplications(apps);
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>Bibliothek</h1>

      {/* ---------------- Seeker View ---------------- */}
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
                <h3>{app.job_id ?? "No Job id"}</h3>
                <p>{app.cv_text ?? "No cv_text"}</p>
                <p>Status: {app.status ?? "No Status"}</p>
                <small>
                  Applied on: {new Date(app.created_at).toLocaleDateString()}
                </small>

                {/* 🔹 Only show this button if accepted and chat exists */}
                {app.status === "accepted" && app.chat_room_id && (
                  <button
                    onClick={() => navigate(`/chat/${app.chat_room_id}`)}
                    style={{
                      marginTop: "10px",
                      padding: "8px 12px",
                      borderRadius: "6px",
                      border: "none",
                      background: "#28a745",
                      color: "white",
                      cursor: "pointer",
                    }}
                  >
                    Go to Chat
                  </button>
                )}
              </div>
            ))}
          </div>
        </>
      )}


      {/* ---------------- Employer View ---------------- */}
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
                    <small>
                      Posted: {new Date(job.created_at).toLocaleDateString()}
                    </small>
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

              {/* Accepted Applications */}
              <h2>Accepted Applications</h2>
              <div
                style={{
                  display: "grid",
                  gridTemplateColumns: "repeat(auto-fill, minmax(300px, 1fr))",
                  gap: "20px",
                  marginTop: "20px",
                }}
              >
                {jobApplications
                  .filter((app) => app.status === "accepted")
                  .map((app) => (
                    <div
                      key={app.id}
                      style={{
                        background: "white",
                        borderRadius: "12px",
                        padding: "16px",
                        boxShadow: "0px 4px 10px rgba(0,0,0,0.1)",
                      }}
                    >
                      <h3>{app.seeker_id ?? "Unknown User"}</h3>
                      <p>{app.cv_text}</p>
                      <p>Chat room id: {app.chat_room_id}</p>
                      <button
                        onClick={() =>
                          navigate(`/chat/${app.chat_room_id}`)
                        }
                        style={{
                          marginTop: "10px",
                          padding: "8px 12px",
                          borderRadius: "6px",
                          border: "none",
                          background: "#007bff",
                          color: "white",
                          cursor: "pointer",
                        }}
                      >
                        Go to Chat
                      </button>
                    </div>
                  ))}
              </div>

              {/* Pending Applications Swipe */}
              <h2 style={{ marginTop: "40px" }}>Pending Applications</h2>
              <div
                style={{
                  position: "relative",
                  height: "70vh",
                  maxWidth: "420px",
                  margin: "20px auto",
                }}
              >
                {jobApplications
                  .filter((app) => app.status === "pending")
                  .map((app, index) => (
                    <TinderCard
                      key={app.id}
                      onSwipe={async (dir) => {
                        if (dir === "right") {
                          await acceptApplication(app.id);
                          setJobApplications((prev) =>
                            prev.map((a) =>
                              a.id === app.id ? { ...a, status: "accepted" } : a
                            )
                          );
                        } else if (dir === "left") {
                          // TODO: call rejection endpoint when implemented
                          setJobApplications((prev) =>
                            prev.map((a) =>
                              a.id === app.id ? { ...a, status: "rejected" } : a
                            )
                          );
                        }
                      }}
                      preventSwipe={["up", "down"]}
                    >
                      <div
                        style={{
                          position: "absolute",
                          width: "100%",
                          background: "white",
                          borderRadius: "16px",
                          boxShadow: "0px 8px 20px rgba(0,0,0,0.25)",
                          padding: "24px",
                          boxSizing: "border-box",
                          minHeight: "300px",
                          overflow: "hidden",
                          zIndex: jobApplications.length - index,
                        }}
                      >
                        <h3>{app.seeker?.username ?? "Unknown User"}</h3>
                        <p>{app.cv_text}</p>
                      </div>
                    </TinderCard>
                  ))}
              </div>
            </>
          )}
        </>
      )}
    </div>
  );
}
