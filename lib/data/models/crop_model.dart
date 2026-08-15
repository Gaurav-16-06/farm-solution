class CropTask {
  final String id;
  final String titleEn;
  final String titleHi;
  final String descriptionEn;
  final String descriptionHi;
  final DateTime dueDate;
  bool isCompleted;
  final String category; // 'irrigation', 'fertilizer', 'pesticide', 'weeding'

  CropTask({
    required this.id,
    required this.titleEn,
    required this.titleHi,
    required this.descriptionEn,
    required this.descriptionHi,
    required this.dueDate,
    this.isCompleted = false,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'titleEn': titleEn,
    'titleHi': titleHi,
    'descriptionEn': descriptionEn,
    'descriptionHi': descriptionHi,
    'dueDate': dueDate.toIso8601String(),
    'isCompleted': isCompleted,
    'category': category,
  };

  factory CropTask.fromJson(Map<String, dynamic> json) => CropTask(
    id: json['id'] as String,
    titleEn: json['titleEn'] as String,
    titleHi: json['titleHi'] as String,
    descriptionEn: json['descriptionEn'] as String,
    descriptionHi: json['descriptionHi'] as String,
    dueDate: DateTime.parse(json['dueDate'] as String),
    isCompleted: json['isCompleted'] as bool? ?? false,
    category: json['category'] as String? ?? 'general',
  );
}

class CropModel {
  final String id;
  final String nameEn;
  final String nameHi;
  final String variety;
  final double fieldSize;
  final String fieldUnit; // 'Acre', 'Bigha', 'Hectare'
  final DateTime sowingDate;
  final DateTime expectedHarvestDate;
  final String currentStageEn;
  final String currentStageHi;
  final double progress; // 0.0 to 1.0
  final String healthStatus; // 'healthy', 'warning', 'danger'
  final List<CropTask> tasks;
  final String notes;

  CropModel({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.variety,
    required this.fieldSize,
    required this.fieldUnit,
    required this.sowingDate,
    required this.expectedHarvestDate,
    required this.currentStageEn,
    required this.currentStageHi,
    required this.progress,
    this.healthStatus = 'healthy',
    required this.tasks,
    this.notes = '',
  });

  int get daysSinceSowing {
    final now = DateTime.now();
    return now.difference(sowingDate).inDays.clamp(0, 9999);
  }

  int get daysToHarvest {
    final now = DateTime.now();
    return expectedHarvestDate.difference(now).inDays.clamp(0, 9999);
  }

  int get totalDurationDays {
    return expectedHarvestDate.difference(sowingDate).inDays.clamp(1, 9999);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameEn': nameEn,
    'nameHi': nameHi,
    'variety': variety,
    'fieldSize': fieldSize,
    'fieldUnit': fieldUnit,
    'sowingDate': sowingDate.toIso8601String(),
    'expectedHarvestDate': expectedHarvestDate.toIso8601String(),
    'currentStageEn': currentStageEn,
    'currentStageHi': currentStageHi,
    'progress': progress,
    'healthStatus': healthStatus,
    'tasks': tasks.map((t) => t.toJson()).toList(),
    'notes': notes,
  };

  factory CropModel.fromJson(Map<String, dynamic> json) => CropModel(
    id: json['id'] as String,
    nameEn: json['nameEn'] as String,
    nameHi: json['nameHi'] as String,
    variety: json['variety'] as String,
    fieldSize: (json['fieldSize'] as num).toDouble(),
    fieldUnit: json['fieldUnit'] as String,
    sowingDate: DateTime.parse(json['sowingDate'] as String),
    expectedHarvestDate: DateTime.parse(json['expectedHarvestDate'] as String),
    currentStageEn: json['currentStageEn'] as String,
    currentStageHi: json['currentStageHi'] as String,
    progress: (json['progress'] as num).toDouble(),
    healthStatus: json['healthStatus'] as String? ?? 'healthy',
    tasks: (json['tasks'] as List<dynamic>?)
            ?.map((e) => CropTask.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    notes: json['notes'] as String? ?? '',
  );
}
