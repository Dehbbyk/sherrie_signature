import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/order_summary_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FilledCartPage extends StatefulWidget {
  final String id;

  const FilledCartPage({super.key, required this.id});

  @override
  State<FilledCartPage> createState() => _FilledCartPageState();
}

class _FilledCartPageState extends State<FilledCartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Column(
          children: [
            productProvider.cart.isEmpty
                ? Center(
              child: Text('Your cart is empty.'),
            )
                : Expanded(
              child: ListView.builder(
                itemCount: productProvider.cart.length,
                itemBuilder: (context, index) {
                  var product = productProvider.cart[index];
                  final img = "http://api.timbu.cloud/images/";
                  String imageUrl = '$img${product?["photos"]?[0]?["url"]}';
                  final price = product['current_price'].toString();
                  final productName = product["name"];
                  final quantity = productProvider.getQuantity(product);

                  return Column(
                    children: [
                      ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        title: Text(productName),
                        subtitle: Text(price),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              productProvider.removeFromCart(product);
                            },
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              productProvider.decreaseQuantity(product);
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              productProvider.increaseQuantity(product);
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderSummaryPage()),
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
                'Checkout',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      );
    });
  }
}
