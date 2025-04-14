const mongoose = require('mongoose');

const ProductSchema = new mongoose.Schema({
  id: { type: Number, unique: true, required: false },
  name: { type: String, required: true },
  description: { type: String, required: true },
  price: { type: Number, required: true },
    categoryId: { type: Number, required: true },
  stock: { type: Number, required: true },
  imageUrl: { type: String, required: true },
  category: { type: String, required: true },
  quantity: { type: Number, default: 1 },
  size: { type: String, required: true },
  type: { type: String, required: true },
  color: { type: String, required: true },
  rating: { type: Number, default: 0 },
  isLiked: { type: Boolean, default: false },
  originalPrice: { type: Number, required: true },
  isOnSale: { type: Boolean, default: false },
  discountPercentage: { type: Number, default: 0 },
   createdAt: { type: Date, default: Date.now }, 
});

module.exports = mongoose.model('Product', ProductSchema);
