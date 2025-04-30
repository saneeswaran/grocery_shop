const Cart = require("../model/cart");

exports.addToCart = async (req, res) => {
    const { userId, productId, quantity } = req.body;
    
    try {
        if(!userId || !productId) return res.status(400).json({ message: "userId and productId are required" });
        const isAlreadyAdded = await Cart.findOne({ userId, productId });
        if (isAlreadyAdded) return res.status(409).json({ message: "Product already added to cart" });
        const cartProduct = await Cart.create({ userId, productId, quantity });
        res.status(200).json({ message: "Product added to cart successfully", cartProduct });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}
 
exports.removeFromCart = async (req, res) => {
    const { userId, productId } = req.body;

    try {
        if(!userId || !productId) return res.status(400).json({ message: "userId and productId are required" });
        const removeFromCart = await Cart.findOneAndDelete({ userId, productId });
        if(!removeFromCart) return res.status(404).json({ message: "Product not found" });
        res.status(200).json({ message: "Product removed from cart successfully" });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.getCartProduct = async (req, res) => {
    const userId = req.params.id;
    try {
        const cartProduct = await Cart.find({ userId });
        res.status(200).json(cartProduct);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.getSpecificUserCart = async (req, res) => {
  const userId = req.params.id;

  try {
    const cartProduct = await Cart.find({ userId }).populate("productId");

    if (cartProduct.length === 0) {
      return res.status(404).json({ message: "No items found in the cart." });
    }

    res.status(200).json(cartProduct);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
