// src/pages/CreateJob.js
import React, { useState, useContext } from "react";
import { useNavigate } from "react-router-dom";
import { AuthContext } from "../../components/KeycloakContext.js";
import { createJob } from "../../static/js/userPost.js"; // make sure your API call exists

export default function CreateJob() {
    const { role } = useContext(AuthContext);
    const navigate = useNavigate();

    const [title, setTitle] = useState("");
    const [description, setDescription] = useState("");
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");

    // Only allow employers
    if (role !== "employer") {
        return <p>Only employers can create jobs.</p>;
    }

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError("");
        if (!title.trim() || !description.trim()) {
            setError("Both title and description are required.");
            return;
        }

        setLoading(true);
        try {
            await createJob(title, description ); // adjust keys for backend
            setLoading(false);
            navigate("/bibliothek"); // go back to employer's jobs view
        } catch (err) {
            console.error(err);
            setError("Failed to create job.");
            setLoading(false);
        }
    };

    return (
        <div style={{ maxWidth: "600px", margin: "40px auto", padding: "20px", background: "white", borderRadius: "12px", boxShadow: "0px 4px 12px rgba(0,0,0,0.1)" }}>
            <h2>Create New Job</h2>
            <form onSubmit={handleSubmit} style={{ display: "flex", flexDirection: "column", gap: "16px" }}>
                <div>
                    <label htmlFor="title">Job Title</label>
                    <input
                        type="text"
                        id="title"
                        value={title}
                        onChange={(e) => setTitle(e.target.value)}
                        style={{ width: "100%", padding: "8px", borderRadius: "6px", border: "1px solid #ccc" }}
                        required
                    />
                </div>
                <div>
                    <label htmlFor="description">Job Description</label>
                    <textarea
                        id="description"
                        value={description}
                        onChange={(e) => setDescription(e.target.value)}
                        rows={6}
                        style={{ width: "100%", padding: "8px", borderRadius: "6px", border: "1px solid #ccc" }}
                        required
                    />
                </div>
                {error && <p style={{ color: "red" }}>{error}</p>}
                <button
                    type="submit"
                    disabled={loading}
                    style={{ padding: "10px 20px", borderRadius: "6px", border: "none", background: "#007bff", color: "white", cursor: "pointer" }}
                >
                    {loading ? "Creating..." : "Create Job"}
                </button>
            </form>
        </div>
    );
}
