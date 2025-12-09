// lib/screens/main_app_screen.dart
import 'package:flutter/material.dart';
import '../main.dart'; // Untuk kPrimaryColor
import 'home_screen.dart';
import 'shopping_cart_screen.dart';
import 'wishlist_screen.dart';
import 'profile_screen.dart';
import 'category_list_screen.dart'; // <-- 1. TAMBAHKAN IMPORT INI

class MainAppScreen extends StatefulWidget {
  final int? initialIndex;

  const MainAppScreen({super.key, this.initialIndex});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  late int _selectedIndex;

  // 2. UBAH DAFTAR '_pages' INI
  static const List<Widget> _pages = <Widget>[
    HomeScreen(), // Tab 0
    CategoryListScreen(), // Tab 1 (Diubah dari Placeholder)
    ShoppingCartScreen(), // Tab 2
    WishlistScreen(), // Tab 3
    ProfileScreen(), // Tab 4
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        
        // 3. UBAH BAGIAN 'items' INI
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          // --- BAGIAN YANG DIUBAH ---
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_outlined), // Ikon diubah
            activeIcon: Icon(Icons.grid_view_rounded), // Ikon diubah
            label: 'Category', // Label diubah
          ),
          // --- BATAS PERUBAHAN ---
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}