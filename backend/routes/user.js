const express = require('express');
const router = express.Router();
const authedication = require('../controllers/user');

router.post("/register", authedication.registerUser);
router.post("/login", authedication.loginUser);
router.delete("/admin-delete-user/:id", authedication.deleteUser);
router.get("/get-all-users", authedication.fetchAllUser);
router.put("/update-user/:id", authedication.updateUser);

module.exports = router;