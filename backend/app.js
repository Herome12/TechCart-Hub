const express = require("express")
const path = require("path")
const dotenv = require("dotenv")
const cors = require("cors")
const app = express();
const cookie_parser = require("cookie-parser")
const bodyParser = require("body-parser");
const fileUpload = require("express-fileupload")

// CORS configuration for Vercel frontend
const corsOptions = {
  origin: process.env.FRONTEND_URL || "http://localhost:3000",
  credentials: true,
  optionsSuccessStatus: 200
}

app.use(cors(corsOptions))
app.use(express.json())
app.use(cookie_parser())
app.use(bodyParser.urlencoded({extended:true}))
app.use(fileUpload())

dotenv.config({path:"./config/config.env"})
//routing 

const product = require("./router/productRouter")
const user = require("./router/userRouter")
const payment = require("./router/paymentRoute")
const order = require("./router/orderRouter")


app.use("/api/v1",product)

app.use("/api/v1",user) 

app.use("/api/v1",payment)

app.use("/api/v1",order)




module.exports = app;