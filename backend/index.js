const express = require("express");
const app = express();
require('dotenv').config();
const cors = require("cors");

//middleware
app.use(express.json());
app.use(cors());


//routes
const connection = require("./config/database");
const product = require("./routes/product");
const authedication = require('./routes/user');
const favorite = require("./routes/favorite");
const cart = require("./routes/cart");
const category = require("./routes/category");
const subcategory = require("./routes/subcategory");
const auth = require("./routes/auth");
app.use("/auth", auth);

//database routes
app.use('/product', product);
app.use('/user', authedication);
app.use('/favorite', favorite);
app.use('/cart', cart);
app.use('/category', category); 
app.use('/subcategory', subcategory);


connection();
PORT = process.env.PORT;
app.listen(PORT, () => {
    console.log(   `Server is running on port ${PORT}`)
});