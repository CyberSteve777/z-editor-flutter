import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:z_editor/data/asset_loader.dart';

class FishInfo {
  FishInfo({
    required this.typeName,
    required this.alias,
    required this.creatureClass,
    this.propertiesRtid,
  });

  final String typeName;
  final String alias;
  final String creatureClass;
  final String? propertiesRtid;

  String get iconAssetPath => 'assets/images/others/unknown.webp';
}

class FishTypeRepository {
  static final FishTypeRepository _instance = FishTypeRepository._internal();
  factory FishTypeRepository() => _instance;
  FishTypeRepository._internal();

  List<FishInfo> _allFishes = [];
  bool _isLoaded = false;

  List<FishInfo> get allFishes => _allFishes;
  bool get isLoaded => _isLoaded;

  Future<void> init() async {
    if (_isLoaded) return;
    try {
      final jsonString =
          await loadJsonString('assets/reference/CreatureTypes.json');
      final map = json.decode(jsonString) as Map<String, dynamic>?;
      final list = map?['objects'] as List<dynamic>? ?? [];
      _allFishes = [];
      for (final item in list) {
        if (item is! Map<String, dynamic>) continue;
        final objclass = item['objclass'] as String? ?? '';
        if (objclass != 'CreatureType') continue;
        final objdata = item['objdata'] as Map<String, dynamic>?;
        if (objdata == null) continue;
        final creatureClass = objdata['CreatureClass'] as String? ?? '';
        if (!creatureClass.contains('Fish')) continue;
        final typeName = objdata['TypeName'] as String? ?? '';
        final aliases = item['aliases'] as List<dynamic>?;
        final alias = (aliases?.isNotEmpty == true ? aliases!.first : typeName) as String;
        final props = objdata['Properties'] as String?;
        _allFishes.add(FishInfo(
          typeName: typeName,
          alias: alias,
          creatureClass: creatureClass,
          propertiesRtid: props,
        ));
      }
      _isLoaded = true;
    } catch (e) {
      debugPrint('Error loading creature types: $e');
    }
  }

  FishInfo? getFishByTypeName(String typeName) {
    try {
      return _allFishes.firstWhere((f) => f.typeName == typeName);
    } catch (_) {
      return null;
    }
  }

  FishInfo? getFishByAlias(String alias) {
    try {
      return _allFishes.firstWhere((f) => f.alias == alias);
    } catch (_) {
      return null;
    }
  }

  String buildFishRtid(String alias) => 'RTID($alias@CreatureTypes)';
}
