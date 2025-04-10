const User = require("../models/User");
const bcrypt = require("bcrypt");

class UserController {
  // Lấy thông tin user theo ID
  static async getUserById(req, res) {
    try {
      const user = await User.findByPk(req.params.id);
      if (!user) return res.status(404).json({ message: "User không tồn tại" });
      res.status(200).json(user);
    } catch (error) {
      res.status(500).json({ message: "Lỗi khi lấy user", error });
    }
  }

  // Tạo user mới
  static async createUser(req, res) {
    try {
      const { username, password, email, full_name } = req.body;
      console.log(req.body);
      // Mã hóa mật khẩu trước khi lưu
      const hashedPassword = await bcrypt.hash(password, 10);

      const newUser = await User.create({
        username,
        password: hashedPassword,
        email,
        full_name,
      });

      res.status(201).json({ message: "Tạo user thành công!", user: newUser });
    } catch (error) {
      res.status(500).json({
        message: "Lỗi khi tạo user",
        error: "Có thể người dùng đã tồn tại",
      });
      console.log(error);
    }
  }

  // Cập nhật thông tin user
  static async updateUser(req, res) {
    try {
      const { username, email, full_name } = req.body;
      const user = await User.findByPk(req.params.id);

      if (!user) return res.status(404).json({ message: "User không tồn tại" });

      await user.update({ username, email, full_name });
      res.status(200).json({ message: "Cập nhật user thành công!", user });
    } catch (error) {
      res.status(500).json({ message: "Lỗi khi cập nhật user", error });
    }
  }

  // Xóa user theo ID
  static async deleteUser(req, res) {
    try {
      const user = await User.findByPk(req.params.id);
      if (!user) return res.status(404).json({ message: "User không tồn tại" });

      await user.destroy();
      res.status(200).json({ message: "Xóa user thành công!" });
    } catch (error) {
      res.status(500).json({ message: "Lỗi khi xóa user", error });
    }
  }

  static async login(req, res) {
    try {
      const { username, password } = req.body;

      // Kiểm tra username có tồn tại không
      const user = await User.findOne({ where: { username } });
      if (!user) {
        return res
          .status(401)
          .json({ message: "Sai tên đăng nhập hoặc mật khẩu!" });
      }

      // Kiểm tra mật khẩu có đúng không
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res
          .status(401)
          .json({ message: "Sai tên đăng nhập hoặc mật khẩu!" });
      }

      res.status(200).json({
        message: "Đăng nhập thành công!",
        user: user,
      });
    } catch (error) {
      res.status(500).json({ message: "Lỗi khi đăng nhập", error });
    }
  }
}

module.exports = UserController;
