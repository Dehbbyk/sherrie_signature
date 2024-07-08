// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dok_store/provider/product_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ProductListPage extends StatefulWidget {
//   @override
//   _ProductListPageState createState() => _ProductListPageState();
// }
//
// class _ProductListPageState extends State<ProductListPage> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<ProductProvider>(context, listen: false).fetchData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<ProductProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products'),
//       ),
//       body: provider.isLoading
//           ? Center(child: CircularProgressIndicator())
//           : provider.data.isEmpty
//           ? Center(child: Text('No products available'))
//           : ListView.builder(
//           itemCount: provider.data.length,
//           itemBuilder: (context, index) {
//             const img = "http://api.timbu.cloud/images/";
//             var product = provider.data[index];
//             String imageUrl ='$img${product?["photos"]?[0]?["url"]}';
//             String ngnPrices = product?["current_price"]?[0]?["NGN"] ;
//             String price = 'Price not available';
//               if (ngnPrices != null && ngnPrices.isNotEmpty) {
//                 price = 'NGN ${ngnPrices[0].toString()}';
//               }
//             String productName = product?["name"];
//             return ListTile(
//               leading: CachedNetworkImage(
//                 imageUrl: imageUrl,
//                 placeholder: (context, url) =>
//                     CircularProgressIndicator(),
//                 errorWidget: (context, url, error) =>
//                     Icon(Icons.error),
//               ),
//               title: Text(productName),
//               subtitle: Text(price),
//           );
//         },
//       ),
//     );
//   }
// }
