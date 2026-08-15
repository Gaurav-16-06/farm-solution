class ProductModel {
  final String id;
  final String nameEn;
  final String nameHi;
  final String category; // 'fertilizer', 'seed', 'pesticide', 'organic'
  final double mrp;
  final double subsidizedPrice;
  final String unitEn;
  final String unitHi;
  final int inStockCount;
  final String descriptionEn;
  final String descriptionHi;
  final String composition;
  final String dosageEn;
  final String dosageHi;
  final String imageUrl;
  final bool isSubsidized;

  ProductModel({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.category,
    required this.mrp,
    required this.subsidizedPrice,
    required this.unitEn,
    required this.unitHi,
    required this.inStockCount,
    required this.descriptionEn,
    required this.descriptionHi,
    this.composition = '',
    this.dosageEn = '',
    this.dosageHi = '',
    this.imageUrl = '',
    this.isSubsidized = true,
  });

  bool get isAvailable => inStockCount > 0;

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameEn': nameEn,
    'nameHi': nameHi,
    'category': category,
    'mrp': mrp,
    'subsidizedPrice': subsidizedPrice,
    'unitEn': unitEn,
    'unitHi': unitHi,
    'inStockCount': inStockCount,
    'descriptionEn': descriptionEn,
    'descriptionHi': descriptionHi,
    'composition': composition,
    'dosageEn': dosageEn,
    'dosageHi': dosageHi,
    'imageUrl': imageUrl,
    'isSubsidized': isSubsidized,
  };

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as String,
    nameEn: json['nameEn'] as String,
    nameHi: json['nameHi'] as String,
    category: json['category'] as String,
    mrp: (json['mrp'] as num).toDouble(),
    subsidizedPrice: (json['subsidizedPrice'] as num).toDouble(),
    unitEn: json['unitEn'] as String,
    unitHi: json['unitHi'] as String,
    inStockCount: json['inStockCount'] as int? ?? 0,
    descriptionEn: json['descriptionEn'] as String? ?? '',
    descriptionHi: json['descriptionHi'] as String? ?? '',
    composition: json['composition'] as String? ?? '',
    dosageEn: json['dosageEn'] as String? ?? '',
    dosageHi: json['dosageHi'] as String? ?? '',
    imageUrl: json['imageUrl'] as String? ?? '',
    isSubsidized: json['isSubsidized'] as bool? ?? true,
  );
}
