import 'package:flutter/material.dart';
import 'package:sherrie_signature/services/api_service.dart';
class ProductProvider with ChangeNotifier {
  List< dynamic> _product = [];
  ApiService productService = ApiService();
  bool _isLoading = false;
  List<dynamic> get product => _product;
  bool get isLoading => _isLoading;

  List<dynamic> _wishlist = [];
  List<dynamic> get wishlist => _wishlist;
  bool isInWishlist(dynamic product) {
    return _wishlist.contains(product);
  }
  void addToWishlist(dynamic product) {
    _wishlist.add(product);
    notifyListeners();
  }
  void removeFromWishlist(dynamic product) {
    _wishlist.remove(product);
    notifyListeners();
  }
  final List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;

  int get cartCount => _cart.length;

  void addToCart(dynamic product) {
    _cart.add(product);
    notifyListeners();
  }
    void removeFromCart(dynamic product) {
      _cart.remove(product);
      notifyListeners();
  }
}