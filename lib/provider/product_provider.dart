import 'package:flutter/material.dart';
import 'package:sherrie_signature/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<dynamic> _product = [];
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

  Map<String, int> _quantities = {};

  void addToCart(dynamic product) {
    _cart.add(product);
    _quantities[product['id']] = 1;
    notifyListeners();
  }

  void removeFromCart(dynamic product) {
    _cart.remove(product);
    _quantities.remove(product['id']);
    notifyListeners();
  }

  int getQuantity(dynamic product) {
    return _quantities[product['id']] ?? 1;
  }

  void increaseQuantity(dynamic product) {
    _quantities[product['id']] = (_quantities[product['id']] ?? 1) + 1;
    notifyListeners();
  }

  void decreaseQuantity(dynamic product) {
    if (_quantities[product['id']] != null && _quantities[product['id']]! > 1) {
      _quantities[product['id']] = _quantities[product['id']]! - 1;
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _cart) {
      final price = double.tryParse(item['current_price'].toString()) ?? 0.0;
      final quantity = getQuantity(item);
      total += price * quantity;
    }
    return total;
  }

  final List<dynamic> _checkout = [];
  List<dynamic> get checkout => _checkout;
  int get checkoutCount => _checkout.length;

  void addToCheckout(dynamic product) {
    _checkout.add(product);
    notifyListeners();
  }

  void removeFromCheckout(dynamic product) {
    _checkout.remove(product);
    notifyListeners();
  }

  final List<dynamic> _orders = [];
  List<dynamic> get orders => _orders;

  void fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _product = await productService.fetchProduct();
    } catch (e) {
      print("Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  void addOrder(Map<String, dynamic> order) {
    _orders.add(order);
    notifyListeners();
  }
}
