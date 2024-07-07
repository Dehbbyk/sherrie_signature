class Product {
  final String name;
  final String currency;
  final String imageUrl;
  final int quantityAvailable;
  final double buyingPrice;
  final double sellingPrice;

  Product({
    required this.name,
    required this.currency,
    required this.imageUrl,
    required this.quantityAvailable,
    required this.buyingPrice,
    required this.sellingPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      currency: json['currency'],
      imageUrl: json['imageUrl'],
      quantityAvailable: json['quantityAvailable'],
      buyingPrice: json['buyingPrice'],
      sellingPrice: json['sellingPrice'],
    );
  }

}
