import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_editor/data/asset_loader.dart';
import 'package:z_editor/l10n/app_localizations.dart';

enum PlantCategory { quality, role, attribute, other, collection }

extension PlantCategoryExtension on PlantCategory {
  String getLabel(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    switch (this) {
      case PlantCategory.quality:
        return s.plantCategoryQuality;
      case PlantCategory.role:
        return s.plantCategoryRole;
      case PlantCategory.attribute:
        return s.plantCategoryAttribute;
      case PlantCategory.other:
        return s.plantCategoryOther;
      case PlantCategory.collection:
        return s.plantCategoryCollection;
    }
  }
}

enum PlantTag {
  all,
  white,
  green,
  blue,
  purple,
  orange,
  assist,
  remote,
  productor,
  defence,
  vanguard,
  trapper,
  fire,
  ice,
  magic,
  poison,
  electric,
  physics,
  original,
  parallel,
}

extension PlantTagExtension on PlantTag {
  String getLabel(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    switch (this) {
      case PlantTag.all:
        return s.plantTagAll;
      case PlantTag.white:
        return s.plantTagWhite;
      case PlantTag.green:
        return s.plantTagGreen;
      case PlantTag.blue:
        return s.plantTagBlue;
      case PlantTag.purple:
        return s.plantTagPurple;
      case PlantTag.orange:
        return s.plantTagOrange;
      case PlantTag.assist:
        return s.plantTagAssist;
      case PlantTag.remote:
        return s.plantTagRemote;
      case PlantTag.productor:
        return s.plantTagProductor;
      case PlantTag.defence:
        return s.plantTagDefence;
      case PlantTag.vanguard:
        return s.plantTagVanguard;
      case PlantTag.trapper:
        return s.plantTagTrapper;
      case PlantTag.fire:
        return s.plantTagFire;
      case PlantTag.ice:
        return s.plantTagIce;
      case PlantTag.magic:
        return s.plantTagMagic;
      case PlantTag.poison:
        return s.plantTagPoison;
      case PlantTag.electric:
        return s.plantTagElectric;
      case PlantTag.physics:
        return s.plantTagPhysics;
      case PlantTag.original:
        return s.plantTagOriginal;
      case PlantTag.parallel:
        return s.plantTagParallel;
    }
  }

  String? get iconName {
    switch (this) {
      case PlantTag.white:
        return 'Plant_White.webp';
      case PlantTag.green:
        return 'Plant_Green.webp';
      case PlantTag.blue:
        return 'Plant_Blue.webp';
      case PlantTag.purple:
        return 'Plant_Purple.webp';
      case PlantTag.orange:
        return 'Plant_Orange.webp';
      case PlantTag.assist:
        return 'Plant_Assist.webp';
      case PlantTag.remote:
        return 'Plant_Remote.webp';
      case PlantTag.productor:
        return 'Plant_Productor.webp';
      case PlantTag.defence:
        return 'Plant_Defence.webp';
      case PlantTag.vanguard:
        return 'Plant_Vanguard.webp';
      case PlantTag.trapper:
        return 'Plant_Trapper.webp';
      case PlantTag.fire:
        return 'Plant_Fire.webp';
      case PlantTag.ice:
        return 'Plant_Ice.webp';
      case PlantTag.magic:
        return 'Plant_Magic.webp';
      case PlantTag.poison:
        return 'Plant_Poison.webp';
      case PlantTag.electric:
        return 'Plant_Electric.webp';
      case PlantTag.physics:
        return 'Plant_Physics.webp';
      default:
        return null;
    }
  }

  PlantCategory get category {
    switch (this) {
      case PlantTag.all:
      case PlantTag.white:
      case PlantTag.green:
      case PlantTag.blue:
      case PlantTag.purple:
      case PlantTag.orange:
        return PlantCategory.quality;
      case PlantTag.assist:
      case PlantTag.remote:
      case PlantTag.productor:
      case PlantTag.defence:
      case PlantTag.vanguard:
      case PlantTag.trapper:
        return PlantCategory.role;
      case PlantTag.fire:
      case PlantTag.ice:
      case PlantTag.magic:
      case PlantTag.poison:
      case PlantTag.electric:
      case PlantTag.physics:
        return PlantCategory.attribute;
      case PlantTag.original:
      case PlantTag.parallel:
        return PlantCategory.other;
    }
  }
}

class PlantInfo {
  final String id;
  final String name;
  final List<PlantTag> tags;
  final String? icon;

  PlantInfo({
    required this.id,
    required this.name,
    required this.tags,
    this.icon,
  });

  String? get iconAssetPath {
    if (icon == null) return null;
    final path = icon!;
    return 'assets/images/plants/$path';
  }
}

class PlantRepository {
  static final PlantRepository _instance = PlantRepository._internal();
  factory PlantRepository() => _instance;
  PlantRepository._internal();

  List<PlantInfo> _allPlants = [];
  final List<String> _favoriteIds = [];
  bool _isLoaded = false;
  final Set<String> _uiConfiguredAliases = {};

  List<PlantInfo> get allPlants => _allPlants;
  List<String> get favoriteIds => _favoriteIds;
  bool get isLoaded => _isLoaded;

  Future<void> init() async {
    if (_isLoaded) return;
    await _loadFavorites();
    try {
      final jsonString = await loadJsonString('assets/resources/Plants.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      _allPlants =
          jsonList.map((jsonItem) {
            final id = jsonItem['id'] as String;
            final name = jsonItem['name'] as String;
            final icon = jsonItem['icon'] as String?;
            final tagsList = (jsonItem['tags'] as List<dynamic>?)?.cast<
              String
            >();

            _uiConfiguredAliases.add(id);

            final tags =
                tagsList
                    ?.map((tagStr) {
                      final normalizedTag = tagStr
                          .replaceAll('_', '')
                          .toLowerCase();
                      return PlantTag.values.firstWhere(
                        (e) => e.name.toLowerCase() == normalizedTag,
                        orElse: () => PlantTag.all,
                      );
                    })
                    .where((element) => element != PlantTag.all)
                    .toList() ??
                [];

            return PlantInfo(
              id: id,
              name: name,
              icon: icon,
              tags: tags.isEmpty ? [PlantTag.all] : tags,
            );
          }).toList();

      _isLoaded = true;
    } catch (e) {
      debugPrint('Error loading plants: $e');
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_plants');
    if (favorites != null) {
      _favoriteIds.clear();
      _favoriteIds.addAll(favorites);
    }
  }

  /// Returns the name key for localization (e.g. "plant_sunflower").
  /// Use ResourceNames.lookup(context, getName(id)) for display.
  String getName(String id) {
    for (final p in _allPlants) {
      if (p.id == id) return p.name;
    }
    return 'plant_$id';
  }

  PlantInfo? getPlantInfoById(String id) {
    try {
      return _allPlants.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  List<PlantInfo> search(String query, PlantTag? tag, PlantCategory category) {
    if (!_isLoaded) return [];
    final baseList =
        category == PlantCategory.collection
            ? _allPlants.where((p) => _favoriteIds.contains(p.id)).toList()
            : (tag != null && tag != PlantTag.all
                ? _allPlants.where((p) => p.tags.contains(tag)).toList()
                : _allPlants);

    if (query.trim().isEmpty) return baseList;
    final lower = query.toLowerCase();
    return baseList
        .where(
          (p) =>
              p.id.toLowerCase().contains(lower) ||
              p.name.toLowerCase().contains(lower),
        )
        .toList();
  }

  Future<void> toggleFavorite(String id) async {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_plants', _favoriteIds);
  }
}
