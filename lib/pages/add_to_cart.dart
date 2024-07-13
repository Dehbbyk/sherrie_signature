import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/cart_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key});

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProvider, child){
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){},
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
      return ListView.builder(
          itemBuilder: (context, index){
            var product = snapshot.data![index];
            const img = "http://api.timbu.cloud/images/";
            String imageUrl = '$img${product?["photos"]?[0]?["url"]}';
            List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
            String price = 'LRD 10000';
            if (ngnPricesList != null && ngnPricesList.isNotEmpty) {
              price = 'LRD ${ngnPricesList[0].toString()}';
            }
            final productName = product["name"];
            final productDescription = product["description"] ?? "No description available";
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.green[100],
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: CachedNetworkImage(
                          imageUrl: imageUrl,
                        placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'RS34670',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                                'In Stock',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:8.0),
                        Text(
                          productName,
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height:8),
                        Text(
                          productDescription,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Made with pure natural ingredients',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ExpansionTile(
                          title: Text('How to use'),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Usage instructions for the product.'),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('Delivery and drop-off'),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Delivery and drop-off information.'),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
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
                            ]
                        ),
                            SizedBox(height:16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){},
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.grey[300],
                                        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
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
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Unit price',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                              fontWeight:FontWeight.w400
                                          ),
                                        ),
                                        Text(
                                          price,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CartPage()
                                          ),
                                        );
                                      },
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
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
      );
    }
    },
        ),
      );
    },
    );
  }
}
