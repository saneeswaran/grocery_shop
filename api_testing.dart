import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grocery_shop/constants/constants.dart';
import 'package:grocery_shop/model/category_model.dart';

void main() async {
  final response = await http.get(
    Uri.parse(getAllCategoryRoute),
    headers: headers,
  );
  if (response.statusCode == 200 || response.statusCode == 201) {
    List<dynamic> decoded = jsonDecode(response.body);
    final data = decoded.map((json) => CategoryModel.fromMap(json)).toList();
    print(data);
  } else {
    print('Error: ${response.statusCode}');
  }
}
