import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/home_view.dart';
import 'package:sherrie_signature/provider/product_provider.dart';
import 'package:sherrie_signature/services/api_service.dart';

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
        home: HomeView()
      ),
    );
  }
}

