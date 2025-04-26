const mongoose = require('mongoose');

const ProductSchema = new mongoose.Schema({
  name: { type: String, required: true },
  description: { type: String, required: true },
  price: { type: Number, required: true },
  imageUrls: [{ type: String, required: true }],
  categoryId: { 
    type: mongoose.Schema.Types.ObjectId, // Reference to Category
    ref: 'Category', 
    required: true 
  },
  subCategoryId: { 
    type: mongoose.Schema.Types.ObjectId, // Reference to SubCategory
    ref: 'SubCategory', 
    required: true 
  },
  quantity: { type: Number, default: 1 },
  rating: { type: Number, default: 1 },
});

module.exports = mongoose.model('Product', ProductSchema);
