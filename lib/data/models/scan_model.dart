import 'product_model.dart';

class ScanModel {
  final String id;
  final String cropNameEn;
  final String cropNameHi;
  final String diseaseNameEn;
  final String diseaseNameHi;
  final double confidenceScore;
  final bool isHealthy;
  final String symptomsEn;
  final String symptomsHi;
  final String chemicalRemedyEn;
  final String chemicalRemedyHi;
  final String organicRemedyEn;
  final String organicRemedyHi;
  final String preventionEn;
  final String preventionHi;
  final DateTime scanDate;
  final String imageUrl;

  // Shriram Fertilizers & Chemicals mapping
  final String shriramProductId;
  final String shriramProductName;
  final String dosagePerAcreEn;
  final String dosagePerAcreHi;
  ProductModel? matchedProduct;

  ScanModel({
    required this.id,
    required this.cropNameEn,
    required this.cropNameHi,
    required this.diseaseNameEn,
    required this.diseaseNameHi,
    required this.confidenceScore,
    required this.isHealthy,
    required this.symptomsEn,
    required this.symptomsHi,
    required this.chemicalRemedyEn,
    required this.chemicalRemedyHi,
    required this.organicRemedyEn,
    required this.organicRemedyHi,
    required this.preventionEn,
    required this.preventionHi,
    required this.scanDate,
    this.imageUrl = '',
    this.shriramProductId = '',
    this.shriramProductName = '',
    this.dosagePerAcreEn = '',
    this.dosagePerAcreHi = '',
    this.matchedProduct,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'cropNameEn': cropNameEn,
    'cropNameHi': cropNameHi,
    'diseaseNameEn': diseaseNameEn,
    'diseaseNameHi': diseaseNameHi,
    'confidenceScore': confidenceScore,
    'isHealthy': isHealthy,
    'symptomsEn': symptomsEn,
    'symptomsHi': symptomsHi,
    'chemicalRemedyEn': chemicalRemedyEn,
    'chemicalRemedyHi': chemicalRemedyHi,
    'organicRemedyEn': organicRemedyEn,
    'organicRemedyHi': organicRemedyHi,
    'preventionEn': preventionEn,
    'preventionHi': preventionHi,
    'scanDate': scanDate.toIso8601String(),
    'imageUrl': imageUrl,
    'shriramProductId': shriramProductId,
    'shriramProductName': shriramProductName,
    'dosagePerAcreEn': dosagePerAcreEn,
    'dosagePerAcreHi': dosagePerAcreHi,
    'matchedProduct': matchedProduct?.toJson(),
  };

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
    id: json['id'] as String,
    cropNameEn: json['cropNameEn'] as String,
    cropNameHi: json['cropNameHi'] as String,
    diseaseNameEn: json['diseaseNameEn'] as String,
    diseaseNameHi: json['diseaseNameHi'] as String,
    confidenceScore: (json['confidenceScore'] as num).toDouble(),
    isHealthy: json['isHealthy'] as bool? ?? false,
    symptomsEn: json['symptomsEn'] as String? ?? '',
    symptomsHi: json['symptomsHi'] as String? ?? '',
    chemicalRemedyEn: json['chemicalRemedyEn'] as String? ?? '',
    chemicalRemedyHi: json['chemicalRemedyHi'] as String? ?? '',
    organicRemedyEn: json['organicRemedyEn'] as String? ?? '',
    organicRemedyHi: json['organicRemedyHi'] as String? ?? '',
    preventionEn: json['preventionEn'] as String? ?? '',
    preventionHi: json['preventionHi'] as String? ?? '',
    scanDate: DateTime.parse(json['scanDate'] as String),
    imageUrl: json['imageUrl'] as String? ?? '',
    shriramProductId: json['shriramProductId'] as String? ?? '',
    shriramProductName: json['shriramProductName'] as String? ?? '',
    dosagePerAcreEn: json['dosagePerAcreEn'] as String? ?? '',
    dosagePerAcreHi: json['dosagePerAcreHi'] as String? ?? '',
    matchedProduct: json['matchedProduct'] != null
        ? ProductModel.fromJson(json['matchedProduct'] as Map<String, dynamic>)
        : null,
  );
}
