import 'package:flutter/material.dart';

class Mood {
  final String name;
  final String emoji;
  final Color color;
  final List<String> categories;

  const Mood({
    required this.name,
    required this.emoji,
    required this.color,
    required this.categories,
  });
}
