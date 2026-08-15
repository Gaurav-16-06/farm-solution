import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/fertilizer_calculation.dart';
import '../../../providers/store_provider.dart';

class FertilizerCalculatorView extends StatefulWidget {
  final VoidCallback onNavigateToCart;

  const FertilizerCalculatorView({
    super.key,
    required this.onNavigateToCart,
  });

  @override
  State<FertilizerCalculatorView> createState() => _FertilizerCalculatorViewState();
}

class _FertilizerCalculatorViewState extends State<FertilizerCalculatorView> {
  final _areaController = TextEditingController(text: '1.0');

  @override
  void initState() {
    super.initState();
    final storeProv = Provider.of<StoreProvider>(context, listen: false);
    _areaController.text = storeProv.calcLandArea.toString();
  }

  @override
  void dispose() {
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final storeProv = Provider.of<StoreProvider>(context);
    final isHindi = langProv.isHindi;
    final theme = Theme.of(context);
    final result = storeProv.calculationResult;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Title Banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calculate_rounded, color: AppColors.harvestGold, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.calcTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.calcSubtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Input Card
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Crop Selector
                Text(
                  l10n.selectCrop,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: storeProv.calcCropKey,
                  decoration: const InputDecoration(),
                  items: FertilizerCalculator.supportedCrops.entries.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(
                        isHindi ? e.value.nameHi : e.value.nameEn,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      storeProv.updateCalculatorParams(cropKey: val);
                    }
                  },
                ),
                const SizedBox(height: 14),

                // Land Area & Unit
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.landArea,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _areaController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(hintText: '1.0'),
                            onChanged: (val) {
                              final numVal = double.tryParse(val);
                              if (numVal != null && numVal > 0) {
                                storeProv.updateCalculatorParams(landArea: numVal);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.landUnit,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: storeProv.calcLandUnit,
                            decoration: const InputDecoration(),
                            items: ['Acre', 'Bigha', 'Hectare', 'Kattha'].map((u) {
                              return DropdownMenuItem<String>(
                                value: u,
                                child: Text(u, style: const TextStyle(fontSize: 13)),
                              );
                            }).toList>,
                            onChanged: (u) {
                              if (u != null) {
                                storeProv.updateCalculatorParams(landUnit: u);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Quick Area Preset Buttons
                Row(
                  children: [
                    const Text('Presets: ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ...[0.5, 1.0, 2.5, 5.0].map((val) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: InkWell(
                          onTap: () {
                            _areaController.text = val.toString();
                            storeProv.updateCalculatorParams(landArea: val);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.greenSurface,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$val',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDarkGreen,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Result Card Dossier
        if (result != null) ...[
          Text(
            l10n.resultsHeading,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.primaryLightGreen, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${isHindi ? result.cropNameHi : result.cropNameEn} (${result.landArea} ${result.landUnit})',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryDarkGreen,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.harvestGold,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '₹${result.estimatedCost.toStringAsFixed(0)} Est.',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),

                  // Bag Quantities Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildNutrientMetric(
                          title: l10n.ureaRequired,
                          bags: '${result.ureaBags} Bags',
                          exactBags: result.roundedUreaBags,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildNutrientMetric(
                          title: l10n.dapRequired,
                          bags: '${result.dapBags} Bags',
                          exactBags: result.roundedDapBags,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildNutrientMetric(
                          title: l10n.mopRequired,
                          bags: '${result.mopBags} Bags',
                          exactBags: result.roundedMopBags,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildNutrientMetric(
                          title: l10n.zincRequired,
                          bags: '${result.zincKg} kg',
                          exactBags: 0,
                          color: AppColors.soilBrown,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Split Application Guide
                  Text(
                    isHindi ? 'खाद छिड़काव की वैज्ञानिक समय सारिणी' : 'Application Split Schedule',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),

                  _buildDosePill(
                    icon: Icons.looks_one_rounded,
                    stage: isHindi ? '1. बुवाई के समय (Basal)' : '1. Basal Sowing Stage',
                    dose: isHindi ? result.basalDoseHi : result.basalDoseEn,
                    color: AppColors.primaryGreen,
                  ),
                  const SizedBox(height: 6),
                  _buildDosePill(
                    icon: Icons.looks_two_rounded,
                    stage: isHindi ? '2. पहली सिंचाई (21-25 दिन)' : '2. 1st Irrigation (21-25 Days)',
                    dose: isHindi ? result.firstTopDressingHi : result.firstTopDressingEn,
                    color: AppColors.harvestGold,
                  ),
                  const SizedBox(height: 6),
                  _buildDosePill(
                    icon: Icons.looks_3_rounded,
                    stage: isHindi ? '3. कल्ले / फूल आने पर' : '3. Tillering / Flowering Stage',
                    dose: isHindi ? result.secondTopDressingHi : result.secondTopDressingEn,
                    color: AppColors.infoBlue,
                  ),
                  const SizedBox(height: 18),

                  // 1-Click Add Recommended Fertilizers to Cart!
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        storeProv.addCalculatedFertilizersToCart(result);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isHindi
                                  ? 'आवश्यक खाद (${result.roundedUreaBags} यूरिया + ${result.roundedDapBags} डीएपी) कार्ट में जोड़ी गई!'
                                  : 'Calculated inputs added to Co-operative Cart!',
                            ),
                            action: SnackBarAction(
                              label: isHindi ? 'कार्ट देखें' : 'View Cart',
                              textColor: AppColors.harvestGold,
                              onPressed: widget.onNavigateToCart,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart_rounded, size: 20),
                      label: Text(l10n.addToCart),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildNutrientMetric({
    required String title,
    required String bags,
    required int exactBags,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 10.5, color: color, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            bags,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildDosePill({
    required IconData icon,
    required String stage,
    required String dose,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stage,
                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  dose,
                  style: const TextStyle(fontSize: 11, color: AppColors.textSecondaryLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
