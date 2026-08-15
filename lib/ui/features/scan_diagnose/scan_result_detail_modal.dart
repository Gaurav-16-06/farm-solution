import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/scan_model.dart';
import '../../../providers/store_provider.dart';
import '../../widgets/status_badge.dart';

class ScanResultDetailModal extends StatelessWidget {
  final ScanModel scan;
  final bool isHindi;

  const ScanResultDetailModal({
    super.key,
    required this.scan,
    required this.isHindi,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final storeProv = Provider.of<StoreProvider>(context);

    // Look up live product from store provider to get latest real-time stock
    final liveProduct = storeProv.allRawProducts.firstWhere(
      (p) => p.id == scan.shriramProductId,
      orElse: () => scan.matchedProduct ?? storeProv.allRawProducts.first,
    );

    final isInStock = liveProduct.inStockCount > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Gemini Vision AI Header Badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E88E5), Color(0xFF7B1FA2)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 12),
                      SizedBox(width: 4),
                      Text(
                        'Gemini Vision AI 2.0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                StatusBadge(
                  label: scan.isHealthy ? l10n.scanStatusHealthy : l10n.scanStatusInfected,
                  status: scan.isHealthy ? 'healthy' : 'danger',
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Crop and Disease Title
            Text(
              isHindi ? scan.cropNameHi : scan.cropNameEn,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: theme.brightness == Brightness.dark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              isHindi ? scan.diseaseNameHi : scan.diseaseNameEn,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: scan.isHealthy ? AppColors.healthGood : AppColors.healthDanger,
              ),
            ),
            const SizedBox(height: 12),

            // Confidence Score Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scan.isHealthy ? AppColors.greenSurface : const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: scan.isHealthy
                      ? AppColors.primaryLightGreen.withValues(alpha: 0.3)
                      : AppColors.harvestGold.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_rounded,
                    color: scan.isHealthy ? AppColors.primaryGreen : AppColors.harvestGold,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.scanConfidence,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${(scan.confidenceScore * 100).toStringAsFixed(1)}% AI Diagnostic Match',
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Symptoms
            _buildSection(
              title: l10n.symptomsTitle,
              content: isHindi ? scan.symptomsHi : scan.symptomsEn,
              icon: Icons.biotech_rounded,
              iconColor: Colors.deepOrange,
              theme: theme,
            ),
            const SizedBox(height: 12),

            // Shriram Fertilizers & Chemicals Targeted Treatment Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryGreen,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.greenSurface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.verified_user_rounded,
                          color: AppColors.primaryDarkGreen,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi
                                  ? 'श्रीराम फर्टिलाइजर्स एवं केमिकल्स अनुशंसित उपचार'
                                  : 'Shriram Fertilizers & Chemicals Treatment',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryDarkGreen,
                              ),
                            ),
                            Text(
                              isHindi ? 'विशिष्ट उत्पाद एवं एकड़ अनुसार मात्रा' : 'Targeted Product & 1-Acre Dosage',
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 16),

                  // Product Name
                  Text(
                    isHindi ? liveProduct.nameHi : liveProduct.nameEn,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDarkGreen,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    liveProduct.composition,
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.brightness == Brightness.dark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 1-Acre Dosage Highlight Pill
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.harvestAmberLight,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.harvestGold.withValues(alpha: 0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.speed_rounded, size: 16, color: Color(0xFFE65100)),
                            const SizedBox(width: 6),
                            Text(
                              isHindi ? '1 एकड़ खेत हेतु सही मात्रा (1 Acre Dosage):' : 'Exact Dosage per 1 Acre:',
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFE65100),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          isHindi ? scan.dosagePerAcreHi : scan.dosagePerAcreEn,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Live Store Inventory & Price Checker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isHindi ? 'सहकारी मूल्य (Subsidized Price)' : 'Current Store Price:',
                            style: const TextStyle(fontSize: 10.5, color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Text(
                                '₹${liveProduct.subsidizedPrice.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primaryDarkGreen,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '/ ${isHindi ? liveProduct.unitHi : liveProduct.unitEn}',
                                style: const TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isInStock ? AppColors.greenSurface : const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isInStock ? AppColors.primaryGreen : AppColors.healthDanger,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isInStock ? Icons.check_circle_rounded : Icons.cancel_rounded,
                              size: 14,
                              color: isInStock ? AppColors.primaryDarkGreen : AppColors.healthDanger,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isInStock
                                  ? (isHindi
                                      ? 'उपलब्ध (${liveProduct.inStockCount} पीस)'
                                      : 'IN STOCK (${liveProduct.inStockCount} left)')
                                  : (isHindi ? 'स्टॉक समाप्त (OUT OF STOCK)' : 'OUT OF STOCK'),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: isInStock ? AppColors.primaryDarkGreen : AppColors.healthDanger,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Add to Cart Button if in stock
                  if (isInStock) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          storeProv.addToCart(liveProduct);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isHindi
                                    ? '${liveProduct.nameHi} कार्ट में जोड़ा गया'
                                    : '${liveProduct.nameEn} added to store cart',
                              ),
                              backgroundColor: AppColors.primaryDarkGreen,
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart_rounded, size: 16),
                        label: Text(
                          isHindi ? 'यह दवा समिति कार्ट में जोड़ें' : 'Add to Co-op Cart',
                          style: const TextStyle(fontSize: 12.5),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Organic / Jaivik Treatment
            _buildSection(
              title: l10n.organicTreatmentTitle,
              content: isHindi ? scan.organicRemedyHi : scan.organicRemedyEn,
              icon: Icons.nature_people_rounded,
              iconColor: AppColors.primaryGreen,
              theme: theme,
            ),
            const SizedBox(height: 12),

            // Prevention
            _buildSection(
              title: l10n.preventionTipsTitle,
              content: isHindi ? scan.preventionHi : scan.preventionEn,
              icon: Icons.shield_rounded,
              iconColor: AppColors.soilBrown,
              theme: theme,
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close / बंद करें'),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required IconData icon,
    required Color iconColor,
    required ThemeData theme,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.brightness == Brightness.dark
              ? AppColors.borderDark
              : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: theme.brightness == Brightness.dark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
