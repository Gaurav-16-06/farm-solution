import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/language_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/theme_provider.dart';

class CustomAppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final bool showLanguageToggle;
  final List<Widget>? actions;

  const CustomAppHeader({
    super.key,
    this.title,
    this.subtitle,
    this.showLanguageToggle = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final themeProv = Provider.of<ThemeProvider>(context);

    return AppBar(
      elevation: 1.5,
      backgroundColor: AppColors.primaryDarkGreen,
      automaticallyImplyLeading: false,
      titleSpacing: 14,
      title: Row(
        children: [
          // Official Circular Logo Emblem
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.harvestGold, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/images/logo.svg',
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, stack) => const Icon(
                    Icons.agriculture_rounded,
                    color: AppColors.primaryDarkGreen,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                  Text(
                    title ?? AppConstants.appName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 1),
                Text(
                  subtitle ?? (langProv.isHindi ? 'जेठवारा, प्रतापगढ़ (उ.प्र.) • ${AppConstants.appTagline}' : 'Jethwara, Pratapgarh (UP) • ${AppConstants.appTagline}'),
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (showLanguageToggle)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: InkWell(
              onTap: () => langProv.toggleLanguage(),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.harvestGold,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.translate_rounded,
                      size: 13,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      langProv.isHindi ? 'English' : 'हिंदी',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        IconButton(
          icon: Icon(
            themeProv.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            color: Colors.white.withValues(alpha: 0.9),
            size: 20,
          ),
          tooltip: 'Toggle Theme',
          onPressed: () => themeProv.toggleTheme(),
        ),
        if (actions != null) ...actions!,
        const SizedBox(width: 4),
      ],
    );
  }
}
