import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Profile Page',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart_outlined))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.black54,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Deborah',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                              fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'deborah.oyinda@yahoo.com',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'My Timbu Account',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  ListTile(
                    leading: Icon(Icons.cabin),
                    title: Text('Orders'),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.inbox),
                    title: Text('Inbox'),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.rate_review_outlined),
                    title: Text('Ratings & Reviews'),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Vouchers'),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.favorite_border),
                    title: Text('Saved Items'),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.remove_red_eye),
                    title: Text('Recently Viewed'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'My Settings',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Address Book',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Account Management',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Close Account',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.green[100],
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
