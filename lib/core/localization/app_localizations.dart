import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// AppLocalizations handles both English and Hindi strings with fallbacks.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('hi'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'Sonpur Sewa Samiti',
      'appSubtitle': 'Kisan Sahayata & Co-operative Portal',
      'tabScan': 'Scan & Diagnose',
      'tabCalendar': 'My Crop Calendar',
      'tabStore': 'Store & Fertilizer Calc',
      'tabAdmin': 'Admin Panel',

      'scanHeaderTitle': 'AI Plant Doctor',
      'scanHeaderSubtitle': 'Instant Disease Detection & Advisory',
      'scanButton': 'Take Photo of Leaf',
      'scanGalleryButton': 'Upload from Gallery',
      'scanSampleTitle': 'Try Sample Leaf Scans',
      'scanHistoryTitle': 'Recent Diagnosis Records',
      'scanResultHeading': 'Diagnostic Assessment',
      'scanConfidence': 'AI Confidence',
      'scanStatusHealthy': 'Healthy Crop',
      'scanStatusInfected': 'Infection Detected',
      'symptomsTitle': 'Identified Symptoms',
      'chemicalTreatmentTitle': 'Recommended Chemical Spray',
      'organicTreatmentTitle': 'Organic / Jaivik Remedy',
      'preventionTipsTitle': 'Preventative Best Practices',

      'calendarHeaderTitle': 'Crop Stage Timeline',
      'calendarHeaderSubtitle': 'Track Milestones from Sowing to Harvest',
      'addNewCrop': 'Add New Crop',
      'activeCrops': 'Active Crops',
      'sowingDate': 'Sowing Date',
      'expectedHarvest': 'Expected Harvest',
      'currentStage': 'Current Stage',
      'daysRemaining': 'Days to Harvest',
      'upcomingTasks': 'Upcoming Schedule Tasks',
      'taskCompleted': 'Completed',
      'taskPending': 'Pending Action',
      'cropHealthStatus': 'Crop Health',

      'calcTitle': 'Scientific Fertilizer Calculator',
      'calcSubtitle': 'Calculate Exact NPK, Urea, DAP & MOP for your Field',
      'storeTitle': 'Kisan Seva Kendra Store',
      'storeSubtitle': 'Co-operative Subsidized Fertilizers & Seeds',
      'landArea': 'Land Area',
      'landUnit': 'Unit',
      'selectCrop': 'Select Crop',
      'calculateButton': 'Calculate Requirements',
      'resultsHeading': 'Recommended Fertilizer Dosage',
      'ureaRequired': 'Urea (46% N)',
      'dapRequired': 'DAP (18:46:0)',
      'mopRequired': 'MOP / Potash (60% K)',
      'zincRequired': 'Zinc Sulphate (21%)',
      'bagsUnit': 'Bags (50 kg)',
      'addToCart': 'Add Recommended to Cart',
      'cartTitle': 'Co-operative Cart',
      'checkout': 'Book at Samiti Center',
      'inStock': 'In Stock',
      'outOfStock': 'Out of Stock',
      'price': 'Price',

      'adminHeaderTitle': 'Co-operative Management',
      'adminHeaderSubtitle': 'Sonpur Sewa Samiti Executive Dashboard',
      'totalFarmers': 'Registered Farmers',
      'ureaInStock': 'Urea Bags Available',
      'dapInStock': 'DAP Bags Available',
      'pendingQueries': 'Pending Farmer Queries',
      'broadcastNotice': 'Broadcast Notice / Alert',
      'noticeTitle': 'Notice Title',
      'noticeMessage': 'Notice Details',
      'publishNotice': 'Send Advisory to All Farmers',
      'recentNotices': 'Published Society Notices',
      'farmerQueries': 'Farmer Inquiries & Support',
      'resolveQuery': 'Post Expert Response',
      'stockManager': 'Quick Stock Update',

      'language': 'Language',
      'hindi': 'हिंदी (Hindi)',
      'english': 'English',
      'offlineMode': 'Offline Mode (Hive Local DB)',
      'onlineMode': 'Firebase Cloud Connected',
      'save': 'Save',
      'cancel': 'Cancel',
      'viewDetails': 'View Details',
    },
    'hi': {
      'appName': 'सोनपुर सेवा समिति',
      'appSubtitle': 'किसान सहायता एवं सहकारी पोर्टल',
      'tabScan': 'रोग जांच (स्कैन)',
      'tabCalendar': 'फसल कैलेंडर',
      'tabStore': 'खाद कैलकुलेटर व दुकान',
      'tabAdmin': 'समिति प्रबंधन',

      'scanHeaderTitle': 'एआई फसल डॉक्टर',
      'scanHeaderSubtitle': 'पत्ती स्कैन कर तुरंत पाएं रोग पहचान व सटीक उपचार',
      'scanButton': 'पत्ती की फोटो खींचें',
      'scanGalleryButton': 'गैलरी से फोटो चुनें',
      'scanSampleTitle': 'उदाहरण पत्ती स्कैन जांचें',
      'scanHistoryTitle': 'हालिया जांच रिकॉर्ड',
      'scanResultHeading': 'जांच परिणाम',
      'scanConfidence': 'सटीकता दर',
      'scanStatusHealthy': 'स्वस्थ फसल',
      'scanStatusInfected': 'रोग ग्रसित फसल',
      'symptomsTitle': 'पहचाने गए लक्षण',
      'chemicalTreatmentTitle': 'अनुशंसित रासायनिक छिड़काव',
      'organicTreatmentTitle': 'जैविक / देसी उपचार',
      'preventionTipsTitle': 'रोकथाम हेतु सावधानियां',

      'calendarHeaderTitle': 'फसल विकास चक्र',
      'calendarHeaderSubtitle': 'बुवाई से कटाई तक हर चरण की पूरी निगरानी',
      'addNewCrop': 'नई फसल जोड़ें',
      'activeCrops': 'सक्रिय फसलें',
      'sowingDate': 'बुवाई की तारीख',
      'expectedHarvest': 'अनुमानित कटाई',
      'currentStage': 'वर्तमान चरण',
      'daysRemaining': 'कटाई में शेष दिन',
      'upcomingTasks': 'आगामी जरूरी कार्य',
      'taskCompleted': 'पूर्ण हुआ',
      'taskPending': 'कार्य लंबित',
      'cropHealthStatus': 'फसल की स्थिति',

      'calcTitle': 'वैज्ञानिक खाद कैलकुलेटर',
      'calcSubtitle': 'खेत के क्षेत्रफल अनुसार यूरिया, डीएपी और पोटाश की सही मात्रा जानें',
      'storeTitle': 'किसान सेवा केंद्र भंडार',
      'storeSubtitle': 'समिति द्वारा अनुदानित खाद एवं बीज',
      'landArea': 'खेत का क्षेत्रफल',
      'landUnit': 'इकाई',
      'selectCrop': 'फसल चुनें',
      'calculateButton': 'खाद मात्रा की गणना करें',
      'resultsHeading': 'आवश्यक खाद की अनुशंसित मात्रा',
      'ureaRequired': 'यूरिया (46% नाइट्रोजन)',
      'dapRequired': 'डीएपी (18:46:0)',
      'mopRequired': 'एमओपी / पोटाश (60% के)',
      'zincRequired': 'जिंक सल्फेट (21%)',
      'bagsUnit': 'बोरी (50 कि.ग्रा.)',
      'addToCart': 'खाद को कार्ट में जोड़ें',
      'cartTitle': 'समिति कार्ट',
      'checkout': 'समिति केंद्र पर बुक करें',
      'inStock': 'उपलब्ध है',
      'outOfStock': 'स्टॉक समाप्त',
      'price': 'मूल्य',

      'adminHeaderTitle': 'सहकारी समिति प्रबंधन',
      'adminHeaderSubtitle': 'सोनपुर सेवा समिति कार्यकारी डैशबोर्ड',
      'totalFarmers': 'पंजीकृत किसान',
      'ureaInStock': 'उपलब्ध यूरिया बोरी',
      'dapInStock': 'उपलब्ध डीएपी बोरी',
      'pendingQueries': 'लंबित किसान प्रश्न',
      'broadcastNotice': 'सूचना / चेतावनी जारी करें',
      'noticeTitle': 'सूचना का शीर्षक',
      'noticeMessage': 'सूचना का विवरण',
      'publishNotice': 'सभी किसानों को भेजें',
      'recentNotices': 'समिति की जारी सूचनाएं',
      'farmerQueries': 'किसानों के सवाल व समाधान',
      'resolveQuery': 'विशेषज्ञ परामर्श भेजें',
      'stockManager': 'खाद स्टॉक अपडेट करें',

      'language': 'भाषा (Language)',
      'hindi': 'हिंदी (Hindi)',
      'english': 'English',
      'offlineMode': 'ऑफलाइन मोड (Hive लोकल डाटा)',
      'onlineMode': 'फायरबेस क्लाउड कनेक्टेड',
      'save': 'सुरक्षित करें',
      'cancel': 'रद्द करें',
      'viewDetails': 'विवरण देखें',
    },
  };

  String get appName => _get('appName');
  String get appSubtitle => _get('appSubtitle');
  String get tabScan => _get('tabScan');
  String get tabCalendar => _get('tabCalendar');
  String get tabStore => _get('tabStore');
  String get tabAdmin => _get('tabAdmin');

  String get scanHeaderTitle => _get('scanHeaderTitle');
  String get scanHeaderSubtitle => _get('scanHeaderSubtitle');
  String get scanButton => _get('scanButton');
  String get scanGalleryButton => _get('scanGalleryButton');
  String get scanSampleTitle => _get('scanSampleTitle');
  String get scanHistoryTitle => _get('scanHistoryTitle');
  String get scanResultHeading => _get('scanResultHeading');
  String get scanConfidence => _get('scanConfidence');
  String get scanStatusHealthy => _get('scanStatusHealthy');
  String get scanStatusInfected => _get('scanStatusInfected');
  String get symptomsTitle => _get('symptomsTitle');
  String get chemicalTreatmentTitle => _get('chemicalTreatmentTitle');
  String get organicTreatmentTitle => _get('organicTreatmentTitle');
  String get preventionTipsTitle => _get('preventionTipsTitle');

  String get calendarHeaderTitle => _get('calendarHeaderTitle');
  String get calendarHeaderSubtitle => _get('calendarHeaderSubtitle');
  String get addNewCrop => _get('addNewCrop');
  String get activeCrops => _get('activeCrops');
  String get sowingDate => _get('sowingDate');
  String get expectedHarvest => _get('expectedHarvest');
  String get currentStage => _get('currentStage');
  String get daysRemaining => _get('daysRemaining');
  String get upcomingTasks => _get('upcomingTasks');
  String get taskCompleted => _get('taskCompleted');
  String get taskPending => _get('taskPending');
  String get cropHealthStatus => _get('cropHealthStatus');

  String get calcTitle => _get('calcTitle');
  String get calcSubtitle => _get('calcSubtitle');
  String get storeTitle => _get('storeTitle');
  String get storeSubtitle => _get('storeSubtitle');
  String get landArea => _get('landArea');
  String get landUnit => _get('landUnit');
  String get selectCrop => _get('selectCrop');
  String get calculateButton => _get('calculateButton');
  String get resultsHeading => _get('resultsHeading');
  String get ureaRequired => _get('ureaRequired');
  String get dapRequired => _get('dapRequired');
  String get mopRequired => _get('mopRequired');
  String get zincRequired => _get('zincRequired');
  String get bagsUnit => _get('bagsUnit');
  String get addToCart => _get('addToCart');
  String get cartTitle => _get('cartTitle');
  String get checkout => _get('checkout');
  String get inStock => _get('inStock');
  String get outOfStock => _get('outOfStock');
  String get price => _get('price');

  String get adminHeaderTitle => _get('adminHeaderTitle');
  String get adminHeaderSubtitle => _get('adminHeaderSubtitle');
  String get totalFarmers => _get('totalFarmers');
  String get ureaInStock => _get('ureaInStock');
  String get dapInStock => _get('dapInStock');
  String get pendingQueries => _get('pendingQueries');
  String get broadcastNotice => _get('broadcastNotice');
  String get noticeTitle => _get('noticeTitle');
  String get noticeMessage => _get('noticeMessage');
  String get publishNotice => _get('publishNotice');
  String get recentNotices => _get('recentNotices');
  String get farmerQueries => _get('farmerQueries');
  String get resolveQuery => _get('resolveQuery');
  String get stockManager => _get('stockManager');

  String get language => _get('language');
  String get hindi => _get('hindi');
  String get english => _get('english');
  String get offlineMode => _get('offlineMode');
  String get onlineMode => _get('onlineMode');
  String get save => _get('save');
  String get cancel => _get('cancel');
  String get viewDetails => _get('viewDetails');

  String _get(String key) {
    final lang = locale.languageCode;
    return _localizedValues[lang]?[key] ??
        _localizedValues['hi']?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
