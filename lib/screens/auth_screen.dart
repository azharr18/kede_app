// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import '../main.dart'; 
import '../screens/main_app_screen.dart';
import '../services/auth_service.dart';

// =========================================================
// 1. KELAS AUTH SCREEN (YANG HILANG SEBELUMNYA)
// =========================================================
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // State untuk menentukan apakah menampilkan Login atau Register
  bool _isLogin = true;

  void _toggleView() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Menggunakan SafeArea agar tidak tertutup notch/status bar
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Menampilkan konten berdasarkan state _isLogin
                _isLogin 
                  ? SignInContent(onRegisterClicked: _toggleView)
                  : SignUpContent(onLoginClicked: _toggleView),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================
// 2. WIDGET REUSABLE
// =========================================================

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key, 
    required this.title,
    this.subtitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, 
          style: const TextStyle(
            fontSize: 28, 
            fontWeight: FontWeight.bold, 
            color: kTextColor
          )
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            subtitle, 
            style: const TextStyle(color: kTextLightColor, fontSize: 16)
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class CustomAuthField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const CustomAuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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

// =========================================================
// 3. KONTEN SIGN IN
// =========================================================
class SignInContent extends StatefulWidget {
  final VoidCallback onRegisterClicked;

  const SignInContent({super.key, required this.onRegisterClicked});

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class _SignInContentState extends State<SignInContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _handleSignIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Email dan Password tidak boleh kosong!'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      await _authService.signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainAppScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login Gagal: ${e.toString()}'),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthHeader(title: 'Welcome Back!', subtitle: 'Sign in to continue'),
        
        CustomAuthField(hintText: 'Email Address', controller: _emailController),
        const SizedBox(height: 16),
        CustomAuthField(hintText: 'Password', isPassword: true, controller: _passwordController),
        
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?', style: TextStyle(color: kPrimaryColor)),
          ),
        ),
        const SizedBox(height: 24),
        
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSignIn,
          child: _isLoading 
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
            : const Text('SIGN IN'),
        ),
        const SizedBox(height: 16),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account? ", style: TextStyle(color: kTextLightColor)),
            GestureDetector(
              onTap: widget.onRegisterClicked,
              child: const Text(
                'Create Account',
                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// =========================================================
// 4. KONTEN SIGN UP
// =========================================================
class SignUpContent extends StatefulWidget {
  final VoidCallback onLoginClicked;

  const SignUpContent({super.key, required this.onLoginClicked});

  @override
  State<SignUpContent> createState() => _SignUpContentState();
}

class _SignUpContentState extends State<SignUpContent> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _handleSignUp() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Semua kolom harus diisi!'), backgroundColor: Colors.red
      ));
      return;
    }

    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password minimal 6 karakter!'), backgroundColor: Colors.red
      ));
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      await _authService.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MainAppScreen()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Daftar Gagal: ${e.toString()}'), backgroundColor: Colors.red
        ));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthHeader(title: 'Create Account', subtitle: 'Sign up to get started'),
        
        CustomAuthField(hintText: 'Full Name', controller: _nameController),
        const SizedBox(height: 16),
        CustomAuthField(hintText: 'Email Address', controller: _emailController),
        const SizedBox(height: 16),
        CustomAuthField(hintText: 'Password', isPassword: true, controller: _passwordController),
        const SizedBox(height: 24),
        
        ElevatedButton(
          onPressed: _isLoading ? null : _handleSignUp,
          child: _isLoading 
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : const Text('SIGN UP'),
        ),
        const SizedBox(height: 16),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? ", style: TextStyle(color: kTextLightColor)),
            GestureDetector(
              onTap: widget.onLoginClicked,
              child: const Text(
                'Sign In',
                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}