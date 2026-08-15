import '../../core/services/firebase_service.dart';
import '../../core/services/hive_service.dart';
import '../models/farmer_query_model.dart';
import '../models/notice_model.dart';

class SocietyStats {
  final int registeredFarmers;
  final int activeCropsCount;
  final int ureaBagsStock;
  final int dapBagsStock;
  final double totalSubsidyDistributed;
  final int pendingSupportQueries;

  SocietyStats({
    required this.registeredFarmers,
    required this.activeCropsCount,
    required this.ureaBagsStock,
    required this.dapBagsStock,
    required this.totalSubsidyDistributed,
    required this.pendingSupportQueries,
  });
}

class AdminRepository {
  final HiveService _hiveService;
  final FirebaseService _firebaseService;

  AdminRepository({
    required HiveService hiveService,
    required FirebaseService firebaseService,
  })  : _hiveService = hiveService,
        _firebaseService = firebaseService;

  List<NoticeModel> getNotices() {
    final rawList = _hiveService.getList(HiveService.noticesBoxName);
    final notices = rawList.map((json) => NoticeModel.fromJson(json)).toList();
    notices.sort((a, b) => b.publishedDate.compareTo(a.publishedDate));
    return notices;
  }

  Future<void> publishNotice(NoticeModel notice) async {
    await _hiveService.saveItem(HiveService.noticesBoxName, notice.id, notice.toJson());
    _firebaseService.firestore.syncToCloud('notices', notice.id, notice.toJson());
  }

  List<FarmerQueryModel> getFarmerQueries() {
    final rawList = _hiveService.getList(HiveService.queriesBoxName);
    final queries = rawList.map((json) => FarmerQueryModel.fromJson(json)).toList();
    queries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return queries;
  }

  Future<void> resolveQuery({
    required String queryId,
    required String responseEn,
    required String responseHi,
    required String expertName,
  }) async {
    final rawList = _hiveService.getList(HiveService.queriesBoxName);
    for (final raw in rawList) {
      if (raw['id'] == queryId) {
        raw['status'] = 'resolved';
        raw['responseEn'] = responseEn;
        raw['responseHi'] = responseHi;
        raw['expertName'] = expertName;
        await _hiveService.saveItem(HiveService.queriesBoxName, queryId, raw);
        _firebaseService.firestore.syncToCloud('queries', queryId, raw);
        break;
      }
    }
  }

  SocietyStats getSocietyStats() {
    final products = _hiveService.getList(HiveService.productsBoxName);
    int ureaStock = 0;
    int dapStock = 0;
    for (final p in products) {
      if (p['id'] == 'prod_001') ureaStock = p['inStockCount'] as int? ?? 0;
      if (p['id'] == 'prod_002') dapStock = p['inStockCount'] as int? ?? 0;
    }

    final queries = getFarmerQueries();
    final pendingCount = queries.where((q) => !q.isResolved).length;

    return SocietyStats(
      registeredFarmers: 1420,
      activeCropsCount: 1890,
      ureaBagsStock: ureaStock > 0 ? ureaStock : 850,
      dapBagsStock: dapStock > 0 ? dapStock : 420,
      totalSubsidyDistributed: 425000.0,
      pendingSupportQueries: pendingCount,
    );
  }
}
