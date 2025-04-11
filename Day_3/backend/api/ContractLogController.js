const { where } = require("sequelize");
const ContractLog = require("../models/ContractLog");

class ContractLogController {
  async deleteAllContractLogs() {
    await ContractLog.destroy({ where: {} });
  }

  async getAllContractLogs() {
    const logs = await ContractLog.findAll({
      where: { sync_status: "pending" },
      order: [["action_time", "DESC"]],
    });
    return logs;
  }

  async deleteContractLogById(logId) {
    const deleted = await ContractLog.destroy({
      where: { contract_log_id: logId },
    });

    if (deleted === 0) {
      return false;
    }

    return true;
  }

  async updateSyncStatusToNotified(logId) {
    const [updatedCount] = await ContractLog.update(
      { sync_status: "notified" },
      {
        where: { contract_log_id: logId },
      }
    );

    return updatedCount > 0;
  }
}

module.exports = ContractLogController;
