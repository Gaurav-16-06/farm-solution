import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/app_constants.dart';

class HiveService {
  static const String settingsBoxName = 'settings_box';
  static const String cropsBoxName = 'crops_box';
  static const String scansBoxName = 'scans_box';
  static const String productsBoxName = 'products_box';
  static const String noticesBoxName = 'notices_box';
  static const String queriesBoxName = 'queries_box';

  Box? _settingsBox;
  Box? _cropsBox;
  Box? _scansBox;
  Box? _productsBox;
  Box? _noticesBox;
  Box? _queriesBox;

  // In-memory fallback map for environments or tests where native Hive files aren't bound
  final Map<String, Map<String, dynamic>> _inMemoryStore = {
    settingsBoxName: {},
    cropsBoxName: {},
    scansBoxName: {},
    productsBoxName: {},
    noticesBoxName: {},
    queriesBoxName: {},
  };

  Future<void> init() async {
    try {
      await Hive.initFlutter();
      _settingsBox = await Hive.openBox(settingsBoxName);
      _cropsBox = await Hive.openBox(cropsBoxName);
      _scansBox = await Hive.openBox(scansBoxName);
      _productsBox = await Hive.openBox(productsBoxName);
      _noticesBox = await Hive.openBox(noticesBoxName);
      _queriesBox = await Hive.openBox(queriesBoxName);
    } catch (e) {
      debugPrint('Hive native initialization fallback to in-memory: $e');
    }

    await _seedInitialDataIfEmpty();
  }

  Future<void> _seedInitialDataIfEmpty() async {
    // Seed Crops if empty
    final crops = getList(cropsBoxName);
    if (crops.isEmpty) {
      for (final crop in AppConstants.initialCrops) {
        await saveItem(cropsBoxName, crop['id'] as String, crop);
      }
    }

    // Seed Scans if empty
    final scans = getList(scansBoxName);
    if (scans.isEmpty) {
      for (final scan in AppConstants.initialScans) {
        await saveItem(scansBoxName, scan['id'] as String, scan);
      }
    }

    // Seed Products if empty
    final products = getList(productsBoxName);
    if (products.isEmpty) {
      for (final product in AppConstants.initialProducts) {
        await saveItem(productsBoxName, product['id'] as String, product);
      }
    }

    // Seed Notices if empty
    final notices = getList(noticesBoxName);
    if (notices.isEmpty) {
      for (final notice in AppConstants.initialNotices) {
        await saveItem(noticesBoxName, notice['id'] as String, notice);
      }
    }

    // Seed Queries if empty
    final queries = getList(queriesBoxName);
    if (queries.isEmpty) {
      for (final query in AppConstants.initialQueries) {
        await saveItem(queriesBoxName, query['id'] as String, query);
      }
    }
  }

  // --- Generic Helpers ---

  Future<void> saveItem(String boxName, String key, Map<String, dynamic> data) async {
    final box = _getBox(boxName);
    if (box != null && box.isOpen) {
      await box.put(key, jsonEncode(data));
    } else {
      _inMemoryStore[boxName]?[key] = data;
    }
  }

  Map<String, dynamic>? getItem(String boxName, String key) {
    final box = _getBox(boxName);
    if (box != null && box.isOpen) {
      final val = box.get(key);
      if (val is String) {
        return jsonDecode(val) as Map<String, dynamic>;
      } else if (val is Map) {
        return Map<String, dynamic>.from(val);
      }
    }
    return _inMemoryStore[boxName]?[key] as Map<String, dynamic>?;
  }

  List<Map<String, dynamic>> getList(String boxName) {
    final box = _getBox(boxName);
    if (box != null && box.isOpen) {
      final List<Map<String, dynamic>> list = [];
      for (var key in box.keys) {
        final val = box.get(key);
        if (val is String) {
          list.add(jsonDecode(val) as Map<String, dynamic>);
        } else if (val is Map) {
          list.add(Map<String, dynamic>.from(val));
        }
      }
      return list;
    }
    return _inMemoryStore[boxName]!.values
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }

  Future<void> deleteItem(String boxName, String key) async {
    final box = _getBox(boxName);
    if (box != null && box.isOpen) {
      await box.delete(key);
    } else {
      _inMemoryStore[boxName]?.remove(key);
    }
  }

  // --- Settings Box Specifics ---

  Future<void> saveSetting(String key, dynamic value) async {
    if (_settingsBox != null && _settingsBox!.isOpen) {
      await _settingsBox!.put(key, value);
    } else {
      _inMemoryStore[settingsBoxName]?[key] = value;
    }
  }

  dynamic getSetting(String key, {dynamic defaultValue}) {
    if (_settingsBox != null && _settingsBox!.isOpen) {
      return _settingsBox!.get(key, defaultValue: defaultValue);
    }
    return _inMemoryStore[settingsBoxName]?[key] ?? defaultValue;
  }

  Box? _getBox(String name) {
    switch (name) {
      case settingsBoxName:
        return _settingsBox;
      case cropsBoxName:
        return _cropsBox;
      case scansBoxName:
        return _scansBox;
      case productsBoxName:
        return _productsBox;
      case noticesBoxName:
        return _noticesBox;
      case queriesBoxName:
        return _queriesBox;
      default:
        return null;
    }
  }
}
