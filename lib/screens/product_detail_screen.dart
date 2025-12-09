// lib/screens/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../main.dart'; 
import '../models/product.dart';
import '../widgets/quantity_stepper.dart'; 
import 'write_review_screen.dart'; 
import 'checkout_screen.dart'; // Import sudah benar

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
      
  final PageController _imagePageController = PageController();
  late TabController _tabController;
  bool _isFavorited = false;

  final List<String> _productImages = [
    'assets/images/tomatoes.jpg',
    'assets/images/avocado.jpg', 
    'assets/images/brocoli.jpg', // Pastikan nama file ini benar
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _isFavorited = widget.product.isFavorite;
    // Tambahkan gambar utama produk ke slider
    _productImages.insert(0, widget.product.imagePath); 
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSlider(context),
                _buildProductInfo(),
                const SizedBox(height: 24),
                _buildTabs(),
                const SizedBox(height: 120),
              ],
            ),
          ),
          
          _buildBottomActionButtons(),
        ],
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            controller: _imagePageController,
            itemCount: _productImages.length,
            itemBuilder: (context, index) {
              return Image.asset(
                _productImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
                // Error builder jika aset tidak ditemukan
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
                  );
                },
              );
            },
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTransparentButton(
                      Icons.arrow_back, () => Navigator.pop(context)),
                  _buildTransparentButton(Icons.share, () {}),
                ],
              ),
            ),
          ),
          
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _imagePageController,
                count: _productImages.length,
                effect: const WormEffect(
                  dotColor: Colors.white54,
                  activeDotColor: Colors.white,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransparentButton(IconData icon, VoidCallback onPressed) {
    return CircleAvatar(
      backgroundColor: Colors.black.withOpacity(0.3),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FRUITS',
              style: TextStyle(color: kTextLightColor, fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            widget.product.name,
            style: const TextStyle(
                color: kTextColor, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$${widget.product.price}',
                style: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const QuantityStepper(initialValue: 4),
            ],
          ),
          const SizedBox(height: 24),
          
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 24),
              const SizedBox(width: 8),
              const Text(
                '4.5',
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Text(
                '(128 reviews)',
                style: TextStyle(color: kTextLightColor, fontSize: 16),
              ),
              const Spacer(),
              _buildReviewerAvatars(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewerAvatars() {
    return SizedBox(
      width: 100,
      height: 40,
      child: Stack(
        children: [
          _buildAvatar('assets/images/images.jpg', left: 0),
          _buildAvatar('assets/images/images.jpg', left: 25),
          _buildAvatar('assets/images/images.jpg', left: 50),
        ],
      ),
    );
  }
  
  Widget _buildAvatar(String imagePath, {double left = 0}) {
    Widget child = Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          Container(color: Colors.grey[300]),
    );

    return Positioned(
      left: left,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: ClipOval(child: child),
      ),
    );
  }

  Widget _buildTabs() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: kPrimaryColor,
          unselectedLabelColor: kTextLightColor,
          indicatorColor: kPrimaryColor,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 16),
          tabs: const [
            Tab(text: 'Description'),
            Tab(text: 'Review'),
            Tab(text: 'Discussion'),
          ],
        ),
        
        const Divider(height: 1, color: Colors.black12),
        
        SizedBox(
          height: 200, 
          child: TabBarView(
            controller: _tabController,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style: TextStyle(color: kTextLightColor, fontSize: 16, height: 1.5),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No reviews yet. Be the first to review!'),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WriteReviewScreen(
                              product: widget.product,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text('WRITE A REVIEW'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const Center(child: Text('Discussion will be shown here')),
            ],
          ),
        ),
      ],
    );
  }

  /// Bagian 4: Tombol Aksi Bawah
  Widget _buildBottomActionButtons() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20.0).copyWith(
          bottom: 30.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isFavorited = !_isFavorited;
                });
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _isFavorited ? Colors.pink.withOpacity(0.1) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorited ? Colors.pink : kTextColor,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // --- INI BAGIAN YANG DIUBAH ---
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Aksi 1: (Opsional) Tambahkan item ke keranjang
                  print('Item ditambahkan ke keranjang (logika belum ada)');
                  
                  // Aksi 2: Langsung navigasi ke Checkout
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckoutScreen(),
                    ),
                  );
                },
                child: const Text('ADD TO CART \$14.7'),
              ),
            ),
            // --- BATAS PERUBAHAN ---
          ],
        ),
      ),
    );
  }
}