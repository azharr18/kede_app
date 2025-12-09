// lib/models/category.dart
class Category {
  final String name;
  final int itemCount;
  final String iconPath; // Ini adalah URL ke SVG

  const Category({
    required this.name,
    required this.itemCount,
    required this.iconPath,
  });
}