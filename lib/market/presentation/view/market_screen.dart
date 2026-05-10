import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:coffy_shell/theme/app_colors.dart';
import 'package:coffy_shell/market/presentation/mvvm/market_view_model.dart';
import 'package:coffy_shell/market/domain/entity/catalog_product.dart';
import 'package:coffy_shell/widgets/profile_action_button.dart';
import 'package:coffy_shell/widgets/cart_action_button.dart';
import 'package:coffy_shell/providers/cart_provider.dart';
import 'package:coffy_shell/providers/favorites_provider.dart';
import 'package:coffy_shell/models/product.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late final MarketViewModel marketViewModel;
  String selectedCategory = 'Hepsi';
  final List<String> categories = ['Hepsi', 'Kahve Çekirdeği', 'Demleme', 'Aksesuar'];

  @override
  void initState() {
    super.initState();
    marketViewModel = MarketViewModel();
    marketViewModel.fetchCatalogProducts();
  }

  @override
  void dispose() {
    marketViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.primary),
          onPressed: () {},
        ),
        title: Text(
          'CoffyShell Market',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: const [
          CartActionButton(),
          ProfileActionButton(),
        ],
      ),
      body: ListenableBuilder(
        listenable: marketViewModel,
        builder: (context, child) {
          if (marketViewModel.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.terracotta));
          }

          if (marketViewModel.catalogProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 64, color: AppColors.surfaceVariant),
                  const SizedBox(height: 16),
                  Text(
                    'Henüz market ürünü bulunmuyor.',
                    style: TextStyle(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => marketViewModel.fetchCatalogProducts(),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          final displayedProducts = selectedCategory == 'Hepsi'
              ? marketViewModel.catalogProducts.where((p) => p.category != 'Premium Seri').toList()
              : marketViewModel.catalogProducts.where((p) => p.category == selectedCategory).toList();

          final premiumProduct = marketViewModel.catalogProducts.firstWhere(
            (p) => p.category == 'Premium Seri',
            orElse: () => marketViewModel.catalogProducts.first,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Kahve veya ekipman ara...',
                      hintStyle: TextStyle(color: AppColors.onSurfaceVariant.withOpacity(0.5)),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Category Chips
                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () => setState(() => selectedCategory = category),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.sageGreen.withOpacity(0.4) : Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: isSelected ? AppColors.sageGreen : AppColors.surfaceVariant.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                
                // Feature Banner
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
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
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Haftanın Seçkisi',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                                letterSpacing: 1.1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Etiyopya\nYirgacheffe %20\nİndirim',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.terracotta,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: const Text(
                                'Hemen Al',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                Text(
                  'Öne Çıkanlar',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Product Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                  ),
                  itemCount: displayedProducts.length,
                  itemBuilder: (context, index) {
                    final product = displayedProducts[index];
                    return _ProductCard(product: product);
                  },
                ),
                const SizedBox(height: 32),
                
                // Premium wide card
                _PremiumCard(product: premiumProduct),
                const SizedBox(height: 32),
                
                // CTA Banner
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.coffee_maker_outlined,
                          color: AppColors.secondary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kendi Baristanız Olun',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Atölyelerimize katılın ve en iyi demleme tekniklerini uzmanlarımızdan öğrenin.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final CatalogProduct product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceVariant,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Consumer<FavoritesProvider>(
                  builder: (context, favorites, child) {
                    final p = Product(
                      id: product.id,
                      name: product.name,
                      description: product.description,
                      price: product.price,
                      imageUrl: product.imageUrl,
                      category: product.category,
                    );
                    final isFav = favorites.isFavorite(p);
                    return GestureDetector(
                      onTap: () => favorites.toggleFavorite(p),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: isFav ? AppColors.terracotta : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.category,
          style: const TextStyle(
            color: AppColors.terracotta,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${product.price.toStringAsFixed(0)} TL',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final p = Product(
                  id: product.id,
                  name: product.name,
                  description: product.description,
                  price: product.price,
                  imageUrl: product.imageUrl,
                  category: product.category,
                );
                cartProvider.addToCart(p);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.name} sepete eklendi!'),
                    backgroundColor: AppColors.secondary,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PremiumCard extends StatelessWidget {
  final CatalogProduct product;
  const _PremiumCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                height: 220,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceVariant,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Premium Seri',
                    style: TextStyle(
                      color: AppColors.terracotta,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primary.withOpacity(0.7),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(0)} TL',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final p = Product(
                            id: product.id,
                            name: product.name,
                            description: product.description,
                            price: product.price,
                            imageUrl: product.imageUrl,
                            category: product.category,
                          );
                          cartProvider.addToCart(p);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} sepete eklendi!'),
                              backgroundColor: AppColors.secondary,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.terracotta,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: const Text(
                          'Sepete Ekle',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
