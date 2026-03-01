import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../pvz_models.dart';
import '../rtid_parser.dart';

/// Animation-related keys to exclude from fish property sheets.
const _animationExcludeKeys = {
  'DisplayActions',
  'DisplayAvatarActions',
  'AnimRigProps',
  'AnimRigClass',
  'PopAnim',
};

/// Loads CreatureTypes.json and PropertySheets.json.
/// Maps fish CreatureClass to property sheet (e.g. FishSwordfish -> SwordfishDefault).
/// Excludes animation keys from property sheet data.
class FishPropertiesRepository {
  FishPropertiesRepository._();
  static final FishPropertiesRepository instance = FishPropertiesRepository._();

  final Map<String, String> _aliasToTypeName = {};
  final Map<String, PvzObject> _typeCache = {};
  final Map<String, PvzObject> _propsCache = {};
  bool _isInitialized = false;

  static Future<void> init() async {
    if (instance._isInitialized) return;
    try {
      final creatureTypes = await _loadCreatureTypes();
      final propertySheets = await _loadPropertySheets();

      for (final obj in creatureTypes) {
        if (obj.objClass != 'CreatureType') continue;
        final objdata = obj.objData as Map<String, dynamic>?;
        if (objdata == null) continue;
        final creatureClass = objdata['CreatureClass'] as String? ?? '';
        if (!creatureClass.contains('Fish')) continue;
        final typeName = objdata['TypeName'] as String? ?? '';
        if (typeName.isEmpty) continue;
        final aliases = obj.aliases ?? [];
        final alias = aliases.isNotEmpty ? aliases.first : typeName;
        final propsRtid = objdata['Properties'] as String? ?? '';
        final propsInfo = RtidParser.parse(propsRtid);
        final propsAlias = propsInfo?.alias ?? '';
        if (propsAlias.isEmpty) continue;

        instance._aliasToTypeName[alias] = typeName;
        instance._aliasToTypeName[typeName] = typeName;

        final typeClone = PvzObject(
          aliases: List<String>.from(aliases),
          objClass: obj.objClass,
          objData: _cloneExcluding(obj.objData, _animationExcludeKeys),
        );
        instance._typeCache[typeName] = typeClone;
        instance._typeCache[alias] = typeClone;

        PvzObject propsClone;
        final propsObj = propertySheets[propsAlias];
        if (propsObj != null && propsObj.objData is Map<String, dynamic>) {
          final propsData = Map<String, dynamic>.from(propsObj.objData as Map);
          _removeKeys(propsData, _animationExcludeKeys);
          propsClone = PvzObject(
            aliases: [propsAlias],
            objClass: propsObj.objClass,
            objData: propsData,
          );
        } else {
          propsClone = PvzObject(
            aliases: [propsAlias],
            objClass: 'PropertySheet',
            objData: <String, dynamic>{},
          );
        }
        instance._propsCache[typeName] = propsClone;
        instance._propsCache[alias] = propsClone;
      }
      instance._isInitialized = true;
    } catch (e) {
      debugPrint('FishPropertiesRepository init error: $e');
      instance._isInitialized = true;
    }
  }

  static Future<List<PvzObject>> _loadCreatureTypes() async {
    try {
      final jsonStr =
          await rootBundle.loadString('assets/reference/CreatureTypes.json');
      final root = jsonDecode(jsonStr) as Map<String, dynamic>?;
      final list = root?['objects'] as List<dynamic>? ?? [];
      return list
          .whereType<Map<String, dynamic>>()
          .map((e) => PvzObject.fromJson(e))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<Map<String, PvzObject>> _loadPropertySheets() async {
    try {
      final jsonStr =
          await rootBundle.loadString('assets/reference/PropertySheets.json');
      final root = jsonDecode(jsonStr) as Map<String, dynamic>;
      final list = (root['objects'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map((e) => PvzObject.fromJson(e))
          .toList();
      final result = <String, PvzObject>{};
      for (final o in list) {
        final alias = o.aliases?.isNotEmpty == true ? o.aliases!.first : '';
        if (alias.isNotEmpty && !result.containsKey(alias)) {
          result[alias] = o;
        }
      }
      return result;
    } catch (_) {
      return {};
    }
  }

  static dynamic _cloneExcluding(dynamic data, Set<String> exclude) {
    if (data is Map) {
      final m = <String, dynamic>{};
      for (final e in (data as Map<String, dynamic>).entries) {
        if (!exclude.contains(e.key)) {
          m[e.key] = _cloneExcluding(e.value, exclude);
        }
      }
      return m;
    }
    if (data is List) {
      return data.map((e) => _cloneExcluding(e, exclude)).toList();
    }
    return data;
  }

  static void _removeKeys(Map<String, dynamic> map, Set<String> keys) {
    for (final k in keys) {
      map.remove(k);
    }
  }

  /// Returns type name for alias or typeName.
  static String getTypeName(String aliasOrTypeName) {
    return instance._aliasToTypeName[aliasOrTypeName] ?? aliasOrTypeName;
  }

  /// Returns template {type: PvzObject, props: PvzObject} for built-in fish.
  /// Props exclude animation keys.
  static Map<String, PvzObject>? getFishTemplate(String aliasOrTypeName) {
    final type = instance._typeCache[aliasOrTypeName];
    final props = instance._propsCache[aliasOrTypeName];
    if (type == null || props == null) return null;
    return {'type': type, 'props': props};
  }

  static bool get isInitialized => instance._isInitialized;
}
