import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/add_to_cart.dart';
import 'package:sherrie_signature/pages/empty_cart.dart';
import 'package:sherrie_signature/pages/filled_cart_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  const ProductDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Consumer<ProductProvider>(builder: (context, productProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail Page'),
          actions: [
            IconButton(
              onPressed: () {
                if (productProvider.cart.isEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmptyCartPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilledCartPage(id: 'id',)), // Navigate to CartPage
                  );
                }
              },
              icon: Stack(
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  if (productProvider.cartCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '${productProvider.cartCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: context.read<ProductProvider>().productService.fetchOneProduct(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products available.'));
            } else {
              var product = snapshot.data!;
              const img = "http://api.timbu.cloud/images/";
              String imageUrl = '$img${product?["photos"]?[0]?["url"] ?? ''}';
              List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
              String price = 'LRD 100';
              if (ngnPricesList != null && ngnPricesList.isNotEmpty) {
                price = 'LRD ${ngnPricesList[0].toString()}';
              }
              final productName = product["name"] ?? 'Unnamed Product';
              final productDescription = product['description'] ?? "No description available";
              return SingleChildScrollView(
                child: Container(
                  width: screenWidth,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          height: 180,
                          width: 180,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RS34670',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'In Stock',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        productName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        productDescription,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Made with pure natural ingredients',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      ExpansionTile(
                        title: Text('How to use'),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('Usage instructions for the product.'),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('Delivery and drop-off'),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('Delivery and drop-off information.'),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Sub',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              productProvider.addToCart(product); // Add product to cart
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Added to Cart'),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddToCartPage(id: id)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
    });
  }
}
