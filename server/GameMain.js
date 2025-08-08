#!/usr/bin/env node
import { consoleTesting } from "./NormalWordle.js";

// Get command line arguments
const args = process.argv.slice(2);
const debugMode = args.includes("--debug") || args.includes("-d");

if (debugMode) {
  consoleTesting();
}
