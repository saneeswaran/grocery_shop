const Product = require("../model/product");

//product create
exports.createProduct = async (req, res) => {
    const { name, description, price, stock, imageUrl, category,categoryId, size, type, color, originalPrice } = req.body;

    try {
        let product = await Product.create({
            name,
            description,
            price,
            stock,
            imageUrl,
            category,
            categoryId,
            size,
            type,
            color,
            originalPrice
        });

        product = await product.save();
        res.status(201).send(product);
    } catch (error) {
        res.json({ message: error.message });
    }
}

exports.deleteProduct = async (req, res) => {
    const id = req.query.id || req.body.id || req.params.id;

    //checking id
    if (!id) return res.status(400).json({ message: "Product id is required" });

    //checking product exists or not
    try {
        const deletedProduct = await Product.findByIdAndDelete(id);

        if (!deletedProduct) return res.status(404).json({ message: "Product not found" });
        //else
        res.status(200).json({ message: "Product deleted successfully" });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

exports.updateProduct = async (req, res) => {
    const id = req.query.id || req.body.id || req.params.id;
    //new data from application
    const newData = req.body;

    try {
        const updateProduct = await Product.findByIdAndUpdate(id, newData, { new: true, runValidators: true });
        
        //checking the product exists or not
        if (!updateProduct) return res.status(404).json({ message: "Product not found" });
        // then else part
        res.status(200).json({ message: "Product updated successfully", product: updateProduct });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }

};

exports.getAllProduct = async (req, res) => {
    try {
        const { search, limit = 20, page = 1 } = req.query;

        const query = {};
        if (search) {
            query.name = { $regex: search, $options: 'i' }; // assuming 'name' is a product field
        }

        const allProducts = await Product.find(query)
            .limit(parseInt(limit))
            .skip((parseInt(page) - 1) * parseInt(limit));

        res.status(200).json(allProducts);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
