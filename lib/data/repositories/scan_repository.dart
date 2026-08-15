import '../../core/services/firebase_service.dart';
import '../../core/services/gemini_vision_service.dart';
import '../../core/services/hive_service.dart';
import '../models/scan_model.dart';

class ScanRepository {
  final HiveService _hiveService;
  final FirebaseService _firebaseService;
  final GeminiVisionService _geminiVisionService;

  ScanRepository({
    required HiveService hiveService,
    required FirebaseService firebaseService,
    GeminiVisionService? geminiVisionService,
  })  : _hiveService = hiveService,
        _firebaseService = firebaseService,
        _geminiVisionService = geminiVisionService ??
            GeminiVisionService(hiveService: hiveService);

  List<ScanModel> getAllScans() {
    final rawList = _hiveService.getList(HiveService.scansBoxName);
    final scans = rawList.map((json) => ScanModel.fromJson(json)).toList();
    scans.sort((a, b) => b.scanDate.compareTo(a.scanDate));
    return scans;
  }

  Future<void> saveScan(ScanModel scan) async {
    await _hiveService.saveItem(HiveService.scansBoxName, scan.id, scan.toJson());
    _firebaseService.firestore.syncToCloud('scans', scan.id, scan.toJson());
  }

  /// Connects to Gemini Vision API to analyze leaf photo and map Shriram Fertilizers treatments
  Future<ScanModel> diagnoseSample(String sampleType) async {
    final result = await _geminiVisionService.analyzeLeafImage(imageSourceKey: sampleType);
    await saveScan(result);
    return result;
  }
}
