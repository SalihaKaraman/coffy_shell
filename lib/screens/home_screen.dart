import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coffy_shell/theme/app_colors.dart';
import 'package:coffy_shell/screens/loyalty_card_screen.dart';
import 'package:provider/provider.dart';
import 'package:coffy_shell/providers/navigation_provider.dart';
import 'package:coffy_shell/providers/cart_provider.dart';
import 'package:coffy_shell/services/firebase_service.dart';
import 'package:coffy_shell/models/product.dart';
import 'package:coffy_shell/providers/favorites_provider.dart';
import 'package:coffy_shell/widgets/profile_action_button.dart';
import 'package:coffy_shell/widgets/cart_action_button.dart';

import 'package:coffy_shell/screens/favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.read<NavigationProvider>();
    final cartProvider = context.read<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Decor
          Positioned(
            bottom: -50,
            right: -50,
            child: Opacity(
              opacity: 0.05,
              child: Icon(
                Icons.coffee,
                size: 250,
                color: AppColors.secondary,
              ),
            ),
          ),
          
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header
              SliverAppBar(
                floating: true,
                backgroundColor: AppColors.background.withOpacity(0.8),
                elevation: 0,
                toolbarHeight: 80,
                title: Text(
                  'L\'Artisan Café',
                  style: GoogleFonts.playfairDisplay(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                actions: const [
                  CartActionButton(),
                  ProfileActionButton(),
                ],
              ),

              // Hero Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Güne Güzel Bir Başlangıç',
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () => navProvider.setIndex(1),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  elevation: 0,
                                ),
                                child: const Text('Şimdi Sipariş Ver', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Loyalty Status
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoyaltyCardScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.1),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sadakat Puanların',
                                style: TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Text(
                                    '1,240',
                                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.stars, color: AppColors.secondaryContainer, size: 20),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Bir sonraki kahven bizden! (8/10)',
                                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Quick Actions
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Text(
                        'Hızlı İşlemler',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildActionItem('Favoriler', Icons.favorite, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                            );
                          }),
                          _buildActionItem('Tekrarla', Icons.replay, () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Son siparişiniz sepete eklendi!')),
                            );
                          }),
                          _buildActionItem('Cüzdan', Icons.payments, () {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => const LoyaltyCardScreen()));
                          }),
                          _buildActionItem('Hediye', Icons.card_giftcard, () {}),
                          _buildActionItem('Şubeler', Icons.location_on, () => navProvider.setIndex(2)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Recommendations Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Senin İçin Seçtiklerimiz',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => navProvider.setIndex(1),
                        child: const Text(
                          'Tümünü Gör',
                          style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Recommendations Grid
              StreamBuilder<List<Product>>(
                stream: FirebaseService().getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const SliverToBoxAdapter(
                      child: Center(child: Text('Ürünler yüklenirken hata oluştu.')),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator(color: AppColors.terracotta)),
                    );
                  }

                  final products = snapshot.data!.take(4).toList();
                  
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.82,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = products[index];
                          return _buildProductCard(context, product, cartProvider);
                        },
                        childCount: products.length,
                      ),
                    ),
                  );
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.secondary, size: 28),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product, CartProvider cartProvider) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceVariant,
                      child: const Icon(Icons.coffee),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Consumer<FavoritesProvider>(
                    builder: (context, favorites, child) {
                      final isFav = favorites.isFavorite(product);
                      return GestureDetector(
                        onTap: () => favorites.toggleFavorite(product),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white.withOpacity(0.9),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? AppColors.terracotta : Colors.grey,
                            size: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₺${product.price.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primary),
              ),
              GestureDetector(
                onTap: () {
                  cartProvider.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} sepete eklendi!'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: AppColors.secondary,
                    ),
                  );
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
