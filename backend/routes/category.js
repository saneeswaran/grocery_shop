const express = require("express");
const router = express.Router();
const categoryController = require("../controllers/cateory");

router.post("/add", categoryController.createCategory);
router.get("/all", categoryController.getAllCategories);
router.delete("/delete/:id", categoryController.deleteCategory);

module.exports = router;
