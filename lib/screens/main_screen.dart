import 'package:flutter/material.dart';
import 'package:coffy_shell/screens/menu_screen.dart';
import 'package:coffy_shell/market/presentation/view/market_screen.dart';
import 'package:coffy_shell/branches/presentation/view/branches_screen.dart';
import 'package:coffy_shell/ai/presentation/view/ai_screen.dart';
import 'package:coffy_shell/theme/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MenuScreen(),
    const BranchesScreen(),
    const MarketScreen(),
    const AIScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.terracotta,
        unselectedItemColor: AppColors.earthyBrown.withOpacity(0.5),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menü',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Şubeler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'AI',
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
