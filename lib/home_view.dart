import 'package:dok_store/pages/product_list_page.dart';
import 'package:dok_store/pages/profile_page.dart';
import 'package:dok_store/pages/search_page.dart';
import 'package:dok_store/pages/wish_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var listOfPages = [
      ProductListPage(),
    const WishList(),
    const Profile(),
    const Search(),
  ];
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfPages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (value){
          setState(() {
            selectedIndex = value;
          });
          },
          items:const [
          BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home"
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.heart_broken),
        label: "Wishlist"
      ),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile'
      ),
          BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: "Search"
          ),
        ],
      ),
    );
  }
}