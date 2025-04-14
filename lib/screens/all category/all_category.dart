import 'package:flutter/material.dart';
import 'package:grocery_shop/model/sample_category.dart';

import '../../constants/constants.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({super.key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        height: size.height,
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_allCategory(size: size), _subCategory(size: size)],
        ),
      ),
    );
  }

  Widget _allCategory({required Size size}) {
    return SizedBox(
      height: size.height,
      width: size.width * 0.35,
      child: ListView.builder(
        itemCount: categories.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return _categoryContainer(
            size: size,
            index: index,
            isSelected: isSelected,
          );
        },
      ),
    );
  }

  Widget _categoryContainer({
    required Size size,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = selectedIndex == index ? null : index;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: size.height * 0.18,
        width: size.width * 0.30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          boxShadow: categoryContainerShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: size.height * 0.10,
              width: size.width * 0.20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.pink,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              categories[index]['name'],
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subCategory({required Size size}) {
    if (selectedIndex == null) {
      return Expanded(
        child: const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 40),
            child: Text("Select a category to see subcategories"),
          ),
        ),
      );
    }

    List<String> subcategories = List<String>.from(
      categories[selectedIndex!]['subcategories'],
    );

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: subcategories.length,
          itemBuilder: (context, index) {
            return InkWell(
              splashColor: Colors.black,
              onTap: () {},
              child: ListTile(
                title: Text(subcategories[index]),
                trailing: const Icon(Icons.arrow_right),
              ),
            );
          },
        ),
      ),
    );
  }
}
