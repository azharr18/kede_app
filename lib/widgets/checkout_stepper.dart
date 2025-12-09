// lib/widgets/checkout_stepper.dart
import 'package:flutter/material.dart';
import '../main.dart';

class CheckoutStepper extends StatelessWidget {
  final int currentStep; // 0 = Shipping, 1 = Payment

  const CheckoutStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        children: [
          _buildStep(
            context,
            number: '1',
            title: 'Shipping Address',
            isActive: currentStep >= 0,
          ),
          
          Expanded(
            child: Container(
              height: 2,
              color: currentStep >= 1 ? kPrimaryColor : Colors.grey[300],
            ),
          ),
          
          _buildStep(
            context,
            number: '2',
            title: 'Payment Method',
            isActive: currentStep >= 1,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(BuildContext context,
      {required String number, required String title, required bool isActive}) {
    final Color color = isActive ? kPrimaryColor : Colors.grey[400]!;
    
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? kPrimaryColor : Colors.white,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: isActive && currentStep > int.parse(number) - 1
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : Text(
                    number,
                    style: TextStyle(
                      color: isActive ? Colors.white : color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}