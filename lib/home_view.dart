import 'package:flutter/material.dart';
import 'package:sherrie_signature/pages/product_list_page.dart';
import 'package:sherrie_signature/pages/profile_page.dart';
import 'package:sherrie_signature/pages/search_page.dart';
import 'package:sherrie_signature/pages/widgets/just_for_you_slider.dart';
import 'package:sherrie_signature/pages/wish_list.dart';

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
        icon: Icon(Icons.heart_broken_sharp
        ),
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
      body: listOfPages[selectedIndex],
    );
  }
}