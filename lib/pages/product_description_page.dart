import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/add_to_cart.dart';
import 'package:sherrie_signature/pages/cart_page.dart'; // Add this import
import 'package:sherrie_signature/pages/empty_cart.dart';
import 'package:sherrie_signature/pages/filled_cart_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, child) {
      return Scaffold(
        appBar: AppBar(
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
                    MaterialPageRoute(builder: (context) => FilledCartPage()), // Navigate to CartPage
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
        body: FutureBuilder<List<dynamic>>(
          future: context.read<ProductProvider>().productService.fetchProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products available.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var product = snapshot.data![index];
                  const img = "http://api.timbu.cloud/images/";
                  String imageUrl = '$img${product?["photos"]?[0]?["url"]}';
                  List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
                  String price = 'LRD 10000';
                  if (ngnPricesList != null && ngnPricesList.isNotEmpty) {
                    price = 'LRD ${ngnPricesList[0].toString()}';
                  }
                  final productName = product["name"];
                  final productDescription = product["description"] ?? "No description available";
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                style: TextStyle(fontSize: 24),
                              ),
                              SizedBox(height: 8),
                              Text(
                                productDescription,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                'Made with pure natural ingredients',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 16.0),
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
                              SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                          MaterialPageRoute(
                                            builder: (context) => AddToCartPage()
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}