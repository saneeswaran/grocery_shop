import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/screens/favorite%20page/provider/favorite_provider.dart';
import 'package:grocery_shop/screens/home%20page/provider/product_provider.dart';
import 'package:grocery_shop/screens/home%20page/provider/subcategory_provider.dart';
import 'package:grocery_shop/screens/shopping%20bag/provider/shopping_bag_provider.dart';
import 'package:provider/provider.dart';

class ShowProductsByCategory extends StatefulWidget {
  final String category;
  const ShowProductsByCategory({super.key, required this.category});

  @override
  State<ShowProductsByCategory> createState() => _ShowProductsByCategoryState();
}

class _ShowProductsByCategoryState extends State<ShowProductsByCategory> {
  String? selectedSubcategoryName;

  @override
  void initState() {
    super.initState();
    final subcategoryProvider = Provider.of<SubcategoryProvider>(
      context,
      listen: false,
    );
    subcategoryProvider.fetchSubcategoryByCategoryId(
      context: context,
      categoryId: widget.category,
    );

    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    productProvider.getAllProductsByCategory(
      context: context,
      category: widget.category,
    );
    productProvider.getProductsBySubcategory(
      context: context,
      subcategory: selectedSubcategoryName ?? "",
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: mainColor)),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        width: size.width,
        child: Column(
          children: [
            _subcategoryOutLinedButton(size: size),
            _productsGrid(size: size),
          ],
        ),
      ),
    );
  }

  Widget _subcategoryOutLinedButton({required Size size}) {
    return SizedBox(
      height: size.height * 0.08,
      child: Consumer<SubcategoryProvider>(
        builder: (context, value, child) {
          final sub = value.subcategory;
          return ListView.builder(
            itemCount: sub.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Row(
                  children: [
                    SizedBox(width: size.width * 0.02),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            selectedSubcategoryName == null
                                ? const Color.fromARGB(255, 109, 191, 168)
                                : Colors.white,
                        side: BorderSide(
                          color: mainColor,
                          width: selectedSubcategoryName == null ? 2 : 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          selectedSubcategoryName = null;
                          Provider.of<ProductProvider>(
                            context,
                            listen: false,
                          ).getAllProductsByCategory(
                            context: context,
                            category: widget.category,
                          );
                        });
                      },
                      child: Text(
                        "All",
                        style: TextStyle(
                          color:
                              selectedSubcategoryName == null
                                  ? Colors.white
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
              }

              final subcategory = sub[index - 1];
              return Row(
                children: [
                  SizedBox(width: size.width * 0.02),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          selectedSubcategoryName == subcategory.name
                              ? const Color.fromARGB(255, 109, 191, 168)
                              : Colors.white,
                      side: BorderSide(
                        color: mainColor,
                        width:
                            selectedSubcategoryName == subcategory.name ? 2 : 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedSubcategoryName = subcategory.name;
                        Provider.of<ProductProvider>(
                          context,
                          listen: false,
                        ).getProductsBySubcategory(
                          context: context,
                          subcategory: subcategory.name,
                        );
                      });
                    },
                    child: Text(
                      subcategory.name,
                      style: TextStyle(
                        color:
                            selectedSubcategoryName == subcategory.name
                                ? Colors.white
                                : Colors.black,
                      ),
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

  Widget _productsGrid({required Size size}) {
    return Expanded(
      child: Consumer<ProductProvider>(
        builder: (context, value, child) {
          final products =
              selectedSubcategoryName == null
                  ? value.getAllProductByCategory
                  : value.filterProductsBySubcategoryId;

          if (products.isEmpty) {
            return const Center(child: Text("No Products Found"));
          }

          return GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: size.height * 0.02,
              crossAxisSpacing: size.width * 0.03,
              mainAxisExtent: size.height * 0.4,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Expanded(
                      flex: 7,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(size.width * 0.03),
                                topRight: Radius.circular(size.width * 0.03),
                              ),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  product.imageUrls[0],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: size.height * 0.01,
                            right: size.width * 0.02,
                            child: Column(
                              children: [
                                Consumer<FavoriteProvider>(
                                  builder: (context, fav, _) {
                                    final isFav = fav.favorite.any(
                                      (item) => item.id == product.id,
                                    );
                                    return _iconButton(
                                      size: size,
                                      icon:
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                      onPressed: () {
                                        if (isFav) {
                                          fav.deleteProductFromFavorites(
                                            context: context,
                                            productId: product.id.toString(),
                                          );
                                        } else {
                                          fav.addToFavorite(
                                            context: context,
                                            productId: product.id.toString(),
                                            product: product,
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: size.height * 0.01),
                                Consumer<ShoppingBagProvider>(
                                  builder: (context, bag, _) {
                                    final isInCart = bag.cart.any(
                                      (item) => item.id == product.id,
                                    );
                                    return _iconButton(
                                      size: size,
                                      icon:
                                          isInCart
                                              ? Icons.shopping_cart
                                              : Icons.shopping_cart_outlined,
                                      onPressed: () {
                                        if (isInCart) {
                                          bag.deleteProductFromCart(
                                            context: context,
                                            productId: product.id.toString(),
                                          );
                                        } else {
                                          bag.addToCart(
                                            context: context,
                                            productId: product.id.toString(),
                                            product: product,
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Details
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.01,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: size.width * 0.04,
                                ),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  product.rating.toString(),
                                  style: TextStyle(fontSize: size.width * 0.03),
                                ),
                              ],
                            ),
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.04,
                              ),
                            ),
                            Divider(thickness: 1, color: Colors.grey.shade300),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.quantity.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * 0.03,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  '$indianCurrency ${product.price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.035,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _iconButton({
    required Size size,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon, color: mainColor, size: size.width * 0.045),
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.7),
        shape: const CircleBorder(),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }
}
