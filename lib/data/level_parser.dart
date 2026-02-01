import 'pvz_models.dart';

/// Parses PvzLevelFile into ParsedLevelData (from Z-Editor-master LevelParser.kt)
class LevelParser {
  static ParsedLevelData parseLevel(PvzLevelFile levelFile) {
    final objectMap = <String, PvzObject>{};
    for (final obj in levelFile.objects) {
      final alias = obj.aliases?.isNotEmpty == true ? obj.aliases!.first : 'unknown';
      objectMap[alias] = obj;
    }

    LevelDefinitionData? levelDef;
    final levelDefList = levelFile.objects.where((o) => o.objClass == 'LevelDefinition').toList();
    final levelDefObj = levelDefList.isEmpty ? null : levelDefList.first;
    if (levelDefObj != null && levelDefObj.objData is Map<String, dynamic>) {
      levelDef = LevelDefinitionData.fromJson(levelDefObj.objData as Map<String, dynamic>);
    }

    WaveManagerData? waveManager;
    final wmObj = levelFile.objects
        .where((o) => o.objClass == 'WaveManagerProperties')
        .firstOrNull;
    if (wmObj != null && wmObj.objData is Map<String, dynamic>) {
      waveManager = WaveManagerData.fromJson(
        wmObj.objData as Map<String, dynamic>,
      );
    }

    WaveManagerModuleData? waveModule;
    final wmmObj = levelFile.objects
        .where((o) => o.objClass == 'WaveManagerModuleProperties')
        .firstOrNull;
    if (wmmObj != null && wmmObj.objData is Map<String, dynamic>) {
      waveModule = WaveManagerModuleData.fromJson(
        wmmObj.objData as Map<String, dynamic>,
      );
    }

    return ParsedLevelData(
      levelDef: levelDef,
      waveManager: waveManager,
      waveModule: waveModule,
      objectMap: objectMap,
    );
  }

  static String extractAlias(String rtid) {
    final start = rtid.indexOf('(');
    final end = rtid.indexOf('@');
    if (start >= 0 && end > start) {
      return rtid.substring(start + 1, end);
    }
    return rtid;
  }
}
