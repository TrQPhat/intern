const { DataTypes } = require("sequelize");
const sequelize = require("../connect/db");
const User = require("./User");

const Contract = sequelize.define(
  "Contract",
  {
    contract_id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true,
    },
    user_id: {
      type: DataTypes.INTEGER,
      references: {
        model: User,
        key: "user_id",
      },
    },
    contract_type: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    start_date: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    end_date: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    status: {
      type: DataTypes.STRING,
      defaultValue: "active",
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
  },
  {
    tableName: "contract",
    timestamps: false,
  }
);

// Thiết lập quan hệ User - Contract (1 user có nhiều contract)
User.hasMany(Contract, { foreignKey: "user_id" });
Contract.belongsTo(User, { foreignKey: "user_id" });

module.exports = Contract;
