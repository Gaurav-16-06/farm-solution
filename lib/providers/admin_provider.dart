import 'package:flutter/material.dart';
import '../data/models/farmer_query_model.dart';
import '../data/models/notice_model.dart';
import '../data/repositories/admin_repository.dart';

class AdminProvider extends ChangeNotifier {
  final AdminRepository _repository;

  List<NoticeModel> _notices = [];
  List<FarmerQueryModel> _queries = [];
  SocietyStats? _stats;

  AdminProvider(this._repository) {
    loadAdminData();
  }

  List<NoticeModel> get notices => _notices;
  List<FarmerQueryModel> get queries => _queries;
  SocietyStats get stats =>
      _stats ??
      SocietyStats(
        registeredFarmers: 1420,
        activeCropsCount: 1890,
        ureaBagsStock: 850,
        dapBagsStock: 420,
        totalSubsidyDistributed: 425000,
        pendingSupportQueries: 0,
      );

  void loadAdminData() {
    _notices = _repository.getNotices();
    _queries = _repository.getFarmerQueries();
    _stats = _repository.getSocietyStats();
    notifyListeners();
  }

  Future<void> publishNotice({
    required String titleEn,
    required String titleHi,
    required String contentEn,
    required String contentHi,
    required String category,
    required String author,
    bool isUrgent = false,
  }) async {
    final newNotice = NoticeModel(
      id: 'notice_${DateTime.now().millisecondsSinceEpoch}',
      titleEn: titleEn,
      titleHi: titleHi,
      contentEn: contentEn,
      contentHi: contentHi,
      category: category,
      publishedDate: DateTime.now(),
      author: author,
      isUrgent: isUrgent,
    );

    await _repository.publishNotice(newNotice);
    loadAdminData();
  }

  Future<void> resolveQuery({
    required String queryId,
    required String responseEn,
    required String responseHi,
    required String expertName,
  }) async {
    await _repository.resolveQuery(
      queryId: queryId,
      responseEn: responseEn,
      responseHi: responseHi,
      expertName: expertName,
    );
    loadAdminData();
  }
}
