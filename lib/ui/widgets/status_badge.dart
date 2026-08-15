import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final String status; // 'healthy', 'warning', 'danger', 'info', 'urgent'
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.label,
    required this.status,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData defaultIcon;

    switch (status.toLowerCase()) {
      case 'healthy':
      case 'resolved':
      case 'good':
        bg = AppColors.greenSurface;
        fg = AppColors.primaryDarkGreen;
        defaultIcon = Icons.check_circle_rounded;
        break;
      case 'warning':
      case 'pending':
        bg = AppColors.harvestAmberLight;
        fg = const Color(0xFFE65100);
        defaultIcon = Icons.warning_amber_rounded;
        break;
      case 'danger':
      case 'infected':
      case 'urgent':
        bg = const Color(0xFFFFEBEE);
        fg = AppColors.healthDanger;
        defaultIcon = Icons.error_outline_rounded;
        break;
      default:
        bg = const Color(0xFFE3F2FD);
        fg = AppColors.infoBlue;
        defaultIcon = Icons.info_outline_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: fg.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? defaultIcon, size: 13, color: fg),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
