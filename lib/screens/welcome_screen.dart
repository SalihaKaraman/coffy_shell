import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coffy_shell/theme/app_colors.dart';
import 'package:coffy_shell/screens/main_screen.dart';

import 'package:coffy_shell/screens/loyalty_card_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          // Background Image with Gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=1000'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        AppColors.cream,
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Logo/Text at top
                  Text(
                    'L\'Artisan Café',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  
                  // Main Heading
                  Text(
                    'Güne Güzel Bir Başlangıç',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Subtext
                  Text(
                    'Ustalıkla hazırlanmış kahvelerimiz ve sıcak atmosferimizle gününüzü aydınlatmaya hazırız.',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: AppColors.primary.withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Today's Special Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.sageGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.coffee_maker_outlined, size: 16, color: AppColors.sageGreen),
                        const SizedBox(width: 8),
                        Text(
                          'Bugünün Seçkisi: Ethiopia Yirgacheffe',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Main Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.terracotta,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hemen Başla',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Bottom Secondary Actions
                  Row(
                    children: [
                      Expanded(
                        child: _buildSecondaryAction(
                          context: context,
                          icon: Icons.history,
                          label: 'Sipariş Takibi',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Aktif siparişiniz bulunmamaktadır.')),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 24,
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                      Expanded(
                        child: _buildSecondaryAction(
                          context: context,
                          icon: Icons.card_giftcard,
                          label: 'Loyalty Kart',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoyaltyCardScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryAction({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Icon(icon, size: 24, color: AppColors.primary.withOpacity(0.6)),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
