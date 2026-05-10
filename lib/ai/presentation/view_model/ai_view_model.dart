import 'package:flutter/material.dart';
import 'package:coffy_shell/services/firebase_service.dart';
import 'package:coffy_shell/models/product.dart';
import 'package:coffy_shell/ai/domain/entity/mood.dart';
import 'package:coffy_shell/theme/app_colors.dart';

class AIViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  List<Product> _allProducts = [];
  List<Product> _recommendations = [];
  List<Product> get recommendations => _recommendations;
  
  Mood? _selectedMood;
  Mood? get selectedMood => _selectedMood;

  final List<Mood> moods = [
    const Mood(
      name: 'Enerjik', 
      emoji: '⚡', 
      color: Color(0xFFFFD700), 
      categories: ['Kahve'],
    ),
    const Mood(
      name: 'Sakin', 
      emoji: '🍃', 
      color: AppColors.sageGreen, 
      categories: ['Çay', 'Kahve'],
    ),
    const Mood(
      name: 'Odaklanmış', 
      emoji: '🎯', 
      color: AppColors.earthyBrown, 
      categories: ['Kahve'],
    ),
    const Mood(
      name: 'Tatlı Krizinde', 
      emoji: '🍩', 
      color: Color(0xFFFF69B4), 
      categories: ['Tatlı'],
    ),
    const Mood(
      name: 'Ferah', 
      emoji: '❄️', 
      color: Color(0xFF87CEEB), 
      categories: ['Soğuk', 'Çay'],
    ),
  ];

  Future<void> selectMood(Mood mood) async {
    _selectedMood = mood;
    _recommendations = [];
    _isLoading = true;
    notifyListeners();

    // Simulate AI thinking time
    await Future.delayed(const Duration(seconds: 2));

    if (_allProducts.isEmpty) {
      // Get products from Firebase
      final stream = _firebaseService.getProducts();
      await for (final products in stream) {
        _allProducts = products;
        break; // Only need the first snapshot
      }
    }

    // AI Logic: Filter by category and add some randomness/logic
    _recommendations = _allProducts.where((p) {
      return mood.categories.contains(p.category);
    }).toList();

    // Sort or refine based on "AI" rules
    if (mood.name == 'Enerjik') {
      // Prioritize strong coffees
      _recommendations.sort((a, b) => b.price.compareTo(a.price)); 
    } else if (mood.name == 'Sakin') {
      // Prioritize tea or light coffee
      _recommendations = _recommendations.where((p) => p.name.contains('Latte') || p.category == 'Çay').toList();
    }

    _isLoading = false;
    notifyListeners();
  }
  
  void reset() {
    _selectedMood = null;
    _recommendations = [];
    notifyListeners();
  }
}
