const express = require("express");
const router = express.Router();
const categoryController = require("../controllers/cateory");

router.post("/add", categoryController.createCategory);
router.get("/get-all-categories", categoryController.getAllCategories);
router.get("/:id/data", categoryController.getSubCategoriesAndProducts);
router.get("/get-by-id/:id", categoryController.getSpecificCategoryProduct);
router.put("/update/:id", categoryController.updateCategory);
router.delete("/delete/:id", categoryController.deleteCategory);

module.exports = router;
