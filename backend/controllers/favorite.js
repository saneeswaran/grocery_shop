const Favorite = require("../model/favorite");
const mongoose = require("mongoose");

exports.addToFavorite = async (req, res) => {
    try {
        let { userId, productId } = req.body;

        if (!userId || !productId) {
            return res.status(400).json({ message: "userId and productId are required" });
        }

        // Convert to ObjectId
        userId = new mongoose.Types.ObjectId(userId);
        productId = new mongoose.Types.ObjectId(productId);

        // Check if favorite already exists
        const productExists = await Favorite.findOne({ userId, productId });
        if (productExists) {
            return res.status(409).json({ message: "Product already added to favorite" });
        }

        // Add to favorites
        const favoriteProduct = await Favorite.create({ userId, productId });
        res.status(201).json({ message: "Product added to favorite successfully", favoriteProduct });

    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};


exports.getFavorite = async (req, res) => {
    const userId = req.params.id;

    try {
        const favoriteProduct = await Favorite.find({ userId });
        res.status(200).json(favoriteProduct);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}
 
exports.deleteFromFavorites = async (req, res) => {
    const { userId, productId } = req.body;
    
    try {
        if (!userId || !productId) return res.status(400).json({ message: "userId and productId are required" });
        const removeFavorite = await Favorite.findOneAndDelete({ userId, productId });

        if (!removeFavorite) return res.status(404).json({ message: "Product not found" });
        res.status(200).json({ message: "Product deleted from favorite successfully" });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.getSpecificUserFavorite = async (req, res) => {
    const userId = req.params.id;
try {
    const favoriteProduct = await Favorite.find({ userId }).populate("productId");
    if(!favoriteProduct) return res.status(404).json({ message: "No items found in the favorite." });
    res.status(200).json(favoriteProduct);
} catch (error) {
    res.status(500).json({ message: error.message });
}}
