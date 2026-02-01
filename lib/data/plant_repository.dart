import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  /// Asset path for plant icon. Uses .jpg fallback when .webp is specified.
  String? get iconAssetPath {
    if (icon == null) return null;
    var path = icon!;
    if (path.endsWith('.webp')) {
      path = path.replaceAll('.webp', '.jpg');
    }
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
      final jsonString = await rootBundle.loadString(
        'assets/resources/Plants.json',
      );
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
