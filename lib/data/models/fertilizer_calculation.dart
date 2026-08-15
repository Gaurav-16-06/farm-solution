class CropFertilizerNutrientReq {
  final String cropKey;
  final String nameEn;
  final String nameHi;
  final double nKgPerAcre; // Nitrogen
  final double pKgPerAcre; // Phosphorus
  final double kKgPerAcre; // Potash
  final double zincKgPerAcre;

  const CropFertilizerNutrientReq({
    required this.cropKey,
    required this.nameEn,
    required this.nameHi,
    required this.nKgPerAcre,
    required this.pKgPerAcre,
    required this.kKgPerAcre,
    this.zincKgPerAcre = 5.0,
  });
}

class FertilizerCalculationResult {
  final String cropNameEn;
  final String cropNameHi;
  final double landArea;
  final String landUnit;
  final double landAreaInAcres;

  // Exact Bags (50 kg each)
  final double ureaBags;
  final double dapBags;
  final double mopBags;
  final double zincKg;

  // Split Application Schedules
  final String basalDoseEn;
  final String basalDoseHi;
  final String firstTopDressingEn;
  final String firstTopDressingHi;
  final String secondTopDressingEn;
  final String secondTopDressingHi;

  // Estimated Cost at Cooperative Subsidized Rates
  final double estimatedCost;

  FertilizerCalculationResult({
    required this.cropNameEn,
    required this.cropNameHi,
    required this.landArea,
    required this.landUnit,
    required this.landAreaInAcres,
    required this.ureaBags,
    required this.dapBags,
    required this.mopBags,
    required this.zincKg,
    required this.basalDoseEn,
    required this.basalDoseHi,
    required this.firstTopDressingEn,
    required this.firstTopDressingHi,
    required this.secondTopDressingEn,
    required this.secondTopDressingHi,
    required this.estimatedCost,
  });

  int get roundedUreaBags => ureaBags.ceil().clamp(1, 999);
  int get roundedDapBags => dapBags.ceil().clamp(1, 999);
  int get roundedMopBags => mopBags.ceil().clamp(0, 999);
}

class FertilizerCalculator {
  static const Map<String, CropFertilizerNutrientReq> supportedCrops = {
    'wheat': CropFertilizerNutrientReq(
      cropKey: 'wheat',
      nameEn: 'Wheat',
      nameHi: 'गेहूं (Wheat)',
      nKgPerAcre: 50.0,
      pKgPerAcre: 25.0,
      kKgPerAcre: 16.0,
      zincKgPerAcre: 8.0,
    ),
    'paddy': CropFertilizerNutrientReq(
      cropKey: 'paddy',
      nameEn: 'Paddy / Rice',
      nameHi: 'धान (Paddy / Rice)',
      nKgPerAcre: 42.0,
      pKgPerAcre: 20.0,
      kKgPerAcre: 20.0,
      zincKgPerAcre: 10.0,
    ),
    'mustard': CropFertilizerNutrientReq(
      cropKey: 'mustard',
      nameEn: 'Mustard',
      nameHi: 'सरसों (Mustard)',
      nKgPerAcre: 35.0,
      pKgPerAcre: 18.0,
      kKgPerAcre: 15.0,
      zincKgPerAcre: 5.0,
    ),
    'potato': CropFertilizerNutrientReq(
      cropKey: 'potato',
      nameEn: 'Potato',
      nameHi: 'आलू (Potato)',
      nKgPerAcre: 60.0,
      pKgPerAcre: 35.0,
      kKgPerAcre: 40.0,
      zincKgPerAcre: 10.0,
    ),
    'sugarcane': CropFertilizerNutrientReq(
      cropKey: 'sugarcane',
      nameEn: 'Sugarcane',
      nameHi: 'गन्ना (Sugarcane)',
      nKgPerAcre: 100.0,
      pKgPerAcre: 45.0,
      kKgPerAcre: 45.0,
      zincKgPerAcre: 12.0,
    ),
    'maize': CropFertilizerNutrientReq(
      cropKey: 'maize',
      nameEn: 'Maize / Corn',
      nameHi: 'मक्का (Maize / Corn)',
      nKgPerAcre: 48.0,
      pKgPerAcre: 24.0,
      kKgPerAcre: 16.0,
      zincKgPerAcre: 6.0,
    ),
  };

  /// Converts various land units into standard Acres (Sonpur / Bihar regional conversions)
  static double convertToAcres(double area, String unit) {
    switch (unit.toLowerCase()) {
      case 'acre':
      case 'एकड़':
        return area;
      case 'hectare':
      case 'हेक्टेयर':
        return area * 2.471;
      case 'bigha':
      case 'बीघा':
        return area * 0.625; // 1 Bigha = ~0.625 Acre in Sonpur
      case 'kattha':
      case 'कट्ठा':
        return area * 0.03125; // 20 Kattha = 1 Bigha
      default:
        return area;
    }
  }

  static FertilizerCalculationResult calculate({
    required String cropKey,
    required double landArea,
    required String landUnit,
  }) {
    final crop = supportedCrops[cropKey] ?? supportedCrops['wheat']!;
    final acres = convertToAcres(landArea, landUnit);

    final totalN = crop.nKgPerAcre * acres;
    final totalP = crop.pKgPerAcre * acres;
    final totalK = crop.kKgPerAcre * acres;
    final totalZinc = crop.zincKgPerAcre * acres;

    // 1. DAP (18:46:0) supplies all required Phosphorus (P)
    // 50 kg DAP has 23 kg P2O5 (46%) and 9 kg N (18%)
    final dapKgNeeded = (totalP / 0.46);
    final dapBags = dapKgNeeded / 50.0;
    final nSuppliedByDap = dapKgNeeded * 0.18;

    // 2. Remaining Nitrogen is supplied by Urea (46% N)
    // 50 kg Urea has 23 kg N (46%)
    final remainingN = (totalN - nSuppliedByDap).clamp(0.0, 9999.0);
    final ureaKgNeeded = remainingN / 0.46;
    final ureaBags = ureaKgNeeded / 50.0;

    // 3. Potash is supplied by MOP (60% K2O)
    // 50 kg MOP has 30 kg K2O (60%)
    final mopKgNeeded = totalK / 0.60;
    final mopBags = mopKgNeeded / 50.0;

    // Subsidized cooperative pricing: Urea ₹266.50/bag, DAP ₹1350/bag, MOP ₹1700/bag, Zinc ₹70/kg
    final cost = (ureaBags.ceil() * 266.50) +
        (dapBags.ceil() * 1350.0) +
        (mopBags.ceil() * 1700.0) +
        (totalZinc * 70.0);

    return FertilizerCalculationResult(
      cropNameEn: crop.nameEn,
      cropNameHi: crop.nameHi,
      landArea: landArea,
      landUnit: landUnit,
      landAreaInAcres: acres,
      ureaBags: double.parse(ureaBags.toStringAsFixed(2)),
      dapBags: double.parse(dapBags.toStringAsFixed(2)),
      mopBags: double.parse(mopBags.toStringAsFixed(2)),
      zincKg: double.parse(totalZinc.toStringAsFixed(1)),
      basalDoseEn:
          'At Sowing: Apply full DAP (${dapBags.ceil()} bags), full MOP (${mopBags.ceil()} bags) + 1/3 Urea (${(ureaBags / 3).ceil()} bag).',
      basalDoseHi:
          'बुवाई के समय: पूरा डीएपी (${dapBags.ceil()} बोरी), पूरा पोटाश (${mopBags.ceil()} बोरी) और 1/3 यूरिया (${(ureaBags / 3).ceil()} बोरी) डालें।',
      firstTopDressingEn:
          '1st Irrigation (21-25 Days): Apply 1/3 Urea (${(ureaBags / 3).ceil()} bag) + Zinc Sulphate (${totalZinc.toStringAsFixed(1)} kg).',
      firstTopDressingHi:
          'पहली सिंचाई (21-25 दिन): 1/3 यूरिया (${(ureaBags / 3).ceil()} बोरी) व जिंक सल्फेट (${totalZinc.toStringAsFixed(1)} कि.ग्रा.) का छिड़काव करें।',
      secondTopDressingEn:
          'Flowering Stage (45-50 Days): Apply remaining 1/3 Urea (${(ureaBags / 3).ceil()} bag) before mild watering.',
      secondTopDressingHi:
          'फूल / कल्ले फूटने पर (45-50 दिन): शेष 1/3 यूरिया (${(ureaBags / 3).ceil()} बोरी) का टॉप ड्रेसिंग करें।',
      estimatedCost: cost,
    );
  }
}
