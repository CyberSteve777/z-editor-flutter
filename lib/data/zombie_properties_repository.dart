import 'dart:convert';
import 'package:flutter/services.dart';
import 'pvz_models.dart';
import 'rtid_parser.dart';
 
class ZombiePropertiesRepository {
  ZombiePropertiesRepository._();
  static final ZombiePropertiesRepository instance = ZombiePropertiesRepository._();
 
  final Map<String, ZombieStats> _statsCache = {};
  final Map<String, String> _aliasToTypeCache = {};
  final Map<String, PvzObject> _originalTypeJson = {};
  final Map<String, PvzObject> _originalPropsJson = {};
  bool _isInitialized = false;
 
  static Future<void> init() async {
    if (instance._isInitialized) return;
    try {
      final propsFileMap = await _loadReferenceFile('assets/reference/PropertySheets.json');
      final typesFileMap = await _loadReferenceFile('assets/reference/ZombieTypes.json');
 
      for (final entry in typesFileMap.entries) {
        final alias = entry.key;
        final obj = entry.value;
        try {
          if (obj.objData is! Map<String, dynamic>) continue;
          final typeData = ZombieTypeData.fromJson(obj.objData as Map<String, dynamic>);
          final typeName = typeData.typeName;
          if (typeName.isEmpty) continue;
 
          instance._aliasToTypeCache[alias] = typeName;
          instance._aliasToTypeCache[typeName] = typeName;
          instance._originalTypeJson[typeName] = obj;
 
          final propsAlias = RtidParser.parse(typeData.properties)?.alias ?? '';
          final propsObj = propsFileMap[propsAlias];
          if (propsObj != null && propsObj.objData is Map<String, dynamic>) {
            final sheet = ZombiePropertySheetData.fromJson(
              propsObj.objData as Map<String, dynamic>,
            );
            instance._originalPropsJson[typeName] = propsObj;
            instance._statsCache[typeName] = ZombieStats(
              id: typeName,
              hp: sheet.hitpoints,
              cost: sheet.wavePointCost,
              weight: sheet.weight,
              speed: sheet.speed,
              eatDPS: sheet.eatDPS,
              sizeType: sheet.sizeType,
            );
          }
        } catch (_) {}
      }
      instance._isInitialized = true;
    } catch (_) {
      instance._isInitialized = true;
    }
  }
 
  static Future<Map<String, PvzObject>> _loadReferenceFile(String path) async {
    try {
      final jsonStr = await rootBundle.loadString(path);
      final Map<String, dynamic> root = jsonDecode(jsonStr) as Map<String, dynamic>;
      final objects = (root['objects'] as List<dynamic>? ?? [])
          .map((e) => PvzObject.fromJson(e as Map<String, dynamic>))
          .toList();
      return {
        for (final o in objects) (o.aliases?.isNotEmpty == true ? o.aliases!.first : 'unknown'): o,
      };
    } catch (_) {
      return {};
    }
  }
 
  static String getTypeNameByAlias(String alias) {
    return instance._aliasToTypeCache[alias] ?? alias;
  }
 
  static ZombieStats getStats(String typeName) {
    return instance._statsCache[typeName] ??
        ZombieStats(id: typeName, hp: 0.0, cost: 0, weight: 0.0, speed: 0.0, eatDPS: 0.0, sizeType: 'unknown');
  }
 
  static bool isValidAlias(String alias) {
    return instance._aliasToTypeCache.containsKey(alias);
  }
 
  static Map<String, PvzObject>? getTemplateJson(String typeName) {
    final t = instance._originalTypeJson[typeName];
    final p = instance._originalPropsJson[typeName];
    if (t == null || p == null) return null;
    return {'type': t, 'props': p};
  }
 
  static bool get isInitialized => instance._isInitialized;
}
