import 'dart:convert';

class CategoryModel {
  final String id;
  final String name;
  final String image;

  // Adjusted constructor
  CategoryModel({required this.name, required this.image, this.id = ''});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'image': image};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['_id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
