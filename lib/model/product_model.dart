// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String? id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String subCategoryId;
  final int quantity;
  final double rating;
  final List<String> imageUrls;
  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.subCategoryId,
    required this.quantity,
    required this.rating,
    required this.imageUrls,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'quantity': quantity,
      'rating': rating,
      'imageUrls': imageUrls,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      categoryId: map['categoryId'] as String,
      subCategoryId: map['subCategoryId'] as String,
      quantity: map['quantity'] as int,
      rating: map['rating'] as double,
      imageUrls: List<String>.from((map['imageUrls'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? categoryId,
    String? subCategoryId,
    int? quantity = 1,
    double? rating,
    List<String>? imageUrls,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      quantity: quantity ?? this.quantity,
      rating: rating ?? this.rating,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
