import 'package:flutter/material.dart';
import 'package:coffy_shell/menu/presentation/mvvm/menu_view_model.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final MenuViewModel menuViewModel;

  @override
  void initState() {
    super.initState();
    menuViewModel = MenuViewModel();
    menuViewModel.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: menuViewModel,
      builder: (context, child) {
        if (menuViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: menuViewModel.products.length,
          itemBuilder: (context, index) {
            final product = menuViewModel.products[index];
            return ListTile(
              title: Text(product.name ?? ''),
              subtitle: Text(product.description ?? ''),
              trailing: Text("\$${product.price?.toStringAsFixed(2) ?? '0.00'}"),
            );
          },
        );
      },
    );
  }
}
