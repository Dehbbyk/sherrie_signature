class Product {
  final String name;
  final String currency;
  final List<dynamic> photos;
  final int quantityAvailable;
  final List<dynamic> currentPrice;
  final double sellingPrice;

  Product({
    required this.name,
    required this.currency,
    required this.photos,
    required this.quantityAvailable,
    required this.currentPrice,
    required this.sellingPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      currency: json['currency'],
      photos: json['photos'],
      quantityAvailable: json['quantityAvailable'],
      currentPrice: json['current_Price'],
      sellingPrice: json['sellingPrice'],
    );
  }

}
