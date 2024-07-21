import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/order_detail_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Order History'),
          ),
          body: ListView.builder(
            itemCount: productProvider.orders.length,
            itemBuilder: (context, index) {
              var order = productProvider.orders[index];
              const img = "http://api.timbu.cloud/images/";
              String imageUrl = '$img${order["photos"]?[0]?["url"] ?? ""}';
              final productName = order['name'] ?? 'Unknown Product';
              final date = order['date'] ?? 'Unknown Date';

              return ListTile(
                leading: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
                    : Icon(Icons.image),
                title: Text(productName),
                subtitle: Text(date),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsPage(order: order),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
