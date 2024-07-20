import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/product_detail_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';

class MoreProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('More Products'),
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var product = snapshot.data![index];
                    final id = product['id'];
                    const img = "http://api.timbu.cloud/images/";
                    String imageUrl = '$img${product?["photos"]?[0]?["url"] ?? ''}';
                    List<dynamic> ngnPricesList = product?["current_price"]?[0]?["NGN"] ?? [];
                    String price = 'LRD 100';
                    if (ngnPricesList != null && ngnPricesList.isNotEmpty) {
                      price = 'LRD ${ngnPricesList[0].toString()}';
                    }
                    final productName = product["name"] ?? 'Unnamed Product';
                    final inWishlist = productProvider.isInWishlist(product);
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageUrl,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            height: screenHeight * 0.15,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            productName,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (inWishlist) {
                                    productProvider.removeFromWishlist(product);
                                  } else {
                                    productProvider.addToWishlist(product);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Product successfully added to your wishlist'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  inWishlist ? Icons.favorite : Icons.favorite_outline,
                                  color: inWishlist ? Colors.red : null,
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ProductDetailPage(id: id)),
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
                );
              }
            },
          ),
        );
      },
    );
  }
}
