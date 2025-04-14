const Favorite = require("../model/favorite");

exports.addTOFavorite = async (req, res) => {
    const { userId, productId } = req.body;

    try {
        //checking the product exists or not
        const productExists = await Favorite.findOne({ userId, productId });
        if (productExists) return res.status(409).json({ message: "Product already added to favorite" });
        
        //if not then create it
        const favoriteProduct = await Favorite.create({ userId, productId });
        //then save it 
        res.status(201).json({ message: "Product added to favorite successfully", favoriteProduct });

    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.getFavorite = async (req, res) => {
    const userId = req.params.userId;

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
        const removeFavorite = await Favorite.findOneAndDelete({ userId, productId });

        if (!removeFavorite) return res.status(404).json({ message: "Product not found" });
        res.status(200).json({ message: "Product deleted from favorite successfully" });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}
