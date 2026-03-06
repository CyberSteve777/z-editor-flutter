import 'package:flutter/material.dart';
import '../pvz_models.dart';

class EventMetadata {
  EventMetadata({
    required this.titleKey,
    required this.descriptionKey,
    required this.icon,
    required this.color,
    required this.darkColor,
    required this.defaultAlias,
    required this.defaultObjClass,
    required this.initialDataFactory,
    this.summaryProvider,
  });

  final String titleKey;
  final String descriptionKey;
  final IconData icon;
  final Color color;
  final Color darkColor;
  final String defaultAlias;
  final String defaultObjClass;
  final Object Function() initialDataFactory;
  final String Function(PvzObject obj)? summaryProvider;
}

class EventRegistry {
  static final Map<String, EventMetadata> _registry = {
    'SpawnZombiesFromGroundSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_SpawnZombiesFromGroundSpawnerProps',
      descriptionKey: 'eventDesc_SpawnZombiesFromGroundSpawnerProps',
      icon: Icons.groups,
      color: const Color(0xFF936457),
      darkColor: const Color(0xFFC2A197),
      defaultAlias: 'GroundSpawnEvent',
      defaultObjClass: 'SpawnZombiesFromGroundSpawnerProps',
      initialDataFactory: () => WaveActionData(),
      summaryProvider: (obj) {
        try {
          final data = SpawnZombiesFromGroundData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.zombies.length}';
        } catch (_) {
          return '';
        }
      },
    ),
    'SpawnZombiesJitteredWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_SpawnZombiesJitteredWaveActionProps',
      descriptionKey: 'eventDesc_SpawnZombiesJitteredWaveActionProps',
      icon: Icons.groups,
      color: const Color(0xFF2196F3),
      darkColor: const Color(0xFF90CAF9),
      defaultAlias: 'JitteredEvent',
      defaultObjClass: 'SpawnZombiesJitteredWaveActionProps',
      initialDataFactory: () => WaveActionData(),
      summaryProvider: (obj) {
        try {
          final data = WaveActionData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.zombies.length}';
        } catch (_) {
          return '';
        }
      },
    ),
    'FrostWindWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_FrostWindWaveActionProps',
      descriptionKey: 'eventDesc_FrostWindWaveActionProps',
      icon: Icons.ac_unit,
      color: const Color(0xFF0288D1),
      darkColor: const Color(0xFF90CAF9),
      defaultAlias: 'FrostWindEvent',
      defaultObjClass: 'FrostWindWaveActionProps',
      initialDataFactory: () => FrostWindWaveActionPropsData(),
      summaryProvider: (obj) {
        try {
          final data = FrostWindWaveActionPropsData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.winds.length}';
        } catch (_) {
          return '';
        }
      },
    ),
    'BeachStageEventZombieSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_BeachStageEventZombieSpawnerProps',
      descriptionKey: 'eventDesc_BeachStageEventZombieSpawnerProps',
      icon: Icons.water,
      color: const Color(0xFF00ACC1),
      darkColor: const Color(0xFF81D4FA),
      defaultAlias: 'LowTideEvent',
      defaultObjClass: 'BeachStageEventZombieSpawnerProps',
      initialDataFactory: () => BeachStageEventData(),
      summaryProvider: (obj) {
        try {
          final data = BeachStageEventData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.zombieCount}';
        } catch (_) {
          return '';
        }
      },
    ),
    'TidalChangeWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_TidalChangeWaveActionProps',
      descriptionKey: 'eventDesc_TidalChangeWaveActionProps',
      icon: Icons.water_drop,
      color: const Color(0xFF00ACC1),
      darkColor: const Color(0xFF81D4FA),
      defaultAlias: 'TidalChangeEvent',
      defaultObjClass: 'TidalChangeWaveActionProps',
      initialDataFactory: () => TidalChangeWaveActionData(),
    ),
    'ModifyConveyorWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_ModifyConveyorWaveActionProps',
      descriptionKey: 'eventDesc_ModifyConveyorWaveActionProps',
      icon: Icons.transform,
      color: const Color(0xFF4AC380),
      darkColor: const Color(0xFF7CBD99),
      defaultAlias: 'ModConveyorEvent',
      defaultObjClass: 'ModifyConveyorWaveActionProps',
      initialDataFactory: () => ModifyConveyorWaveActionData(),
    ),
    'DinoWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_DinoWaveActionProps',
      descriptionKey: 'eventDesc_DinoWaveActionProps',
      icon: Icons.pets,
      color: const Color(0xFF91B900),
      darkColor: const Color(0xFFA2B659),
      defaultAlias: 'DinoTimeEvent',
      defaultObjClass: 'DinoWaveActionProps',
      initialDataFactory: () => DinoWaveActionPropsData(),
    ),
    'DinoTreadActionProps': EventMetadata(
      titleKey: 'eventTitle_DinoTreadActionProps',
      descriptionKey: 'eventDesc_DinoTreadActionProps',
      icon: Icons.pets,
      color: const Color(0xFF91B900),
      darkColor: const Color(0xFFA2B659),
      defaultAlias: 'DinoTreadEvent',
      defaultObjClass: 'DinoTreadActionProps',
      initialDataFactory: () => DinoTreadActionPropsData(),
    ),
    'DinoRunActionProps': EventMetadata(
      titleKey: 'eventTitle_DinoRunActionProps',
      descriptionKey: 'eventDesc_DinoRunActionProps',
      icon: Icons.pets,
      color: const Color(0xFF91B900),
      darkColor: const Color(0xFFA2B659),
      defaultAlias: 'DinoRunEvent',
      defaultObjClass: 'DinoRunActionProps',
      initialDataFactory: () => DinoRunActionPropsData(),
    ),
    'SpawnModernPortalsWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_SpawnModernPortalsWaveActionProps',
      descriptionKey: 'eventDesc_SpawnModernPortalsWaveActionProps',
      icon: Icons.hourglass_empty,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'PortalEvent',
      defaultObjClass: 'SpawnModernPortalsWaveActionProps',
      initialDataFactory: () => PortalEventData(),
    ),
    'StormZombieSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_StormZombieSpawnerProps',
      descriptionKey: 'eventDesc_StormZombieSpawnerProps',
      icon: Icons.storm,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'StormEvent',
      defaultObjClass: 'StormZombieSpawnerProps',
      initialDataFactory: () => StormZombieSpawnerPropsData(),
    ),
    'RaidingPartyZombieSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_RaidingPartyZombieSpawnerProps',
      descriptionKey: 'eventDesc_RaidingPartyZombieSpawnerProps',
      icon: Icons.tsunami,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'RaidingPartyEvent',
      defaultObjClass: 'RaidingPartyZombieSpawnerProps',
      initialDataFactory: () => RaidingPartyEventData(),
    ),
    'ZombiePotionActionProps': EventMetadata(
      titleKey: 'eventTitle_ZombiePotionActionProps',
      descriptionKey: 'eventDesc_ZombiePotionActionProps',
      icon: Icons.science,
      color: const Color(0xFF607D8B),
      darkColor: const Color(0xFFB0BEC5),
      defaultAlias: 'PotionEvent',
      defaultObjClass: 'ZombiePotionActionProps',
      initialDataFactory: () => ZombiePotionActionPropsData(),
    ),
    'ZombieAtlantisShellActionProps': EventMetadata(
      titleKey: 'eventTitle_ZombieAtlantisShellActionProps',
      descriptionKey: 'eventDesc_ZombieAtlantisShellActionProps',
      icon: Icons.beach_access,
      color: const Color(0xFF00838F),
      darkColor: const Color(0xFF4DD0E1),
      defaultAlias: 'ShellEvent',
      defaultObjClass: 'ZombieAtlantisShellActionProps',
      initialDataFactory: () => ZombieAtlantisShellActionPropsData(),
      summaryProvider: (obj) {
        try {
          final data = ZombieAtlantisShellActionPropsData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.tiles.length}';
        } catch (_) {
          return '';
        }
      },
    ),
    'SpawnGravestonesWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_SpawnGravestonesWaveActionProps',
      descriptionKey: 'eventDesc_SpawnGravestonesWaveActionProps',
      icon: Icons.unarchive,
      color: const Color(0xFF607D8B),
      darkColor: const Color(0xFFB0BEC5),
      defaultAlias: 'GravestonesEvent',
      defaultObjClass: 'SpawnGravestonesWaveActionProps',
      initialDataFactory: () => SpawnGraveStonesData(),
    ),
    'SpawnZombiesFromGridItemSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_SpawnZombiesFromGridItemSpawnerProps',
      descriptionKey: 'eventDesc_SpawnZombiesFromGridItemSpawnerProps',
      icon: Icons.groups,
      color: const Color(0xFF607D8B),
      darkColor: const Color(0xFFB0BEC5),
      defaultAlias: 'GraveSpawner',
      defaultObjClass: 'SpawnZombiesFromGridItemSpawnerProps',
      initialDataFactory: () => SpawnZombiesFromGridItemData(),
    ),
    'FairyTaleFogWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_FairyTaleFogWaveActionProps',
      descriptionKey: 'eventDesc_FairyTaleFogWaveActionProps',
      icon: Icons.cloud,
      color: const Color(0xFFBE5DBA),
      darkColor: const Color(0xFFBD99BB),
      defaultAlias: 'FairyFogEvent',
      defaultObjClass: 'FairyTaleFogWaveActionProps',
      initialDataFactory: () => FairyTaleFogWaveActionData(),
    ),
    'FairyTaleWindWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_FairyTaleWindWaveActionProps',
      descriptionKey: 'eventDesc_FairyTaleWindWaveActionProps',
      icon: Icons.air,
      color: const Color(0xFFBE5DBA),
      darkColor: const Color(0xFFBD99BB),
      defaultAlias: 'WindEvent',
      defaultObjClass: 'FairyTaleWindWaveActionProps',
      initialDataFactory: () => FairyTaleWindWaveActionData(),
    ),
    'WaveActionMagicMirrorTeleportationArrayProps': EventMetadata(
      titleKey: 'eventTitle_MagicMirrorWaveActionProps',
      descriptionKey: 'eventDesc_MagicMirrorWaveActionProps',
      icon: Icons.tablet,
      color: const Color(0xFFBE5DBA),
      darkColor: const Color(0xFFBD99BB),
      defaultAlias: 'MagicMirrorEvent',
      defaultObjClass: 'WaveActionMagicMirrorTeleportationArrayProps',
      initialDataFactory: () => MagicMirrorWaveActionData(),
    ),
    'SpiderRainZombieSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_SpiderRainZombieSpawnerProps',
      descriptionKey: 'eventDesc_SpiderRainZombieSpawnerProps',
      icon: Icons.pest_control,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'SpiderRainEvent',
      defaultObjClass: 'SpiderRainZombieSpawnerProps',
      initialDataFactory: () => ParachuteRainEventData(),
      summaryProvider: (obj) {
        try {
          final data = ParachuteRainEventData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.groupSize}x${data.spiderCount}';
        } catch (_) {
          return '';
        }
      },
    ),
    'ParachuteRainZombieSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_ParachuteRainZombieSpawnerProps',
      descriptionKey: 'eventDesc_ParachuteRainZombieSpawnerProps',
      icon: Icons.paragliding,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'ParachuteRainEvent',
      defaultObjClass: 'ParachuteRainZombieSpawnerProps',
      initialDataFactory: () => ParachuteRainEventData(),
      summaryProvider: (obj) {
        try {
          final data = ParachuteRainEventData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.groupSize}x${data.spiderCount}';
        } catch (_) {
          return '';
        }
      },
    ),
    'BassRainZombieSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_BassRainZombieSpawnerProps',
      descriptionKey: 'eventDesc_BassRainZombieSpawnerProps',
      icon: Icons.music_note,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'BassRainEvent',
      defaultObjClass: 'BassRainZombieSpawnerProps',
      initialDataFactory: () => ParachuteRainEventData(),
    ),
    'BlackHoleWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_BlackHoleWaveActionProps',
      descriptionKey: 'eventDesc_BlackHoleWaveActionProps',
      icon: Icons.circle_outlined,
      color: const Color(0xFF9C27B0),
      darkColor: const Color(0xFFCE93D8),
      defaultAlias: 'BlackHoleEvent',
      defaultObjClass: 'BlackHoleWaveActionProps',
      initialDataFactory: () => BlackHoleEventData(),
      summaryProvider: (obj) {
        try {
          final data = BlackHoleEventData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return 'col: ${data.colNumPlantIsDragged}';
        } catch (_) {
          return '';
        }
      },
    ),
    'BarrelWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_BarrelWaveActionProps',
      descriptionKey: 'eventDesc_BarrelWaveActionProps',
      icon: Icons.local_fire_department,
      color: const Color(0xFFE65100),
      darkColor: const Color(0xFFFFAB91),
      defaultAlias: 'BarrelEvent',
      defaultObjClass: 'BarrelWaveActionProps',
      initialDataFactory: () => BarrelWaveEventData(),
      summaryProvider: (obj) {
        try {
          final data = BarrelWaveEventData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.barrels.length}';
        } catch (_) {
          return '';
        }
      },
    ),
    'BungeeWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_BungeeWaveActionProps',
      descriptionKey: 'eventDesc_BungeeWaveActionProps',
      icon: Icons.paragliding,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'BungeeDropEvent',
      defaultObjClass: 'BungeeWaveActionProps',
      initialDataFactory: () => BungeeWaveActionData(),
      summaryProvider: (obj) {
        try {
          final data = BungeeWaveActionData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return 'C${data.target.mX + 1}R${data.target.mY + 1}';
        } catch (_) {
          return '';
        }
      },
    ),
    'SpawnZombiesFishWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_SpawnZombiesFishWaveActionProps',
      descriptionKey: 'eventDesc_SpawnZombiesFishWaveActionProps',
      icon: Icons.water,
      color: const Color(0xFF00ACC1),
      darkColor: const Color(0xFF81D4FA),
      defaultAlias: 'ZombieFishWave',
      defaultObjClass: 'SpawnZombiesFishWaveActionProps',
      initialDataFactory: () => SpawnZombiesFishWaveActionPropsData(),
      summaryProvider: (obj) {
        try {
          final data = SpawnZombiesFishWaveActionPropsData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return 'Z:${data.zombies.length} F:${data.fishes.length}';
        } catch (_) {
          return '';
        }
      },
    ),
    'TideWaveWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_TideWaveWaveActionProps',
      descriptionKey: 'eventDesc_TideWaveWaveActionProps',
      icon: Icons.water,
      color: const Color(0xFF00ACC1),
      darkColor: const Color(0xFF81D4FA),
      defaultAlias: 'TideWaveEvent',
      defaultObjClass: 'TideWaveWaveActionProps',
      initialDataFactory: () => TideWaveWaveActionPropsData(),
    ),
    'ThunderWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_ThunderWaveActionProps',
      descriptionKey: 'eventDesc_ThunderWaveActionProps',
      icon: Icons.thunderstorm,
      color: const Color(0xFF5C6BC0),
      darkColor: const Color(0xFF9FA8DA),
      defaultAlias: 'ThunderEvent',
      defaultObjClass: 'ThunderWaveActionProps',
      initialDataFactory: () => ThunderWaveActionPropsData(),
      summaryProvider: (obj) {
        try {
          final data = ThunderWaveActionPropsData.fromJson(
            obj.objData as Map<String, dynamic>,
          );
          return '${data.thunders.length}';
        } catch (_) {
          return '';
        }
      },
    ),
  };

  static List<EventMetadata> getAll() => _registry.values.toList();
  static EventMetadata? getByObjClass(String? objClass) {
    if (objClass == null) return null;
    return _registry[objClass];
  }
}
