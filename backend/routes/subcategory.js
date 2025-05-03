const express = require("express");
const router = express.Router();
const subcategoryController = require("../controllers/subcategory");

router.post("/add", subcategoryController.addSubCategory);
router.get('/get-sub-category-by-id/:categoryId', subcategoryController.getSubcategoryById);
router.delete("/delete/:id", subcategoryController.deleteSubCategory);
router.put("/update/:id", subcategoryController.updateSubcategory);
router.get("/get-all-subcategories", subcategoryController.getAllSubcategory);

module.exports = router;
