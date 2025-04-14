const SubCategory = require("../model/subcategory");

exports.addSubCategory = async (req, res) => {
  const { name, categoryId } = req.body;

  try {
    const exists = await SubCategory.findOne({ name, categoryId });
    if (exists) return res.status(409).json({ message: "Subcategory already exists" });

    const subcategory = await SubCategory.create({ name, categoryId });
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
