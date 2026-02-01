/// Stage data for level editor. Ported from Z-Editor-master StageRepository.kt
enum StageType { all, main, extra, seasons, special }

class StageItem {
  const StageItem({
    required this.alias,
    required this.name,
    this.iconName,
    required this.type,
  });

  final String alias;
  final String name;
  final String? iconName;
  final StageType type;
}

class StageRepository {
  StageRepository._();

  static const List<StageItem> _database = [
    StageItem(alias: 'TutorialStage', name: 'Tutorial', iconName: 'Stage_Modern.png', type: StageType.main),
    StageItem(alias: 'EgyptStage', name: 'Ancient Egypt', iconName: 'Stage_Egypt.png', type: StageType.main),
    StageItem(alias: 'PirateStage', name: 'Pirate Seas', iconName: 'Stage_Pirate.png', type: StageType.main),
    StageItem(alias: 'WestStage', name: 'Wild West', iconName: 'Stage_West.png', type: StageType.main),
    StageItem(alias: 'KongfuStage', name: 'Kongfu World', iconName: 'Stage_Kongfu.png', type: StageType.main),
    StageItem(alias: 'FutureStage', name: 'Future', iconName: 'Stage_Future.png', type: StageType.main),
    StageItem(alias: 'DarkStage', name: 'Dark Ages', iconName: 'Stage_Dark.png', type: StageType.main),
    StageItem(alias: 'BeachStage', name: 'Big Wave Beach', iconName: 'Stage_Beach.png', type: StageType.main),
    StageItem(alias: 'IceageStage', name: 'Ice Age', iconName: 'Stage_Iceage.png', type: StageType.main),
    StageItem(alias: 'LostCityStage', name: 'Lost City', iconName: 'Stage_LostCity.png', type: StageType.main),
    StageItem(alias: 'SkycityStage', name: 'Sky City', iconName: 'Stage_Skycity.png', type: StageType.main),
    StageItem(alias: 'EightiesStage', name: 'Neon Mixtape', iconName: 'Stage_Eighties.png', type: StageType.main),
    StageItem(alias: 'DinoStage', name: 'Jurassic Marsh', iconName: 'Stage_Dino.png', type: StageType.main),
    StageItem(alias: 'ModernStage', name: 'Modern Day', iconName: 'Stage_Modern.png', type: StageType.main),
    StageItem(alias: 'SteamStage', name: 'Steam Age', iconName: 'Stage_Steam.png', type: StageType.main),
    StageItem(alias: 'RenaiStage', name: 'Renaissance', iconName: 'Stage_Renai.png', type: StageType.main),
    StageItem(alias: 'HeianStage', name: 'Heian Era', iconName: 'Stage_Heian.png', type: StageType.main),
    StageItem(alias: 'DeepseaStage', name: 'Deep Sea', iconName: 'Stage_Atlantis.png', type: StageType.main),
    StageItem(alias: 'DeepseaLandStage', name: 'Atlantis', iconName: 'Stage_Atlantis.png', type: StageType.main),
    StageItem(alias: 'FairyTaleStage', name: 'Fairy Tale', type: StageType.extra),
    StageItem(alias: 'ZCorpStage', name: 'Z-Corp', type: StageType.extra),
    StageItem(alias: 'RiftStage', name: "Penny's Pursuit", type: StageType.extra),
    StageItem(alias: 'TwisterStage', name: 'Day', type: StageType.seasons),
    StageItem(alias: 'NightStage', name: 'Night', type: StageType.seasons),
    StageItem(alias: 'PoolDaylightStage', name: 'Pool Day', type: StageType.seasons),
    StageItem(alias: 'PoolNightStage', name: 'Pool Night', type: StageType.seasons),
    StageItem(alias: 'RoofStage', name: 'Roof Day', type: StageType.seasons),
    StageItem(alias: 'RoofNightStage', name: 'Roof Night', type: StageType.seasons),
    StageItem(alias: 'TheatreDarkStage', name: 'Theatre', type: StageType.special),
    StageItem(alias: 'BowlingStage', name: 'Bowling', type: StageType.special),
    StageItem(alias: 'AquariumStage', name: 'Aquarium', type: StageType.special),
  ];

  static List<StageItem> get allItems => List.unmodifiable(_database);

  static List<StageItem> getByType(StageType type) {
    if (type == StageType.all) return allItems;
    return _database.where((s) => s.type == type).toList();
  }
}
