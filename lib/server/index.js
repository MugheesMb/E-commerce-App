
//importing them
const express = require("express");
const mongoose = require('mongoose');
const authRouter = require("./routes/auth");

//initialization
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://mugybro:Mugybro@cluster0.aj6qo.mongodb.net/?retryWrites=true&w=majority";

//giving the insatnce of the authrouter in this file
app.use(express.json());
app.use(authRouter); 



//making conection to database
mongoose.connect(DB).then(() => {
    console.log('Connection succesful');
}).catch((e) => {
    console.log(e);
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connec to port ${PORT}`);
});
