class Product {
  final String name;
  final String currency;
  final List<dynamic> photos;
  final int quantityAvailable;
  final List<dynamic> currentPrice;
  final double sellingPrice;
  final String description;
  final String category;

  Product({
    required this.name,
    required this.currency,
    required this.photos,
    required this.quantityAvailable,
    required this.currentPrice,
    required this.sellingPrice,
    required this. description,
    required this. category
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      currency: json['currency'],
      photos: json['photos'] ,
      quantityAvailable: json['quantityAvailable'],
      currentPrice: json['current_Price'],
      sellingPrice: json['sellingPrice'],
      description: json['description'],
      category: json['category']
    );
  }

}
