import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final items = provider.products;
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        mainAxisExtent: 350,
      ),
      itemBuilder: (context, index) {
        return GridTile(
          child: Card(
            child: Column(
              children: [
                _imageContainer(size: size, provider: provider, index: index),
                _priceDetails(size: size, index: index, provider: provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _imageContainer({
    required Size size,
    required ProductProvider provider,
    required int index,
  }) {
    final product = provider.products[index];
    return Container(
      padding: const EdgeInsets.all(5),
      height: size.height * 0.25,
      width: size.width * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: CachedNetworkImageProvider(product.imageUrl),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        spacing: size.height * 0.01,
        children: [
          // offer and like button
          _offerAndLike(index: index, provider: provider),
          Align(
            alignment: Alignment.topRight,
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                final isInCart = provider.cartproducts.any(
                  (element) => element.id == product.id,
                );
                return _customContainer(
                  icon: Icons.shopping_cart,
                  color: isInCart ? mainColor : Colors.grey,
                  onTap: () {
                    if (isInCart) return;
                    provider.addProductToCart(product);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _offerAndLike({required ProductProvider provider, required int index}) {
    final products = provider.products[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 30,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Center(
            child: Text(
              products.discount.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        //like button
        Consumer<ProductProvider>(
          builder: (context, provider, child) {
            bool isFavCheck = provider.isFavCheck(products.id);
            return _customContainer(
              icon: isFavCheck ? Icons.favorite : Icons.favorite_border,
              color: isFavCheck ? mainColor : Colors.grey,
              onTap: () {
                if (isFavCheck) return;
                provider.addToFavorite(products);
              },
            );
          },
        ),
      ],
    );
  }

  Container _customContainer({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _priceDetails({
    required Size size,
    required ProductProvider provider,
    required int index,
  }) {
    final product = provider.products[index];
    return Column(
      spacing: size.height * 0.01,
      children: [
        Row(
          spacing: size.width * 0.01,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.yellow),
            Text(
              product.rating.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.01),
        Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: size.height * 0.01),
        Text(
          product.stock.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              product.price.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey.shade400,
              ),
            ),
            Text(
              product.offerPrice.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
