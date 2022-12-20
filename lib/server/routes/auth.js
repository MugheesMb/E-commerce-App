const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();



//Creating API
authRouter.post("/api/signup", async  (req,res) => {
    try {
    //getting data from client
    const {name,email,password} = req.body;

    //check if the email is already register or not
    const existingUser = await User.findOne({ email });
    if (existingUser) {
        return res.status(400).json({ msg: "User with same email already exist" });
    }

    //post data in database
    const hashedpass = await bcryptjs.hash(password, 8);
    let user = new User({
        email,
        password: hashedpass,
        name,

    });
    user = await user.save();

   //return that data to user
    res.json(user);
}catch (e) {
    res.status(500).json({ error: e.message });
}
 
})

module.exports = authRouter;