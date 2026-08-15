import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/scan_model.dart';
import '../../../providers/scan_provider.dart';
import '../../../providers/store_provider.dart';
import '../../widgets/shop_contact_card.dart';
import '../../widgets/status_badge.dart';
import 'scan_result_detail_modal.dart';

class ScanDiagnoseScreen extends StatefulWidget {
  const ScanDiagnoseScreen({super.key});

  @override
  State<ScanDiagnoseScreen> createState() => _ScanDiagnoseScreenState();
}

class _ScanDiagnoseScreenState extends State<ScanDiagnoseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scanLineAnimation;
  bool _isFlashOn = false;
  String _selectedSampleKey = 'wheat_rust';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<double>(begin: 0.1, end: 0.9).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _showScanDetails(BuildContext context, ScanModel scan, bool isHindi) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ScanResultDetailModal(scan: scan, isHindi: isHindi),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final scanProv = Provider.of<ScanProvider>(context);
    final theme = Theme.of(context);
    final isHindi = langProv.isHindi;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Shop Storefront & Contact Card
          ShopContactCard(isHindi: isHindi),
          const SizedBox(height: 14),

          // Gemini Vision AI Banner Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryDarkGreen.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.document_scanner_rounded,
                    color: AppColors.harvestGold,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            l10n.scanHeaderTitle,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.harvestGold,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Gemini Vision',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isHindi
                            ? 'पत्ती स्कैन कर पाएं रोग पहचान एवं श्रीराम फर्टिलाइजर्स का सटीक उपचार'
                            : 'AI disease detection mapped to Shriram Fertilizers & Chemicals',
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

          // Interactive Viewfinder Card
          Container(
            height: 230,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: scanProv.isScanning
                    ? AppColors.primaryLightGreen
                    : AppColors.primaryGreen.withValues(alpha: 0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Viewfinder background leaf illustration & grid
                Center(
                  child: Opacity(
                    opacity: 0.6,
                    child: Icon(
                      _selectedSampleKey == 'paddy_healthy'
                          ? Icons.eco_rounded
                          : Icons.coronavirus_rounded,
                      size: 110,
                      color: _selectedSampleKey == 'paddy_healthy'
                          ? AppColors.primaryLightGreen
                          : AppColors.harvestGold,
                    ),
                  ),
                ),

                // Grid Overlay
                Positioned.fill(
                  child: CustomPaint(
                    painter: _ViewfinderGridPainter(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                ),

                // Animated Scan Line when scanning
                if (scanProv.isScanning)
                  AnimatedBuilder(
                    animation: _scanLineAnimation,
                    builder: (context, child) {
                      return Align(
                        alignment: Alignment(0, (_scanLineAnimation.value * 2) - 1),
                        child: Container(
                          height: 3,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.transparent,
                                AppColors.primaryLightGreen,
                                Colors.white,
                                AppColors.primaryLightGreen,
                                Colors.transparent,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryLightGreen.withValues(alpha: 0.8),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                // Viewfinder Corner Brackets
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: CustomPaint(
                      painter: _CornerBracketPainter(
                        color: scanProv.isScanning
                            ? AppColors.primaryLightGreen
                            : Colors.white70,
                      ),
                    ),
                  ),
                ),

                // Camera Top Bar Controls
                Positioned(
                  top: 12,
                  left: 12,
                  right: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: scanProv.isScanning ? Colors.red : Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              scanProv.isScanning ? 'GEMINI VISION ANALYZING' : 'VISION CAMERA ACTIVE',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                              color: _isFlashOn ? AppColors.harvestGold : Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _isFlashOn = !_isFlashOn;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.cameraswitch_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Switched to High-Resolution Optical Macro Sensor'),
                                  duration: Duration(milliseconds: 900),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Scanning Progress Overlay
                if (scanProv.isScanning)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primaryLightGreen,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              scanProv.scanningStatusText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Sample Selector Chips
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.scanSampleTitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    isHindi ? '1-क्लिक टेस्ट' : '1-Tap Demo',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildSampleChip(
                      key: 'wheat_rust',
                      labelEn: 'Wheat Yellow Rust',
                      labelHi: 'गेहूं पीला रतुआ',
                      icon: Icons.grain_rounded,
                      color: Colors.amber.shade800,
                    ),
                    _buildSampleChip(
                      key: 'potato_blight',
                      labelEn: 'Potato Late Blight',
                      labelHi: 'आलू झुलसा रोग',
                      icon: Icons.spa_rounded,
                      color: Colors.brown,
                    ),
                    _buildSampleChip(
                      key: 'mustard_aphid',
                      labelEn: 'Mustard Aphids',
                      labelHi: 'सरसों माहू कीट',
                      icon: Icons.bug_report_rounded,
                      color: Colors.deepOrange,
                    ),
                    _buildSampleChip(
                      key: 'paddy_healthy',
                      labelEn: 'Healthy Paddy',
                      labelHi: 'स्वस्थ धान पत्ती',
                      icon: Icons.verified_rounded,
                      color: AppColors.primaryGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Action Scan Buttons
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ElevatedButton.icon(
                  onPressed: scanProv.isScanning
                      ? null
                      : () {
                          scanProv.runDiagnosis(_selectedSampleKey, isHindi: isHindi);
                        },
                  icon: const Icon(Icons.camera_alt_rounded, size: 20),
                  label: Text(l10n.scanButton),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: OutlinedButton.icon(
                  onPressed: scanProv.isScanning
                      ? null
                      : () {
                          scanProv.runDiagnosis(_selectedSampleKey, isHindi: isHindi);
                        },
                  icon: const Icon(Icons.photo_library_rounded, size: 18),
                  label: Text(l10n.scanGalleryButton),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Latest Scan Result Card (if any)
          if (scanProv.currentResult != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.scanResultHeading,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.greenSurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Shriram Prescribed',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDarkGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildResultCard(context, scanProv.currentResult!, isHindi, l10n),
            const SizedBox(height: 18),
          ],

          // History Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.scanHistoryTitle,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
              Text(
                '${scanProv.scans.length} Records',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.brightness == Brightness.dark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          ...scanProv.scans.map(
            (s) => _buildHistoryItem(context, s, isHindi, theme),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSampleChip({
    required String key,
    required String labelEn,
    required String labelHi,
    required IconData icon,
    required Color color,
  }) {
    final langProv = Provider.of<LanguageProvider>(context);
    final isSelected = _selectedSampleKey == key;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        avatar: Icon(icon, size: 16, color: isSelected ? Colors.white : color),
        label: Text(langProv.isHindi ? labelHi : labelEn),
        selected: isSelected,
        selectedColor: AppColors.primaryGreen,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : null,
        ),
        onSelected: (val) {
          setState(() {
            _selectedSampleKey = key;
          });
        },
      ),
    );
  }

  Widget _buildResultCard(
    BuildContext context,
    ScanModel scan,
    bool isHindi,
    AppLocalizations l10n,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: scan.isHealthy
              ? AppColors.primaryLightGreen
              : AppColors.healthDanger.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? scan.cropNameHi : scan.cropNameEn,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      Text(
                        isHindi ? scan.diseaseNameHi : scan.diseaseNameEn,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(
                  label: scan.isHealthy ? l10n.scanStatusHealthy : l10n.scanStatusInfected,
                  status: scan.isHealthy ? 'healthy' : 'danger',
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Shriram Treatment Banner
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.greenSurface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.medication_rounded, size: 16, color: AppColors.primaryDarkGreen),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      isHindi
                          ? 'श्रीराम उपचार: ${scan.shriramProductName}'
                          : 'Shriram Prescription: ${scan.shriramProductName}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDarkGreen,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            Text(
              isHindi ? scan.symptomsHi : scan.symptomsEn,
              style: const TextStyle(fontSize: 12.5),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Divider(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.auto_awesome_rounded, size: 16, color: AppColors.primaryGreen),
                    const SizedBox(width: 4),
                    Text(
                      '${(scan.confidenceScore * 100).toStringAsFixed(0)}% Gemini Match',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () => _showScanDetails(context, scan, isHindi),
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                  label: Text(l10n.viewDetails),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    ScanModel scan,
    bool isHindi,
    ThemeData theme,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        onTap: () => _showScanDetails(context, scan, isHindi),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: scan.isHealthy ? AppColors.greenSurface : const Color(0xFFFFEBEE),
            shape: BoxShape.circle,
          ),
          child: Icon(
            scan.isHealthy ? Icons.eco_rounded : Icons.coronavirus_rounded,
            color: scan.isHealthy ? AppColors.primaryGreen : AppColors.healthDanger,
            size: 22,
          ),
        ),
        title: Text(
          isHindi ? scan.diseaseNameHi : scan.diseaseNameEn,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${isHindi ? scan.cropNameHi : scan.cropNameEn} • ${(scan.confidenceScore * 100).toStringAsFixed(0)}% Gemini AI Match',
          style: const TextStyle(fontSize: 11),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      ),
    );
  }
}

class _ViewfinderGridPainter extends CustomPainter {
  final Color color;
  _ViewfinderGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    const int divisions = 3;
    for (int i = 1; i < divisions; i++) {
      final x = size.width * (i / divisions);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
      final y = size.height * (i / divisions);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CornerBracketPainter extends CustomPainter {
  final Color color;
  _CornerBracketPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double len = 20.0;

    // Top-left
    canvas.drawLine(const Offset(0, 0), const Offset(len, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, len), paint);

    // Top-right
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - len, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, len), paint);

    // Bottom-left
    canvas.drawLine(Offset(0, size.height), Offset(len, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - len), paint);

    // Bottom-right
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - len, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - len), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
