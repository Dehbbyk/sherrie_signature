import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sherrie_signature/pages/empty_cart.dart';
import 'package:sherrie_signature/pages/product_description_page.dart';
import 'package:sherrie_signature/pages/product_detail_page.dart';
import 'package:sherrie_signature/pages/widgets/just_for_you_slider.dart';
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
                )
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
                          icon: Icon(Icons.keyboard_arrow_right))
                    ],
                  ),
                ),
                //JustForYouSlider(),
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
                            _buildCategorySection('Deals', deals, screenHeight, screenWidth, context),
                            _buildCategorySection('Our Collections', ourCollections, screenHeight, screenWidth, context),
                            _buildCategorySection('You Might Like', youMightLike, screenHeight, screenWidth, context),
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

  Widget _buildCategorySection(String title, List<dynamic> products, double screenHeight, double screenWidth, BuildContext context) {
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
            height: screenHeight / 10,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
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
                return Container(
                  width: screenWidth/2,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
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
            ),
          ),
        ],
      ),
    );
  }
}
