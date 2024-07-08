import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiService {
  final String baseUrl = 'api.timbu.cloud';
  final String apiKey = '5e0b6f9d95b040a380f683e8b57ea03420240704190137292988';
  final String appId = 'BODV38H42OCLMGE';
  final organizationId = 'ca2260578d7d4744a491ed7cce125698';
  Future<List<dynamic>> fetchData() async {
    final queryParams = {
      'organization_id': organizationId,
      "reverse_sort":"false",
      "page":"1",
      "size":"10",
      'ApiKey': apiKey,
      'Appid': appId,
    };
    final uri = Uri.https(baseUrl, '/products', queryParams);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final decodedResponse= json.decode(response.body);
      debugPrint('Response data: ${response.body}');
      return decodedResponse["items"];
    } else {
      debugPrint('Failed to load data: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load data');
    }
  }
}