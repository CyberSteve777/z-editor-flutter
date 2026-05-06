import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:z_editor/data/repository/reference_repository.dart';
import 'package:z_editor/data/asset_loader.dart';

/// Grid item info. Ported from Z-Editor-master GridItemRepository.kt
/// For display use ResourceNames.lookup(context, 'griditem_$typeName').
enum GridItemFilterMode { all, restricted, renaiStatues }

enum GridItemTag { normal, special }

class GridItemInfo {
  const GridItemInfo({
    required this.typeName,
    required this.category,
    this.icon,
    this.tag = GridItemTag.normal,
  });

  final String typeName;
  final GridItemCategory category;

  /// Icon filename in assets/images/griditems/ (e.g. 'gravestone_egypt.webp').
  /// Null = use placeholder icon.
  final String? icon;
  final GridItemTag tag;
}

enum GridItemCategory {
  all('All'),
  scene('Scene'),
  trap('Trap'),
  spawnableObjects('Spawnable Objects');

  const GridItemCategory(this.label);
  final String label;
}

/// Grid item repository. Icons from assets/images/griditems/.
/// Items without matching icon use placeholder.
/// For localized display use getLocalizedName(context, typeName) via ResourceNames.
class GridItemRepository {
  GridItemRepository._();

  static const String _resourcePath = 'assets/resources/GridItems.json';
  static final List<GridItemInfo> staticItems = [];
  static bool _isLoaded = false;

  static Future<void> init() async {
    if (_isLoaded) return;
    try {
      final jsonString = await loadJsonString(_resourcePath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      staticItems
        ..clear()
        ..addAll(
          jsonList.map((raw) {
            final item = raw as Map<String, dynamic>;
            return GridItemInfo(
              typeName: item['typeName'] as String,
              category: _parseCategory(item['category'] as String?),
              icon: item['icon'] as String?,
              tag: _parseTag(item['tag'] as String?),
            );
          }),
        );
      _isLoaded = true;
    } catch (e) {
      debugPrint('Error loading grid items: $e');
    }
  }

  static List<GridItemInfo> get allItems => staticItems;

  static List<GridItemInfo> getByCategory(GridItemCategory category) {
    if (category == GridItemCategory.all) return allItems;
    return allItems.where((i) => i.category == category).toList();
  }

  static List<GridItemInfo> getAll() => allItems;

  /// Returns asset path for icon, or unknown placeholder if no icon.
  /// For renai_zomboss_statue_zombie1_half, returns base statue icon path;
  /// caller should overlay purple "Z" badge when [needsZombossBadge] is true.
  static String getIconPath(String aliases) {
    final typeName = aliases == 'gravestone' ? 'gravestone_egypt' : aliases;
    try {
      final item = allItems.firstWhere((i) => i.typeName == typeName);
      final icon = item.icon;
      return icon != null
          ? 'assets/images/griditems/$icon'
          : 'assets/images/others/unknown.webp';
    } catch (_) {
      return 'assets/images/others/unknown.webp';
    }
  }

  /// True for renai_zomboss_statue_zombie1_half; caller should overlay purple "Z" badge.
  static bool needsZombossBadge(String typeName) =>
      typeName == 'renai_zomboss_statue_zombie1_half';

  /// True for Renai statue types that use full-body (non-half) icons.
  /// These are scaled down in [GridItemIcon] for better fit in grids and lists.
  static bool isRenaiStatueNonHalf(String typeName) =>
      isRenaiStatue(typeName) && !typeName.endsWith('_half');

  /// True for any Renai statue type (half or non-half).
  static bool isRenaiStatue(String typeName) =>
      typeName.contains('renai_statue_') ||
      typeName == 'renai_zomboss_statue_zombie1_half';

  /// Renai statue types only (for statue picker in Renai module).
  static List<GridItemInfo> getRenaiStatueItems() =>
      allItems.where((i) => isRenaiStatue(i.typeName)).toList();

  static bool isValid(String typeName) {
    if (allItems.any((i) => i.typeName == typeName)) return true;
    return ReferenceRepository.instance.isValidGridItem(typeName);
  }

  static String buildGridAliases(String id) {
    if (id == 'gravestone_egypt') return 'gravestone';
    return id;
  }

  static List<GridItemInfo> search(String query) {
    if (query.trim().isEmpty) return allItems;
    final lower = query.toLowerCase();
    return allItems
        .where((i) => i.typeName.toLowerCase().contains(lower))
        .toList();
  }

  static GridItemCategory _parseCategory(String? raw) {
    return GridItemCategory.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => GridItemCategory.scene,
    );
  }

  static GridItemTag _parseTag(String? raw) {
    return GridItemTag.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => GridItemTag.normal,
    );
  }
}
