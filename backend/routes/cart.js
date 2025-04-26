const express = require("express");
const router = express.Router();
const cartController = require("../controllers/cart");

router.get("/get-cart-product/:id", cartController.getCartProduct);
router.post('/add-to-cart/:id', cartController.addToCart);
router.delete('/delete-from-cart/:id', cartController.removeFromCart);

module.exports = router;