import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sonpur_sewa_samiti/core/services/firebase_service.dart';
import 'package:sonpur_sewa_samiti/core/services/hive_service.dart';
import 'package:sonpur_sewa_samiti/data/repositories/admin_repository.dart';
import 'package:sonpur_sewa_samiti/data/repositories/crop_repository.dart';
import 'package:sonpur_sewa_samiti/data/repositories/scan_repository.dart';
import 'package:sonpur_sewa_samiti/data/repositories/store_repository.dart';
import 'package:sonpur_sewa_samiti/main.dart';

void main() {
  testWidgets('Sonpur Sewa Samiti 4-Tab Smooth Navigation and Language Toggle Test',
      (WidgetTester tester) async {
    // 1. Initialize Test Storage & Services
    final hiveService = HiveService();
    await hiveService.init();

    final firebaseService = FirebaseService.instance;
    await firebaseService.initialize();

    final cropRepo = CropRepository(hiveService: hiveService, firebaseService: firebaseService);
    final scanRepo = ScanRepository(hiveService: hiveService, firebaseService: firebaseService);
    final storeRepo = StoreRepository(hiveService: hiveService, firebaseService: firebaseService);
    final adminRepo = AdminRepository(hiveService: hiveService, firebaseService: firebaseService);

    // 2. Pump the Application
    await tester.pumpWidget(
      SonpurSewaSamitiApp(
        hiveService: hiveService,
        cropRepo: cropRepo,
        scanRepo: scanRepo,
        storeRepo: storeRepo,
        adminRepo: adminRepo,
      ),
    );
    await tester.pumpAndSettle();

    // 3. Verify App starts on Tab 0: Scan & Diagnose
    expect(find.byIcon(Icons.document_scanner_rounded), findsWidgets);
    expect(find.text('AI CAMERA READY'), findsOneWidget);

    // 4. Verify Language Toggle from Hindi to English
    expect(find.text('English'), findsOneWidget); // Toggle button label in Hindi mode
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    // Now in English mode, toggle button shows 'हिंदी'
    expect(find.text('हिंदी'), findsOneWidget);

    // 5. Test Tab 1: My Crop Calendar
    final calendarTab = find.byIcon(Icons.calendar_month_outlined);
    expect(calendarTab, findsOneWidget);
    await tester.tap(calendarTab);
    await tester.pumpAndSettle();

    // Verify Crop Calendar screen is displayed
    expect(find.text('Crop Stage Timeline'), findsOneWidget);
    expect(find.text('Add New Crop'), findsOneWidget);

    // 6. Test Tab 2: Store & Fertilizer Calc
    final storeTab = find.byIcon(Icons.calculate_outlined);
    expect(storeTab, findsOneWidget);
    await tester.tap(storeTab);
    await tester.pumpAndSettle();

    // Verify Fertilizer Calculator screen is displayed
    expect(find.text('Fertilizer Calc'), findsOneWidget);
    expect(find.text('Co-op Store'), findsOneWidget);
    expect(find.text('Recommended Fertilizer Dosage'), findsOneWidget);

    // 7. Test Tab 3: Admin Panel
    final adminTab = find.byIcon(Icons.admin_panel_settings_outlined);
    expect(adminTab, findsOneWidget);
    await tester.tap(adminTab);
    await tester.pumpAndSettle();

    // Verify Admin Panel dashboard is displayed
    expect(find.text('Co-operative Management'), findsOneWidget);
    expect(find.text('Registered Farmers'), findsOneWidget);
    expect(find.text('Quick Stock Update'), findsOneWidget);

    // 8. Test Navigation back to Tab 0: Scan & Diagnose
    final scanTab = find.byIcon(Icons.document_scanner_outlined);
    expect(scanTab, findsOneWidget);
    await tester.tap(scanTab);
    await tester.pumpAndSettle();

    // Verify back to Scan tab smoothly
    expect(find.text('AI Plant Doctor'), findsOneWidget);
  });
}
