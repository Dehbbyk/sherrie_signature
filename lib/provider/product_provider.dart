import 'package:dok_store/services/api_service.dart';
import 'package:flutter/material.dart';
class ProductProvider with ChangeNotifier {
  List< dynamic> _product = [];
  ApiService productService = ApiService();
  bool _isLoading = false;
  List<dynamic> get product => _product;
  bool get isLoading => _isLoading;

  get cartItems => null;
}