const Contract = require("../models/Contract");

class ContractController {
  // Lấy tất cả hợp đồng
  static async getAllContracts(req, res) {
    try {
      const contracts = await Contract.findAll();
      res.status(200).json(contracts);
    } catch (error) {
      res
        .status(500)
        .json({ message: "Lỗi khi lấy danh sách hợp đồng", error });
    }
  }
}

module.exports = ContractController;
