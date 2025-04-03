const express = require("express");
const contractController = require("../api/contractController");

const router = express.Router();

router.get("/", contractController.getAllContracts);

module.exports = router;
