import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:sherrie_signature/models/products.dart';
class ApiService {
  final String baseUrl = 'https://api.timbu.cloud/products';
  final String apiKey = '5e0b6f9d95b040a380f683e8b57ea03420240704190137292988';
  final String appId = 'BODV38H42OCLMGE';
  final organizationId = 'ca2260578d7d4744a491ed7cce125698';
  final String categoryUrl = 'https://api.timbu.cloud/categories';

  Future<List<dynamic>> fetchProduct() async {
    final queryParams = {
      'organization_id': organizationId,
      "reverse_sort":"false",
      "page":"1",
      "size":"20",
      'ApiKey': apiKey,
      'Appid': appId,
    };
    final uri = Uri.parse(
        '$baseUrl?organization_id=$organizationId&reverse_sort=false&page=1&size=20&Appid=$appId&Apikey=$apiKey');
    print('Fetching product from: $uri');
    final response = await http.get(uri);
    try{
      if (response.statusCode == 200) {
        var item= json.decode(response.body);
        return item['items'];
      } else {
        List<dynamic> items = json.decode(response.body)['items'];
        print('Fetched products: $items');
        return items.map((item) => Product.fromJson(item)).toList();
      }
    }catch(error){
      if(kIsWeb){
        throw Exception ('CORS policy error: ${error.toString()}');}else{
        throw Exception ('Failed to load data: ${error.toString()}');
      }
    }
  }}