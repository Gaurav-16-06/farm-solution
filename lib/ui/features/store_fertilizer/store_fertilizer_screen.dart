import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/store_provider.dart';
import 'cart_bottom_sheet.dart';
import 'fertilizer_calculator_view.dart';
import 'store_catalog_view.dart';

class StoreFertilizerScreen extends StatefulWidget {
  const StoreFertilizerScreen({super.key});

  @override
  State<StoreFertilizerScreen> createState() => _StoreFertilizerScreenState();
}

class _StoreFertilizerScreenState extends State<StoreFertilizerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openCartModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const CartBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final storeProv = Provider.of<StoreProvider>(context);
    final isHindi = langProv.isHindi;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: AppColors.primaryDarkGreen,
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.harvestGold,
            indicatorWeight: 3.5,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
            unselectedLabelStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                icon: const Icon(Icons.calculate_outlined, size: 18),
                text: isHindi ? 'खाद कैलकुलेटर' : 'Fertilizer Calc',
              ),
              Tab(
                icon: const Icon(Icons.storefront_rounded, size: 18),
                text: isHindi ? 'किसान भंडार' : 'Co-op Store',
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FertilizerCalculatorView(onNavigateToCart: _openCartModal),
          StoreCatalogView(onOpenCart: _openCartModal),
        ],
      ),
      floatingActionButton: storeProv.cartCount > 0
          ? FloatingActionButton.extended(
              onPressed: _openCartModal,
              backgroundColor: AppColors.harvestGold,
              foregroundColor: Colors.black87,
              icon: const Icon(Icons.shopping_basket_rounded),
              label: Text(
                '${storeProv.cartCount} ${isHindi ? "सामग्री" : "Items"} (₹${storeProv.cartTotal.toStringAsFixed(0)})',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            )
          : null,
    );
  }
}
