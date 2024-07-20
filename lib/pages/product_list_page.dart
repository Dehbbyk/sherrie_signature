import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/empty_cart.dart';
import 'package:sherrie_signature/pages/order_history_page.dart';
import 'package:sherrie_signature/pages/widgets/more_product_page.dart';
import 'package:sherrie_signature/provider/product_provider.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sharries Signature',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                      color: Colors.green),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmptyCartPage()),
                    );
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                    );
                  },
                  icon: Icon(Icons.history_rounded),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    ' Welcome, Jane',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Just for you',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MoreProductsPage()),
                          );
                        },
                        icon: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ),
                Expanded(
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
                        List<dynamic> deals = snapshot.data!
                            .where((product) => product['categories'] != null &&
                            product['categories'].any((category) => category['name'] == 'deals'))
                            .toList();

                        List<dynamic> ourCollections = snapshot.data!
                            .where((product) => product['categories'] != null &&
                            product['categories'].any((category) => category['name'] == 'our collections'))
                            .toList();

                        List<dynamic> youMightLike = snapshot.data!
                            .where((product) => product['categories'] != null &&
                            product['categories'].any((category) => category['name'] == 'you might like'))
                            .toList();

                        return ListView(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            _buildCategorySection('Deals', deals, screenHeight, screenWidth, context, productProvider),
                            _buildCategorySection('Our Collections', ourCollections, screenHeight, screenWidth, context, productProvider),
                            _buildCategorySection('You Might Like', youMightLike, screenHeight, screenWidth, context, productProvider),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategorySection(String title, List<dynamic> products, double screenHeight, double screenWidth, BuildContext context, ProductProvider productProvider) {
    if (products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('No products available in $title.'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: screenHeight * 0.3,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
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
                final id = product['id'];
                bool inWishlist = productProvider.wishlist.contains(product);

                return Container(
                  width: screenWidth / 2,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                        height: screenHeight * 0.15, // Adjust the height to fit the image properly
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
                              // Handle Add to Cart button press
                            },
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w400,
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
  }
}