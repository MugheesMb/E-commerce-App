const express = require("express");
const mongoose = require('mongoose');
//const authRouter = require("./routes/auth");


const PORT = 3000;
const app = express();
const DB = "mongodb+srv://mugybro:Mugybro@cluster0.aj6qo.mongodb.net/?retryWrites=true&w=majority";


app.use(express.json());
app.use(authRouter);
mongoose.connect(DB).then(() => {
    console.log('Connection succesful');
}).catch((e) => {
    console.log(e);
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connec to port ${PORT}`);
});