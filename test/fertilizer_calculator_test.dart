import 'package:flutter_test/flutter_test.dart';
import 'package:sonpur_sewa_samiti/data/models/fertilizer_calculation.dart';

void main() {
  group('FertilizerCalculator Engine Tests', () {
    test('Calculates accurate Urea, DAP, and MOP for 1 Acre Wheat', () {
      final result = FertilizerCalculator.calculate(
        cropKey: 'wheat',
        landArea: 1.0,
        landUnit: 'Acre',
      );

      expect(result.cropNameEn, 'Wheat');
      expect(result.landAreaInAcres, 1.0);
      expect(result.dapBags, greaterThan(1.0)); // DAP supplies 25kg P2O5
      expect(result.ureaBags, greaterThan(0.0)); // Remaining N
      expect(result.mopBags, greaterThan(0.5)); // MOP supplies Potash
      expect(result.zincKg, 8.0);
      expect(result.estimatedCost, greaterThan(2000.0));
      expect(result.basalDoseEn.isNotEmpty, true);
      expect(result.firstTopDressingHi.isNotEmpty, true);
    });

    test('Converts Bigha accurately to Acre for Sonpur region (1 Bigha = 0.625 Acre)', () {
      final acres = FertilizerCalculator.convertToAcres(2.0, 'Bigha');
      expect(acres, 1.25);

      final result = FertilizerCalculator.calculate(
        cropKey: 'mustard',
        landArea: 2.0,
        landUnit: 'Bigha',
      );

      expect(result.landAreaInAcres, 1.25);
      expect(result.roundedUreaBags, greaterThanOrEqualTo(1));
      expect(result.roundedDapBags, greaterThanOrEqualTo(1));
    });

    test('Handles Potato high nutrient demand correctly', () {
      final result = FertilizerCalculator.calculate(
        cropKey: 'potato',
        landArea: 1.0,
        landUnit: 'Hectare',
      );

      expect(result.landAreaInAcres, closeTo(2.471, 0.01));
      expect(result.roundedUreaBags, greaterThan(2));
      expect(result.roundedDapBags, greaterThan(2));
    });
  });
}
