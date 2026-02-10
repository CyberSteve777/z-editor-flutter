// Run: dart run tool/merge_resources.dart
// Merges Plants_1.json and Zombies_1.json into main JSON files.
// Updates icons/tags, keeps name keys (plant_*, zombie_*), updates resource_zh/en/ru.json.
import 'dart:convert';
import 'dart:io';

String _toEnglishFallback(String key) {
  final id = key.replaceFirst(RegExp(r'^(plant|zombie)_'), '');
  return id.split('_').map((s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}').join(' ');
}

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
    final plantZh = <String, String>{};

    for (final item1 in plants1) {
      final map1 = item1 as Map<String, dynamic>;
      final id = map1['id'] as String;
      final nameZh = map1['name'] as String? ?? id;
      final icon = map1['icon'] as String? ?? 'icon_$id.webp';
      final tags = map1['tags'] as List<dynamic>?;
      final key = 'plant_$id';
      plantZh[key] = nameZh;

      final idx = plants.indexWhere((e) => (e as Map)['id'] == id);
      if (idx >= 0) {
        (plants[idx] as Map<String, dynamic>)['icon'] = icon;
        if (tags != null) (plants[idx] as Map<String, dynamic>)['tags'] = tags;
      } else {
        plants.add({
          'id': id,
          'name': key,
          'tags': tags ?? [],
          'icon': icon,
        });
      }
    }

    await File(plantsPath).writeAsString(const JsonEncoder.withIndent('    ').convert(plants));
    await File(plants1Path).delete();

    _updateL10n(l10nDir, plantZh);
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
      final key = 'zombie_$id';
      zombieZh[key] = nameZh;

      final idx = zombies.indexWhere((e) => (e as Map)['id'] == id);
      if (idx >= 0) {
        (zombies[idx] as Map<String, dynamic>)['icon'] = icon;
        if (tags != null) (zombies[idx] as Map<String, dynamic>)['tags'] = tags;
      } else {
        zombies.add({
          'id': id,
          'name': key,
          'tags': tags ?? [],
          'icon': icon,
        });
      }
    }

    await File(zombiesPath).writeAsString(const JsonEncoder.withIndent('    ').convert(zombies));
    await File(zombies1Path).delete();

    _updateL10n(l10nDir, zombieZh);
  }

  // ignore: avoid_print
  print('Merged Plants_1.json and Zombies_1.json into main files');
  // ignore: avoid_print
  print('Updated resource_zh.json, resource_en.json, resource_ru.json');
  // ignore: avoid_print
  print('Deleted Plants_1.json and Zombies_1.json');
}

void _updateL10n(Directory l10nDir, Map<String, String> zhEntries) {
  final zhPath = '${l10nDir.path}/resource_zh.json';
  if (File(zhPath).existsSync()) {
    final zh = Map<String, String>.from(json.decode(File(zhPath).readAsStringSync()) as Map);
    zh.addAll(zhEntries);
    File(zhPath).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(zh));
  }
  for (final locale in ['en', 'ru']) {
    final path = '${l10nDir.path}/resource_$locale.json';
    if (File(path).existsSync()) {
      final map = Map<String, String>.from(json.decode(File(path).readAsStringSync()) as Map);
      for (final k in zhEntries.keys) {
        if (!map.containsKey(k)) map[k] = _toEnglishFallback(k);
      }
      File(path).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(map));
    }
  }
}
