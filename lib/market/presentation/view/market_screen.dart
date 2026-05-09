import 'package:flutter/material.dart';
import 'package:coffy_shell/market/presentation/mvvm/market_view_model.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late final MarketViewModel marketViewModel;

  @override
  void initState() {
    super.initState();
    marketViewModel = MarketViewModel();
    marketViewModel.fetchCatalogProducts();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: marketViewModel,
      builder: (context, child) {
        if (marketViewModel.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: marketViewModel.catalogProducts.length,
          itemBuilder: (context, index) {
            final product = marketViewModel.catalogProducts[index];
            return ListTile(title: Text(product.name ?? ''));
          },
        );
      },
    );
  }
}
