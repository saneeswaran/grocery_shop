const mongoose = require("mongoose");

const favoriteSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    },
    productId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    }
}); 
favoriteSchema.index({ userId: 1, productId: 1 }, { unique: true });
module.exports = new mongoose.model("Favorite", favoriteSchema);   