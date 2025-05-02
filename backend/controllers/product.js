const Product = require("../model/product");

exports.createProduct = async (req, res) => {
  const {
    name,
    description,
    quantity,
    categoryId,
    subCategoryId,
    price,
    imageUrls,
  } = req.body;

  try {
    if (!name || !description || !quantity || !categoryId || !subCategoryId || !price || !imageUrls) {
      return res.status(400).json({ message: 'All fields are required' });
    }

    // Correct field names as per ProductSchema
    let newProduct = new Product({
      name,
      description,
      quantity,
      categoryId: categoryId,
      subCategoryId: subCategoryId,
      price,
      imageUrls: imageUrls, // Use imageUrl (not imageUrls)
    });
await newProduct.save();
    res.status(201).json({ message: 'Product added successfully', product: newProduct });
  } catch (error) {
    console.error("Error while saving product:", error);
    res.status(500).json({ message: error.message });
  }
};

exports.deleteProduct = async (req, res) => {
  const id =req.params.id;
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

exports.getAllProducts = async (req, res) => {
  try {
    const products = await Product.find()
      .populate('categoryId')   
      .populate('subCategoryId'); 
    res.status(200).json(products);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching products', error });
  }
};

exports.getProductsbyCategory = async (req, res) => {
  const category = req.query.category;
  console.log(category);
  try {
    const products = await Product.find({ categoryId: category });
    if(!products || products.length == 0) return res.status(404).json({ message: "No products found" });
    res.status(200).json(products);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
}

exports.getSubcategoryProducts = async (req, res) => {
  const subcategory = req.query.subcategory;
  console.log(subcategory);
  try {
    const products = await Product.find({ subcategoryId: subcategory });
    if (!products || products.length === 0) {
      return res.status(404).json({ message: "No products found" });
    }
    res.status(200).json(products);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};




