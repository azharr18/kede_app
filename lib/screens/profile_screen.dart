// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../main.dart'; 
// --- BARIS PENTING INI YANG TADI HILANG ---
import 'auth_screen.dart'; 

import 'my_profile_screen.dart';
import 'notifications_screen.dart';
import 'messages_screen.dart';
import 'color_themes_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'User', 
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildProfileButton(
            icon: Icons.person_outline,
            text: 'MY PROFILE',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyProfileScreen()));
            },
          ),
          _buildProfileButton(
            icon: Icons.notifications_none_outlined,
            text: 'NOTIFICATIONS',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsScreen()));
            },
          ),
          _buildProfileButton(
            icon: Icons.message_outlined,
            text: 'MESSAGE',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesScreen()));
            },
          ),
          _buildProfileButton(
            icon: Icons.grid_view_outlined,
            text: 'ELEMENTS',
            onPressed: () {
               // Kosong
            },
          ),
          _buildProfileButton(
            icon: Icons.color_lens_outlined,
            text: 'COLOR SKINS',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ColorThemesScreen()));
            },
          ),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                // Navigasi Logout
                Navigator.of(context).pushAndRemoveUntil(
                  // Hapus const biar aman
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.logout, size: 24),
                  SizedBox(width: 16),
                  Text('LOGOUT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor, 
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}