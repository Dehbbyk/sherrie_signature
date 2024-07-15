import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/product_description_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';

class JustForYouSlider extends StatelessWidget {
  const JustForYouSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 112.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: <Widget>[
        Center(
          child: FutureBuilder<List<dynamic>>(
            future: context.read<ProductProvider>().productService.fetchProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No products available.'));
              } else {
                // Group products by category
                Map<String, List<dynamic>> categorizedProducts = {};
                for (var product in snapshot.data!) {
                  String category = product["category"] ?? 'Uncategorized';
                  if (!categorizedProducts.containsKey(category)) {
                    categorizedProducts[category] = [];
                  }
                  categorizedProducts[category]!.add(product);
                }
                return ListView(
                  children: categorizedProducts.entries.map((entry) {
                    String category = entry.key;
                    List<dynamic> products = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                var product = products[index];
                                const img = "http://api.timbu.cloud/images/";
                                String imageUrl = '$img${product?["photos"]?[0]?["url"] ?? ''}';
                                List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
                                String price = 'LRD 100';
                                if (ngnPricesList != null && ngnPricesList.isNotEmpty) {
                                  price = 'LRD ${ngnPricesList[0].toString()}';
                                }
                                final productName = product["name"] ?? 'Unnamed Product';
                                return Container(
                                  width: 160,
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: imageUrl,
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                        height: 100,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        productName,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            price,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ProductDescriptionPage()
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Add to Cart',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
