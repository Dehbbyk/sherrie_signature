import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FilledCartPage extends StatefulWidget {
  final String id;
  const FilledCartPage({super.key, required this.id});

  @override
  State<FilledCartPage> createState() => _FilledCartPageState();
}

class _FilledCartPageState extends State<FilledCartPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Consumer<ProductProvider>(builder: (context, productProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: productProvider.cart.isEmpty
            ? Center(
              child: Text('Your cart is empty.'),
        )
            : ListView.builder(
          itemCount: productProvider.cart.length,
          itemBuilder: (context, index) {
            var product = productProvider.cart[index];
            const img = "http://api.timbu.cloud/images/";
            String imageUrl = '$img${product?["photos"]?[0]?["url"]}';
            List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
            String price = 'LRD 10000';
            if (ngnPricesList.isNotEmpty) {
              price = 'LRD ${ngnPricesList[0].toString()}';
            }
            final productName = product["name"];
            return Column(
              children: [
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(productName),
                  subtitle: Text(price),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.remove_circle_outline_rounded),
                  //   onPressed: () {
                  //     productProvider.removeFromCart(product);
                  //   },
                  // ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed:(){
                          productProvider.removeFromCart(product);
                        } ,
                        child: Text(
                            'Remove',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                          ),
                        )
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}