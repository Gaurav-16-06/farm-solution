import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/admin_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../providers/store_provider.dart';
import '../widgets/custom_app_header.dart';
import 'admin_panel/admin_panel_screen.dart';
import 'crop_calendar/crop_calendar_screen.dart';
import 'scan_diagnose/scan_diagnose_screen.dart';
import 'store_fertilizer/store_fertilizer_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // Reordered Screens: AI Disease Scanner in Center Position (Tab index 2)
  final List<Widget> _screens = const [
    CropCalendarScreen(),       // Tab 0: Crop Calendar
    StoreFertilizerScreen(),    // Tab 1: Store & Fertilizer Calc
    ScanDiagnoseScreen(),       // Tab 2: AI Disease Scanner (Center Camera)
    AdminPanelScreen(),         // Tab 3: Admin Panel
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final navProv = Provider.of<NavigationProvider>(context);
    final storeProv = Provider.of<StoreProvider>(context);
    final adminProv = Provider.of<AdminProvider>(context);
    final theme = Theme.of(context);

    final pendingAdminCount = adminProv.stats.pendingSupportQueries;

    return Scaffold(
      appBar: const CustomAppHeader(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: KeyedSubtree(
          key: ValueKey<int>(navProv.currentIndex),
          child: _screens[navProv.currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: navProv.currentIndex,
          onTap: (index) => navProv.setIndex(index),
          backgroundColor: theme.brightness == Brightness.dark
              ? const Color(0xFF131D15)
              : Colors.white,
          selectedItemColor: theme.brightness == Brightness.dark
              ? AppColors.primaryLightGreen
              : AppColors.primaryDarkGreen,
          unselectedItemColor: const Color(0xFF788D7B),
          selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
          unselectedLabelStyle: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500),
          type: BottomNavigationBarType.fixed,
          items: [
            // Tab 0: My Crop Calendar
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_month_outlined),
              activeIcon: const Icon(Icons.calendar_month_rounded),
              label: l10n.tabCalendar,
            ),

            // Tab 1: Store & Fertilizer Calc
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: storeProv.cartCount > 0,
                label: Text('${storeProv.cartCount}'),
                backgroundColor: AppColors.harvestGold,
                textColor: Colors.black87,
                child: const Icon(Icons.storefront_outlined),
              ),
              activeIcon: Badge(
                isLabelVisible: storeProv.cartCount > 0,
                label: Text('${storeProv.cartCount}'),
                backgroundColor: AppColors.harvestGold,
                textColor: Colors.black87,
                child: const Icon(Icons.storefront_rounded),
              ),
              label: l10n.tabStore,
            ),

            // Tab 2 (CENTER): AI Disease Scanner with prominent Camera Icon & green floating style
            BottomNavigationBarItem(
              icon: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryDarkGreen.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.photo_camera_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              activeIcon: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryDarkGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.harvestGold, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryDarkGreen.withValues(alpha: 0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.photo_camera_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              label: l10n.tabScan,
            ),

            // Tab 3: Admin Panel
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: pendingAdminCount > 0,
                label: Text('$pendingAdminCount'),
                backgroundColor: AppColors.healthDanger,
                child: const Icon(Icons.admin_panel_settings_outlined),
              ),
              activeIcon: Badge(
                isLabelVisible: pendingAdminCount > 0,
                label: Text('$pendingAdminCount'),
                backgroundColor: AppColors.healthDanger,
                child: const Icon(Icons.admin_panel_settings_rounded),
              ),
              label: l10n.tabAdmin,
            ),
          ],
        ),
      ),
    );
  }
}
