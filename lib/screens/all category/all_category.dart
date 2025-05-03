import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/screens/all%20category/provider/category_provider.dart';
import 'package:grocery_shop/screens/home%20page/components/show_products_by_category.dart';
import 'package:grocery_shop/screens/home%20page/provider/product_provider.dart';
import 'package:grocery_shop/screens/home%20page/provider/subcategory_provider.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:provider/provider.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({super.key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  String? selectedCategory;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(
      context,
      listen: false,
    ).fetchAllCategory(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final provider = Provider.of<CategoryProvider>(context);
    final categories = provider.category;
    return Scaffold(
      body: Row(
        children: [
          // Left Menu
          Container(
            width: size.width * 0.3,
            height: size.height,
            padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
            color: Colors.grey.shade100,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                bool isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      selectedCategory = category.id; // Set selected category
                    });
                    // Fetch subcategories based on selected category
                    Provider.of<SubcategoryProvider>(
                      context,
                      listen: false,
                    ).fetchSubcategoryByCategoryId(
                      context: context,
                      categoryId: category.id,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: size.height * 0.01,
                      horizontal: size.width * 0.02,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.015,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? mainColor : Colors.white,
                      borderRadius: BorderRadius.circular(size.width * 0.04),
                      boxShadow: categoryContainerShadow,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.07,
                          width: size.height * 0.07,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(category.image),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: size.width * 0.032,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Right Content (Subcategory and Products)
          Expanded(
            child: Container(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _subcategoryTile(
                    context: context,
                    title: selectedCategory ?? '',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subcategoryTile({
    required BuildContext context,
    required String title,
  }) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.9,
      width: size.width * 0.7,
      child: Consumer<SubcategoryProvider>(
        builder: (context, value, child) {
          final sub = value.subcategory;

          if (selectedCategory != title) return const SizedBox();

          return ListView.builder(
            itemCount: sub.length + 1, // +1 for "All"
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  title: const Text(
                    'All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  onTap: () {
                    moveToPage(
                      context,
                      ShowProductsByCategory(category: title),
                    );
                    Provider.of<ProductProvider>(
                      context,
                      listen: false,
                    ).filterProductByCategoryId(categoryId: title);
                  },
                );
              }

              final subcategory = sub[index - 1];
              return ListTile(
                title: Text(subcategory.name),
                onTap: () {
                  moveToPage(context, ShowProductsByCategory(category: title));
                  Provider.of<ProductProvider>(
                    context,
                    listen: false,
                  ).filterProductBySubcategoryId(
                    subcategoryId: subcategory.id.toString(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
