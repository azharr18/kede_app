// lib/screens/wishlist_screen.dart
import 'package:flutter/material.dart';
// Ganti 'kede_app' dengan nama proyek Anda (di pubspec.yaml)
import '/main.dart';
import '/models/product.dart';
import '/widgets/product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // --- KODE INI SUDAH DIPERBAIKI ---
  final List<Product> _wishlistItems = [
    Product(
      name: 'Avocado',
      imagePath: 'assets/images/avocado.jpg', // <-- Diubah ke .jpg
      price: 6.7,
      isFavorite: true,
    ),
    Product(
      name: 'Brocoli',
      imagePath: 'assets/images/brocoli.jpg', // Pastikan nama ini benar
      price: 8.7,
      isFavorite: true,
    ),
    Product(
      name: 'Tomatoes',
      imagePath: 'assets/images/tomatoes.jpg',
      price: 4.9,
      isFavorite: true,
    ),
    Product(
      name: 'Grapes',
      imagePath: 'assets/images/grapes.jpg',
      price: 7.2,
      isFavorite: true,
    ),
  ];
  // --- BATAS PERBAIKAN ---

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Wishlist',
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _wishlistItems.length,
        itemBuilder: (context, index) {
          return ProductCard(product: _wishlistItems[index]);
        },
      ),
    );
  }
}