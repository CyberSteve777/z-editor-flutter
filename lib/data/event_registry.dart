import 'package:flutter/material.dart';
import 'pvz_models.dart';

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
      titleKey: 'eventTitle_SpawnZombiesFromGround',
      descriptionKey: 'eventDesc_SpawnZombiesFromGround',
      icon: Icons.groups,
      color: const Color(0xFF936457),
      darkColor: const Color(0xFFC2A197),
      defaultAlias: 'GroundSpawner',
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
      titleKey: 'eventTitle_Jittered',
      descriptionKey: 'eventDesc_Jittered',
      icon: Icons.groups,
      color: const Color(0xFF2196F3),
      darkColor: const Color(0xFF90CAF9),
      defaultAlias: 'Jittered',
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
      titleKey: 'eventTitle_FrostWind',
      descriptionKey: 'eventDesc_FrostWind',
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
      titleKey: 'eventTitle_BeachStage',
      descriptionKey: 'eventDesc_BeachStage',
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
      titleKey: 'eventTitle_TidalChange',
      descriptionKey: 'eventDesc_TidalChange',
      icon: Icons.water_drop,
      color: const Color(0xFF00ACC1),
      darkColor: const Color(0xFF81D4FA),
      defaultAlias: 'TidalChangeEvent',
      defaultObjClass: 'TidalChangeWaveActionProps',
      initialDataFactory: () => TidalChangeWaveActionData(),
    ),
    'ModifyConveyorWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_ModifyConveyor',
      descriptionKey: 'eventDesc_ModifyConveyor',
      icon: Icons.transform,
      color: const Color(0xFF4AC380),
      darkColor: const Color(0xFF7CBD99),
      defaultAlias: 'ModConveyorEvent',
      defaultObjClass: 'ModifyConveyorWaveActionProps',
      initialDataFactory: () => ModifyConveyorWaveActionData(),
    ),
    'DinoWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_Dino',
      descriptionKey: 'eventDesc_Dino',
      icon: Icons.pets,
      color: const Color(0xFF91B900),
      darkColor: const Color(0xFFA2B659),
      defaultAlias: 'DinoTimeEvent',
      defaultObjClass: 'DinoWaveActionProps',
      initialDataFactory: () => DinoWaveActionPropsData(),
    ),
    'SpawnModernPortalsWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_Portal',
      descriptionKey: 'eventDesc_Portal',
      icon: Icons.hourglass_empty,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'PortalEvent',
      defaultObjClass: 'SpawnModernPortalsWaveActionProps',
      initialDataFactory: () => PortalEventData(),
    ),
    'StormZombieSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_Storm',
      descriptionKey: 'eventDesc_Storm',
      icon: Icons.storm,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'StormEvent',
      defaultObjClass: 'StormZombieSpawnerProps',
      initialDataFactory: () => StormZombieSpawnerPropsData(),
    ),
    'RaidingPartyZombieSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_Raiding',
      descriptionKey: 'eventDesc_Raiding',
      icon: Icons.tsunami,
      color: const Color(0xFFFF9800),
      darkColor: const Color(0xFFFFCC80),
      defaultAlias: 'RaidingPartyEvent',
      defaultObjClass: 'RaidingPartyZombieSpawnerProps',
      initialDataFactory: () => RaidingPartyEventData(),
    ),
    'ZombiePotionActionProps': EventMetadata(
      titleKey: 'eventTitle_Potion',
      descriptionKey: 'eventDesc_Potion',
      icon: Icons.science,
      color: const Color(0xFF607D8B),
      darkColor: const Color(0xFFB0BEC5),
      defaultAlias: 'PotionEvent',
      defaultObjClass: 'ZombiePotionActionProps',
      initialDataFactory: () => ZombiePotionActionPropsData(),
    ),
    'SpawnGravestonesWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_Gravestones',
      descriptionKey: 'eventDesc_Gravestones',
      icon: Icons.unarchive,
      color: const Color(0xFF607D8B),
      darkColor: const Color(0xFFB0BEC5),
      defaultAlias: 'GravestonesEvent',
      defaultObjClass: 'SpawnGravestonesWaveActionProps',
      initialDataFactory: () => SpawnGraveStonesData(),
    ),
    'SpawnZombiesFromGridItemSpawnerProps': EventMetadata(
      titleKey: 'eventTitle_GridItemSpawn',
      descriptionKey: 'eventDesc_GridItemSpawn',
      icon: Icons.groups,
      color: const Color(0xFF607D8B),
      darkColor: const Color(0xFFB0BEC5),
      defaultAlias: 'GraveSpawner',
      defaultObjClass: 'SpawnZombiesFromGridItemSpawnerProps',
      initialDataFactory: () => SpawnZombiesFromGridItemData(),
    ),
    'FairyTaleFogWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_FairyFog',
      descriptionKey: 'eventDesc_FairyFog',
      icon: Icons.cloud,
      color: const Color(0xFFBE5DBA),
      darkColor: const Color(0xFFBD99BB),
      defaultAlias: 'FairyFogEvent',
      defaultObjClass: 'FairyTaleFogWaveActionProps',
      initialDataFactory: () => FairyTaleFogWaveActionData(),
    ),
    'FairyTaleWindWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_FairyWind',
      descriptionKey: 'eventDesc_FairyWind',
      icon: Icons.air,
      color: const Color(0xFFBE5DBA),
      darkColor: const Color(0xFFBD99BB),
      defaultAlias: 'WindEvent',
      defaultObjClass: 'FairyTaleWindWaveActionProps',
      initialDataFactory: () => FairyTaleWindWaveActionData(),
    ),
    'MagicMirrorWaveActionProps': EventMetadata(
      titleKey: 'eventTitle_MagicMirror',
      descriptionKey: 'eventDesc_MagicMirror',
      icon: Icons.blur_circular,
      color: const Color(0xFF607D8B),
      darkColor: const Color(0xFFB0BEC5),
      defaultAlias: 'MagicMirrorEvent',
      defaultObjClass: 'MagicMirrorWaveActionProps',
      initialDataFactory: () => MagicMirrorWaveActionData(),
    ),
  };

  static List<EventMetadata> getAll() => _registry.values.toList();
  static EventMetadata? getByObjClass(String? objClass) {
    if (objClass == null) return null;
    return _registry[objClass];
  }
}
