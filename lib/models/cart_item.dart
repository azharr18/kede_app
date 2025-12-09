// lib/models/cart_item.dart
import 'product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  // Fungsi helper untuk menghitung total harga per item
  double get totalPrice => product.price * quantity;
}