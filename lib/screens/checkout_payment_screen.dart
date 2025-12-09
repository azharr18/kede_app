// lib/screens/checkout_payment_screen.dart
import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/checkout_stepper.dart';
import '../widgets/credit_card_widget.dart';
import 'main_app_screen.dart'; 

enum PaymentMethod { cod, creditCard }

class CheckoutPaymentScreen extends StatefulWidget {
  const CheckoutPaymentScreen({super.key});

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  PaymentMethod _selectedMethod = PaymentMethod.creditCard;

  final _addressController = TextEditingController();
  final _cardHolderController = TextEditingController(text: 'Samuel Witwicky');
  final _cardNumberController = TextEditingController(text: '1234 5678 9101 1121');

  @override
  void dispose() {
    _addressController.dispose();
    _cardHolderController.dispose();
    _cardNumberController.dispose();
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
                const CheckoutStepper(currentStep: 1),
                const SizedBox(height: 24),

                _buildPaymentToggle(),
                const SizedBox(height: 24),

                _selectedMethod == PaymentMethod.cod
                    ? _buildCodContent()
                    : _buildCreditCardContent(),

                const SizedBox(height: 100),
              ],
            ),
          ),
          
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildPaymentToggle() {
    return Row(
      children: [
        Expanded(
          child: _buildToggleButton(
            text: 'COD',
            isSelected: _selectedMethod == PaymentMethod.cod,
            onPressed: () {
              setState(() {
                _selectedMethod = PaymentMethod.cod;
              });
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildToggleButton(
            text: 'Credit Card',
            isSelected: _selectedMethod == PaymentMethod.creditCard,
            onPressed: () {
              setState(() {
                _selectedMethod = PaymentMethod.creditCard;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButton(
      {required String text,
      required bool isSelected,
      required VoidCallback onPressed}) {
    return isSelected
        ? ElevatedButton(
            onPressed: onPressed,
            child: Text(text),
          )
        : OutlinedButton(
            onPressed: onPressed,
            child: Text(text),
          );
  }

  Widget _buildCodContent() {
    return _buildTextField(
      label: 'Address',
      controller: _addressController,
      hint: 'Address',
    );
  }

  Widget _buildCreditCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              CreditCardWidget(
                balance: '\$45,662',
                cardNumber: '**** **** **** 1234',
                gradient: LinearGradient(
                  colors: [Color(0xFF4B0082), Color(0xFF8A2BE2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                isSelected: true,
              ),
              CreditCardWidget(
                balance: '\$1,024',
                cardNumber: '**** **** **** 5678',
                gradient: LinearGradient(
                  colors: [Color(0xFF0052D4), Color(0xFF4364F7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        
        _buildTextField(
          label: 'Card Holder Name',
          controller: _cardHolderController,
        ),
        _buildTextField(
          label: 'Card Number',
          controller: _cardNumberController,
        ),
      ],
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
            print('Order Submitted!');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => 
                const MainAppScreen(initialIndex: 0)
              ),
              (Route<dynamic> route) => route.isFirst,
            );
          },
          child: const Text('NEXT'),
        ),
      ),
    );
  }
}