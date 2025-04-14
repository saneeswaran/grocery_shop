import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      height: size.height * 0.40,
      width: size.width * 0.60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        spacing: size.height * 0.01,
        children: [_imageContainer(size: size), _otherProductDetails()],
      ),
    );
  }

  Widget _imageContainer({required Size size}) {
    return Container(
      height: size.height * 0.22,
      width: size.width * 0.55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-oisjxyya3uzU_Fsq7EfaiXrRWQJCi89QsSdNNYudEXQGl27fb7rQ-mg&s',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _discountAndLikeButton(text: "50%"),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Align(
              alignment: Alignment.topRight,
              child: _customContainer(icon: Icons.shopping_cart, onTap: () {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _discountAndLikeButton({required String text}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _customContainer(icon: Icons.favorite_border, onTap: () {}),
        ],
      ),
    );
  }

  Container _customContainer({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(icon, color: mainColor, size: 20),
      ),
    );
  }

  Widget _otherProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("5.0"),
            ),
          ],
        ),
        Text(
          "product name",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          "product type",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Divider(color: Colors.grey.shade400, thickness: 0.8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Quantity",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade300,
              ),
            ),
            Row(
              children: [
                Text(
                  "Org price",
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  "off price",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
