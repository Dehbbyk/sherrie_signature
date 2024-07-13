import 'package:dok_store/pages/product_list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductListPage(),
      ],
    );
  }
}
