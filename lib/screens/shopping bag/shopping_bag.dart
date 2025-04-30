import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/screens/shopping%20bag/provider/shopping_bag_provider.dart';
import 'package:grocery_shop/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({super.key});

  @override
  State<ShoppingBag> createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  final filterCartConbtroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ShoppingBagProvider>(context, listen: false);
    provider.getUserCartProduct(context: context);
    filterCartConbtroller.addListener(() {
      provider.filterCartProduct(query: filterCartConbtroller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingBagProvider>(context);
    final isShowSearchBar = provider.isShowSearchBar;
    final cart = provider.filterCart;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title:
            isShowSearchBar
                ? TextField(controller: filterCartConbtroller)
                : const Text(
                  "Shopping Bag",
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        actions: [
          IconButton(
            onPressed: () {
              provider.showSearchBar();
              log(isShowSearchBar.toString());
            },
            icon: const Icon(Icons.search, color: mainColor),
          ),
          isShowSearchBar
              ? const SizedBox()
              : Consumer<ShoppingBagProvider>(
                builder: (context, provider, child) {
                  final cartProductLength = provider.filterCart.length;
                  return Text(
                    '$cartProductLength Items',
                    style: const TextStyle(
                      color: mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
          SizedBox(width: size.width * 0.02),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          provider.hideSearchBar();
          log(isShowSearchBar.toString());
        },
        child: Container(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Column(
            spacing: size.height * 0.02,
            children: [
              SizedBox(
                height: size.height * 0.4,
                width: size.width * 1,
                child:
                    cart.isEmpty
                        ? const Center(child: Text("Cart is empty"))
                        : ListView.builder(
                          itemCount: cart.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final cartProduct = cart[index];
                            return Container(
                              margin: EdgeInsets.all(size.width * 0.02),
                              height: size.height * 0.18,
                              width: size.width * 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: dailyNeedsProductShadow,
                              ),
                              child: Row(
                                children: [
                                  //image
                                  SizedBox(
                                    height: size.height * 0.20,
                                    width: size.width * 0.25,
                                    child: Container(
                                      height: size.height * 0.20,
                                      width: size.width * 0.25,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            cartProduct.imageUrls[0],
                                          ),
                                          fit: BoxFit.contain,
                                          scale: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //content
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: size.height * 0.03,
                                      left: size.height * 0.02,
                                    ),
                                    height: size.height * 0.20,
                                    width: size.width * 0.50,
                                    child: Column(
                                      spacing: size.height * 0.002,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //product name
                                        Text(
                                          cartProduct.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        //quantity
                                        Text(
                                          'Quantity: ${cartProduct.quantity.toString()}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),

                                        //unit price
                                        _customRichText(
                                          text1: "Unity Price: ",
                                          text2: "\$${cartProduct.price}",
                                        ),

                                        //total
                                        Consumer<ShoppingBagProvider>(
                                          builder: (context, value, child) {
                                            final totalAmount = value
                                                .calculateTotalPrice(
                                                  productId:
                                                      cartProduct.id.toString(),
                                                );
                                            return _customRichText(
                                              text1: "Total: ",
                                              text2: "\$$totalAmount",
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  //
                                  SizedBox(
                                    height: size.height * 0.20,
                                    width: size.width * 0.15,
                                    child: Consumer<ShoppingBagProvider>(
                                      builder: (context, provider, child) {
                                        return _quantityContainer(
                                          size: size,
                                          increaseQuantity: () {
                                            provider.increaseQuantity(
                                              productId:
                                                  cartProduct.id.toString(),
                                              stock: 70,
                                            );
                                          },
                                          quantity:
                                              cartProduct.quantity.toString(),
                                          decreaseQuantity: () {
                                            provider.decreaseQuantity(
                                              productId:
                                                  cartProduct.id.toString(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
              ),
              //Delivery Option
              _costSummary(size: size),
              _elevatedButton(
                size: size,
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  final userId = pref.getString('userId');
                  log(userId.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customRichText({required String text1, required String text2}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          TextSpan(
            text: text2,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityContainer({
    required Size size,
    required VoidCallback increaseQuantity,
    required String quantity,
    required VoidCallback decreaseQuantity,
  }) {
    return SizedBox(
      height: size.height * 0.05,
      width: size.width * 0.15,
      child: Container(
        margin: EdgeInsets.only(
          right: size.width * 0.02,
          top: size.height * 0.01,
          bottom: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            IconButton(
              onPressed: increaseQuantity,
              icon: const Icon(Icons.add, color: mainColor, size: 22),
            ),

            Text(
              quantity,
              style: const TextStyle(color: mainColor, fontSize: 18),
            ),

            IconButton(
              onPressed: decreaseQuantity,
              icon: const Icon(Icons.remove, color: mainColor, size: 22),
            ),
          ],
        ),
      ),
    );
  }

  Widget _costSummary({required Size size}) {
    return Container(
      padding: EdgeInsets.all(size.height * 0.02),
      height: size.height * 0.25,
      width: size.width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Cost Summary",
            style: TextStyle(
              color: mainColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: Colors.grey.shade200),
          Consumer<ShoppingBagProvider>(
            builder: (context, value, child) {
              final itemsPrice = value.totalItemPrice;
              return _customRichTextForCostSummary(
                text1: "items Price",
                color: Colors.black,
                fontWeight1: FontWeight.bold,
                text2: "$itemsPrice",
                fontWeight2: FontWeight.bold,
              );
            },
            child: _customRichTextForCostSummary(
              text1: "items Price",
              text2: "205",
            ),
          ),
          _customRichTextForCostSummary(text1: "Tax", text2: "250"),
          _customRichTextForCostSummary(text1: "Discount", text2: "100"),
          Divider(color: Colors.grey.shade200),
          Consumer<ShoppingBagProvider>(
            builder: (context, value, child) {
              final subtotal = value.subtotal;
              return _customRichTextForCostSummary(
                text1: "Subtotal",
                color: Colors.black,
                fontWeight1: FontWeight.bold,
                text2: "$subtotal",
                fontWeight2: FontWeight.bold,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _customRichTextForCostSummary({
    required String text1,
    required String text2,
    Color color = Colors.grey,
    FontWeight fontWeight1 = FontWeight.normal,
    FontWeight fontWeight2 = FontWeight.normal,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: TextStyle(color: color, fontSize: 18, fontWeight: fontWeight1),
        ),
        Text(
          text2,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: fontWeight2,
          ),
        ),
      ],
    );
  }

  Widget _elevatedButton({
    required Size size,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: size.height * 0.07,
      width: size.width * 1,
      child: CustomElevatedButton(
        onPressed: onPressed,
        text: "Proceed to payment",
      ),
    );
  }
}
