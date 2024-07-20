import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/empty_cart.dart';
import 'package:sherrie_signature/pages/filled_cart_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';

class CartPage extends StatefulWidget {
  final String id;
  const CartPage({super.key, required this.id});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, child) {
      double deliveryFee = 2.0;

      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
          actions: [
            IconButton(
              onPressed: () {
                if (productProvider.cart.isEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmptyCartPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilledCartPage(id: 'id')), // Navigate to CartPage
                  );
                }
              },
              icon: Stack(
                children: [
                  Icon(Icons.shopping_cart_outlined),
                  if (productProvider.cartCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '${productProvider.cartCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: context.read<ProductProvider>().productService.fetchOneProduct(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products available.'));
            } else {
              List cartItems = productProvider.cart;
              double subTotal = cartItems.fold(
                0.0,
                    (sum, item) =>
                sum + ((item['price'] ?? 0.0) * (item['quantity'] ?? 0)),
              );
              double totalAmount = subTotal + deliveryFee;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        var product = cartItems[index];
                        const img = "http://api.timbu.cloud/images/";
                        String imageUrl =
                            '$img${product?["photos"]?[0]?["url"] ?? ''}';
                        List<dynamic> ngnPricesList =
                            product?["current_price"]?[0]?["NGN"] ?? [];
                        String price = 'LRD 10000';
                        if (ngnPricesList.isNotEmpty) {
                          price = 'LRD ${ngnPricesList[0].toString()}';
                        }
                        final productName =
                            product["name"] ?? 'Unnamed Product';

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
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Unit price: $price',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove),
                                            onPressed: () {
                                              setState(() {
                                                if (product['quantity'] >
                                                    1) {
                                                  product['quantity']--;
                                                }
                                              });
                                            },
                                          ),
                                          Text(
                                            (product['quantity'] ?? 0)
                                                .toString(),
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                product['quantity'] =
                                                    (product['quantity'] ??
                                                        0) +
                                                        1;
                                              });
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              setState(() {
                                                cartItems.remove(index);
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
                    ),
                  ),
                  Padding(
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
                                Text(
                                  'Cart summary',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Sub-total',
                                        style: TextStyle(fontSize: 16)),
                                    Text(
                                      '\$${subTotal.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Delivery',
                                        style: TextStyle(fontSize: 16)),
                                    Text(
                                      '\$${deliveryFee.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Amount',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$${totalAmount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                          BorderRadius.circular(8.0),
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
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontWeight:FontWeight.w400
                                          ),
                                        ),
                                        Text(
                                          'LSD 19.00',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ],
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
                                          borderRadius:
                                          BorderRadius.circular(8.0),
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
                        Text(
                          'You might like',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        // Implement "You might like" section here
                        // This is a placeholder for the recommendation section
                        // You can use a similar ListView.builder as above to display recommended products
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      );
    });
  }
}
