const mongoose = require("mongoose");

const categorySchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    unique: true, // no duplicate category names
    trim: true
  },
  image: {
    type: String, // store image URL or base64
    required: false
  }
});

module.exports = mongoose.model("Category", categorySchema);
