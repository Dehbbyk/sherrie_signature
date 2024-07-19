import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FilledCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.cart.isEmpty) {
            return Center(
              child: Text('Your cart is empty.'),
            );
          }
          return ListView.builder(
            itemCount: productProvider.cart.length,
            itemBuilder: (context, index) {
              var product = productProvider.cart[index];
              const img = "http://api.timbu.cloud/images/";
              String imageUrl = '$img${product?["photos"]?[0]?["url"]}';
              List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
              String price = 'LRD 10000';
              if (ngnPricesList != null && ngnPricesList.isNotEmpty) {
                price = 'LRD ${ngnPricesList[0].toString()}';
              }
              final productName = product["name"];
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                title: Text(productName),
                subtitle: Text(price),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline_rounded),
                  onPressed: () {
                    productProvider.removeFromCart(product);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
