class NoticeModel {
  final String id;
  final String titleEn;
  final String titleHi;
  final String contentEn;
  final String contentHi;
  final String category; // 'advisory', 'subsidy', 'weather', 'general'
  final DateTime publishedDate;
  final String author;
  final bool isUrgent;

  NoticeModel({
    required this.id,
    required this.titleEn,
    required this.titleHi,
    required this.contentEn,
    required this.contentHi,
    required this.category,
    required this.publishedDate,
    required this.author,
    this.isUrgent = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'titleEn': titleEn,
    'titleHi': titleHi,
    'contentEn': contentEn,
    'contentHi': contentHi,
    'category': category,
    'publishedDate': publishedDate.toIso8601String(),
    'author': author,
    'isUrgent': isUrgent,
  };

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    id: json['id'] as String,
    titleEn: json['titleEn'] as String,
    titleHi: json['titleHi'] as String,
    contentEn: json['contentEn'] as String,
    contentHi: json['contentHi'] as String,
    category: json['category'] as String? ?? 'general',
    publishedDate: DateTime.parse(json['publishedDate'] as String),
    author: json['author'] as String? ?? 'Sonpur Sewa Samiti',
    isUrgent: json['isUrgent'] as bool? ?? false,
  );
}
