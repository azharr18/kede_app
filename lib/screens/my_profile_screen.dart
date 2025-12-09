// lib/screens/my_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart'; 

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  
  // Controller untuk form input
  final _fullNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  bool _isLoading = false;
  bool _isEditing = false; // Mode edit atau view

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // --- READ (Membaca Data) ---
  Future<void> _fetchUserData() async {
    if (_user == null) return;

    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _fullNameController.text = data['fullName'] ?? '';
          _userNameController.text = data['userName'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _addressController.text = data['address'] ?? '';
        });
      } else {
        // Jika data belum ada di database, isi default dari Auth
        setState(() {
          _fullNameController.text = _user!.displayName ?? '';
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  // --- CREATE / UPDATE (Menyimpan Data) ---
  Future<void> _saveUserData() async {
    if (_user == null) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(_user!.uid).set({
        'fullName': _fullNameController.text.trim(),
        'userName': _userNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'address': _addressController.text.trim(),
        'email': _user!.email, // Email biasanya tidak diedit di sini
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true)); // merge: true agar tidak menimpa field lain jika ada

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile Updated Successfully!')),
        );
        setState(() => _isEditing = false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // --- DELETE (Menghapus Data) ---
  Future<void> _deleteUserData() async {
    // Konfirmasi dialog
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Profile Data?'),
        content: const Text('This will remove your personal details from our database (Account remains).'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    ) ?? false;

    if (!confirm || _user == null) return;

    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('users').doc(_user!.uid).delete();
      
      // Kosongkan form
      setState(() {
        _fullNameController.clear();
        _userNameController.clear();
        _phoneController.clear();
        _addressController.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data deleted successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
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
          'Profile',
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit, color: kPrimaryColor),
            onPressed: () {
              if (_isEditing) {
                _saveUserData();
              } else {
                setState(() => _isEditing = true);
              }
            },
          )
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Gambar Profil
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile_picture.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Menampilkan Nama di bawah foto (Read Only display)
              Text(
                _fullNameController.text.isNotEmpty ? _fullNameController.text : 'User',
                style: const TextStyle(
                  color: kTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _user?.email ?? '',
                style: const TextStyle(color: kTextLightColor, fontSize: 16),
              ),
              
              const SizedBox(height: 32),
              
              // FORM FIELDS
              _buildEditableField('Full Name', _fullNameController),
              _buildEditableField('User Name', _userNameController),
              _buildEditableField('Phone', _phoneController, isNumber: true),
              _buildEditableField('Shipping Address', _addressController),
              
              // Tombol Delete Data (Hanya muncul saat mode edit)
              if (_isEditing)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red)
                    ),
                    onPressed: _deleteUserData, 
                    child: const Text("Delete Profile Data"),
                  ),
                ),
            ],
          ),
        ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(color: kTextLightColor, fontSize: 14),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: TextField(
            controller: controller,
            enabled: _isEditing, // Hanya bisa diketik jika mode edit aktif
            keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: _isEditing ? Colors.grey[50] : Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              border: _isEditing 
                ? const UnderlineInputBorder(borderSide: BorderSide(color: kPrimaryColor))
                : InputBorder.none,
              isDense: true,
            ),
            style: const TextStyle(
              color: kTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (!_isEditing) const Divider(height: 1, color: Colors.black12),
        const SizedBox(height: 8),
      ],
    );
  }
}