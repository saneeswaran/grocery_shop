const express = require("express");
const router = express.Router();

const product = require('../controllers/product');

router.post("/create-product", product.createProduct);
router.post("/delete-product/:id", product.deleteProduct); // fixed
router.put("/update-product/:id", product.updateProduct);  // fixed
router.get("/get-all-products", product.getAllProduct);

module.exports = router;
