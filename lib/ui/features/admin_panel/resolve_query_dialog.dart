import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/farmer_query_model.dart';
import '../../../providers/admin_provider.dart';

class ResolveQueryDialog extends StatefulWidget {
  final FarmerQueryModel query;

  const ResolveQueryDialog({super.key, required this.query});

  @override
  State<ResolveQueryDialog> createState() => _ResolveQueryDialogState();
}

class _ResolveQueryDialogState extends State<ResolveQueryDialog> {
  final _responseController = TextEditingController();

  @override
  void dispose() {
    _responseController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_responseController.text.trim().isEmpty) return;

    final adminProv = Provider.of<AdminProvider>(context, listen: false);
    adminProv.resolveQuery(
      queryId: widget.query.id,
      responseEn: _responseController.text,
      responseHi: _responseController.text,
      expertName: 'Dr. S. K. Mishra (Senior Agronomist, Samiti)',
    );

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Expert agronomy response published to farmer profile.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langProv = Provider.of<LanguageProvider>(context);
    final isHindi = langProv.isHindi;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isHindi ? 'किसान परामर्श समाधान' : 'Agronomy Query Resolution',
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
              const SizedBox(height: 8),

              // Farmer metadata
              Text(
                '${widget.query.farmerName} • ${widget.query.village}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                'Crop: ${widget.query.cropName}',
                style: const TextStyle(fontSize: 11.5, color: AppColors.primaryGreen, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),

              // Question Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.bgLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Text(
                  isHindi ? widget.query.questionHi : widget.query.questionEn,
                  style: const TextStyle(fontSize: 12.5, height: 1.3),
                ),
              ),
              const SizedBox(height: 14),

              // Expert Response Input
              Text(
                isHindi ? 'विशेषज्ञ सलाह / समाधान लिखें' : 'Expert Advice / Remedy',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _responseController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: isHindi
                      ? 'दवा का नाम, छिड़काव की सही मात्रा एवं सावधानियां लिखें...'
                      : 'Prescribe medicine dosage, foliar ratio and best practices...',
                ),
              ),
              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _submit(context),
                  icon: const Icon(Icons.check_rounded, size: 18),
                  label: Text(isHindi ? 'सलाह भेजें' : 'Submit Expert Response'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
