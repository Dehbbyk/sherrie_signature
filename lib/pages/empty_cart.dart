import 'package:flutter/material.dart';

class EmptyCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.green,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your Cart is empty',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Explore our collections today and start your journey\n'
                        'towards radiant beauty. Your skin will thank you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle start shopping button press
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Start shopping',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recently viewed',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      'View all',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.green
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RecentlyViewedItem(
                    imageUrl: 'http://api.timbu.cloud/images/',
                    name: 'Repair Scrub',
                    price: 19.00,
                  ),
                  // Add more RecentlyViewedItem widgets here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentlyViewedItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;

  RecentlyViewedItem({
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              width: 160,
              height: 210,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '\$$price',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                // Handle add to cart button press
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Add to cart',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
