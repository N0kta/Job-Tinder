import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom"; // ✅ import useParams
import { getUserChatRooms, getChatRoomMessages } from "../../static/js/userGet.js";
import { createMessage } from "../../static/js/userPost.js";

export default function Chat() {
    const { roomId } = useParams(); // ✅ get room ID from URL
    const [chatRooms, setChatRooms] = useState([]);
    const [selectedRoom, setSelectedRoom] = useState(null);
    const [messages, setMessages] = useState([]);
    const [newMessage, setNewMessage] = useState("");

    // Load all chat rooms on mount
    useEffect(() => {
        async function fetchRooms() {
            const rooms = await getUserChatRooms();
            setChatRooms(rooms || []);
        }
        fetchRooms();
    }, []); // only on mount

    useEffect(() => {
        if (roomId && chatRooms.length > 0) {
            const numericRoomId = parseInt(roomId, 10);
            const roomExists = chatRooms.find(r => r.id === numericRoomId);
            if (roomExists) {
                handleRoomClick(numericRoomId);
            }
        }
    }, [roomId, chatRooms]); // run when rooms are loaded or URL changes


    // Load messages for a room
    const handleRoomClick = async (roomId) => {
        setSelectedRoom(roomId);
        const msgs = await getChatRoomMessages(roomId);
        setMessages(msgs || []);
    };

    // Send message
    const handleSendMessage = async () => {
        if (!newMessage.trim() || !selectedRoom) return;
        const msg = await createMessage(selectedRoom, newMessage);
        if (msg) {
            setNewMessage("");
            setMessages(prev => [...prev, msg]);
        }
    };

    return (
        <div style={{ display: "flex", height: "80vh" }}>
            {/* Chat room list */}
            <div style={{ width: "30%", borderRight: "1px solid #ccc", padding: "1rem", overflowY: "auto" }}>
                <h2>Your Chats</h2>
                {chatRooms.map(room => (
                    <div
                        key={room.id}
                        onClick={() => handleRoomClick(room.id)}
                        style={{
                            padding: "0.5rem",
                            marginBottom: "0.5rem",
                            cursor: "pointer",
                            background: selectedRoom === room.id ? "#eee" : "transparent",
                            borderRadius: "5px",
                        }}
                    >
                        Chat Room #{room.id}
                    </div>
                ))}
            </div>

            {/* Messages */}
            <div style={{ flex: 1, display: "flex", flexDirection: "column" }}>
                <div style={{ flex: 1, padding: "1rem", overflowY: "auto", borderBottom: "1px solid #ccc" }}>
                    {messages.map(msg => (
                        <div key={msg.id} style={{ marginBottom: "0.5rem" }}>
                            <strong>{msg.sender_id}</strong>: {msg.content}
                        </div>
                    ))}
                </div>

                {/* Input */}
                {selectedRoom && (
                    <div style={{ padding: "1rem", display: "flex", gap: "0.5rem" }}>
                        <input
                            type="text"
                            value={newMessage}
                            onChange={e => setNewMessage(e.target.value)}
                            placeholder="Type a message..."
                            style={{ flex: 1 }}
                        />
                        <button onClick={handleSendMessage}>Send</button>
                    </div>
                )}
            </div>
        </div>
    );
}
