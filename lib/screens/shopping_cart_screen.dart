// lib/screens/shopping_cart_screen.dart
import 'package:flutter/material.dart';
import '../main.dart'; 
import '../models/product.dart'; 
import '../models/cart_item.dart';
import '../widgets/quantity_stepper.dart'; 
import 'checkout_screen.dart'; 

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final List<CartItem> _cartItems = [
    CartItem(
      product: Product(
        name: 'Avocado',
        imagePath: 'assets/images/avocado.jpg', 
        price: 7.2,
      ),
      quantity: 4,
    ),
    CartItem(
      product: Product(
        name: 'Broccoli',
        imagePath: 'assets/images/brocoli.jpg',
        price: 6.3,
      ),
      quantity: 1,
    ),
    CartItem(
      product: Product(
        name: 'Grapes',
        imagePath: 'assets/images/grapes.jpg',
        price: 5.7,
      ),
      quantity: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckoutScreen(),
                ),
              );
            },
            child: const Text(
              'Checkout',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      
      body: ListView.separated(
        padding: const EdgeInsets.all(20.0),
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          return _buildCartItem(_cartItems[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 24),
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return SizedBox(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(item.product.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '\$${item.product.price}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FRUITS',
                      style: TextStyle(color: kTextLightColor, fontSize: 14),
                    ),
                    Text(
                      item.product.name,
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    QuantityStepper(initialValue: item.quantity),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}