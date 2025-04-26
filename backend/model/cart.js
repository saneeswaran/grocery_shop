const mongoose = require("mongoose");

const cartSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    },
    productId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    },
    quantity: {
        type: Number,
        required: true
    }
}, { timestamps: true });

// Prevent duplicates
cartSchema.index({ userId: 1, productId: 1 }, { unique: true });

module.exports = new mongoose.model("Cart", cartSchema);
