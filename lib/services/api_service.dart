import 'dart:convert';
import 'package:dok_store/models/products.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://app.timbu.cloud/api/products';
  final String apiKey = '5e0b6f9d95b040a380f683e8b57ea03420240704190137292988';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
