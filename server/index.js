import http from "http";
import dotenv from "dotenv";

import app from "./http-server.js";

// Initialize environment variables
dotenv.config({ path: "./.env" });

// Display important environment configuration
console.log("\n=== Environment Configuration ===");
console.log(`Server Port: ${process.env.PORT}`);

console.log(`Node Environment: ${process.env.NODE_ENV || "development"}`);
console.log(
  "================================================================\n"
);

// Create HTTP server
const server = http.createServer(app);

// Setup WebSocket server

// Start the server
try {
  server.listen(process.env.PORT, () => {
    console.log(
      `✅ Successfully running backend service http://localhost:${process.env.PORT}`
    );
    console.log(
      "================================================================\n\n"
    );
  });
} catch (err) {
  console.error("❌ Start Server Error:", err.message);
  process.exit(1); // Exit if DB connection fails
}

// Handle uncaught exceptions
process.on("uncaughtException", (err) => {
  console.error("Uncaught Exception:", err);
});

// Handle unhandled promise rejections
process.on("unhandledRejection", (err) => {
  console.error("Unhandled Rejection:", err);
});
