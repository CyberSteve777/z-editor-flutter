// Run: dart run tool/merge_resources.dart
// Merges Plants_1.json and Zombies_1.json into main JSON files.
// Updates icons to webp, keeps name keys (plant_*, zombie_*), updates resource_zh.json.
import 'dart:convert';
import 'dart:io';

void main() async {
  final baseDir = Directory.current;
  final projectRoot = baseDir.path.endsWith('z_editor') ? baseDir.path : '$baseDir/z_editor';
  final assetsDir = Directory('$projectRoot/assets');
  final resourcesDir = Directory('${assetsDir.path}/resources');
  final l10nDir = Directory('${assetsDir.path}/l10n');

  // Merge Plants
  final plantsPath = '${resourcesDir.path}/Plants.json';
  final plants1Path = '${resourcesDir.path}/Plants_1.json';
  if (File(plants1Path).existsSync()) {
    final plants = json.decode(await File(plantsPath).readAsString()) as List;
    final plants1 = json.decode(await File(plants1Path).readAsString()) as List;
    final existingIds = plants.map((e) => (e as Map)['id'] as String).toSet();
    final plantZh = <String, String>{};

    for (final item1 in plants1) {
      final map1 = item1 as Map<String, dynamic>;
      final id = map1['id'] as String;
      final nameZh = map1['name'] as String? ?? id;
      final icon = map1['icon'] as String? ?? 'icon_$id.webp';
      final tags = map1['tags'] as List<dynamic>?;
      plantZh['plant_$id'] = nameZh;

      final idx = plants.indexWhere((e) => (e as Map)['id'] == id);
      if (idx >= 0) {
        (plants[idx] as Map<String, dynamic>)['icon'] = icon;
        if (tags != null) (plants[idx] as Map<String, dynamic>)['tags'] = tags;
      } else {
        plants.add({
          'id': id,
          'name': 'plant_$id',
          'tags': tags ?? [],
          'icon': icon,
        });
      }
    }

    await File(plantsPath).writeAsString(const JsonEncoder.withIndent('    ').convert(plants));
    await File(plants1Path).delete();

    // Update resource_zh.json with plant names
    final zhPath = '${l10nDir.path}/resource_zh.json';
    if (File(zhPath).existsSync()) {
      final zh = Map<String, String>.from(json.decode(await File(zhPath).readAsString()) as Map);
      zh.addAll(plantZh);
      await File(zhPath).writeAsString(const JsonEncoder.withIndent('  ').convert(zh));
    }
  }

  // Merge Zombies
  final zombiesPath = '${resourcesDir.path}/Zombies.json';
  final zombies1Path = '${resourcesDir.path}/Zombies_1.json';
  if (File(zombies1Path).existsSync()) {
    final zombies = json.decode(await File(zombiesPath).readAsString()) as List;
    final zombies1 = json.decode(await File(zombies1Path).readAsString()) as List;
    final zombieZh = <String, String>{};

    for (final item1 in zombies1) {
      final map1 = item1 as Map<String, dynamic>;
      final id = map1['id'] as String;
      final nameZh = map1['name'] as String? ?? id;
      final icon = map1['icon'] as String? ?? 'zombie_$id.webp';
      final tags = map1['tags'] as List<dynamic>?;
      zombieZh['zombie_$id'] = nameZh;

      final idx = zombies.indexWhere((e) => (e as Map)['id'] == id);
      if (idx >= 0) {
        (zombies[idx] as Map<String, dynamic>)['icon'] = icon;
        if (tags != null) (zombies[idx] as Map<String, dynamic>)['tags'] = tags;
      } else {
        zombies.add({
          'id': id,
          'name': 'zombie_$id',
          'tags': tags ?? [],
          'icon': icon,
        });
      }
    }

    await File(zombiesPath).writeAsString(const JsonEncoder.withIndent('    ').convert(zombies));
    await File(zombies1Path).delete();

    // Update resource_zh.json with zombie names
    final zhPath = '${l10nDir.path}/resource_zh.json';
    if (File(zhPath).existsSync()) {
      final zh = Map<String, String>.from(json.decode(await File(zhPath).readAsString()) as Map);
      zh.addAll(zombieZh);
      await File(zhPath).writeAsString(const JsonEncoder.withIndent('  ').convert(zh));
    }
  }

  print('Merged Plants_1.json and Zombies_1.json into main files');
  print('Deleted Plants_1.json and Zombies_1.json');
}
