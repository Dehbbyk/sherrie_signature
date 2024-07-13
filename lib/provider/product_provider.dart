import 'package:flutter/material.dart';
import 'package:sherrie_signature/services/api_service.dart';
class ProductProvider with ChangeNotifier {
  List< dynamic> _product = [];
  ApiService productService = ApiService();
  bool _isLoading = false;
  List<dynamic> get product => _product;
  bool get isLoading => _isLoading;

  get cartItems => null;
}