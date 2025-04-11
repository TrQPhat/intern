const admin = require("firebase-admin");
const serviceAccount = require("./firebase-adminsdk.json");
const UserController = require("../api/userController");
const ContractLogController = require("../api/ContractLogController");
const contractLogController = new ContractLogController();

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// Hàm gửi FCM
async function sendFCMNotification(token, title, body, data = {}) {
  const message = {
    token,
    notification: {
      title,
      body,
    },
    data,
  };

  try {
    const response = await admin.messaging().send(message);
    console.log("Gửi thành công:", response);
    return true;
  } catch (error) {
    console.error("Gửi FCM lỗi:", error);
    return false;
  }
}

// Xử lý contract log định kỳ và gửi FCM
async function processContractLogs() {
  const logs = await contractLogController.getAllContractLogs();

  if (logs.length === 0) return;

  for (const log of logs) {
    const title = `📄 ${log.action_type.toUpperCase()} hợp đồng #${
      log.contract_id
    }`;
    const body = `User #${log.user_id}, Loại: ${log.contract_type}, Từ ${log.start_date} đến ${log.end_date}`;
    const data = {
      contract_id: String(log.contract_id),
      action_type: log.action_type,
    };
    //console.log(JSON.stringify(log));
    const token = await UserController.getDeviceToken(log.user_id);
    if (token != "offline" && token != null) {
      await sendFCMNotification(token, title, body, data);

      //cập nhật trạng thái notified
      await contractLogController.updateSyncStatusToNotified(
        log.contract_log_id
      );
    }
  }

  // // xóa log
  // await contractLogController.deleteAllContractLogs();
  console.log(`🧹 Đã xoá ${logs.length} log sau khi gửi FCM.`);
}

// Gọi định kỳ mỗi 5 giây
setInterval(async () => {
  await processContractLogs();
}, 5000);

module.exports = { sendFCMNotification, processContractLogs };
