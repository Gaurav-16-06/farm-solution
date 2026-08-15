import 'package:flutter/material.dart';
import '../data/models/crop_model.dart';
import '../data/repositories/crop_repository.dart';

class CropProvider extends ChangeNotifier {
  final CropRepository _repository;
  List<CropModel> _crops = [];
  bool _isLoading = false;

  CropProvider(this._repository) {
    loadCrops();
  }

  List<CropModel> get crops => _crops;
  bool get isLoading => _isLoading;

  void loadCrops() {
    _isLoading = true;
    notifyListeners();
    try {
      _crops = _repository.getAllCrops();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCrop({
    required String nameEn,
    required String nameHi,
    required String variety,
    required double fieldSize,
    required String fieldUnit,
    required DateTime sowingDate,
    required int durationDays,
    required String initialStageEn,
    required String initialStageHi,
    required List<CropTask> defaultTasks,
  }) async {
    final harvestDate = sowingDate.add(Duration(days: durationDays));
    final newCrop = CropModel(
      id: 'crop_${DateTime.now().millisecondsSinceEpoch}',
      nameEn: nameEn,
      nameHi: nameHi,
      variety: variety,
      fieldSize: fieldSize,
      fieldUnit: fieldUnit,
      sowingDate: sowingDate,
      expectedHarvestDate: harvestDate,
      currentStageEn: initialStageEn,
      currentStageHi: initialStageHi,
      progress: 0.10,
      healthStatus: 'healthy',
      tasks: defaultTasks,
    );

    await _repository.saveCrop(newCrop);
    loadCrops();
  }

  Future<void> toggleTask(String cropId, String taskId, bool isCompleted) async {
    await _repository.updateTaskStatus(cropId, taskId, isCompleted);
    loadCrops();
  }

  Future<void> deleteCrop(String cropId) async {
    await _repository.deleteCrop(cropId);
    loadCrops();
  }
}
