import 'package:dok_store/pages/product_list_page.dart';
import 'package:dok_store/provider/product_provider.dart';
import 'package:dok_store/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final apiService = ApiService();
  runApp(
    MyApp(),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ProductListPage(),
      ),
    );
  }
}