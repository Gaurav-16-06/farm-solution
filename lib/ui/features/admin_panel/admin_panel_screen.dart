import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/farmer_query_model.dart';
import '../../../data/models/notice_model.dart';
import '../../../providers/admin_provider.dart';
import '../../../providers/store_provider.dart';
import '../../widgets/stat_summary_card.dart';
import '../../widgets/status_badge.dart';
import 'publish_notice_dialog.dart';
import 'resolve_query_dialog.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  void _openPublishNoticeModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => const PublishNoticeDialog(),
    );
  }

  void _openResolveQueryModal(BuildContext context, FarmerQueryModel query) {
    showDialog(
      context: context,
      builder: (ctx) => ResolveQueryDialog(query: query),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final adminProv = Provider.of<AdminProvider>(context);
    final storeProv = Provider.of<StoreProvider>(context);
    final isHindi = langProv.isHindi;
    final theme = Theme.of(context);
    final stats = adminProv.stats;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
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
                  child: const Icon(Icons.admin_panel_settings_rounded, color: AppColors.harvestGold, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.adminHeaderTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.adminHeaderSubtitle,
                        style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.9)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // KPI Stat Cards Grid
          Row(
            children: [
              Expanded(
                child: StatSummaryCard(
                  title: l10n.totalFarmers,
                  value: '${stats.registeredFarmers}',
                  subtitle: isHindi ? 'सक्रिय सदस्य' : 'Active Members',
                  icon: Icons.groups_rounded,
                  color: AppColors.primaryGreen,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatSummaryCard(
                  title: l10n.pendingQueries,
                  value: '${stats.pendingSupportQueries}',
                  subtitle: isHindi ? 'शीघ्र समाधान आवश्यक' : 'Needs Attention',
                  icon: Icons.contact_support_rounded,
                  color: stats.pendingSupportQueries > 0 ? Colors.deepOrange : AppColors.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: StatSummaryCard(
                  title: l10n.ureaInStock,
                  value: '${stats.ureaBagsStock} Bags',
                  subtitle: isHindi ? 'गोदाम स्टॉक' : 'Warehouse Stock',
                  icon: Icons.inventory_2_rounded,
                  color: AppColors.soilBrown,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatSummaryCard(
                  title: l10n.dapInStock,
                  value: '${stats.dapBagsStock} Bags',
                  subtitle: isHindi ? 'गोदाम स्टॉक' : 'Warehouse Stock',
                  icon: Icons.grain_rounded,
                  color: AppColors.infoBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Quick Stock Controller
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.stockManager,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                      const Icon(Icons.tune_rounded, size: 18, color: AppColors.primaryGreen),
                    ],
                  ),
                  const Divider(height: 16),

                  // Urea Stock Controls
                  _buildStockControlRow(
                    label: isHindi ? 'नीम लेपित यूरिया (Urea)' : 'Neem Coated Urea',
                    currentStock: stats.ureaBagsStock,
                    onAdd: () async {
                      await storeProv.updateProductStock('prod_001', 50);
                      adminProv.loadAdminData();
                    },
                    onDeduct: () async {
                      await storeProv.updateProductStock('prod_001', -50);
                      adminProv.loadAdminData();
                    },
                  ),
                  const SizedBox(height: 10),

                  // DAP Stock Controls
                  _buildStockControlRow(
                    label: isHindi ? 'डीएपी 18-46-0 (DAP)' : 'DAP 18-46-0',
                    currentStock: stats.dapBagsStock,
                    onAdd: () async {
                      await storeProv.updateProductStock('prod_002', 50);
                      adminProv.loadAdminData();
                    },
                    onDeduct: () async {
                      await storeProv.updateProductStock('prod_002', -50);
                      adminProv.loadAdminData();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Notices Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.recentNotices,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              ElevatedButton.icon(
                onPressed: () => _openPublishNoticeModal(context),
                icon: const Icon(Icons.campaign_rounded, size: 16),
                label: Text(l10n.broadcastNotice, style: const TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          ...adminProv.notices.map((notice) => _buildNoticeCard(notice, isHindi, theme)),
          const SizedBox(height: 16),

          // Farmer Queries Section
          Text(
            l10n.farmerQueries,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),

          ...adminProv.queries.map(
            (q) => _buildQueryCard(context, q, isHindi, theme, l10n),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStockControlRow({
    required String label,
    required int currentStock,
    required VoidCallback onAdd,
    required VoidCallback onDeduct,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
              Text('$currentStock Bags available', style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: onDeduct,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                minimumSize: const Size(36, 32),
              ),
              child: const Text('-50'),
            ),
            const SizedBox(width: 6),
            ElevatedButton(
              onPressed: onAdd,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                minimumSize: const Size(36, 32),
              ),
              child: const Text('+50'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoticeCard(NoticeModel notice, bool isHindi, ThemeData theme) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isHindi ? notice.titleHi : notice.titleEn,
                    style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800),
                  ),
                ),
                StatusBadge(
                  label: notice.isUrgent
                      ? (isHindi ? 'आपातकालीन' : 'Urgent Alert')
                      : (isHindi ? 'सामान्य' : 'Info'),
                  status: notice.isUrgent ? 'danger' : 'info',
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              isHindi ? notice.contentHi : notice.contentEn,
              style: TextStyle(
                fontSize: 12,
                color: theme.brightness == Brightness.dark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  notice.author,
                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
                ),
                Text(
                  dateFormat.format(notice.publishedDate),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueryCard(
    BuildContext context,
    FarmerQueryModel query,
    bool isHindi,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${query.farmerName} (${query.village})',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                ),
                StatusBadge(
                  label: query.isResolved ? (isHindi ? 'समाधान दिया' : 'Resolved') : (isHindi ? 'लंबित' : 'Pending'),
                  status: query.isResolved ? 'resolved' : 'warning',
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Crop: ${query.cropName}',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
            ),
            const SizedBox(height: 6),
            Text(
              isHindi ? query.questionHi : query.questionEn,
              style: const TextStyle(fontSize: 12),
            ),
            if (query.isResolved && query.responseEn != null) ...[
              const Divider(height: 14),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.greenSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${query.expertName ?? "Agronomist Response"}:',
                      style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: AppColors.primaryDarkGreen),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isHindi ? (query.responseHi ?? query.responseEn!) : query.responseEn!,
                      style: const TextStyle(fontSize: 11.5, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
            if (!query.isResolved) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: () => _openResolveQueryModal(context, query),
                  icon: const Icon(Icons.reply_rounded, size: 14),
                  label: Text(l10n.resolveQuery, style: const TextStyle(fontSize: 11)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    minimumSize: const Size(36, 28),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
