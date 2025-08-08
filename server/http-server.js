import express from "express";
import helmet from "helmet";
import cors from "cors";

//const cookieParser = require('cookie-parser')

// middleware
const app = express();
app.use(cors());
app.use(helmet());
//app.use(cookieParser())
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// routes
// import { router as accountRoute } from "./routes/accountRoute.js";
// import { router as sysRoute } from "./routes/sysRoute.js";
// import { router as docRoute } from "./routes/docRoute.js";
// import { router as ocrRoute } from "./routes/ocrRoute.js";
// import { router as clRoute } from "./routes/clRoute.js";
// import { router as correctToolRoute } from "./routes/correctToolRoute.js";
// import { router as keywordMatchRoute } from "./routes/keywordMatchRoute.js";

// app.use("/api/auth", accountRoute);
// app.use("/api/sys", sysRoute);
// app.use("/api/doc", docRoute);
// app.use("/api/ocr", ocrRoute);
// app.use("/api/cl", clRoute);
// app.use("/api/correctTool", correctToolRoute);
// app.use("/api/keywordMatch", keywordMatchRoute);

export default app;
