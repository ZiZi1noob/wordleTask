import express from "express";
const router = express.Router();

// Import controller methods
import { getUserInfo } from "../controllers/userController.js";

// User management routes
router.get("/get-info/:name", getUserInfo);
// router.delete("/user-delete/:username", userDelete);
// router.patch("/change-password/:username", changePassword);

// Export the router
export { router };
