import 'package:flutter/material.dart';
import 'package:coffy_shell/theme/app_colors.dart';
import 'package:coffy_shell/widgets/primary_button.dart';

class LoyaltyCardScreen extends StatelessWidget {
  const LoyaltyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text(
          'Sadakat Kartı',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Artisanal Rewards',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.cream,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '3 Kahve Daha Alın, 1 Bedava Kazanın',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      bool isCollected = index < 2; // 2 coffees collected
                      return Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isCollected ? AppColors.terracotta : AppColors.surfaceVariant.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.coffee,
                          color: isCollected ? Colors.white : AppColors.onPrimaryContainer.withOpacity(0.5),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'Barkodu Okutun',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 100,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.earthyBrown.withOpacity(0.2)),
              ),
              child: const Center(
                child: Icon(Icons.qr_code_2, size: 80, color: AppColors.primary),
              ),
            ),
            const Spacer(),
            PrimaryButton(
              text: 'Geçmiş Siparişlerim',
              isSecondary: true,
              onPressed: () {
                // TODO: History logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
