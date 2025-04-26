const express = require("express");
const router = express.Router();

const product = require('../controllers/product');

router.post("/create-product", product.createProduct);
router.delete("/delete-product/:id", product.deleteProduct); 
router.put("/update-product/:id", product.updateProduct);  
router.get("/get-all-products", product.getAllProducts);

module.exports = router;
