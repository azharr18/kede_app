// lib/widgets/credit_card_widget.dart
import 'package:flutter/material.dart';
import '../main.dart'; // Untuk kPrimaryColor

class CreditCardWidget extends StatelessWidget {
  final String balance;
  final String cardNumber;
  final Gradient gradient;
  final bool isSelected;

  const CreditCardWidget({
    super.key,
    required this.balance,
    required this.cardNumber,
    required this.gradient,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Credit Card',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                balance,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                cardNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          
          Positioned(
            right: 0,
            top: 40,
            child: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          
          if (isSelected)
            Positioned(
              right: -5,
              bottom: -10,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: kPrimaryColor, size: 24),
              ),
            ),
        ],
      ),
    );
  }
}