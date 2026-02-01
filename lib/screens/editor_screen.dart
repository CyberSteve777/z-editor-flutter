import 'package:flutter/material.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/level_repository.dart';
import 'package:z_editor/data/module_registry.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/reference_repository.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/data/zombie_properties_repository.dart';
import 'package:z_editor/screens/editor/basic_info_screen.dart';
import 'package:z_editor/screens/editor/json_viewer_screen.dart';
import 'package:z_editor/screens/editor/modules/star_challenge_screen.dart';
import 'package:z_editor/screens/editor/tabs/izombie_tab.dart';
import 'package:z_editor/screens/editor/tabs/vase_breaker_tab.dart';
import 'package:z_editor/screens/editor/tabs/zomboss_battle_tab.dart';
import 'package:z_editor/screens/editor/tabs/wave_timeline_tab.dart';
import 'package:z_editor/screens/select/module_selection_screen.dart';
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

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  Future<void> _loadLevel() async {
    setState(() => _isLoading = true);
    await ReferenceRepository.init();
    await ZombiePropertiesRepository.init();
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
    if (classes.contains('WaveManagerModuleProperties'))
      tabs.add(EditorTabType.timeline);
    if (classes.contains('EvilDaveProperties')) tabs.add(EditorTabType.iZombie);
    if (classes.contains('VaseBreakerPresetProperties') ||
        classes.contains('VaseBreakerArcadeModuleProperties'))
      tabs.add(EditorTabType.vaseBreaker);
    if (classes.contains('ZombossBattleModuleProperties'))
      tabs.add(EditorTabType.zomboss);
    _availableTabs = tabs;
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

  void _markDirty() => setState(() => _hasChanges = true);

  Future<bool> _confirmLeave() async {
    final l10n = AppLocalizations.of(context);
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.unsavedChanges ?? 'Unsaved changes'),
        content: Text(l10n?.saveBeforeLeaving ?? 'Save before leaving?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n?.discard ?? 'Discard'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
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
                child: Column(
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
                              return _LevelSettingsTab(
                                levelDef: _parsedData!.levelDef,
                                levelFile: _levelFile!,
                                onChanged: _markDirty,
                                onModulesChanged: () {
                                  _markDirty();
                                  _recalculateTabs();
                                },
                              );
                            case EditorTabType.timeline:
                              return WaveTimelineTab(
                                levelFile: _levelFile!,
                                parsed: _parsedData!,
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
                ),
              ),
      ),
    );
  }
}

class _StubTab extends StatelessWidget {
  const _StubTab({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            l10n?.moduleEditorInProgress ?? 'Module editor in development',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _LevelSettingsTab extends StatefulWidget {
  const _LevelSettingsTab({
    required this.levelDef,
    required this.levelFile,
    required this.onChanged,
    required this.onModulesChanged,
  });

  final LevelDefinitionData? levelDef;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onModulesChanged;

  @override
  State<_LevelSettingsTab> createState() => _LevelSettingsTabState();
}

class _LevelSettingsTabState extends State<_LevelSettingsTab> {
  void _syncLevelDefToFile(LevelDefinitionData def) {
    final obj = widget.levelFile.objects
        .where((o) => o.objClass == 'LevelDefinition')
        .firstOrNull;
    if (obj != null) obj.objData = def.toJson();
    widget.onChanged();
  }

  void _confirmRemoveModule(String rtid) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.removeModule ?? 'Remove module'),
        content: Text(l10n?.removeModuleConfirm ?? 'Remove this module?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              _removeModule(rtid);
              Navigator.pop(ctx);
            },
            child: Text(
              l10n?.confirmRemove ?? 'Remove',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _removeModule(String rtid) {
    final def = widget.levelDef;
    if (def == null) return;
    def.modules.remove(rtid);
    final info = RtidParser.parse(rtid);
    if (info != null && info.source == 'CurrentLevel') {
      widget.levelFile.objects.removeWhere(
        (o) => o.aliases?.contains(info.alias) == true,
      );
    }
    _syncLevelDefToFile(def);
    widget.onModulesChanged();
  }

  void _addModule(ModuleMetadata meta) {
    final def = widget.levelDef;
    if (def == null) return;
    var alias = meta.effectiveAlias;
    final source = meta.defaultSource;
    if (source == 'CurrentLevel') {
      var count = 0;
      while (widget.levelFile.objects.any(
        (o) => o.aliases?.contains(alias) == true,
      )) {
        count++;
        alias = '${meta.effectiveAlias}_$count';
      }
      if (!meta.allowMultiple && count > 0) return;
      final rtid = RtidParser.build(alias, source);
      def.modules.add(rtid);
      final objData = Map<String, dynamic>.from(meta.initialData ?? {});
      widget.levelFile.objects.add(
        PvzObject(aliases: [alias], objClass: meta.objClass, objData: objData),
      );
    } else {
      final rtid = RtidParser.build(alias, source);
      def.modules.add(rtid);
    }
    _syncLevelDefToFile(def);
    widget.onModulesChanged();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final def = widget.levelDef;
    if (def == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              l10n?.noLevelDefinition ?? 'No level definition',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                l10n?.noLevelDefinitionHint ??
                    'Level definition module was not found.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    final moduleInfos = def.modules.map((rtid) {
      final info = RtidParser.parse(rtid);
      final alias = info?.alias ?? '?';
      final objClass = info?.source == 'CurrentLevel'
          ? widget.levelFile.objects
                .where((o) => o.aliases?.contains(alias) == true)
                .firstOrNull
                ?.objClass
          : ReferenceRepository.instance.getObjClass(alias);
      final meta = ModuleRegistry.getMetadata(objClass ?? '');
      return (rtid: rtid, alias: alias, objClass: objClass ?? '', meta: meta);
    }).toList();

    final coreModules = moduleInfos.where((m) => m.meta.isCore).toList();
    final miscModules = moduleInfos.where((m) => !m.meta.isCore).toList();
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.edit_note),
            title: Text(l10n?.levelBasicInfo ?? 'Level basic info'),
            subtitle: Text(
              l10n?.levelBasicInfoSubtitle ??
                  'Name, number, description, stage',
            ),
            onTap: () => _openBasicInfoScreen(def),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n?.editableModules ?? 'Editable modules',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        ...coreModules.map(
          (m) => Card(
            child: ListTile(
              leading: Icon(m.meta.icon, color: theme.colorScheme.primary),
              title: Text(m.meta.getTitle(context)),
              subtitle: Text('${m.alias} (${m.objClass})'),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => _confirmRemoveModule(m.rtid),
              ),
              onTap: () => _openModuleEditor(m.rtid, m.objClass),
            ),
          ),
        ),
        if (miscModules.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            l10n?.parameterModules ?? 'Parameter modules',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          ...miscModules.map(
            (m) => Card(
              child: ListTile(
                leading: Icon(
                  m.meta.icon,
                  color: theme.colorScheme.outline,
                  size: 20,
                ),
                title: Text(m.meta.getTitle(context), style: theme.textTheme.bodyMedium),
                subtitle: Text(m.alias, style: theme.textTheme.bodySmall),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                  onPressed: () => _confirmRemoveModule(m.rtid),
                ),
                onTap: () => _openModuleEditor(m.rtid, m.objClass),
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _openModuleSelectionScreen(def),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n?.addNewModule ?? 'Add new module',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _openBasicInfoScreen(LevelDefinitionData def) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BasicInfoScreen(
          levelFile: widget.levelFile,
          levelDef: def,
          onBack: () => Navigator.pop(context),
          onStageTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StageSelectionScreen(
                  currentStageRtid: def.stageModule,
                  onStageSelected: (rtid) {
                    def.stageModule = rtid;
                    _syncLevelDefToFile(def);
                    if (mounted) Navigator.pop(context);
                  },
                  onBack: () => Navigator.pop(context),
                ),
              ),
            );
          },
          onChanged: () {
            _syncLevelDefToFile(def);
            setState(() {});
          },
        ),
      ),
    );
  }

  void _openModuleSelectionScreen(LevelDefinitionData def) {
    final existing = def.modules
        .map((rtid) {
          final info = RtidParser.parse(rtid);
          if (info?.source == 'CurrentLevel') {
            return widget.levelFile.objects
                .where((o) => o.aliases?.contains(info!.alias) == true)
                .firstOrNull
                ?.objClass;
          }
          return ReferenceRepository.instance.getObjClass(info?.alias ?? '');
        })
        .whereType<String>()
        .toSet();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ModuleSelectionScreen(
          existingObjClasses: existing,
          onModuleSelected: (meta) {
            _addModule(meta);
            if (mounted) Navigator.pop(context);
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _openModuleEditor(String rtid, String objClass) {
    final l10n = AppLocalizations.of(context);
    final meta = ModuleRegistry.getMetadata(objClass);

    switch (meta.routeId) {
      case 'StarChallenge':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StarChallengeModuleScreen(
              rtid: rtid,
              levelFile: widget.levelFile,
              onChanged: widget.onChanged,
              onBack: () => Navigator.pop(context),
            ),
          ),
        );
        return;
      // Add other cases here
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(meta.getTitle(context)),
        content: Text(
          l10n?.moduleEditorInProgress ?? 'Module editor in development',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n?.done ?? 'Done'),
          ),
        ],
      ),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final it = iterator;
    return it.moveNext() ? it.current : null;
  }
}
