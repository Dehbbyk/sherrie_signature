import 'package:cached_network_image/cached_network_image.dart';
import 'package:dok_store/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, child) {
      double deliveryFee = 2.0;

      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
            )
          ],
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
              double subTotal = snapshot.data!.fold(
                  0, (sum, item) => sum + (item['price'] * item['quantity']));
              double totalAmount = subTotal + deliveryFee;

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var product = snapshot.data![index];
                  const img = "http://api.timbu.cloud/images/";
                  String imageUrl = '$img${product?["photos"]?[0]?["url"] ?? ''}';
                  List<dynamic> ngnPricesList =
                      product?["current_price"]?[0]?["NGN"] ?? [];
                  String price = 'LRD 10000';
                  if (ngnPricesList.isNotEmpty) {
                    price = 'LRD ${ngnPricesList[0].toString()}';
                  }
                  final productName = product["name"] ?? 'Unnamed Product';

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageUrl,
                            width: 80,
                            height: 80,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(productName,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 8.0),
                                Text('RS34670',
                                    style: TextStyle(color: Colors.grey)),
                                SizedBox(height: 8.0),
                                Text('Unit price: $price',
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        setState(() {
                                          if (product['quantity'] > 1) {
                                            product['quantity']--;
                                          }
                                        });
                                      },
                                    ),
                                    Text(product['quantity'].toString(),
                                        style: TextStyle(fontSize: 16)),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          product['quantity']++;
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        setState(() {
                                          snapshot.data!.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cart summary',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sub-total', style: TextStyle(fontSize: 16)),
                          Consumer<ProductProvider>(
                            builder: (context, productProvider, child) {
                              double subTotal = productProvider.cartItems?.fold(
                                  0,
                                      (sum, item) =>
                                  sum + (item['price'] * item['quantity'])) ??
                                  0;
                              return Text(
                                '\$${subTotal.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 16),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Delivery', style: TextStyle(fontSize: 16)),
                          Text('\$${deliveryFee.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Consumer<ProductProvider>(
                            builder: (context, productProvider, child) {
                              double subTotal = productProvider.cartItems?.fold(
                                  0,
                                      (sum, item) =>
                                  sum + (item['price'] * item['quantity'])) ??
                                  0;
                              double totalAmount = subTotal + deliveryFee;
                              return Text(
                                '\$${totalAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle Cancel action
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.grey[300],
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle Checkout action
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              'Checkout',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('You might like',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              // Implement "You might like" section here
              // This is a placeholder for the recommendation section
              // You can use a similar ListView.builder as above to display recommended products
            ],
          ),
        ),
      );
    });
  }
}