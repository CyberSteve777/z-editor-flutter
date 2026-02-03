/// PVZ2 level file and object models
/// Ported from Z-Editor-master PvzDataModels.kt
library;

class PvzLevelFile {
  PvzLevelFile({required this.objects, this.version = 1});

  List<PvzObject> objects;
  int version;

  factory PvzLevelFile.fromJson(Map<String, dynamic> json) {
    final list = json['objects'] as List<dynamic>? ?? [];
    return PvzLevelFile(
      objects: list
          .map((e) => PvzObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['version'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'objects': objects.map((e) => e.toJson()).toList(),
    'version': version,
  };
}

class PvzObject {
  PvzObject({this.aliases, required this.objClass, required this.objData});

  List<String>? aliases;
  final String objClass;
  dynamic objData;

  factory PvzObject.fromJson(Map<String, dynamic> json) {
    final aliases = json['aliases'] as List<dynamic>?;
    return PvzObject(
      aliases: aliases?.cast<String>(),
      objClass: json['objclass'] as String? ?? '',
      objData: json['objdata'],
    );
  }

  Map<String, dynamic> toJson() => {
    if (aliases != null) 'aliases': aliases,
    'objclass': objClass,
    'objdata': objData,
  };
}

// ======================== 1. Level Header and Global Properties ========================

class LevelDefinitionData {
  LevelDefinitionData({
    this.name = '',
    this.levelNumber = 1,
    this.description = '',
    this.stageModule = '',
    this.loot = 'RTID(DefaultLoot@LevelModules)',
    this.startingSun = 200,
    this.victoryModule = 'RTID(VictoryOutro@LevelModules)',
    this.musicType = '',
    this.disablePeavine,
    this.isArtifactDisabled,
    this.modules = const [],
  });

  String name;
  int? levelNumber;
  String description;
  String stageModule;
  String loot;
  int? startingSun;
  String victoryModule;
  String musicType;
  bool? disablePeavine;
  bool? isArtifactDisabled;
  List<String> modules;

  factory LevelDefinitionData.fromJson(Map<String, dynamic> json) {
    final mods = json['Modules'] as List<dynamic>? ?? [];
    return LevelDefinitionData(
      name: json['Name'] as String? ?? '',
      levelNumber: json['LevelNumber'] as int?,
      description: json['Description'] as String? ?? '',
      stageModule: json['StageModule'] as String? ?? '',
      loot: json['Loot'] as String? ?? 'RTID(DefaultLoot@LevelModules)',
      startingSun: json['StartingSun'] as int?,
      victoryModule:
          json['VictoryModule'] as String? ?? 'RTID(VictoryOutro@LevelModules)',
      musicType: json['MusicType'] as String? ?? '',
      disablePeavine: json['DisablePeavine'] as bool?,
      isArtifactDisabled: json['IsArtifactDisabled'] as bool?,
      modules: mods.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Name': name,
    'LevelNumber': levelNumber,
    'Description': description,
    'StageModule': stageModule,
    'Loot': loot,
    'StartingSun': startingSun,
    'VictoryModule': victoryModule,
    'MusicType': musicType,
    if (disablePeavine != null) 'DisablePeavine': disablePeavine,
    if (isArtifactDisabled != null) 'IsArtifactDisabled': isArtifactDisabled,
    'Modules': modules,
  };
}

// === Wave Manager ===

class WaveManagerModuleData {
  WaveManagerModuleData({
    List<DynamicZombieGroup>? dynamicZombies,
    this.waveManagerProps,
    this.manualStartup,
  }) : dynamicZombies = dynamicZombies ?? [];

  List<DynamicZombieGroup> dynamicZombies;
  String? waveManagerProps;
  bool? manualStartup;

  factory WaveManagerModuleData.fromJson(Map<String, dynamic> json) {
    return WaveManagerModuleData(
      dynamicZombies: (json['DynamicZombies'] as List<dynamic>?)
              ?.map(
                (e) => DynamicZombieGroup.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          <DynamicZombieGroup>[],
      waveManagerProps: json['WaveManagerProps'] as String?,
      manualStartup: json['ManualStartup'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'DynamicZombies': dynamicZombies.map((e) => e.toJson()).toList(),
    if (waveManagerProps != null) 'WaveManagerProps': waveManagerProps,
    if (manualStartup != null) 'ManualStartup': manualStartup,
  };
}

class DynamicZombieGroup {
  DynamicZombieGroup({
    this.pointIncrement = 0,
    this.startingPoints = 0,
    this.startingWave = 0,
    List<String>? zombiePool,
    List<int>? zombieLevel,
  })  : zombiePool = zombiePool ?? [],
        zombieLevel = zombieLevel ?? [];

  int pointIncrement;
  int startingPoints;
  int startingWave;
  List<String> zombiePool;
  List<int> zombieLevel;

  factory DynamicZombieGroup.fromJson(Map<String, dynamic> json) {
    return DynamicZombieGroup(
      pointIncrement: json['PointIncrementPerWave'] as int? ?? 0,
      startingPoints: json['StartingPoints'] as int? ?? 0,
      startingWave: json['StartingWave'] as int? ?? 0,
      zombiePool: (json['ZombiePool'] as List<dynamic>?)?.cast<String>() ?? [],
      zombieLevel: (json['ZombieLevel'] as List<dynamic>?)?.cast<int>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'PointIncrementPerWave': pointIncrement,
    'StartingPoints': startingPoints,
    'StartingWave': startingWave,
    'ZombiePool': zombiePool,
    'ZombieLevel': zombieLevel,
  };
}

// === Wave List ===

class WaveManagerData {
  WaveManagerData({
    this.waveCount = 1,
    this.flagWaveInterval = 10,
    this.suppressFlagZombie,
    this.levelJam,
    this.zombieCountDownFirstWaveSecs = 12,
    this.zombieCountDownFirstWaveConveyorSecs = 5,
    this.zombieCountDownHugeWaveDelay = 5,
    this.maxNextWaveHealthPercentage = 0.85,
    this.minNextWaveHealthPercentage = 0.70,
    this.waves = const [],
  });

  int waveCount;
  int flagWaveInterval;
  bool? suppressFlagZombie;
  String? levelJam;
  int? zombieCountDownFirstWaveSecs;
  int? zombieCountDownFirstWaveConveyorSecs;
  int? zombieCountDownHugeWaveDelay;
  double maxNextWaveHealthPercentage;
  double minNextWaveHealthPercentage;
  List<List<String>> waves;

  factory WaveManagerData.fromJson(Map<String, dynamic> json) {
    var wavesList = <List<String>>[];
    if (json['Waves'] != null) {
      wavesList = (json['Waves'] as List<dynamic>)
          .map(
            (wave) => (wave as List<dynamic>).map((e) => e as String).toList(),
          )
          .toList();
    }

    return WaveManagerData(
      waveCount: json['WaveCount'] as int? ?? 1,
      flagWaveInterval: json['FlagWaveInterval'] as int? ?? 10,
      suppressFlagZombie: json['SuppressFlagZombie'] as bool?,
      levelJam: json['LevelJam'] as String?,
      zombieCountDownFirstWaveSecs:
          json['ZombieCountDownFirstWaveSecs'] as int?,
      zombieCountDownFirstWaveConveyorSecs:
          json['ZombieCountDownFirstWaveConveyorSecs'] as int?,
      zombieCountDownHugeWaveDelay:
          json['ZombieCountDownHugeWaveDelay'] as int?,
      maxNextWaveHealthPercentage:
          (json['MaxNextWaveHealthPercentage'] as num?)?.toDouble() ?? 0.85,
      minNextWaveHealthPercentage:
          (json['MinNextWaveHealthPercentage'] as num?)?.toDouble() ?? 0.70,
      waves: wavesList,
    );
  }

  Map<String, dynamic> toJson() => {
    'WaveCount': waveCount,
    'FlagWaveInterval': flagWaveInterval,
    if (suppressFlagZombie != null) 'SuppressFlagZombie': suppressFlagZombie,
    if (levelJam != null) 'LevelJam': levelJam,
    if (zombieCountDownFirstWaveSecs != null)
      'ZombieCountDownFirstWaveSecs': zombieCountDownFirstWaveSecs,
    if (zombieCountDownFirstWaveConveyorSecs != null)
      'ZombieCountDownFirstWaveConveyorSecs':
          zombieCountDownFirstWaveConveyorSecs,
    if (zombieCountDownHugeWaveDelay != null)
      'ZombieCountDownHugeWaveDelay': zombieCountDownHugeWaveDelay,
    'MaxNextWaveHealthPercentage': maxNextWaveHealthPercentage,
    'MinNextWaveHealthPercentage': minNextWaveHealthPercentage,
    'Waves': waves,
  };
}

// === Last Stand ===

class LastStandMinigamePropertiesData {
  LastStandMinigamePropertiesData({
    this.startingSun = 2000,
    this.startingPlantfood = 0,
  });

  int startingSun;
  int startingPlantfood;

  factory LastStandMinigamePropertiesData.fromJson(Map<String, dynamic> json) {
    return LastStandMinigamePropertiesData(
      startingSun: json['StartingSun'] as int? ?? 2000,
      startingPlantfood: json['StartingPlantfood'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'StartingSun': startingSun,
    'StartingPlantfood': startingPlantfood,
  };
}

// === Sun Dropper ===

class SunDropperPropertiesData {
  SunDropperPropertiesData({
    this.initialSunDropDelay = 2.0,
    this.sunCountdownBase = 4.25,
    this.sunCountdownMax = 9.5,
    this.sunCountdownIncreasePerSun = 0.1,
    this.sunCountdownRange = 2.75,
  });

  double initialSunDropDelay;
  double sunCountdownBase;
  double sunCountdownMax;
  double sunCountdownIncreasePerSun;
  double sunCountdownRange;

  factory SunDropperPropertiesData.fromJson(Map<String, dynamic> json) {
    return SunDropperPropertiesData(
      initialSunDropDelay:
          (json['InitialSunDropDelay'] as num?)?.toDouble() ?? 2.0,
      sunCountdownBase: (json['SunCountdownBase'] as num?)?.toDouble() ?? 4.25,
      sunCountdownMax: (json['SunCountdownMax'] as num?)?.toDouble() ?? 9.5,
      sunCountdownIncreasePerSun:
          (json['SunCountdownIncreasePerSun'] as num?)?.toDouble() ?? 0.1,
      sunCountdownRange:
          (json['SunCountdownRange'] as num?)?.toDouble() ?? 2.75,
    );
  }

  Map<String, dynamic> toJson() => {
    'InitialSunDropDelay': initialSunDropDelay,
    'SunCountdownBase': sunCountdownBase,
    'SunCountdownMax': sunCountdownMax,
    'SunCountdownIncreasePerSun': sunCountdownIncreasePerSun,
    'SunCountdownRange': sunCountdownRange,
  };
}

// === Seed Bank ===

class SeedBankData {
  SeedBankData({
    this.presetPlantList = const [],
    this.plantWhiteList = const [],
    this.plantBlackList = const [],
    this.selectionMethod = 'chooser',
    this.globalLevel,
    this.overrideSeedSlotsCount = 8,
    this.zombieMode,
    this.seedPacketType,
  });

  List<String> presetPlantList;
  List<String> plantWhiteList;
  List<String> plantBlackList;
  String selectionMethod;
  int? globalLevel;
  int? overrideSeedSlotsCount;
  bool? zombieMode;
  String? seedPacketType;

  factory SeedBankData.fromJson(Map<String, dynamic> json) {
    return SeedBankData(
      presetPlantList:
          (json['PresetPlantList'] as List<dynamic>?)?.cast<String>() ?? [],
      plantWhiteList:
          (json['PlantWhiteList'] as List<dynamic>?)?.cast<String>() ?? [],
      plantBlackList:
          (json['PlantBlackList'] as List<dynamic>?)?.cast<String>() ?? [],
      selectionMethod: json['SelectionMethod'] as String? ?? 'chooser',
      globalLevel: json['GlobalLevel'] as int?,
      overrideSeedSlotsCount: json['OverrideSeedSlotsCount'] as int? ?? 8,
      zombieMode: json['ZombieMode'] as bool?,
      seedPacketType: json['SeedPacketType'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'PresetPlantList': presetPlantList,
    'PlantWhiteList': plantWhiteList,
    'PlantBlackList': plantBlackList,
    'SelectionMethod': selectionMethod,
    if (globalLevel != null) 'GlobalLevel': globalLevel,
    if (overrideSeedSlotsCount != null)
      'OverrideSeedSlotsCount': overrideSeedSlotsCount,
    if (zombieMode != null) 'ZombieMode': zombieMode,
    if (seedPacketType != null) 'SeedPacketType': seedPacketType,
  };
}

// === Conveyor Belt ===

class ConveyorBeltData {
  ConveyorBeltData({
    this.initialPlantList = const [],
    this.dropDelayConditions = const [],
    this.speedConditions = const [],
  });

  List<InitialPlantListData> initialPlantList;
  List<DropDelayConditionData> dropDelayConditions;
  List<SpeedConditionData> speedConditions;

  factory ConveyorBeltData.fromJson(Map<String, dynamic> json) {
    return ConveyorBeltData(
      initialPlantList:
          (json['InitialPlantList'] as List<dynamic>?)
              ?.map(
                (e) => InitialPlantListData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      dropDelayConditions:
          (json['DropDelayConditions'] as List<dynamic>?)
              ?.map(
                (e) =>
                    DropDelayConditionData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      speedConditions:
          (json['SpeedConditions'] as List<dynamic>?)
              ?.map(
                (e) => SpeedConditionData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'InitialPlantList': initialPlantList.map((e) => e.toJson()).toList(),
    'DropDelayConditions': dropDelayConditions.map((e) => e.toJson()).toList(),
    'SpeedConditions': speedConditions.map((e) => e.toJson()).toList(),
  };
}

class DropDelayConditionData {
  DropDelayConditionData({this.delay = 0, this.maxPacketsDelay = 0});

  int delay;
  int maxPacketsDelay;

  factory DropDelayConditionData.fromJson(Map<String, dynamic> json) {
    return DropDelayConditionData(
      delay: json['Delay'] as int? ?? 0,
      maxPacketsDelay: json['MaxPackets'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'Delay': delay,
    'MaxPackets': maxPacketsDelay,
  };
}

class SpeedConditionData {
  SpeedConditionData({this.speed = 0, this.maxPacketsSpeed = 0});

  int speed;
  int maxPacketsSpeed;

  factory SpeedConditionData.fromJson(Map<String, dynamic> json) {
    return SpeedConditionData(
      speed: json['Speed'] as int? ?? 0,
      maxPacketsSpeed: json['MaxPackets'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'Speed': speed,
    'MaxPackets': maxPacketsSpeed,
  };
}

class InitialPlantListData {
  InitialPlantListData({
    this.plantType = '',
    this.iLevel,
    this.weight = 100,
    this.maxCount = 0,
    this.maxWeightFactor = 1.0,
    this.minCount = 0,
    this.minWeightFactor = 1.0,
  });

  String plantType;
  int? iLevel;
  int weight;
  int maxCount;
  double maxWeightFactor;
  int minCount;
  double minWeightFactor;

  factory InitialPlantListData.fromJson(Map<String, dynamic> json) {
    return InitialPlantListData(
      plantType: json['PlantType'] as String? ?? '',
      iLevel: json['iLevel'] as int?,
      weight: json['Weight'] as int? ?? 100,
      maxCount: json['MaxCount'] as int? ?? 0,
      maxWeightFactor: (json['MaxWeightFactor'] as num?)?.toDouble() ?? 1.0,
      minCount: json['MinCount'] as int? ?? 0,
      minWeightFactor: (json['MinWeightFactor'] as num?)?.toDouble() ?? 1.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'PlantType': plantType,
    if (iLevel != null) 'iLevel': iLevel,
    'Weight': weight,
    'MaxCount': maxCount,
    'MaxWeightFactor': maxWeightFactor,
    'MinCount': minCount,
    'MinWeightFactor': minWeightFactor,
  };
}

// === Initial Plant ===

class InitialPlantEntryData {
  InitialPlantEntryData({this.plants = const []});

  List<InitialPlantData> plants;

  factory InitialPlantEntryData.fromJson(Map<String, dynamic> json) {
    return InitialPlantEntryData(
      plants:
          (json['Plants'] as List<dynamic>?)
              ?.map((e) => InitialPlantData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'Plants': plants.map((e) => e.toJson()).toList(),
  };
}

class InitialPlantData {
  InitialPlantData({
    this.gridX = 0,
    this.gridY = 0,
    this.level = 1,
    this.avatar = false,
    this.plantTypes = const [],
  });

  int gridX;
  int gridY;
  int level;
  bool avatar;
  List<String> plantTypes;

  factory InitialPlantData.fromJson(Map<String, dynamic> json) {
    return InitialPlantData(
      gridX: json['GridX'] as int? ?? 0,
      gridY: json['GridY'] as int? ?? 0,
      level: json['Level'] as int? ?? 1,
      avatar: json['Avatar'] as bool? ?? false,
      plantTypes: (json['PlantTypes'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'GridX': gridX,
    'GridY': gridY,
    'Level': level,
    'Avatar': avatar,
    'PlantTypes': plantTypes,
  };
}

// === Initial Zombie ===

class InitialZombieEntryData {
  InitialZombieEntryData({this.placements = const []});

  List<InitialZombieData> placements;

  factory InitialZombieEntryData.fromJson(Map<String, dynamic> json) {
    return InitialZombieEntryData(
      placements:
          (json['InitialZombiePlacements'] as List<dynamic>?)
              ?.map(
                (e) => InitialZombieData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'InitialZombiePlacements': placements.map((e) => e.toJson()).toList(),
  };
}

class InitialZombieData {
  InitialZombieData({
    this.gridX = 0,
    this.gridY = 0,
    this.typeName = '',
    this.condition = 'icecubed',
  });

  int gridX;
  int gridY;
  String typeName;
  String condition;

  factory InitialZombieData.fromJson(Map<String, dynamic> json) {
    return InitialZombieData(
      gridX: json['GridX'] as int? ?? 0,
      gridY: json['GridY'] as int? ?? 0,
      typeName: json['TypeName'] as String? ?? '',
      condition: json['Condition'] as String? ?? 'icecubed',
    );
  }

  Map<String, dynamic> toJson() => {
    'GridX': gridX,
    'GridY': gridY,
    'TypeName': typeName,
    'Condition': condition,
  };
}

// === Initial Grid Item ===

class InitialGridItemEntryData {
  InitialGridItemEntryData({this.placements = const []});

  List<InitialGridItemData> placements;

  factory InitialGridItemEntryData.fromJson(Map<String, dynamic> json) {
    return InitialGridItemEntryData(
      placements:
          (json['InitialGridItemPlacements'] as List<dynamic>?)
              ?.map(
                (e) => InitialGridItemData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'InitialGridItemPlacements': placements.map((e) => e.toJson()).toList(),
  };
}

class InitialGridItemData {
  InitialGridItemData({this.gridX = 0, this.gridY = 0, this.typeName = ''});

  int gridX;
  int gridY;
  String typeName;

  factory InitialGridItemData.fromJson(Map<String, dynamic> json) {
    return InitialGridItemData(
      gridX: json['GridX'] as int? ?? 0,
      gridY: json['GridY'] as int? ?? 0,
      typeName: json['TypeName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'GridX': gridX,
    'GridY': gridY,
    'TypeName': typeName,
  };
}

// === Protect The Grid Item Challenge ===

class ProtectTheGridItemChallengePropertiesData {
  ProtectTheGridItemChallengePropertiesData({
    this.description = '',
    this.mustProtectCount = 0,
    this.gridItems = const [],
  });

  String description;
  int mustProtectCount;
  List<ProtectGridItemData> gridItems;

  factory ProtectTheGridItemChallengePropertiesData.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProtectTheGridItemChallengePropertiesData(
      description: json['Description'] as String? ?? '',
      mustProtectCount: json['MustProtectCount'] as int? ?? 0,
      gridItems:
          (json['GridItems'] as List<dynamic>?)
              ?.map(
                (e) => ProtectGridItemData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'Description': description,
    'MustProtectCount': mustProtectCount,
    'GridItems': gridItems.map((e) => e.toJson()).toList(),
  };
}

class ProtectGridItemData {
  ProtectGridItemData({this.gridX = 0, this.gridY = 0, this.gridItemType = ''});

  int gridX;
  int gridY;
  String gridItemType;

  factory ProtectGridItemData.fromJson(Map<String, dynamic> json) {
    return ProtectGridItemData(
      gridX: json['GridX'] as int? ?? 0,
      gridY: json['GridY'] as int? ?? 0,
      gridItemType: json['GridItemType'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'GridX': gridX,
    'GridY': gridY,
    'GridItemType': gridItemType,
  };
}

// === Protect The Plant Challenge ===

class ProtectThePlantChallengePropertiesData {
  ProtectThePlantChallengePropertiesData({
    this.mustProtectCount = 0,
    this.plants = const [],
  });

  int mustProtectCount;
  List<ProtectPlantData> plants;

  factory ProtectThePlantChallengePropertiesData.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProtectThePlantChallengePropertiesData(
      mustProtectCount: json['MustProtectCount'] as int? ?? 0,
      plants:
          (json['Plants'] as List<dynamic>?)
              ?.map((e) => ProtectPlantData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'MustProtectCount': mustProtectCount,
    'Plants': plants.map((e) => e.toJson()).toList(),
  };
}

class ProtectPlantData {
  ProtectPlantData({this.gridX = 0, this.gridY = 0, this.plantType = ''});

  int gridX;
  int gridY;
  String plantType;

  factory ProtectPlantData.fromJson(Map<String, dynamic> json) {
    return ProtectPlantData(
      gridX: json['GridX'] as int? ?? 0,
      gridY: json['GridY'] as int? ?? 0,
      plantType: json['PlantType'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'GridX': gridX,
    'GridY': gridY,
    'PlantType': plantType,
  };
}

// === Sun Bomb Challenge ===

class SunBombChallengeData {
  SunBombChallengeData({
    this.plantBombExplosionRadius = 25,
    this.zombieBombExplosionRadius = 80,
    this.plantDamage = 1000,
    this.zombieDamage = 500,
  });

  int plantBombExplosionRadius;
  int zombieBombExplosionRadius;
  int plantDamage;
  int zombieDamage;

  factory SunBombChallengeData.fromJson(Map<String, dynamic> json) {
    return SunBombChallengeData(
      plantBombExplosionRadius: json['PlantBombExplosionRadius'] as int? ?? 25,
      zombieBombExplosionRadius:
          json['ZombieBombExplosionRadius'] as int? ?? 80,
      plantDamage: json['PlantDamage'] as int? ?? 1000,
      zombieDamage: json['ZombieDamage'] as int? ?? 500,
    );
  }

  Map<String, dynamic> toJson() => {
    'PlantBombExplosionRadius': plantBombExplosionRadius,
    'ZombieBombExplosionRadius': zombieBombExplosionRadius,
    'PlantDamage': plantDamage,
    'ZombieDamage': zombieDamage,
  };
}

// === Star Challenge ===

class StarChallengeModuleData {
  StarChallengeModuleData({
    this.challengesAlwaysAvailable = true,
    List<dynamic>? challenges,
  }) : challenges = challenges ?? [];

  bool challengesAlwaysAvailable;
  List<dynamic> challenges; // Can be any challenge type

  factory StarChallengeModuleData.fromJson(Map<String, dynamic> json) {
    return StarChallengeModuleData(
      challengesAlwaysAvailable:
          json['ChallengesAlwaysAvailable'] as bool? ?? true,
      challenges: List<dynamic>.from(json['Challenges'] as List<dynamic>? ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'ChallengesAlwaysAvailable': challengesAlwaysAvailable,
    'Challenges': challenges,
  };
}

class StarChallengeBeatTheLevelData {
  StarChallengeBeatTheLevelData({
    this.description = '',
    this.descriptiveName = '',
  });

  String description;
  String descriptiveName;

  factory StarChallengeBeatTheLevelData.fromJson(Map<String, dynamic> json) {
    return StarChallengeBeatTheLevelData(
      description: json['Description'] as String? ?? '',
      descriptiveName: json['DescriptiveName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'Description': description,
    'DescriptiveName': descriptiveName,
  };
}

class StarChallengeSaveMowerData {
  StarChallengeSaveMowerData();
  factory StarChallengeSaveMowerData.fromJson(Map<String, dynamic> json) =>
      StarChallengeSaveMowerData();
  Map<String, dynamic> toJson() => {};
}

class StarChallengePlantFoodNonuseData {
  StarChallengePlantFoodNonuseData();
  factory StarChallengePlantFoodNonuseData.fromJson(
    Map<String, dynamic> json,
  ) => StarChallengePlantFoodNonuseData();
  Map<String, dynamic> toJson() => {};
}

class StarChallengePlantSurviveData {
  StarChallengePlantSurviveData({this.count = 10});
  int count;
  factory StarChallengePlantSurviveData.fromJson(Map<String, dynamic> json) {
    return StarChallengePlantSurviveData(count: json['Count'] as int? ?? 10);
  }
  Map<String, dynamic> toJson() => {'Count': count};
}

class StarChallengeZombieDistanceData {
  StarChallengeZombieDistanceData({this.targetDistance = 5.0});
  double targetDistance;
  factory StarChallengeZombieDistanceData.fromJson(Map<String, dynamic> json) {
    return StarChallengeZombieDistanceData(
      targetDistance: (json['TargetDistance'] as num?)?.toDouble() ?? 5.0,
    );
  }
  Map<String, dynamic> toJson() => {'TargetDistance': targetDistance};
}

class StarChallengeSunProducedData {
  StarChallengeSunProducedData({this.targetSun = 0});
  int targetSun;
  factory StarChallengeSunProducedData.fromJson(Map<String, dynamic> json) {
    return StarChallengeSunProducedData(
      targetSun: json['TargetSun'] as int? ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {'TargetSun': targetSun};
}

class StarChallengeSunUsedData {
  StarChallengeSunUsedData({this.maximumSun = 2000});
  int maximumSun;
  factory StarChallengeSunUsedData.fromJson(Map<String, dynamic> json) {
    return StarChallengeSunUsedData(
      maximumSun: json['MaximumSun'] as int? ?? 2000,
    );
  }
  Map<String, dynamic> toJson() => {'MaximumSun': maximumSun};
}

class StarChallengeSpendSunHoldoutData {
  StarChallengeSpendSunHoldoutData({this.holdoutSeconds = 0});
  int holdoutSeconds;
  factory StarChallengeSpendSunHoldoutData.fromJson(Map<String, dynamic> json) {
    return StarChallengeSpendSunHoldoutData(
      holdoutSeconds: json['HoldoutSeconds'] as int? ?? 0,
    );
  }
  Map<String, dynamic> toJson() => {'HoldoutSeconds': holdoutSeconds};
}

class StarChallengeKillZombiesInTimeData {
  StarChallengeKillZombiesInTimeData({this.zombiesToKill = 10, this.time = 10});
  int zombiesToKill;
  int time;
  factory StarChallengeKillZombiesInTimeData.fromJson(
    Map<String, dynamic> json,
  ) {
    return StarChallengeKillZombiesInTimeData(
      zombiesToKill: json['ZombiesToKill'] as int? ?? 10,
      time: json['Time'] as int? ?? 10,
    );
  }
  Map<String, dynamic> toJson() => {
    'ZombiesToKill': zombiesToKill,
    'Time': time,
  };
}

class StarChallengeZombieSpeedData {
  StarChallengeZombieSpeedData({this.speedModifier = 0.0});
  double speedModifier;
  factory StarChallengeZombieSpeedData.fromJson(Map<String, dynamic> json) {
    return StarChallengeZombieSpeedData(
      speedModifier: (json['SpeedModifier'] as num?)?.toDouble() ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() => {'SpeedModifier': speedModifier};
}

class StarChallengeSunReducedData {
  StarChallengeSunReducedData({this.sunModifier = 0.0});
  double sunModifier;
  factory StarChallengeSunReducedData.fromJson(Map<String, dynamic> json) {
    return StarChallengeSunReducedData(
      sunModifier: (json['sunModifier'] as num?)?.toDouble() ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() => {'sunModifier': sunModifier};
}

class StarChallengePlantsLostData {
  StarChallengePlantsLostData({this.maximumPlantsLost = 10});
  int maximumPlantsLost;
  factory StarChallengePlantsLostData.fromJson(Map<String, dynamic> json) {
    return StarChallengePlantsLostData(
      maximumPlantsLost: json['MaximumPlantsLost'] as int? ?? 10,
    );
  }
  Map<String, dynamic> toJson() => {'MaximumPlantsLost': maximumPlantsLost};
}

class StarChallengeSimultaneousPlantsData {
  StarChallengeSimultaneousPlantsData({this.maximumPlants = 10});
  int maximumPlants;
  factory StarChallengeSimultaneousPlantsData.fromJson(
    Map<String, dynamic> json,
  ) {
    return StarChallengeSimultaneousPlantsData(
      maximumPlants: json['MaximumPlants'] as int? ?? 10,
    );
  }
  Map<String, dynamic> toJson() => {'MaximumPlants': maximumPlants};
}

class StarChallengeUnfreezePlantsData {
  StarChallengeUnfreezePlantsData({this.count = 0});
  int count;
  factory StarChallengeUnfreezePlantsData.fromJson(Map<String, dynamic> json) {
    return StarChallengeUnfreezePlantsData(count: json['Count'] as int? ?? 0);
  }
  Map<String, dynamic> toJson() => {'Count': count};
}

class StarChallengeBlowZombieData {
  StarChallengeBlowZombieData({this.count = 0});
  int count;
  factory StarChallengeBlowZombieData.fromJson(Map<String, dynamic> json) {
    return StarChallengeBlowZombieData(count: json['Count'] as int? ?? 0);
  }
  Map<String, dynamic> toJson() => {'Count': count};
}

class StarChallengeTargetScoreData {
  StarChallengeTargetScoreData({
    this.description = '[STARCHALLENGE_TARGET_SCORE]',
    this.descriptionFailure = '[STARCHALLENGE_TARGET_SCORE_FAILURE]',
    this.descriptiveName = '[STARCHALLENGE_TARGET_SCORE_NAME]',
    this.targetScore = 20000,
  });
  String description;
  String descriptionFailure;
  String descriptiveName;
  int targetScore;
  factory StarChallengeTargetScoreData.fromJson(Map<String, dynamic> json) {
    return StarChallengeTargetScoreData(
      description:
          json['Description'] as String? ?? '[STARCHALLENGE_TARGET_SCORE]',
      descriptionFailure:
          json['DescriptionFailure'] as String? ??
          '[STARCHALLENGE_TARGET_SCORE_FAILURE]',
      descriptiveName:
          json['DescriptiveName'] as String? ??
          '[STARCHALLENGE_TARGET_SCORE_NAME]',
      targetScore: json['TargetScore'] as int? ?? 20000,
    );
  }
  Map<String, dynamic> toJson() => {
    'Description': description,
    'DescriptionFailure': descriptionFailure,
    'DescriptiveName': descriptiveName,
    'TargetScore': targetScore,
  };
}

// === Pirate Plank ===

class PiratePlankPropertiesData {
  PiratePlankPropertiesData({this.plankRows = const []});

  List<int> plankRows;

  factory PiratePlankPropertiesData.fromJson(Map<String, dynamic> json) {
    return PiratePlankPropertiesData(
      plankRows: (json['PlankRows'] as List<dynamic>?)?.cast<int>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {'PlankRows': plankRows};
}

// === Tide ===

class TidePropertiesData {
  TidePropertiesData({
    this.startingWaveLocation = 5,
  });

  int startingWaveLocation;

  factory TidePropertiesData.fromJson(Map<String, dynamic> json) {
    return TidePropertiesData(
      startingWaveLocation: json['StartingWaveLocation'] as int? ?? 5,
    );
  }

  Map<String, dynamic> toJson() => {
    'StartingWaveLocation': startingWaveLocation,
  };
}

// === Railcart ===

class RailcartPropertiesData {
  RailcartPropertiesData({
    this.railcartType = 'railcart_cowboy',
    this.railcarts = const [],
    this.rails = const [],
  });

  String railcartType;
  List<RailcartData> railcarts;
  List<RailData> rails;

  factory RailcartPropertiesData.fromJson(Map<String, dynamic> json) {
    return RailcartPropertiesData(
      railcartType: json['RailcartType'] as String? ?? 'railcart_cowboy',
      railcarts:
          (json['Railcarts'] as List<dynamic>?)
              ?.map((e) => RailcartData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      rails:
          (json['Rails'] as List<dynamic>?)
              ?.map((e) => RailData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'RailcartType': railcartType,
    'Railcarts': railcarts.map((e) => e.toJson()).toList(),
    'Rails': rails.map((e) => e.toJson()).toList(),
  };
}

class RailcartData {
  RailcartData({this.column = 0, this.row = 0});

  int column;
  int row;

  factory RailcartData.fromJson(Map<String, dynamic> json) {
    return RailcartData(
      column: json['Column'] as int? ?? 0,
      row: json['Row'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'Column': column, 'Row': row};
}

class RailData {
  RailData({this.column = 0, this.rowStart = 0, this.rowEnd = 0});

  int column;
  int rowStart;
  int rowEnd;

  factory RailData.fromJson(Map<String, dynamic> json) {
    return RailData(
      column: json['Column'] as int? ?? 0,
      rowStart: json['RowStart'] as int? ?? 0,
      rowEnd: json['RowEnd'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'Column': column,
    'RowStart': rowStart,
    'RowEnd': rowEnd,
  };
}

// === Power Tile ===

class PowerTilePropertiesData {
  PowerTilePropertiesData({this.linkedTiles = const []});

  List<LinkedTileData> linkedTiles;

  factory PowerTilePropertiesData.fromJson(Map<String, dynamic> json) {
    return PowerTilePropertiesData(
      linkedTiles:
          (json['LinkedTiles'] as List<dynamic>?)
              ?.map((e) => LinkedTileData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'LinkedTiles': linkedTiles.map((e) => e.toJson()).toList(),
  };
}

class LinkedTileData {
  LinkedTileData({
    this.group = 'alpha',
    this.propagationDelay = 1.5,
    TileLocationData? location,
  }) : location = location ?? TileLocationData();

  String group;
  double propagationDelay;
  TileLocationData location;

  factory LinkedTileData.fromJson(Map<String, dynamic> json) {
    return LinkedTileData(
      group: json['Group'] as String? ?? 'alpha',
      propagationDelay: (json['PropagationDelay'] as num?)?.toDouble() ?? 1.5,
      location: TileLocationData.fromJson(
        json['Location'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'Group': group,
    'PropagationDelay': propagationDelay,
    'Location': location.toJson(),
  };
}

class TileLocationData {
  TileLocationData({this.mx = 0, this.my = 0});

  int mx;
  int my;

  factory TileLocationData.fromJson(Map<String, dynamic> json) {
    return TileLocationData(
      mx: json['mX'] as int? ?? 0,
      my: json['mY'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'mX': mx, 'mY': my};
}

// === War Mist ===

class WarMistPropertiesData {
  WarMistPropertiesData({
    this.initMistPosX = 5,
    this.normValX = 1000,
    this.bloverEffectInterval = 15,
  });

  int initMistPosX;
  int normValX;
  int bloverEffectInterval;

  factory WarMistPropertiesData.fromJson(Map<String, dynamic> json) {
    return WarMistPropertiesData(
      initMistPosX: json['m_iInitMistPosX'] as int? ?? 5,
      normValX: json['m_iNormValX'] as int? ?? 1000,
      bloverEffectInterval: json['m_iBloverEffectInterval'] as int? ?? 15,
    );
  }

  Map<String, dynamic> toJson() => {
    'm_iInitMistPosX': initMistPosX,
    'm_iNormValX': normValX,
    'm_iBloverEffectInterval': bloverEffectInterval,
  };
}

// === Zombie Potion ===

class ZombiePotionModulePropertiesData {
  ZombiePotionModulePropertiesData({
    this.initialPotionCount = 10,
    this.maxPotionCount = 60,
    PotionSpawnTimerData? potionSpawnTimer,
    this.potionTypes = const [],
  }) : potionSpawnTimer = potionSpawnTimer ?? PotionSpawnTimerData();

  int initialPotionCount;
  int maxPotionCount;
  PotionSpawnTimerData potionSpawnTimer;
  List<String> potionTypes;

  factory ZombiePotionModulePropertiesData.fromJson(Map<String, dynamic> json) {
    return ZombiePotionModulePropertiesData(
      initialPotionCount: json['InitialPotionCount'] as int? ?? 10,
      maxPotionCount: json['MaxPotionCount'] as int? ?? 60,
      potionSpawnTimer: PotionSpawnTimerData.fromJson(
        json['PotionSpawnTimer'] as Map<String, dynamic>? ?? {},
      ),
      potionTypes:
          (json['PotionTypes'] as List<dynamic>?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'InitialPotionCount': initialPotionCount,
    'MaxPotionCount': maxPotionCount,
    'PotionSpawnTimer': potionSpawnTimer.toJson(),
    'PotionTypes': potionTypes,
  };
}

class PotionSpawnTimerData {
  PotionSpawnTimerData({this.min = 12, this.max = 16});

  int min;
  int max;

  factory PotionSpawnTimerData.fromJson(Map<String, dynamic> json) {
    return PotionSpawnTimerData(
      min: json['Min'] as int? ?? 12,
      max: json['Max'] as int? ?? 16,
    );
  }

  Map<String, dynamic> toJson() => {'Min': min, 'Max': max};
}

// === Increased Cost ===

class IncreasedCostModulePropertiesData {
  IncreasedCostModulePropertiesData({
    this.baseCostIncreased = 25,
    this.maxIncreasedCount = 10,
  });

  int baseCostIncreased;
  int maxIncreasedCount;

  factory IncreasedCostModulePropertiesData.fromJson(
    Map<String, dynamic> json,
  ) {
    return IncreasedCostModulePropertiesData(
      baseCostIncreased: json['BaseCostIncreased'] as int? ?? 25,
      maxIncreasedCount: json['MaxIncreasedCount'] as int? ?? 10,
    );
  }

  Map<String, dynamic> toJson() => {
    'BaseCostIncreased': baseCostIncreased,
    'MaxIncreasedCount': maxIncreasedCount,
  };
}

// === Death Hole ===

class DeathHoleModuleData {
  DeathHoleModuleData({this.lifeTime = 10});

  int lifeTime;

  factory DeathHoleModuleData.fromJson(Map<String, dynamic> json) {
    return DeathHoleModuleData(lifeTime: json['LifeTime'] as int? ?? 10);
  }

  Map<String, dynamic> toJson() => {'LifeTime': lifeTime};
}

// === Zombie Move Fast ===

class ZombieMoveFastModulePropertiesData {
  ZombieMoveFastModulePropertiesData({this.stopColumn = 6, this.speedUp = 3.0});

  int stopColumn;
  double speedUp;

  factory ZombieMoveFastModulePropertiesData.fromJson(
    Map<String, dynamic> json,
  ) {
    return ZombieMoveFastModulePropertiesData(
      stopColumn: json['StopColumn'] as int? ?? 6,
      speedUp: (json['SpeedUp'] as num?)?.toDouble() ?? 3.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'StopColumn': stopColumn,
    'SpeedUp': speedUp,
  };
}

// === Level Mutator Max Sun ===

class LevelMutatorMaxSunPropsData {
  LevelMutatorMaxSunPropsData({
    this.maxSunOverride = 9900,
    this.difficultyProps =
        'RTID(LevelModuleDifficultyMaxSun@LevelModulesDifficulty)',
    this.iconImage =
        'IMAGE_UI_PENNY_PURSUITS_DIFFICULTY_MODIFIER_ICONS_DIFFICULTY_MODIFIER_STARTING_SUN',
    this.iconText = '',
  });

  int maxSunOverride;
  String difficultyProps;
  String iconImage;
  String iconText;

  factory LevelMutatorMaxSunPropsData.fromJson(Map<String, dynamic> json) {
    return LevelMutatorMaxSunPropsData(
      maxSunOverride: json['MaxSunOverride'] as int? ?? 9900,
      difficultyProps:
          json['DifficultyProps'] as String? ??
          'RTID(LevelModuleDifficultyMaxSun@LevelModulesDifficulty)',
      iconImage:
          json['IconImage'] as String? ??
          'IMAGE_UI_PENNY_PURSUITS_DIFFICULTY_MODIFIER_ICONS_DIFFICULTY_MODIFIER_STARTING_SUN',
      iconText: json['IconText'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'MaxSunOverride': maxSunOverride,
    'DifficultyProps': difficultyProps,
    'IconImage': iconImage,
    'IconText': iconText,
  };
}

// === Level Mutator Starting Plantfood ===

class LevelMutatorStartingPlantfoodPropsData {
  LevelMutatorStartingPlantfoodPropsData({
    this.startingPlantfoodOverride = 0,
    this.difficultyProps =
        'RTID(LevelModuleDifficultyStartingPlantfood@LevelModulesDifficulty)',
    this.iconImage =
        'IMAGE_UI_PENNY_PURSUITS_DIFFICULTY_MODIFIER_ICONS_DIFFICULTY_MODIFIER_PF',
    this.iconText = '',
  });

  int startingPlantfoodOverride;
  String difficultyProps;
  String iconImage;
  String iconText;

  factory LevelMutatorStartingPlantfoodPropsData.fromJson(
    Map<String, dynamic> json,
  ) {
    return LevelMutatorStartingPlantfoodPropsData(
      startingPlantfoodOverride: json['StartingPlantfoodOverride'] as int? ?? 0,
      difficultyProps:
          json['DifficultyProps'] as String? ??
          'RTID(LevelModuleDifficultyStartingPlantfood@LevelModulesDifficulty)',
      iconImage:
          json['IconImage'] as String? ??
          'IMAGE_UI_PENNY_PURSUITS_DIFFICULTY_MODIFIER_ICONS_DIFFICULTY_MODIFIER_PF',
      iconText: json['IconText'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'StartingPlantfoodOverride': startingPlantfoodOverride,
    'DifficultyProps': difficultyProps,
    'IconImage': iconImage,
    'IconText': iconText,
  };
}

// === Bowling Minigame ===

class BowlingMinigamePropertiesData {
  BowlingMinigamePropertiesData({this.bowlingFoulLine = 2});

  int bowlingFoulLine;

  factory BowlingMinigamePropertiesData.fromJson(Map<String, dynamic> json) {
    return BowlingMinigamePropertiesData(
      bowlingFoulLine: json['BowlingFoulLine'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson() => {'BowlingFoulLine': bowlingFoulLine};
}

// === New Bowling Minigame ===

class NewBowlingMinigamePropertiesData {
  NewBowlingMinigamePropertiesData();

  factory NewBowlingMinigamePropertiesData.fromJson(Map<String, dynamic> json) {
    return NewBowlingMinigamePropertiesData();
  }

  Map<String, dynamic> toJson() => {};
}

// === PVZ1 Overwhelm ===

class PVZ1OverwhelmModulePropertiesData {
  PVZ1OverwhelmModulePropertiesData();

  factory PVZ1OverwhelmModulePropertiesData.fromJson(
    Map<String, dynamic> json,
  ) {
    return PVZ1OverwhelmModulePropertiesData();
  }

  Map<String, dynamic> toJson() => {};
}

// === Roof ===

class RoofPropertiesData {
  RoofPropertiesData({
    this.flowerPotStartColumn = 0,
    this.flowerPotEndColumn = 2,
  });

  int flowerPotStartColumn;
  int flowerPotEndColumn;

  factory RoofPropertiesData.fromJson(Map<String, dynamic> json) {
    return RoofPropertiesData(
      flowerPotStartColumn: json['FlowerPotStartColumn'] as int? ?? 0,
      flowerPotEndColumn: json['FlowerPotEndColumn'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson() => {
    'FlowerPotStartColumn': flowerPotStartColumn,
    'FlowerPotEndColumn': flowerPotEndColumn,
  };
}

// === Level Scoring ===

class LevelScoringData {
  LevelScoringData({
    this.plantBonusMultiplier = 0.0,
    this.plantBonuses = const [],
    this.scoringRulesType = 'NoMultiplier',
    this.startingPlantfood = 0,
  });

  double plantBonusMultiplier;
  List<String> plantBonuses;
  String scoringRulesType;
  int startingPlantfood;

  factory LevelScoringData.fromJson(Map<String, dynamic> json) {
    return LevelScoringData(
      plantBonusMultiplier:
          (json['PlantBonusMultiplier'] as num?)?.toDouble() ?? 0.0,
      plantBonuses:
          (json['PlantBonuses'] as List<dynamic>?)?.cast<String>() ?? [],
      scoringRulesType: json['ScoringRulesType'] as String? ?? 'NoMultiplier',
      startingPlantfood: json['StartingPlantfood'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'PlantBonusMultiplier': plantBonusMultiplier,
    'PlantBonuses': plantBonuses,
    'ScoringRulesType': scoringRulesType,
    'StartingPlantfood': startingPlantfood,
  };
}

// === Manhole Pipeline ===

class ManholePipelineModuleData {
  ManholePipelineModuleData({
    this.operationTimePerGrid = 1,
    this.damagePerSecond = 30,
    this.pipelineList = const [],
  });

  int operationTimePerGrid;
  int damagePerSecond;
  List<PipelineData> pipelineList;

  factory ManholePipelineModuleData.fromJson(Map<String, dynamic> json) {
    return ManholePipelineModuleData(
      operationTimePerGrid: json['OperationTimePerGrid'] as int? ?? 1,
      damagePerSecond: json['DamagePerSecond'] as int? ?? 30,
      pipelineList:
          (json['PipelineList'] as List<dynamic>?)
              ?.map((e) => PipelineData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'OperationTimePerGrid': operationTimePerGrid,
    'DamagePerSecond': damagePerSecond,
    'PipelineList': pipelineList.map((e) => e.toJson()).toList(),
  };
}

class PipelineData {
  PipelineData({
    this.startX = 0,
    this.startY = 0,
    this.endX = 0,
    this.endY = 0,
  });

  int startX;
  int startY;
  int endX;
  int endY;

  factory PipelineData.fromJson(Map<String, dynamic> json) {
    return PipelineData(
      startX: json['StartX'] as int? ?? 0,
      startY: json['StartY'] as int? ?? 0,
      endX: json['EndX'] as int? ?? 0,
      endY: json['EndY'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'StartX': startX,
    'StartY': startY,
    'EndX': endX,
    'EndY': endY,
  };
}

// === Penny Classroom ===

class PennyClassroomModuleData {
  PennyClassroomModuleData({this.plantMap = const {}});

  Map<String, int> plantMap;

  factory PennyClassroomModuleData.fromJson(Map<String, dynamic> json) {
    final raw = json['PlantMap'] as Map<String, dynamic>? ?? {};
    return PennyClassroomModuleData(
      plantMap: raw.map(
        (key, value) => MapEntry(key, (value as num?)?.toInt() ?? 0),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'PlantMap': plantMap,
  };
}

// === Seed Rain ===

class SeedRainPropertiesData {
  SeedRainPropertiesData({this.rainInterval = 5, this.seedRains = const []});

  int rainInterval;
  List<SeedRainItem> seedRains;

  factory SeedRainPropertiesData.fromJson(Map<String, dynamic> json) {
    return SeedRainPropertiesData(
      rainInterval: json['RainInterval'] as int? ?? 5,
      seedRains:
          (json['SeedRains'] as List<dynamic>?)
              ?.map((e) => SeedRainItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'RainInterval': rainInterval,
    'SeedRains': seedRains.map((e) => e.toJson()).toList(),
  };
}

class SeedRainItem {
  SeedRainItem({
    this.seedRainType = 0,
    this.plantTypeName,
    this.zombieTypeName,
    this.maxCount = 5,
    this.weight = 100,
  });

  int seedRainType;
  String? plantTypeName;
  String? zombieTypeName;
  int maxCount;
  int weight;

  factory SeedRainItem.fromJson(Map<String, dynamic> json) {
    return SeedRainItem(
      seedRainType: json['SeedRainType'] as int? ?? 0,
      plantTypeName: json['PlantTypeName'] as String?,
      zombieTypeName: json['ZombieTypeName'] as String?,
      maxCount: json['MaxCount'] as int? ?? 5,
      weight: json['Weight'] as int? ?? 100,
    );
  }

  Map<String, dynamic> toJson() => {
    'SeedRainType': seedRainType,
    'PlantTypeName': plantTypeName,
    'ZombieTypeName': zombieTypeName,
    'MaxCount': maxCount,
    'Weight': weight,
  };
}

// === Zombie Spawn ===

class ZombieSpawnData {
  ZombieSpawnData({this.type = '', this.level, this.row});

  String type;
  int? level;
  int? row;

  factory ZombieSpawnData.fromJson(Map<String, dynamic> json) {
    return ZombieSpawnData(
      type: json['Type'] as String? ?? '',
      level: json['Level'] as int?,
      row: json['Row'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'Type': type};
    if (level != null) data['Level'] = level;
    if (row != null) data['Row'] = row;
    return data;
  }
}

// === Location Data ===

class LocationData {
  LocationData({this.x = 0, this.y = 0});

  int x;
  int y;

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(x: json['mX'] as int? ?? 0, y: json['mY'] as int? ?? 0);
  }

  Map<String, dynamic> toJson() => {'mX': x, 'mY': y};
}

// === Vase Breaker ===

class VaseBreakerPresetData {
  VaseBreakerPresetData({
    this.minColumnIndex = 4,
    this.maxColumnIndex = 8,
    this.numColoredPlantVases = 0,
    this.numColoredZombieVases = 0,
    this.gridSquareBlacklist = const [],
    this.vases = const [],
  });

  int minColumnIndex;
  int maxColumnIndex;
  int numColoredPlantVases;
  int numColoredZombieVases;
  List<LocationData> gridSquareBlacklist;
  List<VaseDefinition> vases;

  factory VaseBreakerPresetData.fromJson(Map<String, dynamic> json) {
    return VaseBreakerPresetData(
      minColumnIndex: json['MinColumnIndex'] as int? ?? 4,
      maxColumnIndex: json['MaxColumnIndex'] as int? ?? 8,
      numColoredPlantVases: json['NumColoredPlantVases'] as int? ?? 0,
      numColoredZombieVases: json['NumColoredZombieVases'] as int? ?? 0,
      gridSquareBlacklist:
          (json['GridSquareBlacklist'] as List<dynamic>?)
              ?.map((e) => LocationData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      vases:
          (json['Vases'] as List<dynamic>?)
              ?.map((e) => VaseDefinition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'MinColumnIndex': minColumnIndex,
    'MaxColumnIndex': maxColumnIndex,
    'NumColoredPlantVases': numColoredPlantVases,
    'NumColoredZombieVases': numColoredZombieVases,
    'GridSquareBlacklist': gridSquareBlacklist.map((e) => e.toJson()).toList(),
    'Vases': vases.map((e) => e.toJson()).toList(),
  };
}

class VaseDefinition {
  VaseDefinition({
    this.zombieTypeName,
    this.plantTypeName,
    this.collectableTypeName,
    this.count = 1,
  });

  String? zombieTypeName;
  String? plantTypeName;
  String? collectableTypeName;
  int count;

  factory VaseDefinition.fromJson(Map<String, dynamic> json) {
    return VaseDefinition(
      zombieTypeName: json['ZombieTypeName'] as String?,
      plantTypeName: json['PlantTypeName'] as String?,
      collectableTypeName: json['CollectableTypeName'] as String?,
      count: json['Count'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'Count': count};
    if (zombieTypeName != null) data['ZombieTypeName'] = zombieTypeName;
    if (plantTypeName != null) data['PlantTypeName'] = plantTypeName;
    if (collectableTypeName != null) {
      data['CollectableTypeName'] = collectableTypeName;
    }
    return data;
  }
}

class VaseBreakerArcadeModuleData {
  VaseBreakerArcadeModuleData();
  factory VaseBreakerArcadeModuleData.fromJson(Map<String, dynamic> json) =>
      VaseBreakerArcadeModuleData();
  Map<String, dynamic> toJson() => {};
}

class VaseBreakerFlowModuleData {
  VaseBreakerFlowModuleData();
  factory VaseBreakerFlowModuleData.fromJson(Map<String, dynamic> json) =>
      VaseBreakerFlowModuleData();
  Map<String, dynamic> toJson() => {};
}

// === Evil Dave ===

class EvilDavePropertiesData {
  EvilDavePropertiesData({this.plantDistance = 4});

  int plantDistance;

  factory EvilDavePropertiesData.fromJson(Map<String, dynamic> json) {
    return EvilDavePropertiesData(
      plantDistance: json['PlantDistance'] as int? ?? 4,
    );
  }

  Map<String, dynamic> toJson() => {'PlantDistance': plantDistance};
}

// === Zomboss Battle ===

class ZombossBattleModuleData {
  ZombossBattleModuleData({
    this.reservedColumnCount = 2,
    this.zombossMechType = 'zombossmech_egypt',
    this.zombossStageCount = 3,
    this.zombossDeathRow = 3,
    this.zombossDeathColumn = 5,
    this.zombossSpawnGridPosition,
  });

  int reservedColumnCount;
  String zombossMechType;
  int zombossStageCount;
  int zombossDeathRow;
  int zombossDeathColumn;
  LocationData? zombossSpawnGridPosition;

  factory ZombossBattleModuleData.fromJson(Map<String, dynamic> json) {
    return ZombossBattleModuleData(
      reservedColumnCount: json['ReservedColumnCount'] as int? ?? 2,
      zombossMechType:
          json['ZombossMechType'] as String? ?? 'zombossmech_egypt',
      zombossStageCount: json['ZombossStageCount'] as int? ?? 3,
      zombossDeathRow: json['ZombossDeathRow'] as int? ?? 3,
      zombossDeathColumn: json['ZombossDeathColumn'] as int? ?? 5,
      zombossSpawnGridPosition: json['ZombossSpawnGridPosition'] != null
          ? LocationData.fromJson(
              json['ZombossSpawnGridPosition'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'ReservedColumnCount': reservedColumnCount,
    'ZombossMechType': zombossMechType,
    'ZombossStageCount': zombossStageCount,
    'ZombossDeathRow': zombossDeathRow,
    'ZombossDeathColumn': zombossDeathColumn,
    if (zombossSpawnGridPosition != null)
      'ZombossSpawnGridPosition': zombossSpawnGridPosition!.toJson(),
  };
}

class ZombossBattleIntroData {
  ZombossBattleIntroData({
    this.panStartOffset = 78,
    this.panEndOffset = 486,
    this.panRightDuration = 1.5,
    this.panLeftDuration = 1.5,
    this.zombossPhaseCount = 3,
    this.skipShowingStreetBossBattle = false,
  });

  int panStartOffset;
  int panEndOffset;
  double panRightDuration;
  double panLeftDuration;
  int zombossPhaseCount;
  bool skipShowingStreetBossBattle;

  factory ZombossBattleIntroData.fromJson(Map<String, dynamic> json) {
    return ZombossBattleIntroData(
      panStartOffset: json['PanStartOffset'] as int? ?? 78,
      panEndOffset: json['PanEndOffset'] as int? ?? 486,
      panRightDuration: (json['PanRightDuration'] as num?)?.toDouble() ?? 1.5,
      panLeftDuration: (json['PanLeftDuration'] as num?)?.toDouble() ?? 1.5,
      zombossPhaseCount: json['ZombossPhaseCount'] as int? ?? 3,
      skipShowingStreetBossBattle:
          json['SkipShowingStreetBossBattle'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'PanStartOffset': panStartOffset,
    'PanEndOffset': panEndOffset,
    'PanRightDuration': panRightDuration,
    'PanLeftDuration': panLeftDuration,
    'ZombossPhaseCount': zombossPhaseCount,
    'SkipShowingStreetBossBattle': skipShowingStreetBossBattle,
  };
}

// === Event Data ===

class WaveActionData {
  WaveActionData({
    this.notificationEvents,
    this.additionalPlantFood,
    this.spawnPlantName,
    this.zombies = const [],
  });

  List<String>? notificationEvents;
  int? additionalPlantFood;
  List<String>? spawnPlantName;
  List<ZombieSpawnData> zombies;

  factory WaveActionData.fromJson(Map<String, dynamic> json) {
    return WaveActionData(
      notificationEvents: (json['NotificationEvents'] as List<dynamic>?)
          ?.cast<String>(),
      additionalPlantFood: json['AdditionalPlantfood'] as int?,
      spawnPlantName: (json['SpawnPlantName'] as List<dynamic>?)
          ?.cast<String>(),
      zombies:
          (json['Zombies'] as List<dynamic>?)?.map((e) {
            if (e is Map<String, dynamic>) {
              return ZombieSpawnData.fromJson(e);
            }
            if (e is String) {
              return ZombieSpawnData(type: e);
            }
            return ZombieSpawnData();
          }).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'Zombies': zombies.map((e) => e.toJson()).toList(),
    };
    if (notificationEvents != null) {
      data['NotificationEvents'] = notificationEvents;
    }
    if (additionalPlantFood != null) {
      data['AdditionalPlantfood'] = additionalPlantFood;
    }
    if (spawnPlantName != null) {
      data['SpawnPlantName'] = spawnPlantName;
    }
    return data;
  }
}

class SpawnZombiesFromGroundData {
  SpawnZombiesFromGroundData({
    this.columnStart = 6,
    this.columnEnd = 9,
    this.additionalPlantFood,
    this.spawnPlantName,
    this.zombies = const [],
  });

  int columnStart;
  int columnEnd;
  int? additionalPlantFood;
  List<String>? spawnPlantName;
  List<ZombieSpawnData> zombies;

  factory SpawnZombiesFromGroundData.fromJson(Map<String, dynamic> json) {
    return SpawnZombiesFromGroundData(
      columnStart: json['ColumnStart'] as int? ?? 6,
      columnEnd: json['ColumnEnd'] as int? ?? 9,
      additionalPlantFood: json['AdditionalPlantfood'] as int?,
      spawnPlantName: (json['SpawnPlantName'] as List<dynamic>?)
          ?.cast<String>(),
      zombies:
          (json['Zombies'] as List<dynamic>?)?.map((e) {
            if (e is Map<String, dynamic>) {
              return ZombieSpawnData.fromJson(e);
            }
            if (e is String) {
              return ZombieSpawnData(type: e);
            }
            return ZombieSpawnData();
          }).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'ColumnStart': columnStart,
      'ColumnEnd': columnEnd,
      'Zombies': zombies.map((e) => e.toJson()).toList(),
    };
    if (additionalPlantFood != null) {
      data['AdditionalPlantfood'] = additionalPlantFood;
    }
    if (spawnPlantName != null) {
      data['SpawnPlantName'] = spawnPlantName;
    }
    return data;
  }
}

class PortalEventData {
  PortalEventData({
    this.portalType = 'egypt',
    this.portalColumn = 5,
    this.portalRow = 3,
    this.spawnEffect = '',
    this.spawnSoundID = '',
    this.ignoreGraveStone = false,
  });

  String portalType;
  int portalColumn;
  int portalRow;
  String spawnEffect;
  String spawnSoundID;
  bool ignoreGraveStone;

  factory PortalEventData.fromJson(Map<String, dynamic> json) {
    return PortalEventData(
      portalType: json['PortalType'] as String? ?? 'egypt',
      portalColumn: json['PortalColumn'] as int? ?? 5,
      portalRow: json['PortalRow'] as int? ?? 3,
      spawnEffect: json['SpawnEffect'] as String? ?? '',
      spawnSoundID: json['SpawnSoundID'] as String? ?? '',
      ignoreGraveStone: json['IgnoreGraveStone'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'PortalType': portalType,
    'PortalColumn': portalColumn,
    'PortalRow': portalRow,
    'SpawnEffect': spawnEffect,
    'SpawnSoundID': spawnSoundID,
    'IgnoreGraveStone': ignoreGraveStone,
  };
}

class StormZombieSpawnerPropsData {
  StormZombieSpawnerPropsData({
    this.columnStart = 5,
    this.columnEnd = 9,
    this.groupSize = 1,
    this.timeBetweenGroups = 1,
    this.type = 'sandstorm',
    this.zombies = const [],
  });

  int columnStart;
  int columnEnd;
  int groupSize;
  int timeBetweenGroups;
  String type;
  List<StormZombieData> zombies;

  factory StormZombieSpawnerPropsData.fromJson(Map<String, dynamic> json) {
    return StormZombieSpawnerPropsData(
      columnStart: json['ColumnStart'] as int? ?? 5,
      columnEnd: json['ColumnEnd'] as int? ?? 9,
      groupSize: json['GroupSize'] as int? ?? 1,
      timeBetweenGroups: json['TimeBetweenGroups'] as int? ?? 1,
      type: json['Type'] as String? ?? 'sandstorm',
      zombies:
          (json['Zombies'] as List<dynamic>?)?.map((e) {
            if (e is Map<String, dynamic>) {
              return StormZombieData.fromJson(e);
            }
            if (e is String) {
              return StormZombieData(type: e);
            }
            return StormZombieData();
          }).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'ColumnStart': columnStart,
    'ColumnEnd': columnEnd,
    'GroupSize': groupSize,
    'TimeBetweenGroups': timeBetweenGroups,
    'Type': type,
    'Zombies': zombies.map((e) => e.toJson()).toList(),
  };
}

class StormZombieData {
  StormZombieData({this.type = ''});

  String type;

  factory StormZombieData.fromJson(Map<String, dynamic> json) {
    return StormZombieData(type: json['Type'] as String? ?? '');
  }

  Map<String, dynamic> toJson() => {'Type': type};
}

class RaidingPartyEventData {
  RaidingPartyEventData({
    this.groupSize = 5,
    this.swashbucklerCount = 5,
    this.timeBetweenGroups = 2,
  });

  int groupSize;
  int swashbucklerCount;
  int timeBetweenGroups;

  factory RaidingPartyEventData.fromJson(Map<String, dynamic> json) {
    return RaidingPartyEventData(
      groupSize: json['GroupSize'] as int? ?? 5,
      swashbucklerCount: json['SwashbucklerCount'] as int? ?? 5,
      timeBetweenGroups: json['TimeBetweenGroups'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson() => {
    'GroupSize': groupSize,
    'SwashbucklerCount': swashbucklerCount,
    'TimeBetweenGroups': timeBetweenGroups,
  };
}

class ParachuteRainEventData {
  ParachuteRainEventData({
    this.columnStart = 5,
    this.columnEnd = 9,
    this.groupSize = 1,
    this.spiderCount = 1,
    this.spiderZombieName = '',
    this.timeBeforeFullSpawn = 1.0,
    this.timeBetweenGroups = 1.5,
    this.zombieFallTime = 4.5,
    this.waveStartMessage = '',
  });

  int columnStart;
  int columnEnd;
  int groupSize;
  int spiderCount;
  String spiderZombieName;
  double timeBeforeFullSpawn;
  double timeBetweenGroups;
  double zombieFallTime;
  String waveStartMessage;

  factory ParachuteRainEventData.fromJson(Map<String, dynamic> json) {
    return ParachuteRainEventData(
      columnStart: json['ColumnStart'] as int? ?? 5,
      columnEnd: json['ColumnEnd'] as int? ?? 9,
      groupSize: json['GroupSize'] as int? ?? 1,
      spiderCount: json['SpiderCount'] as int? ?? 1,
      spiderZombieName: json['SpiderZombieName'] as String? ?? '',
      timeBeforeFullSpawn:
          (json['TimeBeforeFullSpawn'] as num?)?.toDouble() ?? 1.0,
      timeBetweenGroups: (json['TimeBetweenGroups'] as num?)?.toDouble() ?? 1.5,
      zombieFallTime: (json['ZombieFallTime'] as num?)?.toDouble() ?? 4.5,
      waveStartMessage: json['WaveStartMessage'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'ColumnStart': columnStart,
    'ColumnEnd': columnEnd,
    'GroupSize': groupSize,
    'SpiderCount': spiderCount,
    'SpiderZombieName': spiderZombieName,
    'TimeBeforeFullSpawn': timeBeforeFullSpawn,
    'TimeBetweenGroups': timeBetweenGroups,
    'ZombieFallTime': zombieFallTime,
    'WaveStartMessage': waveStartMessage,
  };
}

class ModifyConveyorWaveActionData {
  ModifyConveyorWaveActionData({
    this.addList = const [],
    this.removeList = const [],
  });

  List<ModifyConveyorPlantData> addList;
  List<ModifyConveyorRemoveData> removeList;

  factory ModifyConveyorWaveActionData.fromJson(Map<String, dynamic> json) {
    return ModifyConveyorWaveActionData(
      addList:
          (json['Add'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ModifyConveyorPlantData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      removeList:
          (json['Remove'] as List<dynamic>?)
              ?.map(
                (e) => ModifyConveyorRemoveData.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'Add': addList.map((e) => e.toJson()).toList(),
    'Remove': removeList.map((e) => e.toJson()).toList(),
  };
}

class ModifyConveyorPlantData {
  ModifyConveyorPlantData({
    this.type = '',
    this.iLevel,
    this.weight = 100,
    this.maxCount = 0,
    this.maxWeightFactor = 1.0,
    this.minCount = 0,
    this.minWeightFactor = 1.0,
  });

  String type;
  int? iLevel;
  int weight;
  int maxCount;
  double maxWeightFactor;
  int minCount;
  double minWeightFactor;

  factory ModifyConveyorPlantData.fromJson(Map<String, dynamic> json) {
    return ModifyConveyorPlantData(
      type: json['Type'] as String? ?? '',
      iLevel: json['iLevel'] as int?,
      weight: json['Weight'] as int? ?? 100,
      maxCount: json['MaxCount'] as int? ?? 0,
      maxWeightFactor: (json['MaxWeightFactor'] as num?)?.toDouble() ?? 1.0,
      minCount: json['MinCount'] as int? ?? 0,
      minWeightFactor: (json['MinWeightFactor'] as num?)?.toDouble() ?? 1.0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'Type': type,
      'Weight': weight,
      'MaxCount': maxCount,
      'MaxWeightFactor': maxWeightFactor,
      'MinCount': minCount,
      'MinWeightFactor': minWeightFactor,
    };
    if (iLevel != null) data['iLevel'] = iLevel;
    return data;
  }
}

class ModifyConveyorRemoveData {
  ModifyConveyorRemoveData({this.type = ''});

  String type;

  factory ModifyConveyorRemoveData.fromJson(Map<String, dynamic> json) {
    return ModifyConveyorRemoveData(type: json['Type'] as String? ?? '');
  }

  Map<String, dynamic> toJson() => {'Type': type};
}

class TidalChangeWaveActionData {
  TidalChangeWaveActionData({TidalChangeInternalData? tidalChange})
    : tidalChange = tidalChange ?? TidalChangeInternalData();

  TidalChangeInternalData tidalChange;

  factory TidalChangeWaveActionData.fromJson(Map<String, dynamic> json) {
    return TidalChangeWaveActionData(
      tidalChange: TidalChangeInternalData.fromJson(
        json['TidalChange'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {'TidalChange': tidalChange.toJson()};
}

class TidalChangeInternalData {
  TidalChangeInternalData({
    this.changeAmount = 0,
    this.changeType = 'absolute',
  });

  int changeAmount;
  String changeType;

  factory TidalChangeInternalData.fromJson(Map<String, dynamic> json) {
    return TidalChangeInternalData(
      changeAmount: json['ChangeAmount'] as int? ?? 0,
      changeType: json['ChangeType'] as String? ?? 'absolute',
    );
  }

  Map<String, dynamic> toJson() => {
    'ChangeAmount': changeAmount,
    'ChangeType': changeType,
  };
}

class BeachStageEventData {
  BeachStageEventData({
    this.columnStart = 5,
    this.columnEnd = 9,
    this.groupSize = 1,
    this.zombieCount = 1,
    this.zombieName = 'beach',
    this.timeBeforeFullSpawn = 1.0,
    this.timeBetweenGroups = 0.5,
    this.waveStartMessage = '',
  });

  int columnStart;
  int columnEnd;
  int groupSize;
  int zombieCount;
  String zombieName;
  double timeBeforeFullSpawn;
  double timeBetweenGroups;
  String waveStartMessage;

  factory BeachStageEventData.fromJson(Map<String, dynamic> json) {
    return BeachStageEventData(
      columnStart: json['ColumnStart'] as int? ?? 5,
      columnEnd: json['ColumnEnd'] as int? ?? 9,
      groupSize: json['GroupSize'] as int? ?? 1,
      zombieCount: json['ZombieCount'] as int? ?? 1,
      zombieName: json['ZombieName'] as String? ?? 'beach',
      timeBeforeFullSpawn:
          (json['TimeBeforeFullSpawn'] as num?)?.toDouble() ?? 1.0,
      timeBetweenGroups: (json['TimeBetweenGroups'] as num?)?.toDouble() ?? 0.5,
      waveStartMessage: json['WaveStartMessage'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'ColumnStart': columnStart,
    'ColumnEnd': columnEnd,
    'GroupSize': groupSize,
    'ZombieCount': zombieCount,
    'ZombieName': zombieName,
    'TimeBeforeFullSpawn': timeBeforeFullSpawn,
    'TimeBetweenGroups': timeBetweenGroups,
    'WaveStartMessage': waveStartMessage,
  };
}

class BlackHoleEventData {
  BlackHoleEventData({this.colNumPlantIsDragged = 0});

  int colNumPlantIsDragged;

  factory BlackHoleEventData.fromJson(Map<String, dynamic> json) {
    return BlackHoleEventData(
      colNumPlantIsDragged: json['ColNumPlantIsDragged'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'ColNumPlantIsDragged': colNumPlantIsDragged,
  };
}

class FrostWindWaveActionPropsData {
  FrostWindWaveActionPropsData({this.winds = const []});

  List<FrostWindData> winds;

  factory FrostWindWaveActionPropsData.fromJson(Map<String, dynamic> json) {
    return FrostWindWaveActionPropsData(
      winds:
          (json['Winds'] as List<dynamic>?)
              ?.map((e) => FrostWindData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'Winds': winds.map((e) => e.toJson()).toList(),
  };
}

class FrostWindData {
  FrostWindData({this.direction = 'right', this.row = 2});

  String direction;
  int row;

  factory FrostWindData.fromJson(Map<String, dynamic> json) {
    return FrostWindData(
      direction: json['Direction'] as String? ?? 'right',
      row: json['Row'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson() => {'Direction': direction, 'Row': row};
}

class DinoWaveActionPropsData {
  DinoWaveActionPropsData({
    this.dinoRow = 2,
    this.dinoType = 'raptor',
    this.dinoWaveDuration = 2,
  });

  int dinoRow;
  String dinoType;
  int dinoWaveDuration;

  factory DinoWaveActionPropsData.fromJson(Map<String, dynamic> json) {
    return DinoWaveActionPropsData(
      dinoRow: json['DinoRow'] as int? ?? 2,
      dinoType: json['DinoType'] as String? ?? 'raptor',
      dinoWaveDuration: json['DinoWaveDuration'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson() => {
    'DinoRow': dinoRow,
    'DinoType': dinoType,
    'DinoWaveDuration': dinoWaveDuration,
  };
}

class SpawnGraveStonesData {
  SpawnGraveStonesData({
    this.gravestonePool = const [],
    this.spawnPositionsPool = const [],
  });

  List<GravestonePoolItem> gravestonePool;
  List<LocationData> spawnPositionsPool;

  factory SpawnGraveStonesData.fromJson(Map<String, dynamic> json) {
    return SpawnGraveStonesData(
      gravestonePool:
          (json['GravestonePool'] as List<dynamic>?)
              ?.map(
                (e) => GravestonePoolItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      spawnPositionsPool:
          (json['SpawnPositionsPool'] as List<dynamic>?)
              ?.map((e) => LocationData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'GravestonePool': gravestonePool.map((e) => e.toJson()).toList(),
    'SpawnPositionsPool': spawnPositionsPool.map((e) => e.toJson()).toList(),
  };
}

class GravestonePoolItem {
  GravestonePoolItem({this.count = 1, this.type = ''});

  int count;
  String type;

  factory GravestonePoolItem.fromJson(Map<String, dynamic> json) {
    return GravestonePoolItem(
      count: json['Count'] as int? ?? 1,
      type: json['Type'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'Count': count, 'Type': type};
}

class SpawnZombiesFromGridItemData {
  SpawnZombiesFromGridItemData({
    this.waveStartMessage,
    this.zombieSpawnWaitTime = 0,
    this.gridTypes = const [],
    this.zombies = const [],
  });

  String? waveStartMessage;
  int zombieSpawnWaitTime;
  List<String> gridTypes;
  List<ZombieSpawnData> zombies;

  factory SpawnZombiesFromGridItemData.fromJson(Map<String, dynamic> json) {
    return SpawnZombiesFromGridItemData(
      waveStartMessage: json['WaveStartMessage'] as String?,
      zombieSpawnWaitTime: json['ZombieSpawnWaitTime'] as int? ?? 0,
      gridTypes: (json['GridTypes'] as List<dynamic>?)?.cast<String>() ?? [],
      zombies:
          (json['Zombies'] as List<dynamic>?)?.map((e) {
            if (e is Map<String, dynamic>) {
              return ZombieSpawnData.fromJson(e);
            }
            if (e is String) {
              return ZombieSpawnData(type: e);
            }
            return ZombieSpawnData();
          }).toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'ZombieSpawnWaitTime': zombieSpawnWaitTime,
      'GridTypes': gridTypes,
      'Zombies': zombies.map((e) => e.toJson()).toList(),
    };
    if (waveStartMessage != null) data['WaveStartMessage'] = waveStartMessage;
    return data;
  }
}

class ZombiePotionActionPropsData {
  ZombiePotionActionPropsData({this.potions = const []});

  List<ZombiePotionData> potions;

  factory ZombiePotionActionPropsData.fromJson(Map<String, dynamic> json) {
    return ZombiePotionActionPropsData(
      potions:
          (json['Potions'] as List<dynamic>?)
              ?.map((e) => ZombiePotionData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'Potions': potions.map((e) => e.toJson()).toList(),
  };
}

class ZombiePotionData {
  ZombiePotionData({LocationData? location, this.type = ''})
    : location = location ?? LocationData();

  LocationData location;
  String type;

  factory ZombiePotionData.fromJson(Map<String, dynamic> json) {
    return ZombiePotionData(
      location: LocationData.fromJson(
        json['Location'] as Map<String, dynamic>? ?? {},
      ),
      type: json['Type'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'Location': location.toJson(),
    'Type': type,
  };
}

class MagicMirrorWaveActionData {
  MagicMirrorWaveActionData({this.arrays = const []});

  List<MagicMirrorArrayData> arrays;

  factory MagicMirrorWaveActionData.fromJson(Map<String, dynamic> json) {
    return MagicMirrorWaveActionData(
      arrays:
          (json['MagicMirrorTeleportationArrays'] as List<dynamic>?)
              ?.map(
                (e) => MagicMirrorArrayData.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'MagicMirrorTeleportationArrays': arrays.map((e) => e.toJson()).toList(),
  };
}

class MagicMirrorArrayData {
  MagicMirrorArrayData({
    this.mirror1GridX = 2,
    this.mirror1GridY = 2,
    this.mirror2GridX = 6,
    this.mirror2GridY = 2,
    this.typeIndex = 1,
    this.mirrorExistDuration = 300,
  });

  int mirror1GridX;
  int mirror1GridY;
  int mirror2GridX;
  int mirror2GridY;
  int typeIndex;
  int mirrorExistDuration;

  factory MagicMirrorArrayData.fromJson(Map<String, dynamic> json) {
    return MagicMirrorArrayData(
      mirror1GridX: json['Mirror1GridX'] as int? ?? 2,
      mirror1GridY: json['Mirror1GridY'] as int? ?? 2,
      mirror2GridX: json['Mirror2GridX'] as int? ?? 6,
      mirror2GridY: json['Mirror2GridY'] as int? ?? 2,
      typeIndex: json['TypeIndex'] as int? ?? 1,
      mirrorExistDuration: json['MirrorExistDuration'] as int? ?? 300,
    );
  }

  Map<String, dynamic> toJson() => {
    'Mirror1GridX': mirror1GridX,
    'Mirror1GridY': mirror1GridY,
    'Mirror2GridX': mirror2GridX,
    'Mirror2GridY': mirror2GridY,
    'TypeIndex': typeIndex,
    'MirrorExistDuration': mirrorExistDuration,
  };
}

class FairyTaleFogWaveActionData {
  FairyTaleFogWaveActionData({
    this.movingTime = 3.0,
    this.fogType = 'fairy_tale_fog_lvl1',
    FogRangeData? range,
  }) : range = range ?? FogRangeData();

  double movingTime;
  String fogType;
  FogRangeData range;

  factory FairyTaleFogWaveActionData.fromJson(Map<String, dynamic> json) {
    return FairyTaleFogWaveActionData(
      movingTime: (json['MovingTime'] as num?)?.toDouble() ?? 3.0,
      fogType: json['FogType'] as String? ?? 'fairy_tale_fog_lvl1',
      range: FogRangeData.fromJson(
        json['Range'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'MovingTime': movingTime,
    'FogType': fogType,
    'Range': range.toJson(),
  };
}

class FogRangeData {
  FogRangeData({this.mX = 4, this.mY = 0, this.mWidth = 8, this.mHeight = 5});

  int mX;
  int mY;
  int mWidth;
  int mHeight;

  factory FogRangeData.fromJson(Map<String, dynamic> json) {
    return FogRangeData(
      mX: json['mX'] as int? ?? 4,
      mY: json['mY'] as int? ?? 0,
      mWidth: json['mWidth'] as int? ?? 8,
      mHeight: json['mHeight'] as int? ?? 5,
    );
  }

  Map<String, dynamic> toJson() => {
    'mX': mX,
    'mY': mY,
    'mWidth': mWidth,
    'mHeight': mHeight,
  };
}

class FairyTaleWindWaveActionData {
  FairyTaleWindWaveActionData({this.duration = 5.0, this.velocityScale = 2.0});

  double duration;
  double velocityScale;

  factory FairyTaleWindWaveActionData.fromJson(Map<String, dynamic> json) {
    return FairyTaleWindWaveActionData(
      duration: (json['Duration'] as num?)?.toDouble() ?? 5.0,
      velocityScale: (json['VelocityScale'] as num?)?.toDouble() ?? 2.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'Duration': duration,
    'VelocityScale': velocityScale,
  };
}

// === Parsed Data Container ===

class ParsedLevelData {
  ParsedLevelData({
    this.levelDef,
    this.waveManager,
    this.waveModule,
    required this.objectMap,
  });

  LevelDefinitionData? levelDef;
  dynamic waveManager;
  dynamic waveModule;
  Map<String, PvzObject> objectMap;
}

// === Zombie Properties ===

class ZombieTypeData {
  ZombieTypeData({
    this.typeName = '',
    this.properties = '',
    this.resistences,
  });

  String typeName;
  String properties;
  List<double>? resistences;

  factory ZombieTypeData.fromJson(Map<String, dynamic> json) {
    return ZombieTypeData(
      typeName: json['TypeName'] as String? ?? '',
      properties: json['Properties'] as String? ?? '',
      resistences:
          (json['Resistences'] as List<dynamic>?)
              ?.map((e) => (e as num?)?.toDouble() ?? 0.0)
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'TypeName': typeName,
    'Properties': properties,
    if (resistences != null) 'Resistences': resistences,
  };
}

class RectData {
  RectData({this.mX = 0, this.mY = 0, this.mWidth = 0, this.mHeight = 0});

  int mX;
  int mY;
  int mWidth;
  int mHeight;

  factory RectData.fromJson(Map<String, dynamic> json) {
    return RectData(
      mX: json['mX'] as int? ?? 0,
      mY: json['mY'] as int? ?? 0,
      mWidth: json['mWidth'] as int? ?? 0,
      mHeight: json['mHeight'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'mX': mX,
    'mY': mY,
    'mWidth': mWidth,
    'mHeight': mHeight,
  };
}

class Point2D {
  Point2D({this.x = 0, this.y = 0});

  int x;
  int y;

  factory Point2D.fromJson(Map<String, dynamic> json) {
    return Point2D(
      x: json['x'] as int? ?? 0,
      y: json['y'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}

class Point3DDouble {
  Point3DDouble({this.x = 0.0, this.y = 0.0, this.z = 0.0});

  double x;
  double y;
  double z;

  factory Point3DDouble.fromJson(Map<String, dynamic> json) {
    return Point3DDouble(
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
      z: (json['z'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'z': z};
}

class ZombiePropertySheetData {
  ZombiePropertySheetData({
    this.hitpoints = 0.0,
    this.speed = 0.0,
    this.speedVariance,
    this.eatDPS = 0.0,
    this.weight = 0,
    this.wavePointCost = 0,
    this.sizeType,
    this.hitRect,
    this.attackRect,
    this.artCenter,
    this.shadowOffset,
    this.groundTrackName = '',
    this.canSpawnPlantFood = false,
    this.canSurrender,
    this.enableShowHealthBarByDamage,
    this.canBePlantTossedweak,
    this.canBePlantTossedStrong,
    this.canBeLaunchedByPlants,
    this.drawHealthBarTime,
    this.enableEliteImmunities,
    this.enableEliteScale,
    this.canTriggerZombieWin,
    this.chillInsteadOfFreeze,
    this.eliteScale,
    this.armDropFraction,
    this.headDropFraction,
  });

  double hitpoints;
  double speed;
  double? speedVariance;
  double eatDPS;
  int weight;
  int wavePointCost;
  String? sizeType;
  RectData? hitRect;
  RectData? attackRect;
  Point2D? artCenter;
  Point3DDouble? shadowOffset;
  String groundTrackName;
  bool canSpawnPlantFood;
  bool? canSurrender;
  bool? enableShowHealthBarByDamage;
  bool? canBePlantTossedweak;
  bool? canBePlantTossedStrong;
  bool? canBeLaunchedByPlants;
  double? drawHealthBarTime;
  bool? enableEliteImmunities;
  bool? enableEliteScale;
  bool? canTriggerZombieWin;
  bool? chillInsteadOfFreeze;
  double? eliteScale;
  int? armDropFraction;
  int? headDropFraction;

  factory ZombiePropertySheetData.fromJson(Map<String, dynamic> json) {
    return ZombiePropertySheetData(
      hitpoints: (json['Hitpoints'] as num?)?.toDouble() ?? 0.0,
      speed: (json['Speed'] as num?)?.toDouble() ?? 0.0,
      speedVariance: (json['SpeedVariance'] as num?)?.toDouble(),
      eatDPS: (json['EatDPS'] as num?)?.toDouble() ?? 0.0,
      weight: (json['Weight'] as num?)?.toInt() ?? 0,
      wavePointCost: json['WavePointCost'] as int? ?? 0,
      sizeType: json['SizeType'] as String?,
      hitRect: json['HitRect'] is Map<String, dynamic>
          ? RectData.fromJson(json['HitRect'] as Map<String, dynamic>)
          : null,
      attackRect: json['AttackRect'] is Map<String, dynamic>
          ? RectData.fromJson(json['AttackRect'] as Map<String, dynamic>)
          : null,
      artCenter: json['ArtCenter'] is Map<String, dynamic>
          ? Point2D.fromJson(json['ArtCenter'] as Map<String, dynamic>)
          : null,
      shadowOffset: json['ShadowOffset'] is Map<String, dynamic>
          ? Point3DDouble.fromJson(json['ShadowOffset'] as Map<String, dynamic>)
          : null,
      groundTrackName: json['GroundTrackName'] as String? ?? '',
      canSpawnPlantFood: json['CanSpawnPlantFood'] as bool? ?? false,
      canSurrender: json['CanSurrender'] as bool?,
      enableShowHealthBarByDamage:
          json['EnableShowHealthBarByDamage'] as bool?,
      canBePlantTossedweak: json['CanBePlantTossedweak'] as bool?,
      canBePlantTossedStrong: json['CanBePlantTossedStrong'] as bool?,
      canBeLaunchedByPlants: json['CanBeLaunchedByPlants'] as bool?,
      drawHealthBarTime: (json['DrawHealthBarTime'] as num?)?.toDouble(),
      enableEliteImmunities: json['EnableEliteImmunities'] as bool?,
      enableEliteScale: json['EnableEliteScale'] as bool?,
      canTriggerZombieWin: json['CanTriggerZombieWin'] as bool?,
      chillInsteadOfFreeze: json['ChillInsteadOfFreeze'] as bool?,
      eliteScale: (json['EliteScale'] as num?)?.toDouble(),
      armDropFraction: json['ArmDropFraction'] as int?,
      headDropFraction: json['HeadDropFraction'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Hitpoints': hitpoints,
    'Speed': speed,
    if (speedVariance != null) 'SpeedVariance': speedVariance,
    'EatDPS': eatDPS,
    'Weight': weight,
    'WavePointCost': wavePointCost,
    if (sizeType != null) 'SizeType': sizeType,
    if (hitRect != null) 'HitRect': hitRect!.toJson(),
    if (attackRect != null) 'AttackRect': attackRect!.toJson(),
    if (artCenter != null) 'ArtCenter': artCenter!.toJson(),
    if (shadowOffset != null) 'ShadowOffset': shadowOffset!.toJson(),
    'GroundTrackName': groundTrackName,
    'CanSpawnPlantFood': canSpawnPlantFood,
    if (canSurrender != null) 'CanSurrender': canSurrender,
    if (enableShowHealthBarByDamage != null)
      'EnableShowHealthBarByDamage': enableShowHealthBarByDamage,
    if (canBePlantTossedweak != null)
      'CanBePlantTossedweak': canBePlantTossedweak,
    if (canBePlantTossedStrong != null)
      'CanBePlantTossedStrong': canBePlantTossedStrong,
    if (canBeLaunchedByPlants != null)
      'CanBeLaunchedByPlants': canBeLaunchedByPlants,
    if (drawHealthBarTime != null) 'DrawHealthBarTime': drawHealthBarTime,
    if (enableEliteImmunities != null)
      'EnableEliteImmunities': enableEliteImmunities,
    if (enableEliteScale != null) 'EnableEliteScale': enableEliteScale,
    if (canTriggerZombieWin != null)
      'CanTriggerZombieWin': canTriggerZombieWin,
    if (chillInsteadOfFreeze != null)
      'ChillInsteadOfFreeze': chillInsteadOfFreeze,
    if (eliteScale != null) 'EliteScale': eliteScale,
    if (armDropFraction != null) 'ArmDropFraction': armDropFraction,
    if (headDropFraction != null) 'HeadDropFraction': headDropFraction,
  };
}

class ZombieStats {
  ZombieStats({
    this.id = '',
    this.hp = 0.0,
    this.cost = 0,
    this.weight = 0,
    this.speed = 0.0,
    this.eatDPS = 0.0,
    this.sizeType = '',
  });

  String id;
  double hp;
  int cost;
  int weight;
  double speed;
  double eatDPS;
  String sizeType;
}
