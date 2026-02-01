import 'dart:convert';

import 'package:flutter/services.dart';

import 'pvz_models.dart';
import 'rtid_parser.dart';

/// Loads reference LevelModules from assets and provides alias -> objClass lookup.
/// Ported from Z-Editor-master ReferenceRepository.kt
class ReferenceRepository {
  ReferenceRepository._();
  static final ReferenceRepository instance = ReferenceRepository._();

  Map<String, PvzObject>? _moduleCache;

  /// Load LevelModules.json from assets. Call once (e.g. when entering editor).
  static Future<void> init() async {
    if (instance._moduleCache != null) return;
    try {
      final json = await rootBundle.loadString('assets/reference/LevelModules.json');
      final map = jsonDecode(json) as Map<String, dynamic>;
      final list = map['objects'] as List<dynamic>? ?? [];
      final cache = <String, PvzObject>{};
      for (final e in list) {
        final obj = PvzObject.fromJson(e as Map<String, dynamic>);
        final alias = obj.aliases?.isNotEmpty == true ? obj.aliases!.first : 'unknown';
        cache[alias] = obj;
      }
      instance._moduleCache = cache;
    } catch (_) {
      instance._moduleCache = {};
    }
  }

  String? getObjClass(String alias) {
    return _moduleCache?[alias]?.objClass;
  }

  bool get isLoaded => _moduleCache != null;
}
