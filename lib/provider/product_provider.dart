import 'package:dok_store/services/api_service.dart';
import 'package:flutter/material.dart';
class ProductProvider with ChangeNotifier {
  final ApiService apiService;
  List< dynamic> _product = [];
  bool _isLoading = false;
  ProductProvider(this.apiService);
  List<dynamic> get product => _product;
  bool get isLoading => _isLoading;
  Future<void> fetchProduct() async {
    _isLoading = true;
    notifyListeners();
    try {
      _product = await apiService.fetchProduct();
      notifyListeners();
    } catch (error) {
      debugPrint('Error fetching product: $error');
      _product = [];
    } finally {
      _isLoading = false;
      notifyListeners();
      debugPrint('Loading state: $_isLoading');
    }
  }
}