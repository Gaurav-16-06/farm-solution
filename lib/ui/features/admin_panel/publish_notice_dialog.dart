import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/admin_provider.dart';

class PublishNoticeDialog extends StatefulWidget {
  const PublishNoticeDialog({super.key});

  @override
  State<PublishNoticeDialog> createState() => _PublishNoticeDialogState();
}

class _PublishNoticeDialogState extends State<PublishNoticeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleEnController = TextEditingController();
  final _titleHiController = TextEditingController();
  final _contentEnController = TextEditingController();
  final _contentHiController = TextEditingController();
  String _category = 'subsidy';
  bool _isUrgent = false;

  @override
  void dispose() {
    _titleEnController.dispose();
    _titleHiController.dispose();
    _contentEnController.dispose();
    _contentHiController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final adminProv = Provider.of<AdminProvider>(context, listen: false);
    adminProv.publishNotice(
      titleEn: _titleEnController.text,
      titleHi: _titleHiController.text.isNotEmpty ? _titleHiController.text : _titleEnController.text,
      contentEn: _contentEnController.text,
      contentHi: _contentHiController.text.isNotEmpty ? _contentHiController.text : _contentEnController.text,
      category: _category,
      author: 'Sonpur Sewa Samiti Admin',
      isUrgent: _isUrgent,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final langProv = Provider.of<LanguageProvider>(context);
    final isHindi = langProv.isHindi;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.broadcastNotice,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryDarkGreen,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),

                // Category
                const Text('Category / श्रेणी', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _category,
                  decoration: const InputDecoration(),
                  items: [
                    DropdownMenuItem(value: 'subsidy', child: Text(isHindi ? 'खाद/सब्सिडी आवंटन' : 'Subsidy / Stock Allocation')),
                    DropdownMenuItem(value: 'weather', child: Text(isHindi ? 'मौसम चेतावनी' : 'Weather Warning')),
                    DropdownMenuItem(value: 'advisory', child: Text(isHindi ? 'कृषि परामर्श' : 'Crop Advisory')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _category = v);
                  },
                ),
                const SizedBox(height: 12),

                // Title Hindi / English
                Text(
                  isHindi ? 'सूचना शीर्षक (हिंदी)' : 'Notice Title (English)',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: isHindi ? _titleHiController : _titleEnController,
                  decoration: InputDecoration(
                    hintText: isHindi ? 'उदा: यूरिया की नई खेप उपलब्ध' : 'e.g. Fresh Urea Stock Available',
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Content
                Text(
                  isHindi ? 'सूचना का विवरण' : 'Notice Details & Instructions',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: isHindi ? _contentHiController : _contentEnController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: isHindi
                        ? 'समस्त किसान भाइयों को सूचित किया जाता है कि...'
                        : 'All registered members are informed that...',
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Urgent Switch
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    isHindi ? 'आपातकालीन सूचना (SMS अलर्ट भेजें)' : 'High Priority SMS Alert',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  value: _isUrgent,
                  activeColor: AppColors.healthDanger,
                  onChanged: (val) => setState(() => _isUrgent = val),
                ),
                const SizedBox(height: 16),

                // Publish
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.send_rounded, size: 18),
                    label: Text(l10n.publishNotice),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
