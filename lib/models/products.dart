class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String currency;

  Product({required this.name, required this.imageUrl, required this.price, required this.currency});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'].toDouble(),
      currency: json['currency'],
    );
  }
}