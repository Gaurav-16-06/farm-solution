import '../../core/services/firebase_service.dart';
import '../../core/services/hive_service.dart';
import '../models/crop_model.dart';

class CropRepository {
  final HiveService _hiveService;
  final FirebaseService _firebaseService;

  CropRepository({
    required HiveService hiveService,
    required FirebaseService firebaseService,
  })  : _hiveService = hiveService,
        _firebaseService = firebaseService;

  List<CropModel> getAllCrops() {
    final rawList = _hiveService.getList(HiveService.cropsBoxName);
    return rawList.map((json) => CropModel.fromJson(json)).toList();
  }

  Future<void> saveCrop(CropModel crop) async {
    await _hiveService.saveItem(HiveService.cropsBoxName, crop.id, crop.toJson());
    // Background cloud sync
    _firebaseService.firestore.syncToCloud('crops', crop.id, crop.toJson());
  }

  Future<void> updateTaskStatus(String cropId, String taskId, bool isCompleted) async {
    final rawList = _hiveService.getList(HiveService.cropsBoxName);
    for (final raw in rawList) {
      if (raw['id'] == cropId) {
        final crop = CropModel.fromJson(raw);
        for (final task in crop.tasks) {
          if (task.id == taskId) {
            task.isCompleted = isCompleted;
          }
        }
        await _hiveService.saveItem(HiveService.cropsBoxName, cropId, crop.toJson());
        _firebaseService.firestore.syncToCloud('crops', cropId, crop.toJson());
        break;
      }
    }
  }

  Future<void> deleteCrop(String cropId) async {
    await _hiveService.deleteItem(HiveService.cropsBoxName, cropId);
  }
}
