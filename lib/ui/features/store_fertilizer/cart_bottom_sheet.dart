import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/store_provider.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  final _farmerNameController = TextEditingController(text: 'Kisan Ramvilas');
  bool _isProcessing = false;
  bool _orderPlaced = false;

  @override
  void dispose() {
    _farmerNameController.dispose();
    super.dispose();
  }

  Future<void> _handleCheckout(StoreProvider storeProv, BuildContext context) async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 900));
    final success = await storeProv.checkoutCart(_farmerNameController.text);
    if (mounted) {
      setState(() {
        _isProcessing = false;
        _orderPlaced = success;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final storeProv = Provider.of<StoreProvider>(context);
    final isHindi = langProv.isHindi;
    final theme = Theme.of(context);

    if (_orderPlaced) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.greenSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.verified_rounded, size: 56, color: AppColors.primaryGreen),
            ),
            const SizedBox(height: 16),
            Text(
              isHindi ? 'बुकिंग सफलतापूर्वक दर्ज की गई!' : 'Co-operative Booking Confirmed!',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isHindi
                  ? 'आपका टोकन नंबर जारी हो गया है। कृपया सोनपुर सेवा समिति केंद्र पर KCC कार्ड दिखाकर खाद प्राप्त करें।'
                  : 'Your booking token has been generated. Please present your Aadhaar/KCC at Sonpur Sewa Samiti center for collection.',
              style: TextStyle(
                fontSize: 12.5,
                color: theme.brightness == Brightness.dark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK / ठीक है'),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    }

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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.cartTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                if (storeProv.cart.isNotEmpty)
                  TextButton(
                    onPressed: () => storeProv.clearCart(),
                    child: Text(
                      isHindi ? 'खाली करें' : 'Clear All',
                      style: const TextStyle(color: AppColors.healthDanger, fontSize: 12),
                    ),
                  ),
              ],
            ),
            const Divider(),

            if (storeProv.cart.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.shopping_bag_outlined, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      Text(
                        isHindi ? 'आपकी कार्ट खाली है' : 'Your cart is empty',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              ...storeProv.cart.map((item) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.greenSurface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.inventory_2_rounded,
                            color: AppColors.primaryDarkGreen,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isHindi ? item.product.nameHi : item.product.nameEn,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '₹${item.product.subsidizedPrice.toStringAsFixed(0)} / ${isHindi ? item.product.unitHi : item.product.unitEn}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline_rounded, size: 20),
                              onPressed: () {
                                storeProv.updateCartItemQuantity(
                                  item.product.id,
                                  item.quantity - 1,
                                );
                              },
                            ),
                            Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle_outline_rounded,
                                size: 20,
                                color: AppColors.primaryGreen,
                              ),
                              onPressed: () {
                                storeProv.updateCartItemQuantity(
                                  item.product.id,
                                  item.quantity + 1,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 12),

              // Subsidy Savings Banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.harvestAmberLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.harvestGold.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.savings_rounded, color: Color(0xFFE65100), size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        isHindi
                            ? 'सहकारी सब्सिडी से आपकी कुल बचत: ₹${storeProv.cartSavings.toStringAsFixed(0)}'
                            : 'Total Co-operative Subsidy Savings: ₹${storeProv.cartSavings.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Total Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Payable (कुल देय):',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${storeProv.cartTotal.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryDarkGreen,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Checkout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isProcessing ? null : () => _handleCheckout(storeProv, context),
                  icon: _isProcessing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Icon(Icons.check_circle_rounded, size: 18),
                  label: Text(_isProcessing ? 'Processing...' : l10n.checkout),
                ),
              ),
            ],
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
