const Category = require("../model/category");

exports.createCategory = async (req, res) => {
    const { name, image } = req.body;
    
    try {
        const categoryExists = await Category.findOne({ name });
        if (categoryExists) return res.status(409).json({ message: "Category already exists" });
        
        const category = await Category.create({ name, image });
        res.status(201).json({ message: "Category created successfully", category });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

exports.getAllCategories = async (req, res) => {
    try {
        const categories = await Category.find();
        res.status(200).json(categories);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

exports.deleteCategory = async (req, res) => {
    const id = req.query.id || req.body.id || req.params.id;

    try {
        const categoryExists = await Category.findByIdAndDelete(id);
        if (!categoryExists) return res.status(404).json({ message: "Category not found" }); 
        res.status(200).json({ message: "Category deleted successfully" });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.updateCAtegory = async (req, res) => { 
    const id = req.query.id || req.body.id || req.params.id;    
    const newData = req.body;

    try {
        const categoryExists = await Category.findByIdAndUpdate(id, newData, { new: true, runValidators: true })
        if (!categoryExists) return res.status(404).json({ message: "Category not found" }); 
        res.status(200).json({ message: "Category updated successfully", category: categoryExists });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}