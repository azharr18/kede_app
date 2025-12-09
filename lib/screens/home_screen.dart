// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart'; 
import 'category_list_screen.dart'; 
import 'category_detail_screen.dart'; 
import '../models/product.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(), // Header sekarang dinamis
              const SizedBox(height: 24),
              _buildRecipeCard(),
              const SizedBox(height: 32),
              
              _buildSectionHeader(
                title: 'Categories',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoryListScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildCategoryList(context),
              const SizedBox(height: 32),

              _buildSectionHeader(title: 'Trending Deals', onPressed: () {}),
              const SizedBox(height: 16),
              _buildTrendingList(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- BAGIAN YANG DIUPDATE UNTUK MENAMPILKAN NAMA ---
  Widget _buildHeader() {
    // Ambil user yang sedang login
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Text("Please Login");
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning',
                style: TextStyle(color: kTextLightColor, fontSize: 16)),
            
            // Gunakan StreamBuilder untuk mendengarkan perubahan data realtime dari Firestore
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading...', style: TextStyle(color: kTextColor, fontSize: 22, fontWeight: FontWeight.bold));
                }

                if (snapshot.hasError) {
                  return const Text('Error', style: TextStyle(color: Colors.red));
                }

                // Ambil data nama, jika belum ada di database gunakan email atau 'Guest'
                String displayName = 'Guest';
                if (snapshot.data != null && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  displayName = data['fullName'] ?? user.email ?? 'User';
                } else {
                  // Jika dokumen belum dibuat di Firestore
                  displayName = user.email?.split('@')[0] ?? 'User';
                }

                return Text(
                  displayName,
                  style: const TextStyle(
                      color: kTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined,
              color: kTextColor, size: 28),
        ),
      ],
    );
  }

  Widget _buildRecipeCard() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/recipe_banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recomended Recipe\nToday',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      {required String title, required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                color: kTextColor, fontSize: 20, fontWeight: FontWeight.bold)),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.arrow_forward, color: kPrimaryColor),
        ),
      ],
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCategoryItem(context, 'Fruits', 'assets/icons/grapes.svg', 87),
          _buildCategoryItem(context, 'Vegetables', 'assets/icons/leaf.svg', 24),
          _buildCategoryItem(context, 'Mushroom', 'assets/icons/mushroom.svg', 43),
          _buildCategoryItem(context, 'Bread', 'assets/icons/bread.svg', 22),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String name, String iconPath, int itemCount) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailScreen(
                categoryName: name,
                iconPath: iconPath,
                itemCount: itemCount,
              ),
            ),
          );
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              height: 40,
              width: 40,
              colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingList(BuildContext context) {
    final Product avocado = Product(name: 'Avocado', imagePath: 'assets/images/avocado.jpg', price: 6.7, isFavorite: true);
    final Product brocoli = Product(name: 'Brocoli', imagePath: 'assets/images/brocoli.jpg', price: 8.7, isFavorite: false);
    final Product tomatoes = Product(name: 'Tomatoes', imagePath: 'assets/images/tomatoes.jpg', price: 4.9, isFavorite: false);
    final Product grapes = Product(name: 'Grapes', imagePath: 'assets/images/grapes.jpg', price: 7.2, isFavorite: false);

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildProductItem(context, avocado),
              _buildProductItem(context, brocoli),
              _buildProductItem(context, tomatoes),
              _buildProductItem(context, grapes),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(product.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      product.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: product.isFavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '\$${product.price}',
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}