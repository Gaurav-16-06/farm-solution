import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/localization/app_localizations.dart';
import 'core/localization/language_provider.dart';
import 'core/services/firebase_service.dart';
import 'core/services/hive_service.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/admin_repository.dart';
import 'data/repositories/crop_repository.dart';
import 'data/repositories/scan_repository.dart';
import 'data/repositories/store_repository.dart';
import 'providers/admin_provider.dart';
import 'providers/crop_provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/scan_provider.dart';
import 'providers/store_provider.dart';
import 'providers/theme_provider.dart';
import 'ui/features/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Local Hive Storage
  final hiveService = HiveService();
  await hiveService.init();

  // 2. Initialize Firebase Cloud Services
  final firebaseService = FirebaseService.instance;
  await firebaseService.initialize();

  // 3. Initialize Repositories
  final cropRepo = CropRepository(hiveService: hiveService, firebaseService: firebaseService);
  final scanRepo = ScanRepository(hiveService: hiveService, firebaseService: firebaseService);
  final storeRepo = StoreRepository(hiveService: hiveService, firebaseService: firebaseService);
  final adminRepo = AdminRepository(hiveService: hiveService, firebaseService: firebaseService);

  runApp(
    SonpurSewaSamitiApp(
      hiveService: hiveService,
      cropRepo: cropRepo,
      scanRepo: scanRepo,
      storeRepo: storeRepo,
      adminRepo: adminRepo,
    ),
  );
}

class SonpurSewaSamitiApp extends StatelessWidget {
  final HiveService hiveService;
  final CropRepository cropRepo;
  final ScanRepository scanRepo;
  final StoreRepository storeRepo;
  final AdminRepository adminRepo;

  const SonpurSewaSamitiApp({
    super.key,
    required this.hiveService,
    required this.cropRepo,
    required this.scanRepo,
    required this.storeRepo,
    required this.adminRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider(hiveService)),
        ChangeNotifierProvider(create: (_) => ThemeProvider(hiveService)),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => CropProvider(cropRepo)),
        ChangeNotifierProvider(create: (_) => ScanProvider(scanRepo)),
        ChangeNotifierProvider(create: (_) => StoreProvider(storeRepo)),
        ChangeNotifierProvider(create: (_) => AdminProvider(adminRepo)),
      ],
      child: Consumer2<LanguageProvider, ThemeProvider>(
        builder: (context, langProv, themeProv, _) {
          return MaterialApp(
            title: 'Sonpur Sewa Samiti',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProv.themeMode,
            locale: langProv.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('hi'),
              Locale('en'),
            ],
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
