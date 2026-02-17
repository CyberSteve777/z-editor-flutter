import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/repository/level_repository.dart';
import 'package:z_editor/data/registry/module_registry.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/repository/reference_repository.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/data/repository/plant_repository.dart';
import 'package:z_editor/data/repository/zombie_properties_repository.dart';
import 'package:z_editor/data/repository/zombie_repository.dart';
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
import 'package:z_editor/screens/editor/modules/initial_plant_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/initial_zombie_entry_screen.dart';
import 'package:z_editor/screens/editor/modules/initial_grid_item_entry_screen.dart';
import 'package:z_editor/screens/editor/modules/power_tile_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/protect_grid_item_challenge_screen.dart';
import 'package:z_editor/screens/editor/modules/protect_plant_challenge_screen.dart';
import 'package:z_editor/screens/editor/modules/roof_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/rain_dark_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/sun_bomb_challenge_screen.dart';
import 'package:z_editor/screens/editor/modules/war_mist_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/zombie_potion_module_screen.dart';
import 'package:z_editor/screens/editor/modules/penny_classroom_module_screen.dart';
import 'package:z_editor/screens/editor/modules/manhole_pipeline_module_screen.dart';
import 'package:z_editor/screens/editor/modules/wave_manager_module_screen.dart';
import 'package:z_editor/screens/editor/modules/lawn_mower_properties_screen.dart';
import 'package:z_editor/screens/editor/modules/tunnel_defend_module_screen.dart';
import 'package:z_editor/screens/editor/modules/zombie_rush_module_screen.dart';
import 'package:z_editor/screens/editor/tabs/izombie_tab.dart';
import 'package:z_editor/screens/editor/tabs/level_settings_tab.dart';
import 'package:z_editor/screens/editor/tabs/vase_breaker_tab.dart';
import 'package:z_editor/screens/editor/tabs/zomboss_battle_tab.dart';
import 'package:z_editor/screens/editor/tabs/wave_timeline_tab.dart';
import 'package:z_editor/data/registry/event_registry.dart';
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
import 'package:z_editor/data/repository/grid_item_repository.dart';
import 'package:z_editor/screens/select/grid_item_selection_screen.dart';
import 'package:z_editor/screens/select/module_selection_screen.dart';
import 'package:z_editor/screens/select/plant_selection_screen.dart';
import 'package:z_editor/screens/select/zombie_selection_screen.dart';
import 'package:z_editor/screens/select/tool_selection_screen.dart';
import 'package:z_editor/screens/select/stage_selection_screen.dart';
import 'package:z_editor/theme/app_theme.dart';

enum EditorTabType { settings, timeline, iZombie, vaseBreaker, zomboss }

class _EditorEscapeIntent extends Intent {
  const _EditorEscapeIntent();
}

class EditorScreen extends StatefulWidget {
  const EditorScreen({
    super.key,
    required this.fileName,
    required this.filePath,
    required this.onBack,
    required this.onRegisterBackHandler,
    required this.themeMode,
    required this.onCycleTheme,
    required this.locale,
    required this.onLocaleChanged,
    required this.uiScale,
    required this.onUiScaleChange,
    required this.onLanguageTap,
  });

  final String fileName;
  final String filePath;
  final VoidCallback onBack;
  final void Function(Future<bool> Function()? handler) onRegisterBackHandler;
  final ThemeMode themeMode;
  final VoidCallback onCycleTheme;
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final double uiScale;
  final ValueChanged<double> onUiScaleChange;
  final void Function(BuildContext context) onLanguageTap;

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
  final ValueNotifier<({int waveIndex, String? rtid})?> _openWaveSheetNotifier =
      ValueNotifier<({int waveIndex, String? rtid})?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onRegisterBackHandler(() async {
        if (_hasChanges) {
          return await _confirmLeave();
        }
        return true;
      });
    });
    _loadLevel();
  }

  @override
  void dispose() {
    widget.onRegisterBackHandler(null);
    super.dispose();
  }

  Future<void> _loadLevel() async {
    setState(() => _isLoading = true);
    await ReferenceRepository.init();
    await ZombiePropertiesRepository.init();
    await PlantRepository().init();
    await ZombieRepository().init();
    var level = await LevelRepository.loadLevel(widget.fileName);
    if (level == null && widget.filePath.isNotEmpty) {
      level = await LevelRepository.loadLevelFromPath(widget.filePath);
      if (level != null) {
        await LevelRepository.prepareInternalCache(widget.filePath, widget.fileName);
      }
    }
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
    final hadChanges = _hasChanges;
    await LevelRepository.saveAndExport(widget.filePath, _levelFile!);
    if (mounted) {
      setState(() => _hasChanges = false);
      if (hadChanges) {
        final l10n = AppLocalizations.of(context);
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        final snackColor = isDark ? pvzGreenDark : pvzGreenLight;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: snackColor,
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n?.saved ?? 'Saved',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }
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
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n?.discard ?? 'Discard'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n?.stayInEditor ?? 'Stay'),
          ),
          FilledButton(
            onPressed: () async {
              await _save();
              if (ctx.mounted) Navigator.pop(ctx, true);
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
          onStageTap: (levelDef, onStagePicked) =>
              _openStageSelection(levelDef: levelDef, onStagePicked: onStagePicked),
          onChanged: _markDirty,
        ),
      ),
    );
  }

  Future<void> _openStageSelection({
    required LevelDefinitionData levelDef,
    VoidCallback? onStagePicked,
  }) async {
    if (_levelFile == null) return;
    final current = levelDef.stageModule;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StageSelectionScreen(
          currentStageRtid: current,
          onStageSelected: (newRtid) {
            levelDef.stageModule = newRtid;
            for (final o in _levelFile!.objects) {
              if (o.objClass == 'LevelDefinition') {
                o.objData = levelDef.toJson();
                break;
              }
            }
            _markDirty();
            setState(() {});
            onStagePicked?.call();
            if (!mounted) return;
            Navigator.pop(context);
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

  Future<void> _handleEditEvent(String rtid, int waveIndex) async {
    if (_levelFile == null || _parsedData == null) return;
    final l10n = AppLocalizations.of(context);
    final alias = LevelParser.extractAlias(rtid);
    final obj = _parsedData!.objectMap[alias];

    if (obj == null) {
      await Navigator.push(
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
      await Navigator.push(
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
                    filterMode: GridItemFilterMode.all,
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
      await Navigator.push(
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
      await Navigator.push(
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
      await Navigator.push(
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

    if (objClass == 'SpawnZombiesFromGroundSpawnerProps') {
      await Navigator.push(
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

    if (objClass == 'ModifyConveyorWaveActionProps') {
      await Navigator.push(
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
      await Navigator.push(
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
      await Navigator.push(
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

    if (objClass == 'RaidingPartyZombieSpawnerProps') {
      await Navigator.push(
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
      await Navigator.push(
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
      await Navigator.push(
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
      await Navigator.push(
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
      await Navigator.push(
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
                    onBack: () => Navigator.pop(context),
                    filterMode: GridItemFilterMode.all,
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

    if (objClass == 'ZombiePotionActionProps') {
      await Navigator.push(
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
                    filterMode: GridItemFilterMode.all,
                  ),
                ),
              );
            },
          ),
        ),
      );
      return;
    }

    if (objClass == 'MagicMirrorWaveActionProps' ||
        objClass == 'WaveActionMagicMirrorTeleportationArrayProps') {
      await Navigator.push(
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
      await Navigator.push(
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
      await Navigator.push(
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
      await Navigator.push(
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
      SnackBar(
        content: Text(l10n?.eventEditorInDevelopment ?? 'Event editor in development'),
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

  void _handleCreateWaveContainer() {
    if (_levelFile == null) return;
    var alias = 'WaveManagerProps';
    var count = 0;
    while (_levelFile!.objects.any(
      (o) => o.aliases?.contains(alias) == true,
    )) {
      count++;
      alias = 'WaveManagerProps_$count';
    }
    final wm = WaveManagerData(
      waveCount: 0,
      waves: [],
    );
    _levelFile!.objects.add(
      PvzObject(
        aliases: [alias],
        objClass: 'WaveManagerProperties',
        objData: wm.toJson(),
      ),
    );
    final wmmObj = _levelFile!.objects
        .firstWhereOrNull((o) => o.objClass == 'WaveManagerModuleProperties');
    if (wmmObj != null && wmmObj.objData is Map<String, dynamic>) {
      final data = WaveManagerModuleData.fromJson(
        Map<String, dynamic>.from(wmmObj.objData as Map),
      );
      data.waveManagerProps = RtidParser.build(alias, 'CurrentLevel');
      wmmObj.objData = data.toJson();
    }
    _parsedData = LevelParser.parseLevel(_levelFile!);
    _markDirty();
    setState(() {});
  }

  Future<void> _handleDeleteWaveContainer() async {
    if (_levelFile == null) return;
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.deleteWaveContainerTitle ?? 'Delete wave container?'),
        content: Text(
          l10n?.deleteWaveContainerConfirm ??
              'Are you sure you want to delete the empty wave container? You can create a new one later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n?.confirm ?? 'Confirm'),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      _levelFile!.objects.removeWhere(
        (o) => o.objClass == 'WaveManagerProperties',
      );
      _parsedData = LevelParser.parseLevel(_levelFile!);
      _markDirty();
      setState(() {});
    }
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

  void _showUiScaleDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var tempScale = widget.uiScale;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.adjustUiSize),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.currentScale((tempScale * 100).toInt().toString())),
              Slider(
                value: tempScale,
                min: 0.75,
                max: 1.25,
                onChanged: (v) => setDialogState(() => tempScale = v),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text(l10n.small, overflow: TextOverflow.ellipsis)),
                  Flexible(child: Text(l10n.standard, overflow: TextOverflow.ellipsis)),
                  Flexible(child: Text(l10n.large, overflow: TextOverflow.ellipsis)),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.onUiScaleChange(1.0);
                Navigator.pop(ctx);
              },
              child: Text(l10n.reset),
            ),
            TextButton(
              onPressed: () {
                widget.onUiScaleChange(tempScale);
                Navigator.pop(ctx);
              },
              child: Text(l10n.done),
            ),
          ],
        ),
      ),
    );
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
    if (objClass == 'SunDropperProperties' && _parsedData?.levelDef != null) {
      void openSunDropper(String rt) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SunDropperPropertiesScreen(
              rtid: rt,
              levelFile: _levelFile!,
              levelDef: _parsedData!.levelDef!,
              onChanged: _markDirty,
              onBack: () => Navigator.pop(context),
              onModeToggled: (newRtid) {
                _parsedData = LevelParser.parseLevel(_levelFile!);
                setState(() {});
                Navigator.pop(context);
                openSunDropper(newRtid);
              },
            ),
          ),
        );
      }
      openSunDropper(rtid);
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
            onRequestPlantSelection: (onSelected, {excludeIds}) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlantSelectionScreen(
                    isMultiSelect: true,
                    excludeIds: excludeIds ?? const [],
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
        objClass == 'InitialPlantProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InitialPlantPropertiesScreen(
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
    if (objClass == 'LawnMowerProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LawnMowerPropertiesScreen(
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
        objClass == 'TunnelDefendModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TunnelDefendModuleScreen(
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
        objClass == 'ZombieRushModuleProperties') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ZombieRushModuleScreen(
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
    final isDesktop = Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;
    Widget body = Scaffold(
        appBar: AppBar(
          title: Text(
            widget.fileName,
            overflow: TextOverflow.ellipsis,
          ),
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
              icon: const Icon(Icons.language),
              tooltip: l10n?.language ?? 'Language',
              onPressed: () => widget.onLanguageTap(context),
            ),
            IconButton(
              icon: const Icon(Icons.aspect_ratio),
              tooltip: l10n?.uiSize ?? 'UI size',
              onPressed: () => _showUiScaleDialog(context),
            ),
            IconButton(
              icon: const Icon(Icons.code),
              tooltip: l10n?.tooltipJsonViewer ?? 'View/edit JSON',
              onPressed: _levelFile != null
                  ? () async {
                      await _save();
                      if (context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => JsonViewerScreen(
                              fileName: widget.fileName,
                              filePath: widget.filePath,
                              levelFile: _levelFile!,
                              onBack: () => Navigator.pop(context),
                              onSaved: () {
                                if (_levelFile != null) {
                                  setState(() {
                                    _hasChanges = true;
                                    _parsedData = LevelParser.parseLevel(_levelFile!);
                                    _recalculateTabs();
                                  });
                                }
                              },
                            ),
                          ),
                        );
                      }
                    }
                  : null,
            ),
            IconButton(
              icon: Icon(
                widget.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              tooltip: l10n?.toggleTheme ?? 'Toggle theme',
              onPressed: widget.onCycleTheme,
            ),
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: l10n?.tooltipSave ?? 'Save',
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
                            children: _availableTabs.map<Widget>((t) {
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
                                    openWaveSheetNotifier: _openWaveSheetNotifier,
                                    onCreateContainer: () => _handleCreateWaveContainer(),
                                    onDeleteContainer: () => _handleDeleteWaveContainer(),
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
    );
    if (isDesktop) {
      body = Shortcuts(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.escape): _EditorEscapeIntent(),
        },
        child: Actions(
          actions: {
            _EditorEscapeIntent: CallbackAction<_EditorEscapeIntent>(
              onInvoke: (_) async {
                if (_hasChanges) {
                  final leave = await _confirmLeave();
                  if (leave && mounted) widget.onBack();
                } else {
                  widget.onBack();
                }
                return null;
              },
            ),
          },
          child: body,
        ),
      );
    }
    return body;
  }
}
