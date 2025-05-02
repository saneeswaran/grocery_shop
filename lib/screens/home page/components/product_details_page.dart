import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/screens/favorite%20page/provider/favorite_provider.dart';
import 'package:grocery_shop/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;
  final String productTitle;
  final List<String> productImage;
  final String productPrice;
  final String productDescription;
  final String productCategory;
  final String productSubcategory;
  final String productQuantity;
  final String productRating;
  final ProductModel productModel;
  const ProductDetailsPage({
    super.key,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
    required this.productCategory,
    required this.productSubcategory,
    required this.productQuantity,
    required this.productRating,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: size.height * 0.01,
          children: [
            SizedBox(
              height: size.height * 0.30,
              width: size.width * 1,
              child: CarouselSlider(
                items:
                    productImage
                        .map((item) => CachedNetworkImage(imageUrl: item))
                        .toList(),
                options: CarouselOptions(enlargeCenterPage: true),
              ),
            ),
            _listOfImages(size),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Consumer<FavoriteProvider>(
                  builder: (context, value, child) {
                    final bool isFavCheck = value.favorite.any(
                      (item) => item.id == productId,
                    );
                    return IconButton(
                      onPressed: () {
                        if (!isFavCheck) {
                          value.addToFavorite(
                            context: context,
                            productId: productId,
                            product: productModel,
                          );
                        } else {
                          value.deleteProductFromFavorites(
                            context: context,
                            productId: productId,
                          );
                        }
                      },
                      icon: Icon(
                        isFavCheck ? Icons.favorite : Icons.favorite_border,
                        color: mainColor,
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              spacing: size.width * 0.01,
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 20),
                Text(productRating),
              ],
            ),
            Text(
              productQuantity,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            Text(
              productPrice,
              style: const TextStyle(
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: size.height * 0.08,
              width: size.width * 1,
              child: CustomElevatedButton(
                onPressed: () {},
                text: "Add to cart",
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _listOfImages(Size size) {
    return SizedBox(
      height: size.height * 0.1,
      width: size.width * 1,
      child: ListView.builder(
        itemCount: productImage.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            height: size.height * 0.1,
            width: size.width * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: mainColor, width: 1.5),
              image: DecorationImage(
                image: CachedNetworkImageProvider(productImage[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
