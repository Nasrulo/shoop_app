// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shoop_app/app/constants/colors/app_colors.dart';
import 'package:shoop_app/app/customers/main_pages/profile/profile_page.dart';
import 'package:shoop_app/app/home_page.dart';



class CustomerPage extends StatefulWidget {
  const CustomerPage({Key? key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const HomePage(),
    const Center(child: Text('Category Screen')),
    const Center(child: Text('Stores Screen')),
    const Center(child: Text('Cart Screen')),
    const ProfilePage(
        // documentId: FirebaseAuth.instance.currentUser!.uid,
        ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        currentIndex: _selectedIndex,
        // unselectedItemColor: Colors.red,
        selectedItemColor: AppColors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}