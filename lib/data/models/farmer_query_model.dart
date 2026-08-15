class FarmerQueryModel {
  final String id;
  final String farmerName;
  final String village;
  final String cropName;
  final String questionEn;
  final String questionHi;
  final String? responseEn;
  final String? responseHi;
  final String status; // 'pending', 'resolved'
  final DateTime createdAt;
  final String? expertName;

  FarmerQueryModel({
    required this.id,
    required this.farmerName,
    required this.village,
    required this.cropName,
    required this.questionEn,
    required this.questionHi,
    this.responseEn,
    this.responseHi,
    this.status = 'pending',
    required this.createdAt,
    this.expertName,
  });

  bool get isResolved => status == 'resolved';

  Map<String, dynamic> toJson() => {
    'id': id,
    'farmerName': farmerName,
    'village': village,
    'cropName': cropName,
    'questionEn': questionEn,
    'questionHi': questionHi,
    'responseEn': responseEn,
    'responseHi': responseHi,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'expertName': expertName,
  };

  factory FarmerQueryModel.fromJson(Map<String, dynamic> json) => FarmerQueryModel(
    id: json['id'] as String,
    farmerName: json['farmerName'] as String,
    village: json['village'] as String,
    cropName: json['cropName'] as String,
    questionEn: json['questionEn'] as String,
    questionHi: json['questionHi'] as String,
    responseEn: json['responseEn'] as String?,
    responseHi: json['responseHi'] as String?,
    status: json['status'] as String? ?? 'pending',
    createdAt: DateTime.parse(json['createdAt'] as String),
    expertName: json['expertName'] as String?,
  );
}
