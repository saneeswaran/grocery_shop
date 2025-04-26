const express = require("express");
const router = express.Router();
const subcategoryController = require("../controllers/subcategory");

router.post("/add", subcategoryController.addSubCategory);
router.get("/getAllSubcategory", subcategoryController.getAllSubcategory);
router.get("/byCategory/:categoryId", subcategoryController.getSubCategoriesByCategory);
router.delete("/delete/:id", subcategoryController.deleteSubCategory);
router.put("/update/:id", subcategoryController.updateSubcategory);

module.exports = router;
