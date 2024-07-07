class Product {
  final String name;
  final String currency;
  final List<dynamic> imageUrl;
  final int quantityAvailable;
  final List<dynamic> currentPrice;
  final double sellingPrice;

  Product({
    required this.name,
    required this.currency,
    required this.imageUrl,
    required this.quantityAvailable,
    required this.currentPrice,
    required this.sellingPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      currency: json['currency'],
      imageUrl: json['photos'],
      quantityAvailable: json['quantityAvailable'],
      currentPrice: json['current_Price'],
      sellingPrice: json['sellingPrice'],
    );
  }

}
