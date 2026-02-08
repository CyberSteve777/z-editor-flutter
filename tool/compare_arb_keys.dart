import 'dart:convert';
import 'dart:io';

void main() {
  final enPath = 'assets/l10n/app_en.arb';
  final zhPath = 'assets/l10n/app_zh.arb';
  final ruPath = 'assets/l10n/app_ru.arb';

  final enKeys = _extractKeys(enPath);
  final zhKeys = _extractKeys(zhPath);
  final ruKeys = _extractKeys(ruPath);

  print('app_en.arb: ${enKeys.length} keys');
  print('app_zh.arb: ${zhKeys.length} keys');
  print('app_ru.arb: ${ruKeys.length} keys');

  final missingInZh = enKeys.difference(zhKeys);
  final missingInRu = enKeys.difference(ruKeys);
  final extraInZh = zhKeys.difference(enKeys);
  final extraInRu = ruKeys.difference(enKeys);

  if (missingInZh.isNotEmpty) {
    print('\nMissing in app_zh.arb (${missingInZh.length}):');
    for (final k in (missingInZh.toList()..sort())) {
      print('  $k');
    }
  }
  if (missingInRu.isNotEmpty) {
    print('\nMissing in app_ru.arb (${missingInRu.length}):');
    for (final k in (missingInRu.toList()..sort())) {
      print('  $k');
    }
  }
  if (extraInZh.isNotEmpty) {
    print('\nExtra in app_zh.arb (${extraInZh.length}):');
    for (final k in (extraInZh.toList()..sort())) {
      print('  $k');
    }
  }
  if (extraInRu.isNotEmpty) {
    print('\nExtra in app_ru.arb (${extraInRu.length}):');
    for (final k in (extraInRu.toList()..sort())) {
      print('  $k');
    }
  }
  if (missingInZh.isEmpty && missingInRu.isEmpty && extraInZh.isEmpty && extraInRu.isEmpty) {
    print('\nAll ARB files have identical keys.');
  }
}

Set<String> _extractKeys(String path) {
  final content = File(path).readAsStringSync();
  final map = jsonDecode(content) as Map<String, dynamic>;
  return map.keys.where((k) => !k.startsWith('@')).toSet();
}
