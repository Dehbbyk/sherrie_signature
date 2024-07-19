import 'package:flutter/material.dart';
import 'package:sherrie_signature/services/api_service.dart';
class ProductProvider with ChangeNotifier {
  List< dynamic> _product = [];
  ApiService productService = ApiService();
  bool _isLoading = false;
  List<dynamic> get product => _product;
  bool get isLoading => _isLoading;

  get cartItems => null;
  List<dynamic> _wishlist = [];

  List<dynamic> get wishlist => _wishlist;
  void addToWishlist(dynamic product) {
    if (!_wishlist.contains(product)) {
      _wishlist.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(dynamic product) {
    if (_wishlist.contains(product)) {
      _wishlist.remove(product);
      notifyListeners();
    }
  }

  bool isInWishlist(dynamic product) {
    return _wishlist.contains(product);
  }

}