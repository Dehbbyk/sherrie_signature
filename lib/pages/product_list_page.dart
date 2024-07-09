import 'package:cached_network_image/cached_network_image.dart';
import 'package:dok_store/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  // @override
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return Consumer<ProductProvider>(builder: (context, productprovider,
        child) {
      return Scaffold(
            appBar: AppBar(
            title: Text('Products'),
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
                String imageUrl ='$img${product?["photos"]?[0]?["url"]}';
                String ngnPrices = product?["current_price"]?[0]?["NGN"] ;
                String price = 'Price not available';
                  if (ngnPrices != null && ngnPrices.isNotEmpty) {
                    price = 'NGN ${ngnPrices[0].toString()}';
              }
                  final productName = product["name"];
                      return SingleChildScrollView(
                        child:Container(
                          child: ListTile(
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
                        ),
                      );
                  },
                );
              }
            }
          )
        );
      }
    );
  }
}
