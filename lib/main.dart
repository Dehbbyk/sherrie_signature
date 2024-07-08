import 'package:cached_network_image/cached_network_image.dart';
import 'package:dok_store/pages/product_list_page.dart';
import 'package:dok_store/provider/product_provider.dart';
import 'package:dok_store/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final apiService = ApiService();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(apiService),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('DOK Stores'),
      ),
      body: Center(
          child: productProvider.isLoading
          ? CircularProgressIndicator()
              : productProvider.product.isNotEmpty
          ? ProductListPage()

              : ElevatedButton(
                onPressed: () {
                productProvider.fetchProduct();
                },
                  child: Text('Fetch Products'),
      ),
      ),
    );
  }
}