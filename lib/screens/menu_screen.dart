import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffy_shell/theme/app_colors.dart';
import 'package:coffy_shell/widgets/product_card.dart';
import 'package:coffy_shell/widgets/category_chip.dart';
import 'package:coffy_shell/models/product.dart';
import 'package:coffy_shell/screens/product_detail_screen.dart';
import 'package:coffy_shell/screens/cart_screen.dart';
import 'package:coffy_shell/screens/loyalty_card_screen.dart';
import 'package:coffy_shell/providers/cart_provider.dart';

import 'package:coffy_shell/services/firebase_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String selectedCategory = 'Tümü';
  final List<String> categories = ['Tümü', 'Kahve', 'Tatlı', 'Çay', 'Soğuk'];
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text(
          'Menü',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.card_giftcard, color: AppColors.earthyBrown),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoyaltyCardScreen()),
              );
            },
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                label: Text(cart.totalItems.toString()),
                isLabelVisible: cart.totalItems > 0,
                backgroundColor: AppColors.terracotta,
                child: IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.earthyBrown),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: _firebaseService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.terracotta));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }
          
          final allProducts = snapshot.data ?? [];
          final filteredProducts = selectedCategory == 'Tümü'
              ? allProducts
              : allProducts.where((p) => p.category == selectedCategory).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Categories
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CategoryChip(
                        label: categories[index],
                        isSelected: selectedCategory == categories[index],
                        onTap: () {
                          setState(() {
                            selectedCategory = categories[index];
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              
              // Product Grid
              Expanded(
                child: filteredProducts.isEmpty 
                  ? const Center(child: Text('Bu kategoride ürün bulunamadı.'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: filteredProducts[index],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  product: filteredProducts[index],
                                ),
                              ),
                            );
                          },
                          onAdd: () {
                            context.read<CartProvider>().addToCart(filteredProducts[index]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${filteredProducts[index].name} sepete eklendi!'),
                                duration: const Duration(seconds: 2),
                                backgroundColor: AppColors.terracotta,
                                action: SnackBarAction(
                                  label: 'Sepete Git',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CartScreen()),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          );
        }
      ),
    );
  }
}


