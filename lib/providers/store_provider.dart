import 'package:flutter/material.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/fertilizer_calculation.dart';
import '../data/models/product_model.dart';
import '../data/repositories/store_repository.dart';

class StoreProvider extends ChangeNotifier {
  final StoreRepository _repository;

  List<ProductModel> _products = [];
  String _selectedCategory = 'all';
  String _searchQuery = '';

  // Fertilizer Calculator State
  String _calcCropKey = 'wheat';
  double _calcLandArea = 1.0;
  String _calcLandUnit = 'Acre';
  FertilizerCalculationResult? _calculationResult;

  // Shopping Cart State
  final List<CartItemModel> _cart = [];

  StoreProvider(this._repository) {
    loadProducts();
    // Run initial calculation for 1 Acre Wheat
    calculateFertilizer();
  }

  List<ProductModel> get products {
    return _products.where((p) {
      final matchesCat = _selectedCategory == 'all' || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.nameEn.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.nameHi.contains(_searchQuery);
      return matchesCat && matchesSearch;
    }).toList();
  }

  List<ProductModel> get allRawProducts => _products;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  String get calcCropKey => _calcCropKey;
  double get calcLandArea => _calcLandArea;
  String get calcLandUnit => _calcLandUnit;
  FertilizerCalculationResult? get calculationResult => _calculationResult;

  List<CartItemModel> get cart => _cart;
  int get cartCount => _cart.fold(0, (sum, i) => sum + i.quantity);
  double get cartTotal => _cart.fold(0, (sum, i) => sum + i.totalPrice);
  double get cartSavings => _cart.fold(0, (sum, i) => sum + i.totalSavings);

  void loadProducts() {
    _products = _repository.getProducts();
    notifyListeners();
  }

  void setCategory(String cat) {
    _selectedCategory = cat;
    notifyListeners();
  }

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  // --- Calculator Operations ---

  void updateCalculatorParams({String? cropKey, double? landArea, String? landUnit}) {
    if (cropKey != null) _calcCropKey = cropKey;
    if (landArea != null) _calcLandArea = landArea;
    if (landUnit != null) _calcLandUnit = landUnit;
    calculateFertilizer();
  }

  void calculateFertilizer() {
    _calculationResult = FertilizerCalculator.calculate(
      cropKey: _calcCropKey,
      landArea: _calcLandArea,
      landUnit: _calcLandUnit,
    );
    notifyListeners();
  }

  // --- Cart Operations ---

  void addToCart(ProductModel product, {int quantity = 1}) {
    final index = _cart.indexWhere((i) => i.product.id == product.id);
    if (index >= 0) {
      _cart[index].quantity += quantity;
    } else {
      _cart.add(CartItemModel(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void addCalculatedFertilizersToCart(FertilizerCalculationResult result) {
    // 1. Urea
    final ureaProduct = _products.firstWhere(
      (p) => p.id == 'prod_001',
      orElse: () => _products.first,
    );
    addToCart(ureaProduct, quantity: result.roundedUreaBags);

    // 2. DAP
    final dapProduct = _products.firstWhere(
      (p) => p.id == 'prod_002',
      orElse: () => _products.first,
    );
    addToCart(dapProduct, quantity: result.roundedDapBags);

    // 3. MOP if needed
    if (result.roundedMopBags > 0) {
      final mopProduct = _products.firstWhere(
        (p) => p.id == 'prod_003',
        orElse: () => _products.first,
      );
      addToCart(mopProduct, quantity: result.roundedMopBags);
    }
  }

  void updateCartItemQuantity(String productId, int newQty) {
    if (newQty <= 0) {
      _cart.removeWhere((i) => i.product.id == productId);
    } else {
      final index = _cart.indexWhere((i) => i.product.id == productId);
      if (index >= 0) {
        _cart[index].quantity = newQty;
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  Future<bool> checkoutCart(String farmerName) async {
    if (_cart.isEmpty) return false;
    final success = await _repository.processCooperativeBooking(_cart, farmerName);
    if (success) {
      _cart.clear();
      loadProducts();
    }
    return success;
  }

  Future<void> updateProductStock(String productId, int delta) async {
    await _repository.updateStock(productId, delta);
    loadProducts();
  }
}
