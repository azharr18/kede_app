// lib/widgets/auth_sheets.dart
import 'package:flutter/material.dart';
import '../main.dart'; // Untuk mengakses kPrimaryColor, dll
import '../screens/main_app_screen.dart'; // Navigasi setelah login

/*
  =============================================================
  WIDGET UTAMA (REUSABLE)
  =============================================================
*/

/// Fungsi utama untuk menampilkan modal bottom sheet
void showAuthSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24.0),
              child: child,
            ),
          );
        },
      );
    },
  );
}

/// Header yang dipakai di semua sheet (Judul + Tombol Close)
class AuthSheetHeader extends StatelessWidget {
  final String title;
  const AuthSheetHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: kTextColor, size: 28),
        ),
      ],
    );
  }
}

/// Text Field kustom yang dipakai di semua form
class CustomAuthField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  const CustomAuthField({
    super.key,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }
}

/*
  =============================================================
  KONTEN UNTUK MASING-MASING SHEET
  =============================================================
*/

// --- 1. KONTEN SIGN IN ---
class SignInSheetContent extends StatelessWidget {
  const SignInSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthSheetHeader(title: 'Sign In'),
        const SizedBox(height: 24),
        const CustomAuthField(hintText: 'info@example.com'),
        const SizedBox(height: 16),
        const CustomAuthField(hintText: '••••••', isPassword: true),
        const SizedBox(height: 16),
        
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              showAuthSheet(context, const ForgotPassSheetContent());
            },
            child: const Text('Forgot Password?',
                style: TextStyle(color: kPrimaryColor)),
          ),
        ),
        const SizedBox(height: 24),
        
        ElevatedButton(
          onPressed: () {
            print('Sign In Ditekan');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainAppScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text('SIGN IN'),
        ),
        const SizedBox(height: 16),
        
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
            showAuthSheet(context, const SignUpSheetContent());
          },
          child: const Text('CREATE AN ACCOUNT'),
        ),
      ],
    );
  }
}

// --- 2. KONTEN SIGN UP (CREATE ACCOUNT) ---
class SignUpSheetContent extends StatelessWidget {
  const SignUpSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthSheetHeader(title: 'Create your account'),
        const SizedBox(height: 24),
        
        Row(
          children: [
            Expanded(
              child: CustomAuthField(hintText: 'Samuel'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomAuthField(hintText: 'Witwicky'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const CustomAuthField(hintText: 'info@example.com'),
        const SizedBox(height: 16),
        const CustomAuthField(hintText: '••••••', isPassword: true),
        const SizedBox(height: 24),
        
        Text.rich(
          TextSpan(
            text: 'By tapping Sign up you accept all ',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: 'terms and condition',
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        
        ElevatedButton(
          onPressed: () {
            print('Create Account Ditekan');
            Navigator.pop(context);
            showAuthSheet(context, const SignInSheetContent());
          },
          child: const Text('CREATE AN ACCOUNT'),
        ),
      ],
    );
  }
}

// --- 3. KONTEN FORGOT PASSWORD ---
class ForgotPassSheetContent extends StatelessWidget {
  const ForgotPassSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthSheetHeader(title: 'Forget Password'),
        const SizedBox(height: 24),
        const CustomAuthField(hintText: 'New Password'),
        const SizedBox(height: 24),
        
        ElevatedButton(
          onPressed: () {
            print('Submit Forgot Password Ditekan');
          },
          child: const Text('SUBMIT'),
        ),
        const SizedBox(height: 24),
        
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
              showAuthSheet(context, const SignInSheetContent());
            },
            child: Text.rich(
              TextSpan(
                text: 'Sign in to your registered account ',
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Login here',
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}