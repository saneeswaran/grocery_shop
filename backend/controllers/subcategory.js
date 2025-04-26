const SubCategory = require("../model/subcategory");
const Product = require("../model/product");

exports.addSubCategory = async (req, res) => {
  const { name, categoryId, image } = req.body;

  try {
    const exists = await SubCategory.findOne({ name, categoryId });
    if (exists) return res.status(409).json({ message: "Subcategory already exists" });

    const subcategory = await SubCategory.create({ name, categoryId, image });
    res.status(201).json({ message: "Subcategory added", subcategory });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getSubCategoriesByCategory = async (req, res) => {
  const { categoryId } = req.params;

  try {
    const subcategories = await SubCategory.find({ categoryId });
    res.status(200).json(subcategories);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getAllSubcategory = async (req, res) => {
  try {
    const subcategories = await SubCategory.find();
    if (!subcategories || subcategories.length === 0) {
      return res.status(404).json({ message: "No subcategories found" });
    }
    res.status(200).json(subcategories);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteSubCategory = async (req, res) => {
  const { id } = req.params;  // Fixed this line

  try {
    const productExists = await Product.findOne({ subcategoryId: id });  // Await the result
    if (productExists) return res.status(409).json({ message: "Subcategory has products" });

    const deleted = await SubCategory.findByIdAndDelete(id);
    if (!deleted) return res.status(404).json({ message: "Subcategory not found" });
    res.status(200).json({ message: "Subcategory deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateSubcategory = async (req, res) => {
  const { id } = req.params;  // Fixed this line
  const newData = req.body;

  try {
    const updated = await SubCategory.findByIdAndUpdate(id, newData, { new: true, runValidators: true });
    if (!updated) return res.status(404).json({ message: "Subcategory not found" });
    res.status(200).json({ message: "Subcategory updated successfully", subcategory: updated });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
