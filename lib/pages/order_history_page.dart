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
              var product = order['product'];

              // Debug prints
              print('Order: $order');
              print('Product: $product');

              if (product == null || product is! Map) {
                return ListTile(
                  title: Text('Invalid product data'),
                  subtitle: Text('Date: ${order['date'] ?? 'Unknown Date'}'),
                );
              }

              final img = "http://api.timbu.cloud/images/";
              String imageUrl = '$img${product["photos"]?[0]?["url"]}';
              final price = product['current_price'].toString();
              final productName = product["name"] ?? 'Unknown Product';
              final date = order['date'] ?? 'Unknown Date';
              final quantity = productProvider.getQuantity(product);

              return ListTile(
                leading: imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
                    : Icon(Icons.image),
                title: Text(productName),
                subtitle: Text('Date: $date\nQuantity: $quantity\nPrice: LRD $price'),
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
