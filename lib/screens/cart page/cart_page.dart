import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  void fetchData(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    if (context.mounted) {
      Provider.of<CartProvider>(
        context,
        listen: false,
      ).fetchCartProducts(context: context, userId: token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    final cartProducts = provider.cart;
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
    required CartProvider provider,
    required int index,
  }) {
    final cart = provider.cart[index];
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
                    image: CachedNetworkImageProvider(cart.imageUrls[0]),
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
                  // Text(
                  //   "${cart.dis}",
                  //   style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                  // ),
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
                      // Text(
                      //   "${cart.offerPrice.toInt()}",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                  _customRichText(price: provider.cart[index].price.toInt()),
                ],
              ),
            ),
            Consumer<CartProvider>(
              builder: (context, provider, child) {
                return _quanityContainer(
                  size: size,
                  increment: () {
                    provider.productIncrement(
                      productId: cart.id.toString(),
                      stock: 40,
                    );
                  },
                  //  quantity: provider.cartproducts[index].stock,
                  quantity: 20,
                  decrement: () {
                    provider.decrementProduct(productId: cart.id.toString());
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
