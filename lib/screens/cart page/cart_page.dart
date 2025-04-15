import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../provider/product_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final cartProducts = provider.cartproducts;
    final cartCount = cartProducts.length;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: mainColor),
        title: const Text(
          "Shopping Bag",
          style: TextStyle(
            color: mainColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Text(
            "$cartCount Items",
            style: TextStyle(
              color: mainColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: size.height * 0.01,
          children: [
            SizedBox(
              height: size.height * 0.80,
              width: size.width * 1,
              child: ListView.builder(
                itemCount: cartProducts.length,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _cartProducts(
                    size: size,
                    provider: provider,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartProducts({
    required Size size,
    required ProductProvider provider,
    required int index,
  }) {
    final cart = provider.cartproducts[index];
    return Container(
      margin: const EdgeInsets.all(8),
      height: size.height * 0.19,
      width: size.width * 1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: boxShadow,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          spacing: size.width * 0.03,
          children: [
            //image container
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              child: Container(
                height: size.height * 0.12,
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(cart.imageUrl),
                    fit: BoxFit.fill,
                    scale: 2,
                  ),
                ),
              ),
            ),
            //product details
            SizedBox(
              height: size.height * 0.19,
              width: size.width * 0.41,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: size.height * 0.01,
                children: [
                  Text(
                    cart.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${cart.discount}",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                  ),
                  Row(
                    spacing: size.width * 0.01,
                    children: [
                      Text(
                        "unit price: ${cart.price}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Text(
                        "${cart.offerPrice.toInt()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _customRichText(price: provider.specificProduct.toInt()),
                ],
              ),
            ),
            Consumer<ProductProvider>(
              builder: (context, provider, child) {
                final originalProduct = provider.products.firstWhere(
                  (product) => product.id == cart.id,
                );
                return _quanityContainer(
                  size: size,
                  increment: () {
                    provider.productIncrement(cart.id, originalProduct.stock);
                  },
                  quantity: provider.cartproducts[index].stock,
                  decrement: () {
                    provider.productDecrement(cart.id);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _customRichText({required int price}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: "Total: ", style: TextStyle(color: Colors.black)),
          TextSpan(
            text: "$price",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _quanityContainer({
    required Size size,
    required VoidCallback increment,
    required VoidCallback decrement,
    required int quantity,
  }) {
    return Container(
      height: size.height * 0.15,
      width: size.width * 0.13,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          IconButton(
            onPressed: increment,
            icon: Icon(Icons.add, color: mainColor),
          ),
          Text("$quantity", style: TextStyle(color: mainColor)),
          IconButton(
            onPressed: decrement,
            icon: Icon(Icons.remove, color: mainColor),
          ),
        ],
      ),
    );
  }
}
