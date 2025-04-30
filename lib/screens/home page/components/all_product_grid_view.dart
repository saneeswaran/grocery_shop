import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/screens/favorite%20page/provider/favorite_provider.dart';
import 'package:grocery_shop/screens/home%20page/provider/product_provider.dart';
import 'package:grocery_shop/screens/shopping%20bag/provider/shopping_bag_provider.dart';
import 'package:provider/provider.dart';

class AllProductGridView extends StatelessWidget {
  const AllProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final product = Provider.of<ProductProvider>(context).products;
    return GridView.builder(
      padding: EdgeInsets.all(size.width * 0.03),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: product.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: size.height * 0.02,
        crossAxisSpacing: size.width * 0.03,
        mainAxisExtent: size.height * 0.4,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final products = product[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width * 0.03),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Container
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
                          image: NetworkImage(products.imageUrls[0]),
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
                            builder: (context, favoriteProvider, child) {
                              final bool isFav = favoriteProvider.favorite.any(
                                (item) => item.id == products.id,
                              );
                              return _iconButton(
                                size: size,
                                icon:
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                onPressed: () {
                                  if (context.mounted) {
                                    if (!isFav) {
                                      favoriteProvider.addToFavorite(
                                        context: context,
                                        productId: products.id.toString(),
                                        product: products,
                                      );
                                    } else {
                                      favoriteProvider
                                          .deleteProductFromFavorites(
                                            context: context,
                                            productId: products.id.toString(),
                                          );
                                    }
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                          Consumer<ShoppingBagProvider>(
                            builder: (context, bag, child) {
                              final isInBag = bag.cart.any(
                                (item) => item.id == products.id,
                              );
                              return _iconButton(
                                size: size,
                                icon:
                                    isInBag
                                        ? Icons.shopping_cart
                                        : Icons.shopping_cart_outlined,
                                onPressed: () {
                                  if (context.mounted) {
                                    if (!isInBag) {
                                      bag.addToCart(
                                        context: context,
                                        productId: products.id.toString(),
                                        product: products,
                                      );
                                    } else {
                                      bag.deleteProductFromCart(
                                        context: context,
                                        productId: products.id.toString(),
                                      );
                                    }
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
              // Bottom Container
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
                            products.rating.toString(),
                            style: TextStyle(fontSize: size.width * 0.03),
                          ),
                        ],
                      ),
                      Text(
                        products.name,
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
                            products.quantity.toString(),
                            style: TextStyle(
                              fontSize: size.width * 0.03,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            '$indianCurrency ${products.price}',
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
