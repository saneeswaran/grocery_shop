import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';

class DailyNeeds extends StatelessWidget {
  const DailyNeeds({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.50,
      width: size.width * 1,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          //outside container
          return Container(
            margin: const EdgeInsets.all(8),
            height: size.height * 0.50,
            width: size.width * 0.60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: dailyNeedsProductShadow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //image container
                Container(
                  margin: EdgeInsets.all(size.width * 0.02),
                  padding: EdgeInsets.all(size.width * 0.02),
                  height: size.height * 0.30,
                  width: size.width * 0.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://organicmandya.com/cdn/shop/files/Apples_bf998dd2-0ee8-4880-9726-0723c6fbcff3.jpg?v=1721368465&width=1000',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //lke and cart button
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: size.height * 0.01,
                    children: [
                      _customContainerForLikeAndCart(
                        size: size,
                        icon: Icons.favorite_border_outlined,
                        onPressed: () {},
                      ),
                      _customContainerForLikeAndCart(
                        size: size,
                        icon: Icons.shopping_cart_outlined,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(size.width * 0.02),
                  height: size.height * 0.15,
                  width: size.width * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: size.height * 0.008,
                    children: [
                      _customRow(
                        mainAxisAlignment: MainAxisAlignment.start,
                        child: const Icon(Icons.star, color: Colors.yellow),
                        text: const Text("4.9"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.height * 0.007),
                        child: Text(
                          "Product Name",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.shade300),
                      _customRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        child: Text(
                          "Quantity",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        text: const Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Container _customContainerForLikeAndCart({
    required Size size,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: size.height * (40 / 812),
      width: size.width * (40 / 375),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 0.8),
      ),
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 22, color: mainColor),
        ),
      ),
    );
  }

  Widget _customRow({
    required MainAxisAlignment mainAxisAlignment,
    required Widget child,
    required Widget text,
  }) {
    return Row(mainAxisAlignment: mainAxisAlignment, children: [child, text]);
  }
}
