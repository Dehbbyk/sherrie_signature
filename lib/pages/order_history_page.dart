import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/order_detail_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Order History'),
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
                    itemCount: productProvider.orders.length,
                    itemBuilder: (context, index) {
                      var order = productProvider.orders[index];
                      var product = snapshot.data!.firstWhere((product) => product['id'] == order['id']);
                      const img = "http://api.timbu.cloud/images/";
                      String imageUrl = '$img${product?["photos"]?[0]?["url"]}';
                      List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
                      String price = 'LRD 10000';
                      if (ngnPricesList.isNotEmpty) {
                        price = 'LRD ${ngnPricesList[0].toString()}';
                      }
                      final productName = product["name"];
                      final orderId = order['id'];
                      final orderDate = order['date'];

                      return Column(
                          children: [
                            ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: imageUrl,
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              title: Text(productName),
                              subtitle: Text('Date: $orderDate'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetailsPage(orderId: orderId, orderDate: orderDate, productName: productName, imageUrl:imageUrl, price: price ),
                                  ),
                                );
                              },
                            ),
                            Text(
                              'COMPLETED',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  backgroundColor: Colors.green,
                                  color: Colors.white
                              ),
                            )
                          ]
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