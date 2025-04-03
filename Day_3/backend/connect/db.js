const { Sequelize } = require("sequelize");

const sequelize = new Sequelize("company_day3", "root", "", {
  host: "localhost",
  dialect: "mysql",
  logging: false, // Tắt log SQL (tuỳ chọn)
});

(async () => {
  try {
    await sequelize.authenticate();
    console.log("Kết nối MySQL thành công!");
  } catch (error) {
    console.error("Lỗi kết nối MySQL:", error);
  }
})();

module.exports = sequelize;
