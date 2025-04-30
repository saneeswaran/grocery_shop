const Category = require("../model/category");
const subcategory = require("../model/subcategory");

exports.createCategory = async (req, res) => {
  const { name, image } = req.body;

  if (!name || !image) {
    return res.status(400).json({ message: "Name and image are required" });
  }

  try {
    // Check if category already exists
    const categoryExists = await Category.findOne({ name });
    if (categoryExists) {
      return res.status(409).json({ message: "Category already exists" });
    }

    // Create new category
    const category = await Category.create({ name, image });
    res.status(201).json({ message: "Category created successfully", category });
  } catch (error) {
    console.error("Error creating category:", error);  // Log error for debugging
    res.status(500).json({ message: error.message });
  }
};

exports.getAllCategories = async (req, res) => {
  try {
    const categories = await Category.find();
    res.status(200).json(categories);
  } catch (error) {
    console.error("Error fetching categories:", error);  // Log error for debugging
    res.status(500).json({ message: error.message });
  }
};
exports.getSpecificCategoryProduct = async (req, res) => {
  const id = req.params.id;
  try {
    const categoryProduct = await Category.findById(id).populate("products");
    res.status(200).json(categoryProduct);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
}
exports.deleteCategory = async (req, res) => {
  const id = req.query?.id || req.body?.id || req.params?.id;

  try {
    // Step 1: Check if any subcategory is linked to this category
    const subCategoryExists = await subcategory.findOne({ categoryId: id });
    if (subCategoryExists) {
      return res.status(400).json({ message: "Cannot delete this category. It has subcategories." });
    }

    // Step 2: Delete the category if no subcategories are found
    const categoryExists = await Category.findByIdAndDelete(id);
    if (!categoryExists) {
      return res.status(404).json({ message: "Category not found" });
    }

    res.status(200).json({ message: "Category deleted successfully" });
  } catch (error) {
    console.error("Error deleting category:", error);
    res.status(500).json({ message: error.message });
  }
};


exports.updateCategory = async (req, res) => {
  const id = req.query.id || req.body.id || req.params.id;
  const newData = req.body;

  try {
    const categoryExists = await Category.findByIdAndUpdate(id, newData, {
      new: true,
      runValidators: true,
    });

    if (!categoryExists) {
      return res.status(404).json({ message: "Category not found" });
    }

    res.status(200).json({
      message: "Category updated successfully",
      category: categoryExists,
    });
  } catch (error) {
    console.error("Error updating category:", error);  // Log error for debugging
    res.status(500).json({ message: error.message });
  }
};
