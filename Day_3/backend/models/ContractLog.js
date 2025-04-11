const { DataTypes } = require("sequelize");
const sequelize = require("../connect/db");

const ContractLog = sequelize.define(
  "contract_log",
  {
    contract_log_id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    contract_id: DataTypes.INTEGER,
    user_id: DataTypes.INTEGER,
    contract_type: DataTypes.STRING,
    start_date: DataTypes.DATE,
    end_date: DataTypes.DATE,
    status: DataTypes.STRING,
    action_type: DataTypes.ENUM("insert", "update", "delete"),
    action_time: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
    sync_status: {
      type: DataTypes.ENUM("pending", "synced"),
      allowNull: false,
      defaultValue: "pending",
    },
  },
  {
    tableName: "contract_log",
    timestamps: false,
  }
);

module.exports = ContractLog;
