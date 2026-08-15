import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/crop_model.dart';
import '../../../providers/crop_provider.dart';

class AddCropDialog extends StatefulWidget {
  const AddCropDialog({super.key});

  @override
  State<AddCropDialog> createState() => _AddCropDialogState();
}

class _AddCropDialogState extends State<AddCropDialog> {
  final _formKey = GlobalKey<FormState>();

  String _selectedCropType = 'wheat';
  final _varietyController = TextEditingController(text: 'HD-2967 High Yield');
  final _fieldSizeController = TextEditingController(text: '2.0');
  String _selectedUnit = 'Acre';
  DateTime _selectedDate = DateTime.now().subtract(const Duration(days: 15));

  final Map<String, Map<String, dynamic>> _cropPresets = {
    'wheat': {
      'nameEn': 'Wheat',
      'nameHi': 'गेहूं',
      'variety': 'HD-2967 / DBW-187',
      'duration': 120,
      'stageEn': 'Crown Root & Early Tillering',
      'stageHi': 'जड़ विकास एवं प्रारंभिक कल्ले',
      'tasks': [
        {
          'titleEn': 'First Crown Root Irrigation',
          'titleHi': 'पहली मुख्य जड़ सिंचाई (21 दिन)',
          'descEn': 'Apply first light irrigation 20-25 days after sowing.',
          'descHi': 'बुवाई के 20-25 दिन बाद पहली हल्की सिंचाई करें।',
          'days': 6,
          'cat': 'irrigation',
        },
        {
          'titleEn': 'First Top Dressing Urea (45 kg/acre)',
          'titleHi': 'यूरिया का पहला छिड़काव (45 किग्रा)',
          'descEn': 'Apply 1/3 dose of nitrogen after first irrigation.',
          'descHi': 'पहली सिंचाई के बाद एक तिहाई यूरिया डालें।',
          'days': 8,
          'cat': 'fertilizer',
        },
      ],
    },
    'paddy': {
      'nameEn': 'Paddy / Rice',
      'nameHi': 'धान',
      'variety': 'Swarna Sub-1 / Sambha',
      'duration': 135,
      'stageEn': 'Transplanting & Nursery Settling',
      'stageHi': 'रोपाई एवं कल्ले फूटना',
      'tasks': [
        {
          'titleEn': 'Apply Zinc Sulphate 21% (10 kg/acre)',
          'titleHi': 'जिंक सल्फेट 21% (10 किग्रा) डालें',
          'descEn': 'Prevents Khaira deficiency in rice seedlings.',
          'descHi': 'धान में खैरा रोग से बचाव हेतु।',
          'days': 5,
          'cat': 'fertilizer',
        },
      ],
    },
    'mustard': {
      'nameEn': 'Mustard',
      'nameHi': 'सरसों',
      'variety': 'Pusa Jai Kisan (Bio-902)',
      'duration': 105,
      'stageEn': 'Vegetative Branching',
      'stageHi': 'शाखाएं निकलना',
      'tasks': [
        {
          'titleEn': 'Thinning and Weeding',
          'titleHi': 'विरलीकरण व निराई-गुड़ाई',
          'descEn': 'Maintain 10-15 cm spacing between plants.',
          'descHi': 'पौधों के बीच 10-15 सेमी की दूरी रखें।',
          'days': 4,
          'cat': 'weeding',
        },
      ],
    },
    'potato': {
      'nameEn': 'Potato',
      'nameHi': 'आलू',
      'variety': 'Kufri Pukhraj / Jyoti',
      'duration': 90,
      'stageEn': 'Stolon Formation & Tuber Initiation',
      'stageHi': 'कंद बनना व वृद्धि',
      'tasks': [
        {
          'titleEn': 'Earthing Up (Mitti Chadhana)',
          'titleHi': 'पौधों पर मिट्टी चढ़ाना',
          'descEn': 'Cover developing tubers to prevent greening.',
          'descHi': 'कंदों को धूप से बचाने हेतु मिट्टी चढ़ाएं।',
          'days': 7,
          'cat': 'general',
        },
      ],
    },
  };

  @override
  void dispose() {
    _varietyController.dispose();
    _fieldSizeController.dispose();
    super.dispose();
  }

  void _onCropTypeChanged(String? val) {
    if (val != null) {
      setState(() {
        _selectedCropType = val;
        _varietyController.text = _cropPresets[val]?['variety'] ?? '';
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 180)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final preset = _cropPresets[_selectedCropType]!;
    final cropProv = Provider.of<CropProvider>(context, listen: false);

    final rawTasks = (preset['tasks'] as List<dynamic>?) ?? [];
    final List<CropTask> tasks = rawTasks.map((t) {
      return CropTask(
        id: 'task_${DateTime.now().millisecondsSinceEpoch}_${t['days']}',
        titleEn: t['titleEn'] as String,
        titleHi: t['titleHi'] as String,
        descriptionEn: t['descEn'] as String,
        descriptionHi: t['descHi'] as String,
        dueDate: _selectedDate.add(Duration(days: t['days'] as int)),
        category: t['cat'] as String,
      );
    }).toList();

    cropProv.addCrop(
      nameEn: '${preset['nameEn']} (${_varietyController.text})',
      nameHi: '${preset['nameHi']} (${_varietyController.text})',
      variety: _varietyController.text,
      fieldSize: double.tryParse(_fieldSizeController.text) ?? 1.0,
      fieldUnit: _selectedUnit,
      sowingDate: _selectedDate,
      durationDays: preset['duration'] as int,
      initialStageEn: preset['stageEn'] as String,
      initialStageHi: preset['stageHi'] as String,
      defaultTasks: tasks,
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
                      l10n.addNewCrop,
                      style: const TextStyle(
                        fontSize: 18,
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

                // Crop Type Selector
                Text(
                  l10n.selectCrop,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedCropType,
                  decoration: const InputDecoration(),
                  items: _cropPresets.entries.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(
                        isHindi ? e.value['nameHi'] as String : e.value['nameEn'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                  onChanged: _onCropTypeChanged,
                ),
                const SizedBox(height: 12),

                // Variety
                const Text(
                  'Crop Variety / बीज की किस्म',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _varietyController,
                  decoration: const InputDecoration(
                    hintText: 'e.g. HD-2967, PBW-550',
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                // Field Size & Unit
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.landArea,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _fieldSizeController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(hintText: '2.5'),
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.landUnit,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: _selectedUnit,
                            decoration: const InputDecoration(),
                            items: ['Acre', 'Bigha', 'Hectare', 'Kattha'].map((u) {
                              return DropdownMenuItem<String>(
                                value: u,
                                child: Text(u, style: const TextStyle(fontSize: 13)),
                              );
                            }).toList(),
                            onChanged: (v) {
                              if (v != null) setState(() => _selectedUnit = v);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Sowing Date
                Text(
                  l10n.sowingDate,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderLight),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(_selectedDate),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.primaryGreen),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(l10n.save),
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
