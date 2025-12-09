// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/onboarding_screen.dart';

// Import file konfigurasi yang dibuat oleh FlutterFire CLI
// Jika baris ini merah, berarti Anda belum berhasil menjalankan 'flutterfire configure'
// Hapus baris ini dan bagian 'options:' di bawah jika ingin tes manual dulu.
import 'firebase_options.dart'; 

// Definisikan warna utama kita
const Color kPrimaryColor = Color(0xFF6ABF4B);
const Color kTextColor = Color(0xFF202E2E);
const Color kTextLightColor = Color(0xFF728080);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kede Grocery App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: kPrimaryColor,
        useMaterial3: true,
        
        // Tema Teks
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
          bodyMedium: TextStyle(
            color: kTextLightColor,
            fontSize: 16,
          ),
        ),
        
        // Tema Tombol Utama (Elevated)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Tema Tombol Kedua (Outlined)
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: kPrimaryColor, width: 2),
            foregroundColor: kPrimaryColor,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      // Halaman awal aplikasi
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// Fungsi untuk menyimpan perubahan data ke Firestore
// Membuat objek produk (contoh data)
