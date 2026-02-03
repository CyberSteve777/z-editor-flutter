import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/grid_item_repository.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/zombie_properties_repository.dart';
import 'package:z_editor/data/zombie_repository.dart' show ZombieRepository, ZombieTag;
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/widgets/asset_image.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Spawn zombies from grid item event editor. Ported from Z-Editor-master GridItemSpawnerEventEP.kt
class GridItemSpawnEventScreen extends StatefulWidget {
  const GridItemSpawnEventScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.onRequestGridItemSelection,
    required this.onRequestZombieSelection,
    this.onEditCustomZombie,
    this.onInjectCustomZombie,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final void Function(void Function(String) onSelected) onRequestGridItemSelection;
  final void Function(void Function(String) onSelected) onRequestZombieSelection;
  final void Function(String rtid)? onEditCustomZombie;
  final String? Function(String alias)? onInjectCustomZombie;

  @override
  State<GridItemSpawnEventScreen> createState() =>
      _GridItemSpawnEventScreenState();
}

class _GridItemSpawnEventScreenState extends State<GridItemSpawnEventScreen> {
  late PvzObject _moduleObj;
  late SpawnZombiesFromGridItemData _data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final alias = LevelParser.extractAlias(widget.rtid);
    final existing = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (existing != null) {
      _moduleObj = existing;
    } else {
      _moduleObj = PvzObject(
        aliases: [alias],
        objClass: 'SpawnZombiesFromGridItemSpawnerProps',
        objData: SpawnZombiesFromGridItemData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = SpawnZombiesFromGridItemData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = SpawnZombiesFromGridItemData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _addGridType() {
    widget.onRequestGridItemSelection((id) {
      final rtid = RtidParser.build(
        GridItemRepository.buildGridAliases(id),
        'GridItemTypes',
      );
      _data = SpawnZombiesFromGridItemData(
        waveStartMessage: _data.waveStartMessage,
        zombieSpawnWaitTime: _data.zombieSpawnWaitTime,
        gridTypes: [..._data.gridTypes, rtid],
        zombies: _data.zombies,
      );
      _sync();
    });
  }

  void _removeGridType(int index) {
    final gridTypes = List<String>.from(_data.gridTypes)..removeAt(index);
    _data = SpawnZombiesFromGridItemData(
      waveStartMessage: _data.waveStartMessage,
      zombieSpawnWaitTime: _data.zombieSpawnWaitTime,
      gridTypes: gridTypes,
      zombies: _data.zombies,
    );
    _sync();
  }

  void _addZombie() {
    widget.onRequestZombieSelection((id) {
      final aliases = ZombieRepository().buildZombieAliases(id);
      final rtid = RtidParser.build(aliases, 'ZombieTypes');
      final isElite = ZombieRepository().getZombieById(id)?.tags
              .contains(ZombieTag.elite) ??
          false;
      _data = SpawnZombiesFromGridItemData(
        waveStartMessage: _data.waveStartMessage,
        zombieSpawnWaitTime: _data.zombieSpawnWaitTime,
        gridTypes: _data.gridTypes,
        zombies: [
          ..._data.zombies,
          ZombieSpawnData(
            type: rtid,
            level: isElite ? null : 1,
            row: null,
          ),
        ],
      );
      _sync();
    });
  }

  void _removeZombie(int index) {
    final zombies = List<ZombieSpawnData>.from(_data.zombies)..removeAt(index);
    _data = SpawnZombiesFromGridItemData(
      waveStartMessage: _data.waveStartMessage,
      zombieSpawnWaitTime: _data.zombieSpawnWaitTime,
      gridTypes: _data.gridTypes,
      zombies: zombies,
    );
    _sync();
  }

  void _replaceZombieType(int index, String newRtid) {
    final zombies = List<ZombieSpawnData>.from(_data.zombies);
    final current = zombies[index];
    zombies[index] = ZombieSpawnData(
      type: newRtid,
      level: current.level,
      row: current.row,
    );
    _data = SpawnZombiesFromGridItemData(
      waveStartMessage: _data.waveStartMessage,
      zombieSpawnWaitTime: _data.zombieSpawnWaitTime,
      gridTypes: _data.gridTypes,
      zombies: zombies,
    );
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final alias = LevelParser.extractAlias(widget.rtid);
    final zombieRepo = ZombieRepository();
    final objectAliases = widget.levelFile.objects
        .expand((o) => o.aliases ?? [])
        .toSet();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit $alias'),
            Text(
              'Event: Grave spawn',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Grave spawn event',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: '此事件可以在特定的障碍物类型上进行出怪，常用于黑暗时代的亡灵返乡。',
                ),
                HelpSectionData(
                  title: 'Zombie spawn wait',
                  body: '从波次开始到僵尸生成之间的时间间隔，若已进入下一波将不生成僵尸。',
                ),
              ],
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Basic parameters',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: _data.waveStartMessage ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Wave start message',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (v) {
                          _data = SpawnZombiesFromGridItemData(
                            waveStartMessage: v.isEmpty ? null : v,
                            zombieSpawnWaitTime: _data.zombieSpawnWaitTime,
                            gridTypes: _data.gridTypes,
                            zombies: _data.zombies,
                          );
                          _sync();
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: _data.zombieSpawnWaitTime.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Zombie spawn wait (sec)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          final n = int.tryParse(v);
                          if (n != null) {
                            _data = SpawnZombiesFromGridItemData(
                              waveStartMessage: _data.waveStartMessage,
                              zombieSpawnWaitTime: n,
                              gridTypes: _data.gridTypes,
                              zombies: _data.zombies,
                            );
                            _sync();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Grid types',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _addGridType,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ..._data.gridTypes.asMap().entries.map((e) {
                final idx = e.key;
                final rtid = e.value;
                final parsed = RtidParser.parse(rtid);
                final gridAlias = parsed?.alias ?? rtid;
                final isValid = parsed?.source == 'CurrentLevel'
                    ? objectAliases.contains(gridAlias)
                    : GridItemRepository.isValid(gridAlias);
                final iconPath = GridItemRepository.getIconPath(gridAlias);
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  color: isValid ? null : theme.colorScheme.errorContainer,
                  child: ListTile(
                    leading: iconPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AssetImageWidget(
                              assetPath: iconPath,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(Icons.widgets,
                            color: theme.colorScheme.onSurfaceVariant),
                    title: Text(GridItemRepository.getName(gridAlias)),
                    subtitle: Text(gridAlias, style: theme.textTheme.bodySmall),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeGridType(idx),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Zombies',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _addZombie,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ..._data.zombies.asMap().entries.map((e) {
                final idx = e.key;
                final z = e.value;
                final parsed = RtidParser.parse(z.type);
                final alias = parsed?.alias ?? z.type;
                final isCustom = parsed?.source == 'CurrentLevel';
                final zombie = zombieRepo.getZombieById(alias);
                final iconPath = zombie?.iconAssetPath;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: iconPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AssetImageWidget(
                              assetPath: iconPath,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CircleAvatar(
                            child: Text(
                              zombieRepo.getName(alias).isNotEmpty
                                  ? zombieRepo.getName(alias)[0].toUpperCase()
                                  : '?',
                            ),
                          ),
                    title: Text(
                      isCustom
                          ? alias
                          : ResourceNames.lookup(
                              context,
                              zombieRepo.getName(alias),
                            ),
                    ),
                    subtitle: Text(
                      isCustom ? 'Custom: $alias' : alias,
                      style: theme.textTheme.bodySmall,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isCustom && widget.onEditCustomZombie != null)
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => widget.onEditCustomZombie?.call(z.type),
                          ),
                        if (!isCustom && widget.onInjectCustomZombie != null)
                          IconButton(
                            icon: const Icon(Icons.build),
                            onPressed: () {
                              final baseType =
                                  ZombiePropertiesRepository.getTypeNameByAlias(
                                alias,
                              );
                              final newRtid =
                                  widget.onInjectCustomZombie!(baseType);
                              if (newRtid != null) {
                                _replaceZombieType(idx, newRtid);
                              }
                            },
                          ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeZombie(idx),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
