import 'package:flutter/material.dart';
import 'package:coffy_shell/screens/home_screen.dart';
import 'package:coffy_shell/screens/menu_screen.dart';
import 'package:coffy_shell/market/presentation/view/market_screen.dart';
import 'package:coffy_shell/branches/presentation/view/branches_screen.dart';
import 'package:coffy_shell/ai/presentation/view/ai_screen.dart';
import 'package:coffy_shell/providers/navigation_provider.dart';
import 'package:coffy_shell/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const MenuScreen(),
    const BranchesScreen(),
    const MarketScreen(),
    const AIScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    return Scaffold(
      body: Stack(
        children: [
          _screens[navProvider.currentIndex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(navProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(NavigationProvider navProvider) {
    return Container(
      height: 90,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _buildNavItem(0, Icons.home_rounded, 'Anasayfa', navProvider)),
          Expanded(child: _buildNavItem(1, Icons.restaurant_menu_rounded, 'Menü', navProvider)),
          Expanded(child: _buildNavItem(2, Icons.storefront_rounded, 'Şubeler', navProvider)),
          Expanded(child: _buildNavItem(3, Icons.shopping_bag_rounded, 'Market', navProvider)),
          Expanded(child: _buildNavItem(4, Icons.auto_awesome_rounded, 'AI', navProvider)),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, NavigationProvider navProvider) {
    final isSelected = navProvider.currentIndex == index;
    return GestureDetector(
      onTap: () => navProvider.setIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFCC18) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF1C1B1F) : Colors.grey[400],
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? const Color(0xFF1C1B1F) : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.primary,
              ),
        ),
      ),
      body: Center(
        child: Text(
          '$title yakında burada!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
