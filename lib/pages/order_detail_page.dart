import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final int orderId;
  final String orderDate;
  final String productName;
  final String imageUrl;
  final String price;

  OrderDetailsPage({
    required this.orderId,
    required this.orderDate,
    required this.productName,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #$orderId Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text('Order ID: $orderId', style: TextStyle(fontSize: 18)),
            Text('Date: $orderDate', style: TextStyle(fontSize: 18)),
            Text('Product: $productName', style: TextStyle(fontSize: 18)),
            Text('Total: $price', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Products:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text(productName),
              subtitle: Text('Quantity: 2 - Price: \$50.0'),
            ),
            ListTile(
              title: Text('Product 2'),
              subtitle: Text('Quantity: 1 - Price: \$50.0'),
            ),
          ],
        ),
      ),
    );
  }
}