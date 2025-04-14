import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/screens/all%20category/all_category.dart';
import 'package:grocery_shop/screens/home%20page/componenets/all_products.dart';
import 'package:grocery_shop/screens/home%20page/componenets/product_container.dart';
import 'package:grocery_shop/screens/home%20page/drawer_page.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: size.width,
          child: Column(
            spacing: size.height * 0.001,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _adSlider(size: size),
              const SizedBox(height: 20),
              _text(text: "Popular Categories"),
              const SizedBox(height: 10),
              _popularCategories(size: size, context: context),
              _dailyNeeds(
                text1: "Daily Needs",
                text2: "View all",
                onPressed: () {},
              ),
              _dailyNeedsProducts(size: size),
              _dailyNeeds(
                text1: "All Products",
                text2: "View all",
                onPressed: () {},
              ),
              _allProducts(size: size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _adSlider({required Size size}) {
    return CarouselSlider(
      items: carouselItems,
      options: CarouselOptions(
        height: size.height * 0.25,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }

  Widget _text({required String text}) {
    return Text(
      text,
      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
    );
  }

  Widget _popularCategories({
    required Size size,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: size.height * 0.32,
      width: size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _popularContainer(size: size, text: "Vegetables", onTap: () {}),
              _popularContainer(size: size, text: "Fruits", onTap: () {}),
              _popularContainer(size: size, text: "Bakery", onTap: () {}),
              _popularContainer(size: size, text: "Dairy", onTap: () {}),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _popularContainer(size: size, text: "Meat", onTap: () {}),
              _popularContainer(size: size, text: "Snacks", onTap: () {}),
              _popularContainer(size: size, text: "Beverages", onTap: () {}),
              _popularContainer(
                size: size,
                text: "View All",
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                      child: DrawerPage(body: AllCategory()),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _popularContainer({
    required Size size,
    required VoidCallback onTap,
    required String text,
  }) {
    final List<Product> categories = sampleProducts;
    final List<String> value = [];
    final category = categories.firstWhere(
      (element) => element.name == text,
      orElse:
          () => Product(
            name: text,
            imageUrl: "",
            category: "",
            createdAt: DateTime.now(),
            description: "",
            id: 0,
            offerPrice: 0,
            price: 0,
            subCategory: "",
            updatedAt: DateTime.now(),
            gallery: value,
            discount: 0.0,
            isFavorite: false,
            isFeatured: false,

            rating: 0.0,
            stock: 0,
          ), // Fallback value
    );
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: size.height * 0.10,
            width: size.width * 0.20,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(50),
              image:
                  category.imageUrl.isNotEmpty
                      ? DecorationImage(
                        image: CachedNetworkImageProvider(category.imageUrl),
                        fit: BoxFit.cover,
                      )
                      : null,
            ),
          ),
          const SizedBox(height: 5),
          Text(category.name),
        ],
      ),
    );
  }

  Widget _dailyNeeds({
    required String text1,
    required String text2,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _text(text: text1),
          TextButton(
            onPressed: onPressed,
            child: Text(text2, style: TextStyle(color: Colors.grey.shade600)),
          ),
        ],
      ),
    );
  }

  Widget _dailyNeedsProducts({required Size size}) {
    return SizedBox(
      height: size.height * 0.40,
      width: size.width * 1,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,

        itemBuilder: (context, index) {
          return ProductContainer();
        },
      ),
    );
  }

  Widget _allProducts({required Size size}) {
    return SizedBox(width: size.width * 1, child: AllProducts());
  }
}
