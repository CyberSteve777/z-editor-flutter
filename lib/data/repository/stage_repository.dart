import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:z_editor/data/asset_loader.dart';

/// Stage data for level editor.
enum StageType { all, main, extra, seasons, special }

class StageItem {
  const StageItem({required this.alias, this.iconName, required this.type});

  final String alias;
  final String? iconName;
  final StageType type;
}

class StageRepository {
  StageRepository._();

  static const String _resourcePath = 'assets/resources/Stages.json';
  static final List<StageItem> _database = [];
  static bool _isLoaded = false;

  static Future<void> init() async {
    if (_isLoaded) return;
    try {
      final jsonString = await loadJsonString(_resourcePath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      _database
        ..clear()
        ..addAll(
          jsonList.map((raw) {
            final item = raw as Map<String, dynamic>;
            return StageItem(
              alias: item['alias'] as String,
              iconName: item['iconName'] as String?,
              type: _parseType(item['type'] as String?),
            );
          }),
        );
      _isLoaded = true;
    } catch (e) {
      debugPrint('Error loading stages: $e');
    }
  }

  static List<StageItem> get allItems => List.unmodifiable(_database);

  static List<StageItem> getByType(StageType type) {
    if (type == StageType.all) return allItems;
    return _database.where((s) => s.type == type).toList();
  }

  /// Localization key for stage name. Use ResourceNames.lookup(context, getName(alias)).
  static String getName(String alias) => 'stage_$alias';

  static StageType _parseType(String? raw) {
    return StageType.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => StageType.main,
    );
  }
}
