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

  /// Icons under assets/images/fish/. Only these creatures are safe to pick in the editor.
  /// Keys are lowercase; lookups must use [_normalizeFishAlias].
  static const Map<String, String> iconAssetByAlias = {
    'hermitcrab': 'assets/images/fish/icon_hermitcrab.webp',
    'inkfish': 'assets/images/fish/icon_cutterfish.webp',
    'jellyfish': 'assets/images/fish/icon_jellyfish.webp',
    'krill': 'assets/images/fish/icon_krill.webp',
    'pufferfish': 'assets/images/fish/icon_pufferfish.webp',
    'starfish': 'assets/images/fish/icon_starfish.webp',
    'swordfish': 'assets/images/fish/icon_swordfish.webp',
  };

  /// RTIDs and JSON may use mixed case; icon map keys are lowercase.
  static String normalizeFishAlias(String s) => s.trim().toLowerCase();

  static bool hasEditorIcon(String alias) =>
      iconAssetByAlias.containsKey(normalizeFishAlias(alias));

  /// Resolved icon path, or [unknown] if this creature has no bundled icon.
  String get iconAssetPath =>
      iconAssetByAlias[normalizeFishAlias(alias)] ??
      'assets/images/others/unknown.webp';
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
    final key = FishInfo.normalizeFishAlias(typeName);
    try {
      return _allFishes
          .firstWhere((f) => FishInfo.normalizeFishAlias(f.typeName) == key);
    } catch (_) {
      return null;
    }
  }

  FishInfo? getFishByAlias(String alias) {
    final key = FishInfo.normalizeFishAlias(alias);
    try {
      return _allFishes
          .firstWhere((f) => FishInfo.normalizeFishAlias(f.alias) == key);
    } catch (_) {
      return null;
    }
  }

  String buildFishRtid(String alias) => 'RTID($alias@CreatureTypes)';
}
