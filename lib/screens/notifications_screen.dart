// lib/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import '/main.dart'; // Ganti 'kede_app' dengan nama proyek Anda

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
          'Notifications',
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationItem(
            title: 'Apply Success',
            subtitle: 'You has apply an job in Queenify Group as UI Designer',
            time: '10h ago',
            color: Colors.blueAccent,
            isRead: false,
          ),
          _buildNotificationItem(
            title: 'Interview Calls',
            subtitle: 'Congratulations! You have interview calls',
            time: '9h ago',
            color: Colors.white, // Tidak ada titik
            isRead: true,
          ),
          _buildNotificationItem(
            title: 'Apply Success',
            subtitle: 'You has apply an job in Queenify Group as UI Designer',
            time: '8h ago',
            color: kPrimaryColor, // Titik hijau
            isRead: false,
          ),
          _buildNotificationItem(
            title: 'Complete your profile',
            subtitle: 'Please verify your profile information to continue using this app',
            time: '4h ago',
            color: Colors.blueAccent,
            isRead: false,
          ),
        ],
      ),
    );
  }

  // Widget helper untuk satu item notifikasi
  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String time,
    required Color color,
    required bool isRead,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titik warna
          if (color != Colors.white)
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(top: 4.0, right: 12.0),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          if (color == Colors.white) // Jika tidak ada titik, beri spasi
             const SizedBox(width: 24),
          
          // Teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: kTextLightColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Waktu
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: kTextLightColor, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          time,
                          style: const TextStyle(color: kTextLightColor, fontSize: 14),
                        ),
                      ],
                    ),
                    // Mark as read
                    if (!isRead)
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Mark as read',
                          style: TextStyle(color: kPrimaryColor, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
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