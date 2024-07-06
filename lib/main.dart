import 'package:dok_store/pages/product_list_page.dart';
import 'package:dok_store/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => ProductProvider()),
      ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'DOK Store',
          theme: ThemeData(
          primaryColor: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: Colors.grey.shade100
          ),
          home: ProductListPage(),
      ),
    );
  }
}