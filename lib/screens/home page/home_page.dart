import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/screens/all%20category/all_category.dart';
import 'package:grocery_shop/screens/home%20page/components/all_product_grid_view.dart';
import 'package:grocery_shop/screens/home%20page/components/daily_needs.dart';
import 'package:grocery_shop/screens/home%20page/provider/product_provider.dart';
import 'package:grocery_shop/screens/shopping%20bag/provider/shopping_bag_provider.dart';
import 'package:grocery_shop/util/util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).fetchAllProducts(context: context);
    Provider.of<ShoppingBagProvider>(
      context,
      listen: false,
    ).getUserCartProduct(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: mainColor),
          ),
          Badge.count(
            count: 3,
            child: const Icon(Icons.notifications, color: mainColor),
          ),
          SizedBox(width: size.width * 0.03),
        ],
      ),
      drawer: const Drawer(),
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
              _customTitles(
                text1: "Daily Needs",
                text2: "View all",
                onPressed: () {},
              ),
              const DailyNeeds(),
              _customTitles(
                text1: "All Products",
                text2: "View all",
                onPressed: () {},
              ),
              const AllProductGridView(),
              SizedBox(height: size.height * 0.1),
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
        // autoPlay: true,
        enlargeCenterPage: true,
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
      child: GridView.builder(
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, categoryIndex) {
          return categoryIndex == 5
              ? _viewAllContainer(context: context, size: size)
              : _categoryContainer(size: size);
        },
      ),
    );
  }

  Widget _categoryContainer({required Size size}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: size.width * 0.01),
          height: size.height * 0.12,
          width: size.width * 0.25,
          decoration: const BoxDecoration(
            color: Colors.pink,
            shape: BoxShape.circle,
          ),
        ),
        const Text(" Name", maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _viewAllContainer({
    required Size size,
    required BuildContext context,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            moveToPage(context, const AllCategory());
          },
          child: Container(
            margin: EdgeInsets.only(right: size.width * 0.02),
            height: size.height * 0.12,
            width: size.width * 0.25,
            decoration: const BoxDecoration(
              color: mainColor,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "+1",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Text("View All", maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
    );
  }

  Widget _customTitles({
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
}
