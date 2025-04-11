const express = require("express");
const contractController = require("../api/contractController");

const router = express.Router();

router.get("/", contractController.getAllContracts);

router.get("/:user_id", contractController.getContractsByUser_Id);

router.get("/getone/:contract_id", contractController.getContractByID);

router.post("/", contractController.createContract);

router.put("/:contract_id", contractController.updateContract);

router.delete("/:contract_id", contractController.deleteContract);

router.delete(
  "/contract-log/:contractId",
  contractController.deleteLogsByContractId
);

module.exports = router;
