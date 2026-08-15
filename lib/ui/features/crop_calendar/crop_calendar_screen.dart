import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/crop_model.dart';
import '../../../providers/crop_provider.dart';
import '../../widgets/empty_state_view.dart';
import '../../widgets/status_badge.dart';
import 'add_crop_dialog.dart';

class CropCalendarScreen extends StatefulWidget {
  const CropCalendarScreen({super.key});

  @override
  State<CropCalendarScreen> createState() => _CropCalendarScreenState();
}

class _CropCalendarScreenState extends State<CropCalendarScreen> {
  int _selectedCropIndex = 0;

  void _openAddCropModal() {
    showDialog(
      context: context,
      builder: (ctx) => const AddCropDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final cropProv = Provider.of<CropProvider>(context);
    final isHindi = langProv.isHindi;
    final theme = Theme.of(context);

    final crops = cropProv.crops;

    if (crops.isEmpty) {
      return Scaffold(
        body: EmptyStateView(
          title: isHindi ? 'कोई फसल पंजीकृत नहीं है' : 'No Active Crops Registered',
          message: isHindi
              ? 'फसल विकास कैलेंडर शुरू करने के लिए अपनी पहली फसल जोड़ें।'
              : 'Add your first crop to begin stage tracking and schedule reminders.',
          icon: Icons.calendar_month_rounded,
          actionLabel: l10n.addNewCrop,
          onAction: _openAddCropModal,
        ),
      );
    }

    if (_selectedCropIndex >= crops.length) {
      _selectedCropIndex = 0;
    }
    final currentCrop = crops[_selectedCropIndex];

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Header & Add Crop Action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.calendarHeaderTitle,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    Text(
                      l10n.calendarHeaderSubtitle,
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
              ElevatedButton.icon(
                onPressed: _openAddCropModal,
                icon: const Icon(Icons.add_rounded, size: 16),
                label: Text(l10n.addNewCrop, style: const TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Crop Selector Carousel
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: crops.asMap().entries.map((entry) {
                final idx = entry.key;
                final crop = entry.value;
                final isSelected = idx == _selectedCropIndex;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    avatar: Icon(
                      Icons.grass_rounded,
                      size: 16,
                      color: isSelected ? Colors.white : AppColors.primaryGreen,
                    ),
                    label: Text(
                      isHindi ? crop.nameHi : crop.nameEn,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: isSelected ? Colors.white : null,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: AppColors.primaryDarkGreen,
                    onSelected: (val) {
                      if (val) {
                        setState(() {
                          _selectedCropIndex = idx;
                        });
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),

          // Active Crop Main Card
          _buildCropTimelineCard(currentCrop, isHindi, l10n, theme),
          const SizedBox(height: 16),

          // Upcoming Tasks Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.upcomingTasks,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.greenSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${currentCrop.tasks.where((t) => t.isCompleted).length}/${currentCrop.tasks.length} Done',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDarkGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          if (currentCrop.tasks.isEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  isHindi ? 'कोई लंबित कार्य नहीं है।' : 'No upcoming tasks scheduled.',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
          else
            ...currentCrop.tasks.map(
              (task) => _buildTaskItem(currentCrop.id, task, isHindi, cropProv, theme),
            ),
          const SizedBox(height: 16),

          // Regional Weather Advisory for Sonpur
          _buildWeatherAdvisoryCard(isHindi, theme),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCropTimelineCard(
    CropModel crop,
    bool isHindi,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.borderLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? crop.nameHi : crop.nameEn,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        '${crop.fieldSize} ${crop.fieldUnit} • ${crop.variety}',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.brightness == Brightness.dark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  label: isHindi ? 'उत्तम स्वास्थ्य' : 'Healthy Vigor',
                  status: crop.healthStatus,
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Current Stage Highlight
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.greenSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryLightGreen.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology_alt_rounded, size: 18, color: AppColors.primaryDarkGreen),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${isHindi ? "वर्तमान चरण" : "Current Stage"}: ${isHindi ? crop.currentStageHi : crop.currentStageEn}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryDarkGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${crop.daysSinceSowing} ${isHindi ? "दिन बीते" : "Days Passed"}',
                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
                ),
                Text(
                  '${crop.daysToHarvest} ${isHindi ? "दिन शेष" : "Days to Harvest"}',
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.harvestGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: crop.progress.clamp(0.0, 1.0),
                minHeight: 10,
                backgroundColor: AppColors.greenSurface,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
              ),
            ),
            const SizedBox(height: 14),

            // Sowing vs Harvest dates
            Row(
              children: [
                Expanded(
                  child: _buildDatePill(
                    icon: Icons.calendar_today_rounded,
                    title: l10n.sowingDate,
                    date: dateFormat.format(crop.sowingDate),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDatePill(
                    icon: Icons.event_available_rounded,
                    title: l10n.expectedHarvest,
                    date: dateFormat.format(crop.expectedHarvestDate),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePill({
    required IconData icon,
    required String title,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 10, color: AppColors.textSecondaryLight)),
          const SizedBox(height: 2),
          Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(
    String cropId,
    CropTask task,
    bool isHindi,
    CropProvider cropProv,
    ThemeData theme,
  ) {
    final dueFormatted = DateFormat('dd MMM').format(task.dueDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: task.isCompleted
              ? AppColors.primaryLightGreen.withValues(alpha: 0.5)
              : AppColors.borderLight,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: IconButton(
          icon: Icon(
            task.isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            color: task.isCompleted ? AppColors.primaryGreen : Colors.grey,
            size: 24,
          ),
          onPressed: () {
            cropProv.toggleTask(cropId, task.id, !task.isCompleted);
          },
        ),
        title: Text(
          isHindi ? task.titleHi : task.titleEn,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          isHindi ? task.descriptionHi : task.descriptionEn,
          style: TextStyle(
            fontSize: 11.5,
            color: theme.brightness == Brightness.dark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: task.isCompleted ? AppColors.greenSurface : const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            dueFormatted,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: task.isCompleted ? AppColors.primaryDarkGreen : Colors.deepOrange,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherAdvisoryCard(bool isHindi, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBDD7FE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.cloud_sync_rounded, color: AppColors.infoBlue, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isHindi ? 'सोनपुर कृषि मौसम परामर्श' : 'Sonpur Agro-Weather Advisory',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0D47A1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isHindi
                      ? 'तापमान 26°C, आर्द्रता 62%। आगामी 2 दिनों में हल्की पछुआ हवा चलने का अनुमान है। गेहूं में सुबह के समय हल्की सिंचाई अनुकूल रहेगी।'
                      : 'Temp: 26°C, Humidity: 62%. Mild westerly breeze expected. Ideal time for early morning light irrigation in wheat.',
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF1565C0),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
