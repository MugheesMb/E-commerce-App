const express = require("express");

const authRouter = express.Router();

//Creating API
authRouter.post("/api/signup", (req,res) => {

    //getting data from client
    const {name,email,password} = req.body;

    //post data in database
    //return that data to user
})
