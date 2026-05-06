import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:z_editor/data/asset_loader.dart';

enum ZombossTag { all, main, challenge, pvz1 }

class ZombossInfo {
  const ZombossInfo({
    required this.id,
    required this.icon,
    required this.tag,
    required this.defaultPhaseCount,
  });

  final String id;
  final String icon;
  final ZombossTag tag;
  final int defaultPhaseCount;

  /// Localization key for ZombossTag labels. Use ResourceNames.lookup(context, key).
  static String tagLabelKey(ZombossTag tag) {
    return switch (tag) {
      ZombossTag.all => 'zomboss_tag_all',
      ZombossTag.main => 'zomboss_tag_main',
      ZombossTag.challenge => 'zomboss_tag_challenge',
      ZombossTag.pvz1 => 'zomboss_tag_pvz1',
    };
  }
}

class ZombossRepository {
  static const String _resourcePath = 'assets/resources/Zombosses.json';
  static final List<ZombossInfo> allZombosses = [];
  static bool _isLoaded = false;

  static Future<void> init() async {
    if (_isLoaded) return;
    try {
      final jsonString = await loadJsonString(_resourcePath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      allZombosses
        ..clear()
        ..addAll(
          jsonList.map((raw) {
            final item = raw as Map<String, dynamic>;
            return ZombossInfo(
              id: item['id'] as String,
              icon: item['icon'] as String,
              tag: _parseTag(item['tag'] as String?),
              defaultPhaseCount: item['defaultPhaseCount'] as int? ?? 3,
            );
          }),
        );
      _isLoaded = true;
    } catch (e) {
      debugPrint('Error loading zombosses: $e');
    }
  }

  static ZombossInfo? get(String id) {
    return allZombosses.where((e) => e.id == id).firstOrNull;
  }

  static List<ZombossInfo> search(String query, ZombossTag selectedTag) {
    var tagFiltered = allZombosses;
    if (selectedTag != ZombossTag.all) {
      tagFiltered = allZombosses.where((e) => e.tag == selectedTag).toList();
    }

    if (query.trim().isEmpty) return tagFiltered;

    final lowerQ = query.toLowerCase();
    return tagFiltered
        .where((e) => e.id.toLowerCase().contains(lowerQ))
        .toList();
  }

  static ZombossTag _parseTag(String? raw) {
    return ZombossTag.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => ZombossTag.main,
    );
  }
}
