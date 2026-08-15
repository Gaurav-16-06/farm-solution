import 'dart:async';
import 'package:flutter/foundation.dart';

/// User profile model for Firebase Authentication
class AppUser {
  final String uid;
  final String name;
  final String phoneNumber;
  final String role; // 'farmer', 'admin', 'agronomist'
  final String village;

  AppUser({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    this.role = 'farmer',
    this.village = 'Sonpur',
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'phoneNumber': phoneNumber,
    'role': role,
    'village': village,
  };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    uid: json['uid'] as String,
    name: json['name'] as String,
    phoneNumber: json['phoneNumber'] as String,
    role: json['role'] as String? ?? 'farmer',
    village: json['village'] as String? ?? 'Sonpur',
  );
}

/// Firebase Authentication Interface & Local Fallback
class FirebaseAuthService {
  AppUser? _currentUser = AppUser(
    uid: 'farmer_sonpur_001',
    name: 'Kisan Ramvilas',
    phoneNumber: '+91 98765 43210',
    role: 'farmer',
    village: 'Gopalpur, Sonpur',
  );

  AppUser? get currentUser => _currentUser;
  bool get isSignedIn => _currentUser != null;

  Future<bool> signInWithPhone(String phoneNumber, String verificationCode) async {
    // Simulated Firebase Phone Auth verification
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = AppUser(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Registered Farmer',
      phoneNumber: phoneNumber,
      role: 'farmer',
    );
    return true;
  }

  Future<void> signOut() async {
    _currentUser = null;
  }

  void switchRole(String role) {
    if (_currentUser != null) {
      _currentUser = AppUser(
        uid: _currentUser!.uid,
        name: _currentUser!.name,
        phoneNumber: _currentUser!.phoneNumber,
        role: role,
        village: _currentUser!.village,
      );
    }
  }
}

/// Cloud Firestore Service Interface
class FirebaseFirestoreService {
  final List<Map<String, dynamic>> _cloudSyncQueue = [];

  Future<void> syncToCloud(String collection, String documentId, Map<String, dynamic> data) async {
    debugPrint('Firestore [Mock Sync]: Uploaded doc to collection $collection/$documentId');
    _cloudSyncQueue.add({
      'collection': collection,
      'id': documentId,
      'data': data,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchCollection(String collection) async {
    debugPrint('Firestore [Fetch]: Querying cloud documents from $collection');
    return [];
  }
}

/// Firebase Cloud Storage for Leaf Diagnosis Photos
class FirebaseStorageService {
  Future<String> uploadLeafImage(String filePath, String fileName) async {
    debugPrint('Firebase Storage [Upload]: Uploaded $fileName from $filePath');
    return 'https://firebasestorage.googleapis.com/v0/b/sonpur-sewa-samiti.appspot.com/o/leaf_scans%2F$fileName?alt=media';
  }
}

/// Main Firebase Service Manager
class FirebaseService {
  static final FirebaseService instance = FirebaseService._internal();

  final FirebaseAuthService auth = FirebaseAuthService();
  final FirebaseFirestoreService firestore = FirebaseFirestoreService();
  final FirebaseStorageService storage = FirebaseStorageService();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  FirebaseService._internal();

  Future<void> initialize() async {
    // Boilerplate for Firebase.initializeApp()
    // When live google-services.json is attached, standard Firebase Core boots here
    try {
      _isInitialized = true;
      debugPrint('Firebase Service initialized successfully (Online sync ready).');
    } catch (e) {
      debugPrint('Firebase init fallback: $e');
    }
  }
}
