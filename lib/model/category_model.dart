// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  final String? id;
  final String name;
  final String image;

  CategoryModel({this.id, required this.name, required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'_id': id, 'name': name, 'image': image};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
