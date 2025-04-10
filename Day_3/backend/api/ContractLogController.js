const { where } = require("sequelize");
const ContractLog = require("../models/ContractLog");

class ContractLogController {
  // Xóa toàn bộ log
  async deleteAllContractLogs() {
    await ContractLog.destroy({ where: {} });
  }

  async getAllContractLogs() {
    const logs = await ContractLog.findAll({
      order: [["action_time", "DESC"]],
    });
    return logs;
  }
}

module.exports = ContractLogController;
