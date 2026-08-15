import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/product_model.dart';
import '../../../providers/store_provider.dart';
import '../../widgets/shop_contact_card.dart';
import '../../widgets/status_badge.dart';

class StoreCatalogView extends StatelessWidget {
  final VoidCallback onOpenCart;

  const StoreCatalogView({
    super.key,
    required this.onOpenCart,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final storeProv = Provider.of<StoreProvider>(context);
    final isHindi = langProv.isHindi;
    final theme = Theme.of(context);

    final products = storeProv.products;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Shop Contact Card
        ShopContactCard(isHindi: isHindi),
        const SizedBox(height: 14),

        // Search & Category Filters
        TextField(
          decoration: InputDecoration(
            hintText: isHindi ? 'खाद, बीज या कीटनाशक खोजें...' : 'Search fertilizers, seeds, bio-products...',
            prefixIcon: const Icon(Icons.search_rounded),
            filled: true,
            fillColor: theme.cardTheme.color,
          ),
          onChanged: (q) => storeProv.setSearchQuery(q),
        ),
        const SizedBox(height: 10),

        // Category Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCatChip(storeProv, 'all', isHindi ? 'सभी उत्पाद' : 'All Products'),
              _buildCatChip(storeProv, 'fertilizer', isHindi ? 'रासायनिक खाद' : 'Fertilizers'),
              _buildCatChip(storeProv, 'seed', isHindi ? 'प्रमाणित बीज' : 'Certified Seeds'),
              _buildCatChip(storeProv, 'organic', isHindi ? 'जैविक उत्पाद' : 'Bio-Organic'),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Product List
        if (products.isEmpty)
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                isHindi ? 'कोई उत्पाद नहीं मिला।' : 'No products match your search.',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          )
        else
          ...products.map(
            (product) => _buildProductCard(context, product, isHindi, storeProv, theme, l10n),
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCatChip(StoreProvider storeProv, String catKey, String label) {
    final isSelected = storeProv.selectedCategory == catKey;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: AppColors.primaryGreen,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
          color: isSelected ? Colors.white : null,
        ),
        onSelected: (_) => storeProv.setCategory(catKey),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    ProductModel product,
    bool isHindi,
    StoreProvider storeProv,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.greenSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.inventory_2_rounded,
                    color: AppColors.primaryDarkGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? product.nameHi : product.nameEn,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.composition,
                        style: TextStyle(
                          fontSize: 11,
                          color: theme.brightness == Brightness.dark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  label: product.isAvailable
                      ? '${product.inStockCount} ${isHindi ? "उपलब्ध" : "In Stock"}'
                      : l10n.outOfStock,
                  status: product.isAvailable ? 'healthy' : 'danger',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isHindi ? product.descriptionHi : product.descriptionEn,
              style: const TextStyle(fontSize: 12, height: 1.3),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '₹${product.subsidizedPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primaryDarkGreen,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '₹${product.mrp.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'per ${isHindi ? product.unitHi : product.unitEn}',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: product.isAvailable
                      ? () {
                          storeProv.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isHindi
                                    ? '${product.nameHi} कार्ट में जोड़ा गया'
                                    : '${product.nameEn} added to cart',
                              ),
                              duration: const Duration(milliseconds: 900),
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.shopping_cart_outlined, size: 16),
                  label: Text(l10n.addToCart, style: const TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
