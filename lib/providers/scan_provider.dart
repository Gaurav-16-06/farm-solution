import 'package:flutter/material.dart';
import '../data/models/scan_model.dart';
import '../data/repositories/scan_repository.dart';

class ScanProvider extends ChangeNotifier {
  final ScanRepository _repository;
  List<ScanModel> _scans = [];
  ScanModel? _currentResult;
  bool _isScanning = false;
  String _scanningStatusText = '';

  ScanProvider(this._repository) {
    loadScans();
  }

  List<ScanModel> get scans => _scans;
  ScanModel? get currentResult => _currentResult;
  bool get isScanning => _isScanning;
  String get scanningStatusText => _scanningStatusText;

  void loadScans() {
    _scans = _repository.getAllScans();
    notifyListeners();
  }

  Future<void> runDiagnosis(String sampleKey, {bool isHindi = false}) async {
    _isScanning = true;
    _scanningStatusText = isHindi
        ? 'पत्ती के ऊतकों का एआई विश्लेषण जारी है...'
        : 'Analyzing leaf cellular pathology...';
    notifyListeners();

    try {
      final result = await _repository.diagnoseSample(sampleKey);
      _currentResult = result;
      loadScans();
    } finally {
      _isScanning = false;
      _scanningStatusText = '';
      notifyListeners();
    }
  }

  void clearCurrentResult() {
    _currentResult = null;
    notifyListeners();
  }
}
