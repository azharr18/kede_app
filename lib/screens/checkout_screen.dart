// lib/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import '/main.dart';
import '../widgets/checkout_stepper.dart';
import 'checkout_payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _nameController = TextEditingController(text: 'Samuel Witwicky');
  final _emailController = TextEditingController(text: 'info@example.com');
  final _phoneController = TextEditingController();
  final _zipController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _zipController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CheckoutStepper(currentStep: 0),
                const SizedBox(height: 24),

                _buildTextField(
                    label: 'Full Name', controller: _nameController),
                _buildTextField(
                    label: 'Email Address', controller: _emailController),
                _buildTextField(
                    label: 'Phone',
                    controller: _phoneController,
                    hint: 'Enter your phone number'),
                
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                          label: 'Zip Code',
                          controller: _zipController,
                          hint: 'Enter here'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                          label: 'City',
                          controller: _cityController,
                          hint: 'Enter here'),
                    ),
                  ],
                ),
                _buildTextField(
                    label: 'Country',
                    controller: _countryController,
                    hint: 'Enter here'),

                const SizedBox(height: 100),
              ],
            ),
          ),
          
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: kTextColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: kTextLightColor),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20.0).copyWith(bottom: 30),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CheckoutPaymentScreen(), 
              ),
            );
          },
          child: const Text('NEXT'),
        ),
      ),
    );
  }
}