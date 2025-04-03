const express = require("express");
const UserController = require("../api/userController");

const router = express.Router();

router.post("/login", UserController.login);
router.post("/register", UserController.createUser);

module.exports = router;
