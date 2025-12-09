// lib/screens/category_detail_screen.dart
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart'; // <-- Hapus/Komentari ini

// Ganti 'kede_app' dengan nama proyek Anda di pubspec.yaml
// (Jika nama proyek Anda 'kede', ganti 'kede_app' menjadi 'kede')
import '/main.dart';
import '/models/product.dart';
import '/widgets/product_card.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String categoryName;
  final String iconPath; // Ini masih 'assets/icons/grapes.svg'
  final int itemCount;

  CategoryDetailScreen({
    super.key,
    required this.categoryName,
    required this.iconPath,
    required this.itemCount,
  });

  // Pastikan nama file ini sama dengan di folder assets/images/
  final List<Product> products = [
    Product(name: 'Avocado', imagePath: 'assets/images/avocado.jpg', price: 6.7, isFavorite: true),
    Product(name: 'Brocoli', imagePath: 'assets/images/brocoli.jpg', price: 8.7),
    Product(name: 'Tomatoes', imagePath: 'assets/images/tomatoes.jpg', price: 4.9),
    Product(name: 'Grapes', imagePath: 'assets/images/grapes.jpg', price: 7.2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          _buildSearchBar(),
          const SizedBox(height: 16),
          
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                // ProductCard akan memuat gambar JPG
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // --- PERUBAHAN DI SINI ---
    // Kita ubah path dari .svg ke .png
    // Ini mengasumsikan Anda sudah menyimpan 'grapes.png', 'leaf.png'
    // di dalam folder 'assets/icons/'
    final String pngIconPath = iconPath.replaceAll('.svg', '.png');
    // --- BATAS PERUBAHAN ---

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -40,
            bottom: -30,
            // --- PERUBAHAN DI SINI ---
            // Ganti SvgPicture.asset menjadi Image.asset
            child: Image.asset(
              pngIconPath, // Memuat file .png
              width: 150,
              height: 150,
              color: Colors.white.withOpacity(0.1), // Efek transparan
              colorBlendMode: BlendMode.srcIn,
              errorBuilder: (context, error, stackTrace) {
                // Error jika file .png tidak ditemukan
                return const Icon(Icons.error, color: Colors.white, size: 50);
              },
            ),
            // --- BATAS PERUBAHAN ---
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$categoryName Category',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$itemCount items',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search here',
          hintStyle: const TextStyle(color: kTextLightColor),
          prefixIcon: const Icon(Icons.search, color: kTextLightColor),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}