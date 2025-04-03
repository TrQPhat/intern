const express = require("express");
const router = express.Router();

const userRoute = require("../routers/userRoute");
const contractRoute = require("../routers/contractRoute");

router.use("/users", userRoute);
router.use("/contracts", contractRoute);

module.exports = router;
