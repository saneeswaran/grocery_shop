const express = require("express");
const router = express.Router();
const auth = require("../middleware/auth");

router.get("/verify-token", auth.verifyToken);

module.exports = router;