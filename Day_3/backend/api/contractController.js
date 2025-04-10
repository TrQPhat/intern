const { where } = require("sequelize");
const Contract = require("../models/Contract");
const { sendFCM } = require("../service_firebase/fcm_sender");

class ContractController {
  // Lấy tất cả hợp đồng
  static async getAllContracts(req, res) {
    try {
      const contracts = await Contract.findAll();
      res.status(200).json(contracts);
      console.log("lấy danh sách toàn bộ hợp đồng thành công", new Date());
    } catch (error) {
      res.status(500).json({ message: "lỗi lấy danh sách", error });
    }
  }

  // Lấy hợp đồng theo user_id
  static async getContractsByUser_Id(req, res) {
    try {
      const contracts = await Contract.findAll({
        where: { user_id: req.params.user_id },
      });
      res.status(200).json(contracts);
      console.log("lấy thành công", new Date());
    } catch (error) {
      console.error("lỗi khi lấy ds:", error);
      res.status(500).json({ message: "lỗi khi lấy ds:", error });
    }
  }

  // Thêm hợp đồng mới
  static async createContract(req, res) {
    try {
      const { user_id, contract_type, start_date, end_date, status } = req.body;
      const created_at = new Date();

      const newContract = await Contract.create({
        user_id,
        contract_type,
        start_date,
        end_date,
        status,
        created_at,
      });

      res.status(201).json({
        message: "tạo thành công",
        contract: newContract,
      });
    } catch (error) {
      res.status(500).json({ message: "Lỗi khi tạo: ", error });
    }
  }

  // Xoá hợp đồng
  static async deleteContract(req, res) {
    try {
      const { contract_id } = req.params;
      const deleted = await Contract.destroy({ where: { contract_id } });

      if (deleted) {
        res.json({ message: "Xóa thành công" });
      } else {
        res.status(404).json({ message: "hợp đồng không tồn tại" });
      }
    } catch (error) {
      res.status(500).json({ message: "xóa thất bại", error });
    }
  }

  // Sửa hợp đồng
  static async updateContract(req, res) {
    try {
      const { contract_id } = req.params;
      const { user_id, contract_type, start_date, end_date, status } = req.body;

      const [updated] = await Contract.update(
        { user_id, contract_type, start_date, end_date, status },
        { where: { contract_id } }
      );

      if (updated) {
        res.json({ message: "Đã cập nhật thành công" });
      } else {
        res.status(404).json({ message: "không tồn tại hợp đồng" });
      }
    } catch (error) {
      res.status(500).json({ message: "cập nhật lỗi", error });
    }
  }

  static async getContractByID(req, res) {
    try {
      const { contract_id } = req.params;

      const contract = await Contract.findOne({
        where: { contract_id },
      });

      if (contract) {
        res.status(200).json(contract);
        console.log(`Lấy thành công hợp đồng ID: ${contract_id}`, new Date());
      } else {
        res.status(404).json({ message: "Không tìm thấy hợp đồng" });
      }
    } catch (error) {
      console.error(
        `Lỗi khi lấy hợp đồng ID: ${req.params.contract_id}`,
        error
      );
      res.status(500).json({
        message: "Lỗi khi lấy thông tin hợp đồng",
        error: error.message,
      });
    }
  }
}

module.exports = ContractController;
