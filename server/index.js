const express = require("express");
const mongoose = require("mongoose");
const userRouter = require("./Routes/user");
const authRouter = require("./Routes/auth");
const productRouter = require("./Routes/product");
const cartRouter = require("./Routes/cart");
const orderRouter = require("./Routes/order");
const cors = require("cors");
const app = express();

//middleware----------------------------------------------
app.use(cors());
app.use(express.json());
app.use("/api/user/", userRouter);
app.use("/api/auth/", authRouter);
app.use("/api/products", productRouter);
app.use("/api/orders", orderRouter);
app.use("/api/cart", cartRouter);
app.listen(5000, () => {
  console.log("server is running on port 5000");
  mongoose
    .connect("mongodb://localhost:27017/Shop")
    .then(() => console.log("database connected"))
    .catch((err) => console.log(err));
});
