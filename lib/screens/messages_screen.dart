// lib/screens/messages_screen.dart
import 'package:flutter/material.dart';
import '/main.dart'; // Ganti 'kede_app' dengan nama proyek Anda

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

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
          'Messages',
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildMessageItem(
                  'assets/images/avatar1.jpg',
                  'Freddie Ronan',
                  'Roger that sir, thankyou',
                  '2m ago',
                  'Pending',
                ),
                _buildMessageItem(
                  'assets/images/avatar2.jpg',
                  'Ethan Jacoby',
                  'Lorem ipsum dolor',
                  '2m ago',
                  'Read',
                ),
                _buildMessageItem(
                  'assets/images/avatar3.jpg',
                  'Alfie Mason',
                  'Ok. Lorem ipsum dolor sect...',
                  '2m ago',
                  'Pending',
                ),
                // ... Tambahkan item pesan lainnya ...
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search job here...',
          hintStyle: const TextStyle(color: kTextLightColor),
          prefixIcon: const Icon(Icons.search, color: kTextLightColor),
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // Widget helper untuk satu item pesan
  Widget _buildMessageItem(
    String imagePath, String name, String message, String time, String status) {
    
    final bool isRead = status == 'Read';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(
        name,
        style: const TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: kTextLightColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: isRead ? kPrimaryColor : kTextLightColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.check,
                color: isRead ? kPrimaryColor : kTextLightColor,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(color: kTextLightColor, fontSize: 12)),
        ],
      ),
      onTap: () {},
    );
  }
}