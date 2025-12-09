// lib/models/product.dart
class Product {
  final String name;
  final String imagePath; // Ini adalah URL ke gambar
  final double price;
  final bool isFavorite;

  Product({
    required this.name,
    required this.imagePath,
    required this.price,
    this.isFavorite = false,
  });
}