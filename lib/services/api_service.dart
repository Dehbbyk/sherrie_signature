import 'dart:convert';
import 'package:dok_store/models/products.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://app.timbu.cloud/api/products';
  final String apiKey = '5e0b6f9d95b040a380f683e8b57ea03420240704190137292988';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((product) => Product.fromJson(product)).toList();
      } else {
        throw Exception('Failed to load products: ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('Failed to load products: $error');
    }
  }
}
