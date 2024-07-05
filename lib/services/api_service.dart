import 'dart:convert';
import 'package:dok_store/models/products.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'https://app.timbu.cloud/api/products';
  final String apiKey = 'YOUR_API_KEY'; // Replace with your actual API key

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
