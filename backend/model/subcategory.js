const mongoose = require("mongoose");

const subCategorySchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        unique: true, // no duplicate category names
        trim: true
    },
    image: {
        type: String, 
        required: true
    },
    categoryId: {
        type: mongoose.Schema.Types.ObjectId, 
        ref: "Category",
        required: true
    }
}); 
module.exports = new mongoose.model("SubCategory", subCategorySchema);