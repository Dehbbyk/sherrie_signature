import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/product_description_page.dart';
import 'package:sherrie_signature/pages/product_detail_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';
class JustForYouSlider extends StatelessWidget {
  const JustForYouSlider({super.key});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    return FutureBuilder<List<dynamic>>(
      future: context.read<ProductProvider>().productService.fetchProduct(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products available.'));
        } else {
          return Container(
            height: screenHeight / 4, // Set the height of the ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var product = snapshot.data![index];
                const img = "http://api.timbu.cloud/images/";
                String imageUrl =
                    '$img${product?["photos"]?[0]?["url"] ?? ''}';
                List<dynamic> ngnPricesList =
                    product?["current_price"]?[0]?["NGN"] ?? [];
                String price = 'LRD 100';
                if (ngnPricesList != null && ngnPricesList.isNotEmpty) {
                  price = 'LRD ${ngnPricesList[0].toString()}';
                }
                final productName = product["name"] ?? 'Unnamed Product';
                return Container(
                  width: screenWidth/2,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        height: 100,
                        width: 100,
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(id: 'id'),
                                ),
                              );
                            },
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}