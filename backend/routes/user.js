const express = require('express');
const router = express.Router();
const authedication = require('../controllers/user');

router.post("/register", authedication.registerUser);
router.post("/login", authedication.loginUser);

module.exports = router;