// Run: dart run tool/extract_resource_names.dart
// Extracts plant/zombie names from JSON and generates resource localization files.
import 'dart:convert';
import 'dart:io';

void main() async {
  final baseDir = Directory.current;
  final projectRoot = baseDir.path.endsWith('z_editor') ? baseDir.path : '$baseDir/z_editor';
  final assetsDir = Directory('$projectRoot/assets');

  final plantsJson = File('${assetsDir.path}/resources/Plants.json');
  final zombiesJson = File('${assetsDir.path}/resources/Zombies.json');
  final l10nDir = Directory('${assetsDir.path}/l10n');
  if (!l10nDir.existsSync()) l10nDir.createSync(recursive: true);

  final Map<String, String> plantZh = {};
  final Map<String, String> zombieZh = {};

  if (plantsJson.existsSync()) {
    final list = json.decode(await plantsJson.readAsString()) as List;
    for (final item in list) {
      final id = item['id'] as String;
      final name = item['name'] as String? ?? id;
      plantZh['plant_$id'] = name;
    }
  }

  if (zombiesJson.existsSync()) {
    final list = json.decode(await zombiesJson.readAsString()) as List;
    for (final item in list) {
      final id = item['id'] as String;
      final name = item['name'] as String? ?? id;
      zombieZh['zombie_$id'] = name;
    }
  }

  final zh = {...plantZh, ...zombieZh};
  final en = zh.map((k, v) => MapEntry(k, _toEnglishFallback(k)));
  final ru = zh.map((k, v) => MapEntry(k, _toEnglishFallback(k))); // Use EN as fallback for RU

  await File('${l10nDir.path}/resource_zh.json').writeAsString(
    const JsonEncoder.withIndent('  ').convert(zh),
  );
  await File('${l10nDir.path}/resource_en.json').writeAsString(
    const JsonEncoder.withIndent('  ').convert(en),
  );
  await File('${l10nDir.path}/resource_ru.json').writeAsString(
    const JsonEncoder.withIndent('  ').convert(ru),
  );

  // Update Plants.json - replace name with key
  if (plantsJson.existsSync()) {
    final list = json.decode(await plantsJson.readAsString()) as List;
    for (int i = 0; i < list.length; i++) {
      final item = list[i] as Map<String, dynamic>;
      final id = item['id'] as String;
      item['name'] = 'plant_$id';
    }
    await plantsJson.writeAsString(const JsonEncoder.withIndent('    ').convert(list));
  }

  // Update Zombies.json - replace name with key
  if (zombiesJson.existsSync()) {
    final list = json.decode(await zombiesJson.readAsString()) as List;
    for (int i = 0; i < list.length; i++) {
      final item = list[i] as Map<String, dynamic>;
      final id = item['id'] as String;
      item['name'] = 'zombie_$id';
    }
    await zombiesJson.writeAsString(const JsonEncoder.withIndent('    ').convert(list));
  }

  // ignore: avoid_print
  print('Generated resource_zh.json, resource_en.json, resource_ru.json');
  // ignore: avoid_print
  print('Updated Plants.json and Zombies.json with name keys');
}

String _toEnglishFallback(String key) {
  final id = key.replaceFirst(RegExp(r'^(plant|zombie)_'), '');
  return id.split('_').map((s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}').join(' ');
}
