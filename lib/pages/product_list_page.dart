import 'package:cached_network_image/cached_network_image.dart';
import 'package:dok_store/models/products.dart';
import 'package:dok_store/provider/product_provider.dart';
import 'package:dok_store/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
   var provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                const img = "http://api.timbu.cloud/images/";
                String imageUrl = '$img${product.photos[0]["url]}';
                var product = snapshot.data![index];
                final priceList = product.currentPrice;
                String price = 'Price not available';
                if (priceList != null) {
                  final ngnPrices = priceList[0]['NGN'][0];
                  if (ngnPrices != null && ngnPrices.isNotEmpty) {
                    price = 'NGN ${ngnPrices.toString()}';
                  }
                }
                return ListTile(
                  leading: CachedNetworkImage(
                      imageUrl: product.photos,
                    placeholder: (context, url) =>
                        CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                  title: Text(product.name),
                  subtitle: Text(price),
                );
              },
            );
          }
        },
      ),
    );
  }
}