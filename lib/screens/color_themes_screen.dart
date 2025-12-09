// lib/screens/color_themes_screen.dart
import 'package:flutter/material.dart';
import '/main.dart'; // Ganti 'kede_app' dengan nama proyek Anda

class ColorThemesScreen extends StatelessWidget {
  const ColorThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Color Themes',
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Link',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Color Themes',
              style: TextStyle(
                color: kTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildLayoutThemesCard(),
            const SizedBox(height: 24),
            _buildDefaultColorThemesCard(),
          ],
        ),
      ),
    );
  }

  // Card untuk "Layout Themes"
  Widget _buildLayoutThemesCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Layout Themes',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Framework7 comes with 2 main layout themes: Light (default) and Dark:',
            style: TextStyle(color: kTextLightColor, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Light Theme Box
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: const Stack(
                    children: [
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Icon(Icons.check_box, color: kPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Dark Theme Box
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card untuk "Default Color Themes"
  Widget _buildDefaultColorThemesCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Default Color Themes',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Framework7 comes with 12 color themes set.',
            style: TextStyle(color: kTextLightColor, fontSize: 16),
          ),
          const SizedBox(height: 16),
          // Gunakan Wrap agar tombol otomatis pindah baris
          Wrap(
            spacing: 12.0, // Jarak horizontal
            runSpacing: 12.0, // Jarak vertikal
            children: [
              _buildColorButton('Red', Colors.red),
              _buildColorButton('Green', Colors.green),
              _buildColorButton('Blue', Colors.blue),
              _buildColorButton('Pink', Colors.pink),
              _buildColorButton('Yellow', Colors.yellow[700]!),
              _buildColorButton('Orange', Colors.orange),
              _buildColorButton('Purple', Colors.purple),
              _buildColorButton('Deeppurple', Colors.deepPurple),
              _buildColorButton('Lightblue', Colors.lightBlue),
            ],
          )
        ],
      ),
    );
  }

  // Widget helper untuk tombol warna
  Widget _buildColorButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(text),
    );
  }
}