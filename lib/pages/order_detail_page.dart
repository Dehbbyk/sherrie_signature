import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderDetailsPage extends StatelessWidget {
  final dynamic order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    final productName = order['name'] ?? 'Unknown Product';
    final date = order['date'] ?? 'Unknown Date';
    final imageUrl = order['image'] ?? '';
    final description = order['description'] ?? 'No description available';
    final price = order['price'] ?? 0.0;
    final quantity = order['quantity'] ?? 1;
    final totalAmount = price * quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl.isNotEmpty
                ? CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
                : Icon(Icons.image, size: 100),
            SizedBox(height: 16),
            Text(
              productName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Date: $date'),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text('Price: \$$price'),
            SizedBox(height: 8),
            Text('Quantity: $quantity'),
            SizedBox(height: 8),
            Text(
              'Total Amount Paid: \$$totalAmount',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
