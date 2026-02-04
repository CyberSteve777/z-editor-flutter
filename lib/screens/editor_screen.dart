import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/level_repository.dart';
import 'package:z_editor/data/module_registry.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/reference_repository.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/data/zombie_properties_repository.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/screens/editor/basic_info_screen.dart';
import 'package:z_editor/screens/editor/json_viewer_screen.dart';
import 'package:z_editor/screens/editor/others/custom_zombie_properties_screen.dart';
import 'package:z_editor/screens/editor/others/unknown_module_screen.dart';
import 'package:z_editor/screens/editor/modules/star_challenge_screen.dart';
import 'package:z_editor/screens/editor/modules/max_sun_module_screen.dart';
import 'package:z_editor/screens/editor/modules/bowling_minigame_screen.dart';
import 'package:z_editor/screens/editor/modules/death_hole_module_screen.dart';
import 'package:z_editor/screens/editor/modules/increased_cost_module_screen.dart';
import 'package:z_editor/screens/editor/modules/pirate_plank_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/railcart_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/seed_rain_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/conveyor_seedbank_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/seed_bank_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/sun_dropper_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/starting_plantfood_module_screen.dart';
import 'package:z_editor/screens/editor/modules/tide_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/zombie_move_fast_module_screen.dart';
import 'package:z_editor/screens/editor/modules/wave_manager_settings_screen.dart';
import 'package:z_editor/screens/editor/modules/last_stand_minigame_screen.dart';
import 'package:z_editor/screens/editor/modules/initial_plant_entry_screen.dart';
import 'package:z_editor/screens/editor/modules/initial_zombie_entry_screen.dart';
import 'package:z_editor/screens/editor/modules/initial_grid_item_entry_screen.dart';
import 'package:z_editor/screens/editor/modules/manhole_pipeline_module_screen.dart';
import 'package:z_editor/screens/editor/modules/penny_classroom_module_screen.dart';
import 'package:z_editor/screens/editor/modules/power_tile_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/protect_grid_item_challenge_screen.dart';
import 'package:z_editor/screens/editor/modules/protect_plant_challenge_screen.dart';
import 'package:z_editor/screens/editor/modules/roof_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/rain_dark_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/sun_bomb_challenge_screen.dart';
import 'package:z_editor/screens/editor/modules/war_mist_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/zombie_potion_module_screen.dart';
import 'package:z_editor/screens/editor/modules/wave_manager_module_screen.dart';
import 'package:z_editor/screens/editor/tabs/izombie_tab.dart';
import 'package:z_editor/screens/editor/tabs/level_settings_tab.dart';
import 'package:z_editor/screens/editor/tabs/vase_breaker_tab.dart';
import 'package:z_editor/screens/editor/tabs/zomboss_battle_tab.dart';
import 'package:z_editor/screens/editor/tabs/wave_timeline_tab.dart';
import 'package:z_editor/data/event_registry.dart';
import 'package:z_editor/screens/editor/events/invalid_event_screen.dart';
import 'package:z_editor/screens/editor/events/beach_stage_event_screen.dart';
import 'package:z_editor/screens/editor/events/black_hole_event_screen.dart';
import 'package:z_editor/screens/editor/events/dino_event_screen.dart';
import 'package:z_editor/screens/editor/events/fairy_tale_fog_event_screen.dart';
import 'package:z_editor/screens/editor/events/fairy_tale_wind_event_screen.dart';
import 'package:z_editor/screens/editor/events/frost_wind_event_screen.dart';
import 'package:z_editor/screens/editor/events/grid_item_spawn_event_screen.dart';
import 'package:z_editor/screens/editor/events/magic_mirror_event_screen.dart';
import 'package:z_editor/screens/editor/events/modify_conveyor_event_screen.dart';
import 'package:z_editor/screens/editor/events/modern_portals_event_screen.dart';
import 'package:z_editor/screens/editor/events/parachute_rain_event_screen.dart';
import 'package:z_editor/screens/editor/events/raiding_party_event_screen.dart';
import 'package:z_editor/screens/editor/events/spawn_grave_stones_event_screen.dart';
import 'package:z_editor/screens/editor/events/storm_event_screen.dart';
import 'package:z_editor/screens/editor/events/tidal_change_event_screen.dart';
import 'package:z_editor/screens/editor/events/zombie_potion_event_screen.dart';
import 'package:z_editor/screens/editor/events/zombie_spawn_event_screen.dart';
import 'package:z_editor/screens/select/event_selection_screen.dart';
import 'package:z_editor/screens/select/grid_item_selection_screen.dart';
import 'package:z_editor/screens/select/module_selection_screen.dart';
import 'package:z_editor/screens/select/plant_selection_screen.dart';
import 'package:z_editor/screens/select/zombie_selection_screen.dart';
import 'package:z_editor/screens/select/tool_selection_screen.dart';
import 'package:z_editor/screens/select/stage_selection_screen.dart';

enum EditorTabType { settings, timeline, iZombie, vaseBreaker, zomboss }

class EditorScreen extends StatefulWidget {
  const EditorScreen({
    super.key,
    required this.fileName,
    required this.filePath,
    required this.onBack,
    required this.isDarkTheme,
    required this.onToggleTheme,
  });

  final String fileName;
  final String filePath;
  final VoidCallback onBack;
  final bool isDarkTheme;
  final VoidCallback onToggleTheme;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  PvzLevelFile? _levelFile;
  ParsedLevelData? _parsedData;
  bool _isLoading = true;
  bool _hasChanges = false;
  List<EditorTabType> _availableTabs = [EditorTabType.settings];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  Future<void> _loadLevel() async {
    setState(() => _isLoading = true);
    await ReferenceRepository.init();
    await ZombiePropertiesRepository.init();
    await PlantRepository().init();
    await ZombieRepository().init();
    final level = await LevelRepository.loadLevel(widget.fileName);
    if (mounted && level != null) {
      final parsed = LevelParser.parseLevel(level);
      setState(() {
        _levelFile = level;
        _parsedData = parsed;
        _recalculateTabs();
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _recalculateTabs() {
    if (_levelFile == null || _parsedData == null) return;
    final classes = <String>{
      ..._levelFile!.objects.map((o) => o.objClass),
      ...?_parsedData!.levelDef?.modules.map((rtid) {
        final info = RtidParser.parse(rtid);
        if (info == null) return '';
        if (info.source == 'CurrentLevel') {
          return _parsedData!.objectMap[info.alias]?.objClass ?? '';
        }
        return ReferenceRepository.instance.getObjClass(info.alias) ?? '';
      }),
    };
    final tabs = <EditorTabType>[EditorTabType.settings];
    if (classes.contains('WaveManagerModuleProperties')) {
      tabs.add(EditorTabType.timeline);
    }
    if (classes.contains('EvilDaveProperties')) tabs.add(EditorTabType.iZombie);
    if (classes.contains('VaseBreakerPresetProperties') ||
        classes.contains('VaseBreakerArcadeModuleProperties')) {
      tabs.add(EditorTabType.vaseBreaker);
    }
    if (classes.contains('ZombossBattleModuleProperties')) {
      tabs.add(EditorTabType.zomboss);
    }
    _availableTabs = tabs;
  }

  List<ModuleMetadata> _calculateMissingModules() {
    if (_levelFile == null || _parsedData == null) return const [];
    final existingClasses = <String>{
      ..._levelFile!.objects.map((o) => o.objClass),
      ...?_parsedData!.levelDef?.modules.map((rtid) {
        final info = RtidParser.parse(rtid);
        if (info == null) return '';
        if (info.source == 'CurrentLevel') {
          return _parsedData!.objectMap[info.alias]?.objClass ?? '';
        }
        return ReferenceRepository.instance.getObjClass(info.alias) ?? '';
      }),
    }.where((e) => e.isNotEmpty).toSet();

    final isVaseBreaker =
        existingClasses.contains('VaseBreakerPresetProperties') ||
        existingClasses.contains('VaseBreakerArcadeModuleProperties') ||
        existingClasses.contains('VaseBreakerFlowModuleProperties');
    final isZombossBattle =
        existingClasses.contains('ZombossBattleModuleProperties') ||
        existingClasses.contains('ZombossBattleIntroProperties');
    final isLastStand = existingClasses.contains('LastStandMinigameProperties');
    final isEvilDave = existingClasses.contains('EvilDaveProperties');

    final missingList = <String>[];
    if (!existingClasses.contains('CustomLevelModuleProperties')) {
      missingList.add('CustomLevelModuleProperties');
    }
    if (!existingClasses.contains('ZombiesAteYourBrainsProperties')) {
      if (!isEvilDave) missingList.add('ZombiesAteYourBrainsProperties');
    }
    if (!existingClasses.contains('ZombiesDeadWinConProperties')) {
      if (!isEvilDave && !isZombossBattle) {
        missingList.add('ZombiesDeadWinConProperties');
      }
    }
    if (!existingClasses.contains('StandardLevelIntroProperties')) {
      if (!isVaseBreaker && !isLastStand && !isZombossBattle) {
        missingList.add('StandardLevelIntroProperties');
      }
    }
    if (isVaseBreaker) {
      if (!existingClasses.contains('VaseBreakerPresetProperties')) {
        missingList.add('VaseBreakerPresetProperties');
      }
      if (!existingClasses.contains('VaseBreakerArcadeModuleProperties')) {
        missingList.add('VaseBreakerArcadeModuleProperties');
      }
      if (!existingClasses.contains('VaseBreakerFlowModuleProperties')) {
        missingList.add('VaseBreakerFlowModuleProperties');
      }
    }
    if (isEvilDave) {
      if (!existingClasses.contains('InitialPlantEntryProperties')) {
        missingList.add('InitialPlantEntryProperties');
      }
      if (!existingClasses.contains('SeedBankProperties')) {
        missingList.add('SeedBankProperties');
      }
    }
    if (isZombossBattle) {
      if (!existingClasses.contains('ZombossBattleModuleProperties')) {
        missingList.add('ZombossBattleModuleProperties');
      }
      if (!existingClasses.contains('ZombossBattleIntroProperties')) {
        missingList.add('ZombossBattleIntroProperties');
      }
    }
    if (isLastStand) {
      if (!existingClasses.contains('SeedBankProperties')) {
        missingList.add('SeedBankProperties');
      }
    }

    final metas = missingList
        .map((cls) => ModuleRegistry.getMetadata(cls))
        .where((m) {
          return m.titleKey != ModuleRegistry.defaultMetadataKey;
        })
        .toList();
    return metas;
  }

  Future<void> _save() async {
    if (_levelFile == null) return;
    await LevelRepository.saveAndExport(widget.filePath, _levelFile!);
    if (mounted) {
      setState(() => _hasChanges = false);
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n?.saved ?? 'Saved')));
    }
  }

  void _markDirty() {
    setState(() {
      _hasChanges = true;
      // Re-parse to refresh derived state and force UI to recognize updates
      if (_levelFile != null) {
        _parsedData = LevelParser.parseLevel(_levelFile!);
      }
    });
  }

  Future<bool> _confirmLeave() async {
    final l10n = AppLocalizations.of(context);
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.unsavedChanges ?? 'Unsaved changes'),
        content: Text(l10n?.saveBeforeLeaving ?? 'Save before leaving?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n?.discard ?? 'Discard'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await _save();
              if (mounted) Navigator.pop(ctx, true);
            },
            child: Text(l10n?.confirm ?? 'Save'),
          ),
        ],
      ),
    );
    return leave == true;
  }

  // --- Actions ---

  void _handleEditBasicInfo() {
    if (_levelFile == null || _parsedData == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BasicInfoScreen(
          levelFile: _levelFile!,
          levelDef: _parsedData!.levelDef!,
          onBack: () => Navigator.pop(context),
          onStageTap: () {
            _openStageSelection();
          },
          onChanged: _markDirty,
        ),
      ),
    );
  }

  void _openStageSelection() {
    if (_levelFile == null ||
        _parsedData == null ||
        _parsedData!.levelDef == null) {
      return;
    }
    final current = _parsedData!.levelDef!.stageModule;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StageSelectionScreen(
          currentStageRtid: current,
          onStageSelected: (newRtid) {
            final def = _parsedData!.levelDef!;
            def.stageModule = newRtid;
            for (final o in _levelFile!.objects) {
              if (o.objClass == 'LevelDefinition') {
                o.objData = def.toJson();
                break;
              }
            }
            _markDirty();
            setState(() {});
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _handleNavigateToAddModule() async {
    if (_levelFile == null || _parsedData == null) return;

    final existingObjClasses = <String>{};
    for (var rtid in _parsedData!.levelDef!.modules) {
      final info = RtidParser.parse(rtid);
      if (info != null) {
        if (info.source == 'CurrentLevel') {
          final obj = _parsedData!.objectMap[info.alias];
          if (obj != null) existingObjClasses.add(obj.objClass);
        } else {
          final cls = ReferenceRepository.instance.getObjClass(info.alias);
          if (cls != null) existingObjClasses.add(cls);
        }
      }
    }

    final meta = await Navigator.push<ModuleMetadata>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ModuleSelectionScreen(existingObjClasses: existingObjClasses),
      ),
    );

    if (meta != null) {
      _addModule(meta);
    }
  }

  void _addModule(ModuleMetadata meta) {
    final def = _parsedData!.levelDef;
    if (def == null) return;

    var alias = meta.effectiveAlias;
    final source = meta.defaultSource;

    if (source == 'CurrentLevel') {
      var count = 0;
      while (_levelFile!.objects.any(
        (o) => o.aliases?.contains(alias) == true,
      )) {
        count++;
        alias = '${meta.effectiveAlias}_$count';
      }

      final rtid = RtidParser.build(alias, source);
      def.modules.add(rtid);

      final objData = Map<String, dynamic>.from(meta.initialData ?? {});
      _levelFile!.objects.add(
        PvzObject(aliases: [alias], objClass: meta.objClass, objData: objData),
      );
    } else {
      final rtid = RtidParser.build(alias, source);
      def.modules.add(rtid);
    }

    _parsedData = LevelParser.parseLevel(_levelFile!); // Re-parse to update map
    _markDirty();
    _recalculateTabs();
  }

  void _handleRemoveModule(String rtid) {
    final def = _parsedData?.levelDef;
    if (def == null) return;

    def.modules.remove(rtid);
    final info = RtidParser.parse(rtid);
    if (info != null && info.source == 'CurrentLevel') {
      _levelFile!.objects.removeWhere(
        (o) => o.aliases?.contains(info.alias) == true,
      );
    }

    _parsedData = LevelParser.parseLevel(_levelFile!);
    _markDirty();
    _recalculateTabs();
  }

  void _handleEditEvent(String rtid, int waveIndex) {
    if (_levelFile == null || _parsedData == null) return;
    final alias = LevelParser.extractAlias(rtid);
    final obj = _parsedData!.objectMap[alias];

    if (obj == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvalidEventScreen(
            rtid: rtid,
            waveIndex: waveIndex,
            onDeleteReference: _handleDeleteEventReference,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    final objClass = obj.objClass;
    if (objClass == 'SpawnGravestonesWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SpawnGraveStonesEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
            onRequestGridItemSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GridItemSelectionScreen(
                    onGridItemSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'ParachuteRainZombieSpawnerProps' ||
        objClass == 'BassRainZombieSpawnerProps' ||
        objClass == 'SpiderRainZombieSpawnerProps') {
      final subtitle = objClass == 'BassRainZombieSpawnerProps'
          ? 'Event: Bass/Jetpack rain'
          : objClass == 'SpiderRainZombieSpawnerProps'
              ? 'Event: Spider rain'
              : 'Event: Parachute rain';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParachuteRainEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
            eventSubtitle: subtitle,
            onRequestZombieSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombieSelectionScreen(
                    multiSelect: false,
                    onZombieSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiZombieSelected: (_) {},
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'TidalChangeWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TidalChangeEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    if (objClass == 'SpawnZombiesJitteredWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZombieSpawnEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () {
              _setActiveTab(EditorTabType.timeline);
              Navigator.pop(context);
            },
            eventSubtitle: 'Event: Standard spawn',
            isGroundSpawner: false,
            onEditCustomZombie: _handleEditCustomZombie,
            onInjectCustomZombie: _injectCustomZombie,
            onRequestPlantSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlantSelectionScreen(
                    isMultiSelect: false,
                    onPlantSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiPlantSelected: (_) {},
                    onBack: () {
                      _setActiveTab(EditorTabType.timeline);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            onRequestZombieSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombieSelectionScreen(
                    multiSelect: false,
                    onZombieSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiZombieSelected: (_) {},
                    onBack: () {
                      _setActiveTab(EditorTabType.timeline);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'SpawnZombiesFromGroundSpawnerProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZombieSpawnEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () {
              _setActiveTab(EditorTabType.timeline);
              Navigator.pop(context);
            },
            eventSubtitle: 'Event: Ground spawn',
            isGroundSpawner: true,
            onEditCustomZombie: _handleEditCustomZombie,
            onInjectCustomZombie: _injectCustomZombie,
            onRequestPlantSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlantSelectionScreen(
                    isMultiSelect: false,
                    onPlantSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiPlantSelected: (_) {},
                    onBack: () {
                      _setActiveTab(EditorTabType.timeline);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            onRequestZombieSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombieSelectionScreen(
                    multiSelect: false,
                    onZombieSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiZombieSelected: (_) {},
                    onBack: () {
                      _setActiveTab(EditorTabType.timeline);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'ModifyConveyorWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModifyConveyorEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
            onRequestPlantSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlantSelectionScreen(
                    isMultiSelect: false,
                    onPlantSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiPlantSelected: (_) {},
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'BeachStageEventZombieSpawnerProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BeachStageEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
            onRequestZombieSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombieSelectionScreen(
                    multiSelect: false,
                    onZombieSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiZombieSelected: (_) {},
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'StormZombieSpawnerProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StormEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () {
              _setActiveTab(EditorTabType.timeline);
              Navigator.pop(context);
            },
            onEditCustomZombie: _handleEditCustomZombie,
            onInjectCustomZombie: _injectCustomZombie,
            onRequestZombieSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombieSelectionScreen(
                    multiSelect: false,
                    onZombieSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiZombieSelected: (_) {},
                    onBack: () {
                      _setActiveTab(EditorTabType.timeline);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'RaidingPartyZombieSpawnerProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RaidingPartyEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    if (objClass == 'BlackHoleWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlackHoleEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    if (objClass == 'FrostWindWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FrostWindEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    if (objClass == 'DinoWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DinoEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    if (objClass == 'SpawnZombiesFromGridItemSpawnerProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GridItemSpawnEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () {
              _setActiveTab(EditorTabType.timeline);
              Navigator.pop(context);
            },
            onEditCustomZombie: _handleEditCustomZombie,
            onInjectCustomZombie: _injectCustomZombie,
            onRequestGridItemSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GridItemSelectionScreen(
                    onGridItemSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onBack: () {
                      _setActiveTab(EditorTabType.timeline);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            onRequestZombieSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombieSelectionScreen(
                    multiSelect: false,
                    onZombieSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiZombieSelected: (_) {},
                    onBack: () {
                      _setActiveTab(EditorTabType.timeline);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'ZombiePotionActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZombiePotionEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
            onRequestGridItemSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GridItemSelectionScreen(
                    onGridItemSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'MagicMirrorWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MagicMirrorEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    if (objClass == 'FairyTaleFogWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FairyTaleFogEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    if (objClass == 'FairyTaleWindWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FairyTaleWindEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    if (objClass == 'SpawnModernPortalsWaveActionProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModernPortalsEventScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Event editor in development'),
      ),
    );
  }

  void _handleAddEvent(int waveIndex) async {
    if (_levelFile == null || _parsedData == null) return;
    final wm = _parsedData!.waveManager;
    if (wm is! WaveManagerData) return;
    if (waveIndex < 1 || waveIndex > wm.waves.length) return;

    final meta = await Navigator.push<EventMetadata>(
      context,
      MaterialPageRoute(
        builder: (context) => EventSelectionScreen(
          waveIndex: waveIndex,
          onEventSelected: (m) => Navigator.pop(context, m),
          onBack: () => Navigator.pop(context),
        ),
      ),
    );

    if (meta == null || !mounted) return;

    final waveEvents = wm.waves[waveIndex - 1];
    var prefix = 'Wave$waveIndex${meta.defaultAlias}';
    var count = 0;
    var newAlias = '$prefix$count';
    while (_levelFile!.objects.any((o) => o.aliases?.contains(newAlias) == true)) {
      count++;
      newAlias = '$prefix$count';
    }

    final newRtid = RtidParser.build(newAlias, 'CurrentLevel');
    final data = meta.initialDataFactory();
    final objData = (data as dynamic).toJson() as Map<String, dynamic>;
    _levelFile!.objects.add(
      PvzObject(
        aliases: [newAlias],
        objClass: meta.defaultObjClass,
        objData: objData,
      ),
    );
    waveEvents.add(newRtid);

    final wmObj = _levelFile!.objects
        .firstWhereOrNull((o) => o.objClass == 'WaveManagerProperties');
    if (wmObj != null) {
      wmObj.objData = wm.toJson();
    }

    _parsedData = LevelParser.parseLevel(_levelFile!);
    _markDirty();
    setState(() {});
  }

  void _handleDeleteEventReference(String rtid) {
    if (_parsedData?.waveManager is WaveManagerData) {
      final wm = _parsedData!.waveManager as WaveManagerData;
      for (final wave in wm.waves) {
        wave.remove(rtid);
      }
      final wmObj = _levelFile?.objects
          .firstWhereOrNull((o) => o.objClass == 'WaveManagerProperties');
      if (wmObj != null) {
        wmObj.objData = wm.toJson();
      }
      _parsedData = LevelParser.parseLevel(_levelFile!);
      _markDirty();
      setState(() {});
    }
  }

  void _handleEditWaveManagerSettings() {
    if (_levelFile == null || _parsedData == null) return;
    final hasConveyor = _parsedData!.levelDef?.modules.any((rtid) {
      final info = RtidParser.parse(rtid);
      if (info == null) return false;
      if (info.source == 'CurrentLevel') {
        final obj = _parsedData!.objectMap[info.alias];
        return obj?.objClass == 'ConveyorSeedBankProperties';
      }
      return ReferenceRepository.instance.getObjClass(info.alias) ==
          'ConveyorSeedBankProperties';
    }) ?? false;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WaveManagerSettingsScreen(
          levelFile: _levelFile!,
          hasConveyor: hasConveyor,
          onChanged: _markDirty,
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _handleEditCustomZombie(String rtid) {
    if (_levelFile == null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomZombiePropertiesScreen(
          rtid: rtid,
          levelFile: _levelFile!,
          onChanged: _markDirty,
          onBack: () => Navigator.pop(context),
        ),
      ),
    ).then((_) => _setActiveTab(EditorTabType.timeline));
  }

  void _setActiveTab(EditorTabType type) {
    final index = _availableTabs.indexOf(type);
    if (index >= 0) {
      _tabController?.animateTo(index);
    }
  }

  dynamic _cloneJson(dynamic data) {
    return jsonDecode(jsonEncode(data));
  }

  String? _injectCustomZombie(String originalAlias) {
    if (_levelFile == null) return null;
    final typeName = ZombiePropertiesRepository.getTypeNameByAlias(
      originalAlias,
    );
    final template = ZombiePropertiesRepository.getTemplateJson(typeName);
    if (template == null) {
      return null;
    }

    final typeTemplate = template['type'];
    final propsTemplate = template['props'];
    if (typeTemplate is! PvzObject || propsTemplate is! PvzObject) {
      return null;
    }

    final baseName = typeName;
    var index = 1;
    while (_levelFile!.objects.any(
      (o) => o.aliases?.contains('${baseName}_$index') == true,
    )) {
      index++;
    }
    final newTypeAlias = '${baseName}_$index';

    var propsIndex = index;
    while (_levelFile!.objects.any(
      (o) => o.aliases?.contains('${baseName}_props_$propsIndex') == true,
    )) {
      propsIndex++;
    }
    final newPropsAlias = '${baseName}_props_$propsIndex';

    final newPropsData = _cloneJson(propsTemplate.objData);
    final newTypeData = _cloneJson(typeTemplate.objData);
    if (newTypeData is Map<String, dynamic>) {
      newTypeData['Properties'] =
          RtidParser.build(newPropsAlias, 'CurrentLevel');
    }

    final newPropsObj = PvzObject(
      aliases: [newPropsAlias],
      objClass: propsTemplate.objClass,
      objData: newPropsData,
    );
    final newTypeObj = PvzObject(
      aliases: [newTypeAlias],
      objClass: typeTemplate.objClass,
      objData: newTypeData,
    );

    _levelFile!.objects.addAll([newPropsObj, newTypeObj]);
    _parsedData = LevelParser.parseLevel(_levelFile!);
    _markDirty();
    setState(() {});

    return RtidParser.build(newTypeAlias, 'CurrentLevel');
  }

  void _handleEditModule(String rtid) {
    final info = RtidParser.parse(rtid);
    if (info == null) return;

    PvzObject? obj;
    String objClass = 'Unknown';

    if (info.source == 'CurrentLevel') {
      obj = _parsedData!.objectMap[info.alias];
      objClass = obj?.objClass ?? 'Unknown';
    } else {
      objClass =
          ReferenceRepository.instance.getObjClass(info.alias) ?? 'Unknown';
    }

    // Check if we have a specific screen for this module
    if (objClass == 'StarChallengeModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StarChallengeModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'LevelMutatorMaxSunProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MaxSunModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'LevelMutatorStartingPlantfoodProps') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StartingPlantfoodModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'RailcartProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RailcartPropertiesScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'IncreasedCostModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IncreasedCostModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'DeathHoleModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeathHoleModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'ZombieMoveFastModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZombieMoveFastModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' && objClass == 'TideProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TidePropertiesScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'BowlingMinigameProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BowlingMinigameScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'SunDropperProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SunDropperPropertiesScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'PiratePlankProperties') {
      if (_parsedData!.levelDef != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PiratePlankPropertiesScreen(
              rtid: rtid,
              levelFile: _levelFile!,
              levelDef: _parsedData!.levelDef!,
              onChanged: _markDirty,
              onBack: () => Navigator.pop(context),
            ),
          ),
        );
      }
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'SeedRainProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeedRainPropertiesScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'ConveyorSeedBankProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConveyorSeedBankPropertiesScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
            onRequestPlantSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlantSelectionScreen(
                    isMultiSelect: false,
                    onPlantSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
            onRequestToolSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ToolSelectionScreen(
                    onToolSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'LastStandMinigameProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LastStandMinigameScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'SeedBankProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SeedBankPropertiesScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
            onRequestPlantSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlantSelectionScreen(
                    isMultiSelect: true,
                    onPlantSelected: (_) {},
                    onMultiPlantSelected: (ids) {
                      Navigator.pop(context);
                      onSelected(ids);
                    },
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
            onRequestZombieSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombieSelectionScreen(
                    multiSelect: true,
                    onZombieSelected: (_) {},
                    onMultiZombieSelected: (ids) {
                      Navigator.pop(context);
                      onSelected(ids);
                    },
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'InitialPlantEntryProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InitialPlantEntryScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'InitialZombieProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InitialZombieEntryScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'InitialGridItemProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InitialGridItemEntryScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'ProtectThePlantChallengeProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProtectPlantChallengeScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'ProtectTheGridItemChallengeProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProtectGridItemChallengeScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'SunBombChallengeProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SunBombChallengeScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'ZombiePotionModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZombiePotionModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'PennyClassroomModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PennyClassroomModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'ManholePipelineModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManholePipelineModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'PowerTileProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PowerTilePropertiesScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'RoofProperties') {
      if (_parsedData!.levelDef != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoofPropertiesScreen(
              rtid: rtid,
              levelFile: _levelFile!,
              levelDef: _parsedData!.levelDef!,
              onChanged: _markDirty,
              onBack: () => Navigator.pop(context),
            ),
          ),
        );
      }
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'WarMistProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WarMistPropertiesScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
      return;
    }
    if (objClass == 'RainDarkProperties') {
      if (_parsedData!.levelDef != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RainDarkPropertiesScreen(
              currentRtid: rtid,
              levelDef: _parsedData!.levelDef!,
              onChanged: _markDirty,
              onBack: () => Navigator.pop(context),
            ),
          ),
        );
      }
      return;
    }
    if (info.source == 'CurrentLevel' &&
        objClass == 'WaveManagerModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WaveManagerModuleScreen(
            rtid: rtid,
            levelFile: _levelFile!,
            onChanged: _markDirty,
            onBack: () => Navigator.pop(context),
            onRequestZombieSelection: (onSelected) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombieSelectionScreen(
                    multiSelect: false,
                    onZombieSelected: (id) {
                      Navigator.pop(context);
                      onSelected(id);
                    },
                    onMultiZombieSelected: (_) {},
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    // Fallback: Use UnknownModuleScreen for local objects without editor, or show message for references
    if (info.source == 'CurrentLevel' && obj != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UnknownModuleScreen(
            onBack: () => Navigator.pop(context),
          ),
        ),
      );
    } else {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n?.moduleEditorInProgress ?? 'Module editor in development',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopScope(
      canPop: !_hasChanges,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final leave = await _confirmLeave();
        if (leave && mounted) widget.onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.fileName),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (_hasChanges) {
                final leave = await _confirmLeave();
                if (leave && mounted) widget.onBack();
              } else {
                widget.onBack();
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: _levelFile != null
                  ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JsonViewerScreen(
                          fileName: widget.fileName,
                          levelFile: _levelFile!,
                          onBack: () => Navigator.pop(context),
                        ),
                      ),
                    )
                  : null,
            ),
            IconButton(
              icon: Icon(
                widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: widget.onToggleTheme,
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _hasChanges ? _save : null,
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _levelFile == null || _parsedData == null
            ? Center(
                child: Text(l10n?.failedToLoadLevel ?? 'Failed to load level'),
              )
            : DefaultTabController(
                length: _availableTabs.length,
                child: Builder(
                  builder: (context) {
                    _tabController = DefaultTabController.of(context);
                    return Column(
                      children: [
                        TabBar(
                          isScrollable: false,
                          tabAlignment: TabAlignment.fill,
                          dividerHeight: 0,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: _availableTabs.map((t) {
                            IconData icon;
                            String label;
                            switch (t) {
                              case EditorTabType.settings:
                                icon = Icons.settings;
                                label = l10n?.settings ?? 'Settings';
                                break;
                              case EditorTabType.timeline:
                                icon = Icons.timeline;
                                label = l10n?.timeline ?? 'Timeline';
                                break;
                              case EditorTabType.iZombie:
                                icon = Icons.groups;
                                label = l10n?.iZombie ?? 'I, Zombie';
                                break;
                              case EditorTabType.vaseBreaker:
                                icon = Icons.inventory_2;
                                label = l10n?.vaseBreaker ?? 'Vase breaker';
                                break;
                              case EditorTabType.zomboss:
                                icon = Icons.warning_amber;
                                label = l10n?.zomboss ?? 'Zomboss';
                                break;
                            }
                            return Tab(text: label, icon: Icon(icon));
                          }).toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: _availableTabs.map((t) {
                              switch (t) {
                                case EditorTabType.settings:
                                  return LevelSettingsTab(
                                    levelDef: _parsedData!.levelDef,
                                    objectMap: _parsedData!.objectMap,
                                    missingModules: _calculateMissingModules(),
                                    onEditBasicInfo: _handleEditBasicInfo,
                                    onEditModule: _handleEditModule,
                                    onRemoveModule: _handleRemoveModule,
                                    onNavigateToAddModule:
                                        _handleNavigateToAddModule,
                                  );
                                case EditorTabType.timeline:
                                  return WaveTimelineTab(
                                    levelFile: _levelFile!,
                                    parsed: _parsedData!,
                                    onChanged: _markDirty,
                                    onEditEvent: _handleEditEvent,
                                    onAddEvent: _handleAddEvent,
                                    onEditWaveManagerSettings:
                                        _handleEditWaveManagerSettings,
                                    onEditCustomZombie: _handleEditCustomZombie,
                                  );
                                case EditorTabType.iZombie:
                                  return IZombieTab(
                                    levelFile: _levelFile!,
                                    onChanged: _markDirty,
                                  );
                                case EditorTabType.vaseBreaker:
                                  return VaseBreakerTab(
                                    levelFile: _levelFile!,
                                    onChanged: _markDirty,
                                  );
                                case EditorTabType.zomboss:
                                  return ZombossBattleTab(
                                    levelFile: _levelFile!,
                                    onChanged: _markDirty,
                                  );
                              }
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
