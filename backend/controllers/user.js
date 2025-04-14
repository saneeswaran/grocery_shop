const User = require('../model/user');
const bcrypt = require('bcryptjs');
const jwt = require("jsonwebtoken");

exports.registerUser = async (req, res) => {
    const { username, email, password, } = req.body;

    try {
        // Check if user already exists
        const alreadyExists = await User.findOne({ email });
        if (alreadyExists) {
            return res.status(409).json({ 
                message: "User already exists. Please log in." 
            });
        }
        if(!username || !email || !password) return res.status(400).json({ message: "All fields are required" });

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create new user
        const user = await User.create({
            username,
            email,
            password: hashedPassword,
        });

        // Respond with user data (excluding password)
        res.status(201).json({
            message: "User registered successfully",
            user: {
                id: user._id,
                username: user.username,
                email: user.email,
            }
        });

    } catch (error) {
        res.status(500).json({ 
            error: error.message 
        });
    }
};

exports.loginUser = async (req, res) => {
    const { email, password } = req.body;

    try {
        //checking user exists or not 
        const userExists = await User.findOne({ email });
        if (!userExists) return res.status(404).json({ message: "User not found" });

        //checking password is correct or not
        const isMatch = await bcrypt.compare(password, userExists.password);
        if(!isMatch) return res.status(401).json({ message: "Incorrect password" });

        //creating jwt token
        const token = jwt.sign({ id: userExists._id }, "secretKey");
        res.json({
            success: true,
            token: token,
            user: {
                id: userExists._id,
                username: userExists.username,
                email: userExists.email
            }
        })
       
    } catch (error) {
        res.status(400).json({
            success:false,
            error: error.message
        });
    }
}
