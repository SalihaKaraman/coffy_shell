import 'package:flutter/material.dart';
import 'package:coffy_shell/theme/app_colors.dart';
import 'package:coffy_shell/screens/profile_screen.dart';

class ProfileActionButton extends StatelessWidget {
  const ProfileActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.terracotta.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withOpacity(0.1), width: 1.5),
          ),
          child: const Icon(
            Icons.person,
            color: AppColors.terracotta,
            size: 24,
          ),
        ),
      ),
    );
  }
}
