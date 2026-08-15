import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

class ShopContactCard extends StatelessWidget {
  final bool isHindi;

  const ShopContactCard({
    super.key,
    required this.isHindi,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? AppColors.borderDark
              : AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDarkGreen.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop Front Photo with Overlay Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  'assets/images/shop_front.jpg',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    height: 140,
                    color: AppColors.primaryDarkGreen,
                    child: const Center(
                      child: Icon(Icons.store_rounded, size: 50, color: Colors.white70),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified_rounded, size: 14, color: AppColors.harvestGold),
                      const SizedBox(width: 4),
                      Text(
                        isHindi ? 'अधिकृत किसान सेवा केंद्र' : 'Authorized Kisan Seva Kendra',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.harvestGold, width: 1.5),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/logo.svg',
                          fit: BoxFit.contain,
                          errorBuilder: (c, e, s) => const Icon(
                            Icons.eco_rounded,
                            color: AppColors.primaryDarkGreen,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.shopName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            AppConstants.appTagline,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Address Row
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.bgLight,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_rounded, size: 18, color: AppColors.healthDanger),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? 'दुकान का पता (Address):' : 'Shop Location & Address:',
                              style: const TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isHindi ? AppConstants.shopAddressHi : AppConstants.shopAddressEn,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // 1-Tap Action Buttons: Direct Calling & WhatsApp Chat
                Row(
                  children: [
                    // Call Button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Launches tel:8269202960
                        },
                        icon: const Icon(Icons.phone_in_talk_rounded, size: 18),
                        label: Text(
                          isHindi ? 'कॉल करें (${AppConstants.shopPhone})' : 'Call (${AppConstants.shopPhone})',
                          style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryDarkGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // WhatsApp Button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Launches https://wa.me/918269202960
                        },
                        icon: const Icon(Icons.chat_rounded, size: 18),
                        label: Text(
                          isHindi ? 'व्हाट्सएप चैट' : 'WhatsApp Chat',
                          style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
