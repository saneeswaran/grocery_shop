// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String? id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final String categoryId;
  final String subCategoryId;
  final int quantity;
  final double rating;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.categoryId,
    required this.subCategoryId,
    required this.quantity,
    this.rating = 1.0,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrls': imageUrls,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'quantity': quantity,
      'rating': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    final imageData = map['imageUrls'];
    return ProductModel(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      quantity: map['quantity'],
      categoryId:
          map['categoryId'] is Map
              ? map['categoryId']['_id']
              : map['categoryId'],
      subCategoryId:
          map['subCategoryId'] is Map
              ? map['subCategoryId']['_id']
              : map['subCategoryId'],
      price: (map['price'] as num).toDouble(),
      imageUrls: List<String>.from(
        imageData is List ? imageData : (imageData as Map).values,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    List<String>? imageUrls,
    String? categoryId,
    String? subCategoryId,
    int? quantity = 1,
    double? rating,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      quantity: quantity ?? this.quantity,
      rating: rating ?? this.rating,
    );
  }
}
