import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:z_editor/data/pvz_models.dart';

/// Maps magic-hat plant ids ([PlantTypes.json] `TypeName`) to [PropertySheets.json] aliases (`Properties` RTID).
const Map<String, String> kMagicHatPlantIdToPropertySheetAlias = {
  'minigame_imitater': 'MinigameImitaterDefault',
  'minigame_imitater_sun': 'MinigameImitaterSunDefault',
  'minigame_imitater_melee1': 'MinigameImitaterMelee1Default',
  'minigame_imitater_melee2': 'MinigameImitaterMelee2Default',
  'minigame_imitater_melee3': 'MinigameImitaterMelee3Default',
  'minigame_imitater_melee4': 'MinigameImitaterMelee4Default',
  'minigame_imitater_defense': 'MinigameImitaterDefense',
  'minigame_imitater_pitfall': 'MinigameImitaterPitfall',
  'minigame_imitater_helper': 'MinigameImitaterHelper',
  'minigame_imitater_adc1': 'MinigameImitaterADC1',
  'minigame_imitater_adc2': 'MinigameImitaterADC2',
  'minigame_imitater_adc3': 'MinigameImitaterADC3',
  'minigame_imitater_adc4': 'MinigameImitaterADC4',
  'minigame_imitater_adc5': 'MinigameImitaterADC5',
};

/// Loads [PVZ1CopyCatImitaterProps] entries from [PropertySheets.json] for spawn previews.
class MinigameImitaterPropertiesRepository {
  MinigameImitaterPropertiesRepository._();
  static final MinigameImitaterPropertiesRepository instance =
      MinigameImitaterPropertiesRepository._();

  final Map<String, List<String>> _spawnWhitelistByPropertyAlias = {};
  bool _initialized = false;

  static Future<void> init() async {
    await instance._ensureLoaded();
  }

  Future<void> _ensureLoaded() async {
    if (_initialized) return;
    try {
      final jsonStr =
          await rootBundle.loadString('assets/reference/PropertySheets.json');
      final root = jsonDecode(jsonStr) as Map<String, dynamic>;
      final objects = root['objects'] as List<dynamic>? ?? [];
      for (final e in objects) {
        final obj = PvzObject.fromJson(e as Map<String, dynamic>);
        if (obj.objClass != 'PVZ1CopyCatImitaterProps') continue;
        final alias = obj.aliases?.isNotEmpty == true ? obj.aliases!.first : '';
        if (alias.isEmpty) continue;
        final data = obj.objData;
        if (data is! Map<String, dynamic>) continue;
        final raw = data['SpawnPlantWhiteList'];
        if (raw is! List) continue;
        _spawnWhitelistByPropertyAlias[alias] =
            raw.map((x) => x.toString()).toList();
      }
    } catch (_) {
      // leave map partial / empty
    }
    _initialized = true;
  }

  /// Raw [SpawnPlantWhiteList] strings from the property sheet (game type names).
  List<String>? spawnPlantWhiteListForPropertyAlias(String propertySheetAlias) {
    final list = _spawnWhitelistByPropertyAlias[propertySheetAlias];
    if (list == null) return null;
    return List<String>.from(list);
  }

  String? propertySheetAliasForHatPlantId(String hatPlantId) {
    return kMagicHatPlantIdToPropertySheetAlias[hatPlantId];
  }
}

/// Normalizes game plant type strings to editor [PlantInfo.id] style (lowercase, spaces → underscores).
String normalizeMinigamePlantTypeId(String raw) {
  var s = raw.trim();
  if (s.isEmpty) return s;
  s = s.toLowerCase();
  s = s.replaceAll(RegExp(r'\s+'), '_');
  return s;
}
