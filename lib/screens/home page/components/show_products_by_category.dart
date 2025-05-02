import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/screens/home%20page/provider/product_provider.dart';
import 'package:grocery_shop/screens/home%20page/provider/subcategory_provider.dart';
import 'package:provider/provider.dart';

class ShowProductsByCategory extends StatefulWidget {
  final String categoryId;
  const ShowProductsByCategory({super.key, required this.categoryId});

  @override
  State<ShowProductsByCategory> createState() => _ShowProductsByCategoryState();
}

class _ShowProductsByCategoryState extends State<ShowProductsByCategory> {
  @override
  void initState() {
    super.initState();
    final subProvider = Provider.of<SubcategoryProvider>(
      context,
      listen: false,
    );
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );

    subProvider.fetchSubcategoryByCategoryId(
      context: context,
      categoryId: widget.categoryId,
    );
    productProvider.fetchAllProducts(context: context); // Important
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.01),
        child: Column(
          children: [
            _subcategoryButtons(size: size),
            const SizedBox(height: 10),
            Consumer<ProductProvider>(
              builder: (context, value, child) {
                final products =
                    value.filterProductsBySubcategoryId.isNotEmpty
                        ? value.filterProductsBySubcategoryId
                        : value.products;

                return Expanded(
                  child:
                      products.isEmpty
                          ? const Center(child: Text("No Products"))
                          : ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ListTile(
                                title: Text(product.name),
                                subtitle: Text("₹ ${product.price}"),
                              );
                            },
                          ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _subcategoryButtons({required Size size}) {
    return SizedBox(
      height: size.height * 0.045,
      width: size.width * 1,
      child: Consumer<SubcategoryProvider>(
        builder: (context, value, child) {
          final newVal = value.subcategory;
          return value.subcategory.isEmpty
              ? const Center(
                child: Text(
                  "No Subcategory Found",
                  style: TextStyle(color: mainColor, fontSize: 18),
                ),
              )
              : ListView.builder(
                itemCount: newVal.length + 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Clear Filter Button
                    return Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Provider.of<ProductProvider>(
                              context,
                              listen: false,
                            ).clearSubcategoryFilter();
                          },
                          child: const Text("All"),
                        ),
                        SizedBox(width: size.width * 0.01),
                      ],
                    );
                  }

                  final subcategory = newVal[index - 1];
                  return Row(
                    children: [
                      SizedBox(width: size.width * 0.01),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            40,
                            166,
                            130,
                          ),
                        ),
                        onPressed: () {
                          Provider.of<ProductProvider>(
                            context,
                            listen: false,
                          ).filterProductBySubcategoryId(
                            subcategoryId: subcategory.id!,
                          );
                        },
                        child: Text(
                          subcategory.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
        },
      ),
    );
  }
}
