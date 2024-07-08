import 'package:dok_store/services/api_service.dart';
import 'package:flutter/material.dart';
class ProductProvider with ChangeNotifier {
  final ApiService apiService;
  List< dynamic> _data = [];
  bool _isLoading = false;
  ProductProvider(this.apiService);
  List<dynamic> get data => _data;
  bool get isLoading => _isLoading;
  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _data = await apiService.fetchData();
      notifyListeners();
    } catch (error) {
      debugPrint('Error fetching data: $error');
      _data = [];
    } finally {
      _isLoading = false;
      notifyListeners();
      debugPrint('Loading state: $_isLoading');
    }
  }
}