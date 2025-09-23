import React, { useEffect, useState, useContext } from 'react'
import '../../App.css'
import { getJobs } from '../../static/js/userGet.js';
import { createApplication } from '../../static/js/userPost.js';
import { AuthContext } from '../../components/KeycloakContext.js';
import TinderCard from 'react-tinder-card'

export default function Swiping() {
  const [data, setData] = useState([]);
  const { role, user } = useContext(AuthContext); // assuming user.id is available

  useEffect(() => {
    async function fetchJobs() {
      const jobs = await getJobs();
      setData(jobs);
    }
    fetchJobs();
  }, [role]);

  const swiped = async (direction, jobId) => {
    if (direction === "right") {
      await createApplication(jobId, localStorage.getItem("cvText"));
    }
    setData((prev) => prev.filter((job) => job.id !== jobId));
  };

  // Filter out jobs that have been accepted/rejected by the current user
  const filteredData = data.filter(job => {
    const app = job.applications?.find(a => a.seeker_id === user?.id);
    return !app || app.status === "pending";
  });

  const [cvText, setCvText] = useState("");

  // Load saved text from localStorage on mount
  useEffect(() => {
    const saved = localStorage.getItem("cvText");
    if (saved) {
      setCvText(saved);
    }
  }, []);

  // Save handler
  const handleSave = () => {
    localStorage.setItem("cvText", cvText);
    alert("CV text saved!");
  };

  return (
    <div
      style={{
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "100vh",
        width: "100vw",
        overflow: "hidden",
        padding: "16px",
        boxSizing: "border-box",
      }}
    >
      <div
        style={{
          display: "flex",
          flexDirection: "column", // stack vertically
          alignItems: "center",
          width: "100%",
          maxWidth: "420px",
          height: "100%",
        }}
      >
        {/* Tinder Cards */}
        <div style={{ position: "relative", flex: 1, width: "100%" }}>
          {filteredData.map((job, index) => (
            <TinderCard
              key={job.id}
              onSwipe={(dir) => swiped(dir, job.id)}
              preventSwipe={["up", "down"]}
            >
              <div
                style={{
                  position: "absolute",
                  width: "100%",
                  background: "white",
                  borderRadius: "16px",
                  boxShadow: "0px 8px 20px rgba(0,0,0,0.25)",
                  display: "flex",
                  flexDirection: "column",
                  padding: "24px",
                  boxSizing: "border-box",
                  zIndex: filteredData.length - index,
                  minHeight: "300px",
                  maxHeight: "70vh",
                  overflow: "hidden",
                  margin: "8px",
                }}
              >
                <h2 style={{ marginBottom: "10px" }}>{job.titel}</h2>
                <p style={{ flex: 1, marginBottom: "15px", overflowY: "auto" }}>
                  {job.description}
                </p>
                <small style={{ color: "#666" }}>
                  Posted: {new Date(job.created_at).toLocaleDateString()}
                </small>
              </div>
            </TinderCard>
          ))}
        </div>

        {/* CV Form under cards */}
        <div style={{ padding: "20px", width: "100%" }}>
          <h2>Your CV Text</h2>
          <textarea
            value={cvText}
            onChange={(e) => setCvText(e.target.value)}
            rows={6}
            style={{
              width: "100%",
              padding: "10px",
              borderRadius: "8px",
              border: "1px solid #ccc",
              marginBottom: "10px",
              fontSize: "16px",
            }}
          />
          <button
            onClick={handleSave}
            style={{
              padding: "10px 20px",
              borderRadius: "8px",
              border: "none",
              background: "#007bff",
              color: "white",
              cursor: "pointer",
              fontSize: "16px",
              width: "100%",
            }}
          >
            Save
          </button>
        </div>
      </div>
    </div>
  );

}
