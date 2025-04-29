class SubCategoryModel {
  final String? id;
  final String name;
  final String categoryId;
  final String? image;

  SubCategoryModel({
    this.id,
    required this.name,
    required this.categoryId,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "categoryId": categoryId,
      "image": image, // Make sure this is included
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      categoryId: map['categoryId'] ?? '',
      image: map['image'], // Include this too
    );
  }
}
