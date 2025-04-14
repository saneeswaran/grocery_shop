const express = require("express");
const router = express.Router();
const subcategoryController = require("../controllers/subcategory");

router.post("/add", subcategoryController.addSubCategory);
router.get("/byCategory/:categoryId", subcategoryController.getSubCategoriesByCategory);

module.exports = router;
