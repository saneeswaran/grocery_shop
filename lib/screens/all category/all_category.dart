import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/screens/all%20category/provider/category_provider.dart';
import 'package:provider/provider.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({super.key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
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
                    });
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
                              image: NetworkImage(category.image),
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
          // Right Content
          Expanded(
            child: Container(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _subcategoryTile(context, "All"),
                  SizedBox(height: size.height * 0.02),
                  _subcategoryTile(context, "Fruits"),
                  SizedBox(height: size.height * 0.02),
                  _subcategoryTile(context, "Vegetables"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subcategoryTile(BuildContext context, String title) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Text(title, style: TextStyle(fontSize: size.width * 0.045)),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios, size: 16),
      ],
    );
  }
}
