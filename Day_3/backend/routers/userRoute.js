const express = require("express");
const UserController = require("../api/userController");

const router = express.Router();

router.post("/login", UserController.login);
router.post("/register", UserController.createUser);
router.put("/:id", UserController.updateDeviceToken);

module.exports = router;
