import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Loads and provides localized resource names (plants, zombies) from JSON.
/// Keys in JSON are like "plant_sunflower", "zombie_mummy".
class ResourceNames {
  ResourceNames._();

  static final Map<String, Map<String, String>> _cache = {};
  static bool _loaded = false;

  static Future<void> ensureLoaded() async {
    if (_loaded) return;
    for (final locale in ['en', 'zh', 'ru']) {
      try {
        final jsonStr = await rootBundle.loadString('assets/l10n/resource_$locale.json');
        _cache[locale] = Map<String, String>.from(
          jsonDecode(jsonStr) as Map<dynamic, dynamic>,
        );
      } catch (e) {
        _cache[locale] = {};
      }
    }
    _loaded = true;
  }

  static String lookup(BuildContext context, String key) {
    if (!_loaded) return key; // Fallback until loaded
    final locale = Localizations.localeOf(context).languageCode;
    final map = _cache[locale] ?? _cache['en'] ?? {};
    return map[key] ?? key;
  }

  static String lookupWithLocale(String localeCode, String key) {
    final map = _cache[localeCode] ?? _cache['en'] ?? {};
    return map[key] ?? key;
  }
}
