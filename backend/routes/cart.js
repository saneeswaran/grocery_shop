const express = require("express");
const router = express.Router();
const cartController = require("../controllers/cart");

router.get("/get-cart-product/", cartController.getCartProduct);
router.post('/add-to-cart/', cartController.addToCart);
router.delete('/delete-from-cart/', cartController.removeFromCart);

module.exports = router;