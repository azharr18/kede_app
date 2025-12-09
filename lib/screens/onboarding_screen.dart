// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../main.dart'; 
import 'package:KEDE_APP/screens/auth_screen.dart';

class OnboardingPageData {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPageData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  
  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      imagePath: 'assets/images/onboarding_1.png',
      title: 'Welcome to Kede! Your grocery application',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
    OnboardingPageData(
      imagePath: 'assets/images/onboarding_2.png',
      title: 'We provide best quality product to your family',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
    OnboardingPageData(
      imagePath: 'assets/images/onboarding_3.png',
      title: 'Fast and responsibily delivery by our courir',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),
              
              SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: kPrimaryColor,
                  dotColor: Colors.black12,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  print('Get Started Ditekan!');
                  Navigator.pushReplacement(
                    context,
                    // --- PERBAIKAN: Hapus kata 'const' di sini ---
                    MaterialPageRoute(builder: (context) => AuthScreen()), 
                  );
                },
                child: const Text('GET STARTED'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPageData page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          page.imagePath,
          height: 250,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 250,
            color: Colors.grey[200],
            child: const Center(
              child: Text(
                'Gagal memuat GAMBAR PNG.\nPastikan file ada di assets/images/',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(height: 64),
        
        Text(
          page.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        
        Text(
          page.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}