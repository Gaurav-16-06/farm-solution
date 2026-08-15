import 'package:flutter_test/flutter_test.dart';
import 'package:sonpur_sewa_samiti/core/constants/app_constants.dart';
import 'package:sonpur_sewa_samiti/core/services/gemini_vision_service.dart';
import 'package:sonpur_sewa_samiti/core/services/hive_service.dart';
import 'package:sonpur_sewa_samiti/data/models/crop_model.dart';
import 'package:sonpur_sewa_samiti/data/models/product_model.dart';
import 'package:sonpur_sewa_samiti/data/models/scan_model.dart';

void main() {
  group('Gemini Vision & Shriram Fertilizers Model Tests', () {
    test('ScanModel serializes Shriram products, 1-Acre dosage, and store stock', () {
      final now = DateTime.now();
      final scan = ScanModel(
        id: 'scan_test_shriram',
        cropNameEn: 'Wheat Leaf',
        cropNameHi: 'गेहूं की पत्ती',
        diseaseNameEn: 'Yellow Rust',
        diseaseNameHi: 'पीला रतुआ',
        confidenceScore: 0.96,
        isHealthy: false,
        symptomsEn: 'Yellow stripes along veins',
        symptomsHi: 'पत्तियों पर पीले फफोले',
        chemicalRemedyEn: 'Shriram Suraksha (Hexaconazole 5% SC) @ 400ml/Acre',
        chemicalRemedyHi: 'श्रीराम सुरक्षा (हेक्साकोनाजोल 5% एससी) 400 मिली प्रति एकड़',
        organicRemedyEn: 'Neem seed extract',
        organicRemedyHi: 'नीम अर्क',
        preventionEn: 'Resistant varieties',
        preventionHi: 'रोगरोधी किस्में',
        scanDate: now,
        shriramProductId: 'prod_shriram_suraksha',
        shriramProductName: 'Shriram Suraksha (Hexaconazole 5% SC)',
        dosagePerAcreEn: '400 ml in 200 Liters of water per 1 Acre',
        dosagePerAcreHi: '400 मिली 200 लीटर पानी में मिलाकर प्रति 1 एकड़',
        matchedProduct: ProductModel(
          id: 'prod_shriram_suraksha',
          nameEn: 'Shriram Suraksha',
          nameHi: 'श्रीराम सुरक्षा',
          category: 'pesticide',
          mrp: 620.0,
          subsidizedPrice: 490.0,
          unitEn: '500 ml Bottle',
          unitHi: '500 मिली बोतल',
          inStockCount: 75,
          descriptionEn: 'Fungicide',
          descriptionHi: 'फफूंदनाशक',
        ),
      );

      final json = scan.toJson();
      final restored = ScanModel.fromJson(json);

      expect(restored.shriramProductId, 'prod_shriram_suraksha');
      expect(restored.shriramProductName, contains('Shriram Suraksha'));
      expect(restored.dosagePerAcreEn, contains('1 Acre'));
      expect(restored.matchedProduct != null, true);
      expect(restored.matchedProduct!.inStockCount, 75);
      expect(restored.matchedProduct!.subsidizedPrice, 490.0);
    });

    test('GeminiVisionService prescriptions map Shriram Ziva, Energy, DAP, and Urea', () {
      expect(GeminiVisionService.shriramPrescriptions.containsKey('wheat_rust'), true);
      expect(GeminiVisionService.shriramPrescriptions.containsKey('wheat_nutrition'), true);
      expect(GeminiVisionService.shriramPrescriptions.containsKey('potato_blight'), true);
      expect(GeminiVisionService.shriramPrescriptions.containsKey('mustard_aphid'), true);
      expect(GeminiVisionService.shriramPrescriptions.containsKey('paddy_healthy'), true);

      final ziva = GeminiVisionService.shriramPrescriptions['wheat_nutrition']!;
      expect(ziva['productName'], contains('Shriram Ziva'));
      expect(ziva['dosagePerAcreEn'], contains('4 kg per 1 Acre'));
    });

    test('Store Inventory contains required Shriram products with IN STOCK and OUT OF STOCK states', () {
      final products = AppConstants.initialProducts;
      final urea = products.firstWhere((p) => p['id'] == 'prod_shriram_urea');
      final polyta = products.firstWhere((p) => p['id'] == 'prod_shriram_polyta');

      expect(urea['inStockCount'], 850); // IN STOCK
      expect(polyta['inStockCount'], 0); // OUT OF STOCK
      expect(urea['subsidizedPrice'], 266.50);
      expect(polyta['subsidizedPrice'], 1250.0);
    });
  });
}
