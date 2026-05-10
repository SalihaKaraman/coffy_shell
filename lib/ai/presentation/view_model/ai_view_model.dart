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
      name: 'Tired', 
      emoji: '🥱', 
      color: Color(0xFF9E9E9E), 
      categories: ['Kahve'],
    ),
    const Mood(
      name: 'Flow', 
      emoji: '🌊', 
      color: Color(0xFF64B5F6), 
      categories: ['Kahve'],
    ),
    const Mood(
      name: 'Relaxed', 
      emoji: '🧘', 
      color: AppColors.sageGreen, 
      categories: ['Çay', 'Kahve'],
    ),
    const Mood(
      name: 'Curious', 
      emoji: '🧐', 
      color: Color(0xFFBA68C8), 
      categories: ['Kahve', 'Tatlı'],
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
    if (mood.name == 'Tired') {
      // Prioritize strong caffeinated drinks
      _recommendations = _recommendations.where((p) {
        final n = p.name.toLowerCase();
        final d = p.description.toLowerCase();
        return n.contains('espresso') || n.contains('double') || n.contains('cortado') || d.contains('kafein') || d.contains('sert');
      }).toList();
      if (_recommendations.isEmpty) _recommendations = _allProducts.where((p) => p.category == 'Kahve').toList();
    } else if (mood.name == 'Relaxed') {
      // Prioritize tea or milk-based light coffee
      _recommendations = _recommendations.where((p) {
        final n = p.name.toLowerCase();
        final d = p.description.toLowerCase();
        return p.category == 'Çay' || n.contains('latte') || n.contains('flat') || d.contains('süt') || d.contains('yumuşak');
      }).toList();
    } else if (mood.name == 'Flow') {
      // Prioritize black coffee or balanced drinks
      _recommendations = _recommendations.where((p) {
        final n = p.name.toLowerCase();
        final d = p.description.toLowerCase();
        return n.contains('filter') || n.contains('americano') || n.contains('v60') || d.contains('taze') || d.contains('odak');
      }).toList();
    } else if (mood.name == 'Curious') {
      // Prioritize specials, treats or high rated items
      _recommendations.sort((a, b) => b.rating.compareTo(a.rating));
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
