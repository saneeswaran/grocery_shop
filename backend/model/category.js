const mongoose = require("mongoose");

const categorySchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true,  // No duplicate category names
      trim: true,
    },
    image: {
      type: String, // Store image URL or base64 string
      required: false, // Set to true if image is mandatory
    },
  },
  { timestamps: true } // Automatically adds createdAt and updatedAt fields
);

module.exports = mongoose.model("Category", categorySchema);
