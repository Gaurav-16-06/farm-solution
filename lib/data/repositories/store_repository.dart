import '../../core/services/firebase_service.dart';
import '../../core/services/hive_service.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class StoreRepository {
  final HiveService _hiveService;
  final FirebaseService _firebaseService;

  StoreRepository({
    required HiveService hiveService,
    required FirebaseService firebaseService,
  })  : _hiveService = hiveService,
        _firebaseService = firebaseService;

  List<ProductModel> getProducts() {
    final rawList = _hiveService.getList(HiveService.productsBoxName);
    return rawList.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<void> updateStock(String productId, int delta) async {
    final rawList = _hiveService.getList(HiveService.productsBoxName);
    for (final raw in rawList) {
      if (raw['id'] == productId) {
        final currentStock = raw['inStockCount'] as int? ?? 0;
        final updatedStock = (currentStock + delta).clamp(0, 99999);
        raw['inStockCount'] = updatedStock;
        await _hiveService.saveItem(HiveService.productsBoxName, productId, raw);
        _firebaseService.firestore.syncToCloud('products', productId, raw);
        break;
      }
    }
  }

  Future<bool> processCooperativeBooking(List<CartItemModel> items, String farmerName) async {
    // Deduct stock locally and create order ticket
    for (final item in items) {
      await updateStock(item.product.id, -item.quantity);
    }

    final orderRecord = {
      'orderId': 'ORD_${DateTime.now().millisecondsSinceEpoch}',
      'farmerName': farmerName,
      'itemCount': items.length,
      'totalAmount': items.fold<double>(0, (sum, i) => sum + i.totalPrice),
      'createdAt': DateTime.now().toIso8601String(),
      'status': 'confirmed_at_samiti',
    };

    _firebaseService.firestore.syncToCloud('orders', orderRecord['orderId'] as String, orderRecord);
    return true;
  }
}
