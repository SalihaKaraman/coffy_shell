import 'package:flutter/material.dart';
import 'package:coffy_shell/models/product.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void toggleFavorite(Product product) {
    final isExist = _favorites.any((p) => p.id == product.id);
    if (isExist) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }
}
