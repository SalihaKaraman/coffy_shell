import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors from DESIGN.md
  static const Color cream = Color(0xFFFDFCF0);
  static const Color earthyBrown = Color(0xFF4A3728);
  static const Color terracotta = Color(0xFFD67B52);
  static const Color sageGreen = Color(0xFF8DA47E);

  // Material Theme Colors (adapted from DESIGN.md palette)
  static const Color primary = Color(0xFF322214);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF4A3728);
  static const Color onPrimaryContainer = Color(0xFFBBA08C);

  static const Color secondary = Color(0xFF954824);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFD9A6F);
  static const Color onSecondaryContainer = Color(0xFF75300D);

  static const Color tertiary = Color(0xFF172A0E);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF2D4022);
  static const Color onTertiaryContainer = Color(0xFF95AC85);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color surface = Color(0xFFFFF8F5);
  static const Color onSurface = Color(0xFF1E1B1A);
  static const Color surfaceVariant = Color(0xFFE8E1DE);
  static const Color onSurfaceVariant = Color(0xFF4E453E);

  static const Color outline = Color(0xFF80756D);
  static const Color background = Color(0xFFFFF8F5);
  static const Color onBackground = Color(0xFF1E1B1A);
  
  static Color shadow = const Color(0xFF4A3728).withOpacity(0.08); // 8% opacity brown for ambient shadows
}
