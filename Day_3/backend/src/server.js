const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
const routes = require("./routes");
require("../service_firebase/fcm_sender");

dotenv.config();
const app = express();
const PORT = process.env.PORT || 5000;
const token = process.env.DEVICE_TOKEN;

app.use(cors());
app.use(express.json());
app.use("/api", routes);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
