const admin = require("firebase-admin");
const serviceAccount = require("./firebase-adminsdk.json");
const ContractController = require("../api/ContractLogController"); // Đường dẫn đúng
const contractController = new ContractController();

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
    console.log("✅ Gửi thành công:", response);
    return true;
  } catch (error) {
    console.error("❌ Gửi FCM lỗi:", error);
    return false;
  }
}

// Xử lý contract log định kỳ và gửi FCM
async function processContractLogs(fcmTokens = []) {
  const logs = await contractController.getAllContractLogs();

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

    for (const token of fcmTokens) {
      await sendFCMNotification(token, title, body, data);
    }
  }

  // Sau khi gửi FCM xong thì xóa log
  await contractController.deleteAllContractLogs();
  console.log(`🧹 Đã xoá ${logs.length} log sau khi gửi FCM.`);
}

// Gọi định kỳ mỗi 5 giây
setInterval(async () => {
  const fcmTokens = [
    "cJ_lpeIPSQe_ysxzeDP-BX:APA91bFtMFGf1nO-d75IqFlDsJ8g83_DJUBJW3yNx3urjshgDR5ryu8NWaQVtuUdx5jlTrcvNCG7ltFdomt8XdHOQvOWhExOxJXPg5FNsOONU-WESu8SBCY",
  ];

  await processContractLogs(fcmTokens);
}, 5000);

module.exports = { sendFCMNotification, processContractLogs };
