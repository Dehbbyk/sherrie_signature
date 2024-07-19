import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WishList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Wishlist'),
          ),
          body: productProvider.wishlist.isEmpty
              ? Center(child: Text('No items in your wishlist.'))
              : ListView.builder(
            itemCount: productProvider.wishlist.length,
            itemBuilder: (context, index) {
              var product = productProvider.wishlist[index];
              const img = "http://api.timbu.cloud/images/";
              String imageUrl = '$img${product?["photos"]?[0]?["url"] ?? ''}';
              List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
              String price = 'LRD 100';
              if (ngnPricesList != null && ngnPricesList.isNotEmpty) {
                price = 'LRD ${ngnPricesList[0].toString()}';
              }
              final productName = product["name"] ?? 'Unnamed Product';
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                title: Text(productName),
                subtitle: Text(price),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    productProvider.removeFromWishlist(product);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

