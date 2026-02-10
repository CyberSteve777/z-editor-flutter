import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/grid_item_repository.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/zombie_properties_repository.dart';
import 'package:z_editor/data/zombie_repository.dart' show ZombieRepository, ZombieTag;
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/theme/app_theme.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Spawn zombies from grid item event editor. Ported from Z-Editor-master GridItemSpawnerEventEP.kt.
/// Uses jittered-style zombie icon cards, bottom sheet editing, and button handling.
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
    for (final z in _data.zombies) {
      if (_isElite(z)) {
        z.level = null;
      } else if ((z.level ?? 1) < 1) {
        z.level = 1;
      }
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  String _resolveBaseTypeName(ZombieSpawnData zombie) {
    final info = RtidParser.parse(zombie.type);
    final alias = info?.alias ?? zombie.type;
    final obj = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (obj != null && obj.objClass == 'ZombieType') {
      final data = obj.objData;
      if (data is Map<String, dynamic> && data['TypeName'] is String) {
        return data['TypeName'] as String;
      }
    }
    return ZombiePropertiesRepository.getTypeNameByAlias(alias);
  }

  bool _isElite(ZombieSpawnData zombie) {
    return ZombieRepository().isElite(_resolveBaseTypeName(zombie));
  }

  bool _isCustomZombie(ZombieSpawnData zombie) {
    final info = RtidParser.parse(zombie.type);
    return info?.source == 'CurrentLevel';
  }

  List<_CustomZombieOption> _findCompatibleCustomZombies(String baseType) {
    return widget.levelFile.objects
        .where((o) => o.objClass == 'ZombieType')
        .where((o) => o.aliases?.isNotEmpty == true)
        .map((o) {
      try {
        final data = o.objData;
        if (data is Map<String, dynamic> && data['TypeName'] == baseType) {
          final alias = o.aliases!.first;
          return _CustomZombieOption(
            alias: alias,
            rtid: RtidParser.build(alias, 'CurrentLevel'),
          );
        }
      } catch (_) {}
      return null;
    }).whereType<_CustomZombieOption>().toList();
  }

  void _showCustomZombieSwapDialog(
    BuildContext context, {
    required List<_CustomZombieOption> options,
    required String currentRtid,
    required ZombieSpawnData zombie,
    required int index,
  }) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select custom zombie'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final opt = options[i];
              final isCurrent = opt.rtid == currentRtid;
              return ListTile(
                title: Text(opt.alias),
                trailing: isCurrent
                    ? Text(
                        'Current',
                        style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                      )
                    : null,
                onTap: () {
                  _updateZombie(
                    index,
                    ZombieSpawnData(
                      type: opt.rtid,
                      row: zombie.row,
                      level: zombie.level,
                    ),
                  );
                  Navigator.pop(ctx);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
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

  void _updateZombie(int index, ZombieSpawnData zombie) {
    final zombies = List<ZombieSpawnData>.from(_data.zombies);
    zombies[index] = zombie;
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
    final baseType = ZombiePropertiesRepository.getTypeNameByAlias(
      RtidParser.parse(newRtid)?.alias ?? newRtid,
    );
    final isEliteNew = ZombieRepository().isElite(baseType);
    zombies[index] = ZombieSpawnData(
      type: newRtid,
      level: isEliteNew ? null : current.level,
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

  void _showZombieEditSheet(int index) {
    final zombie = _data.zombies[index];
    final isElite = _isElite(zombie);
    final baseType = _resolveBaseTypeName(zombie);
    final info = ZombieRepository().getZombieById(baseType);
    final displayName = info?.name ?? baseType;
    final iconPath = info?.iconAssetPath;
    final isCustom = _isCustomZombie(zombie);
    final compatibleCustom = _findCompatibleCustomZombies(baseType)
        .where((opt) => opt.rtid != zombie.type)
        .toList();
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        int rowValue = zombie.row ?? 0;
        int levelValue = zombie.level ?? 0;
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (iconPath != null && iconPath.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AssetImageWidget(
                            assetPath: iconPath,
                            altCandidates: imageAltCandidates(iconPath),
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                ResourceNames.lookup(context, displayName),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isCustom) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: pvzOrangeLight,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)?.customLabel ??
                                      'Custom',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          initialValue: rowValue,
                          decoration: const InputDecoration(
                            labelText: 'Row',
                            border: OutlineInputBorder(),
                          ),
                          items: const [
                            DropdownMenuItem(value: 0, child: Text('Random')),
                            DropdownMenuItem(value: 1, child: Text('Row 1')),
                            DropdownMenuItem(value: 2, child: Text('Row 2')),
                            DropdownMenuItem(value: 3, child: Text('Row 3')),
                            DropdownMenuItem(value: 4, child: Text('Row 4')),
                            DropdownMenuItem(value: 5, child: Text('Row 5')),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setModalState(() => rowValue = v);
                            _updateZombie(
                              index,
                              ZombieSpawnData(
                                type: zombie.type,
                                row: v == 0 ? null : v,
                                level: zombie.level,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            Future.microtask(() {
                              widget.onRequestZombieSelection((id) {
                                final aliases =
                                    ZombieRepository().buildZombieAliases(id);
                                final rtid =
                                    RtidParser.build(aliases, 'ZombieTypes');
                                _replaceZombieType(index, rtid);
                              });
                            });
                          },
                          icon: const Icon(Icons.swap_horiz),
                          label: const Text('Change'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (isElite)
                    Text(
                      'Elite zombies use default level.',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  else ...[
                    SwitchListTile(
                      title: const Text('Auto level'),
                      value: levelValue == 0,
                      onChanged: (v) {
                        setModalState(() => levelValue = v ? 0 : 1);
                        _updateZombie(
                          index,
                          ZombieSpawnData(
                            type: zombie.type,
                            row: zombie.row,
                            level: v ? null : 1,
                          ),
                        );
                      },
                    ),
                    if (levelValue != 0)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Level: $levelValue'),
                          Slider(
                            value: levelValue.toDouble(),
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: '$levelValue',
                            onChanged: (v) {
                              final newLevel = v.round();
                              setModalState(() => levelValue = newLevel);
                              _updateZombie(
                                index,
                                ZombieSpawnData(
                                  type: zombie.type,
                                  row: zombie.row,
                                  level: newLevel,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            final copy = ZombieSpawnData(
                              type: zombie.type,
                              row: rowValue == 0 ? null : rowValue,
                              level: isElite ? null : (levelValue == 0 ? null : levelValue),
                            );
                            _data = SpawnZombiesFromGridItemData(
                              waveStartMessage: _data.waveStartMessage,
                              zombieSpawnWaitTime: _data.zombieSpawnWaitTime,
                              gridTypes: _data.gridTypes,
                              zombies: [..._data.zombies, copy],
                            );
                            _sync();
                            Navigator.pop(ctx);
                          },
                          icon: const Icon(Icons.copy),
                          label: const Text('Copy'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () {
                            _removeZombie(index);
                            Navigator.pop(ctx);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                        ),
                      ),
                    ],
                  ),
                  if (compatibleCustom.isNotEmpty ||
                      (isCustom && widget.onEditCustomZombie != null) ||
                      (!isCustom && widget.onInjectCustomZombie != null)) ...[
                    const SizedBox(height: 8),
                    Builder(
                      builder: (ctx) {
                        final isDark = Theme.of(ctx).brightness == Brightness.dark;
                        final primaryYellow = isDark ? pvzYellowDark : pvzYellowLight;
                        final secondaryYellow = isDark ? pvzYellowDarkMuted : pvzYellowLightMuted;
                        return Row(
                          children: [
                            if (compatibleCustom.isNotEmpty)
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    _showCustomZombieSwapDialog(
                                      context,
                                      options: compatibleCustom,
                                      currentRtid: zombie.type,
                                      zombie: zombie,
                                      index: index,
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: secondaryYellow,
                                    side: BorderSide(color: secondaryYellow),
                                  ),
                                  icon: const Icon(Icons.swap_horiz),
                                  label: Text(
                                    '${AppLocalizations.of(context)?.switchCustomZombie ?? 'Switch'} (${compatibleCustom.length})',
                                  ),
                                ),
                              ),
                            if (compatibleCustom.isNotEmpty &&
                                ((isCustom && widget.onEditCustomZombie != null) ||
                                    (!isCustom && widget.onInjectCustomZombie != null)))
                              const SizedBox(width: 8),
                            if (isCustom && widget.onEditCustomZombie != null)
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    widget.onEditCustomZombie!(zombie.type);
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: primaryYellow,
                                    foregroundColor: Colors.black87,
                                  ),
                                  icon: const Icon(Icons.edit),
                                  label: Text(
                                    AppLocalizations.of(context)?.editCustomZombieProperties ??
                                        'Edit properties',
                                  ),
                                ),
                              )
                            else if (!isCustom &&
                                widget.onInjectCustomZombie != null)
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () {
                                    final newRtid =
                                        widget.onInjectCustomZombie!(baseType);
                                    if (newRtid != null) {
                                      _updateZombie(
                                        index,
                                        ZombieSpawnData(
                                          type: newRtid,
                                          row: zombie.row,
                                          level: zombie.level,
                                        ),
                                      );
                                    }
                                    Navigator.pop(ctx);
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: primaryYellow,
                                    foregroundColor: Colors.black87,
                                  ),
                                  icon: const Icon(Icons.build),
                                  label: Text(
                                    AppLocalizations.of(context)?.makeZombieAsCustom ??
                                        'Make custom',
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
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
                  PvzAddButton(
                    onPressed: _addGridType,
                    size: 40,
                    label: 'Add',
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
                    'Zombies (${_data.zombies.length})',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ..._data.zombies.asMap().entries.map((e) {
                    final idx = e.key;
                    final z = e.value;
                    final baseType = _resolveBaseTypeName(z);
                    final info = zombieRepo.getZombieById(baseType);
                    final iconPath = info?.iconAssetPath;
                    final isElite = _isElite(z);
                    return ZombieIconCard(
                      iconPath: iconPath,
                      levelDisplay: isElite ? 'E' : (z.level == null ? '0' : '${z.level}'),
                      isElite: isElite,
                      isCustom: _isCustomZombie(z),
                      onTap: () => _showZombieEditSheet(idx),
                    );
                  }),
                  PvzAddButton(
                    onPressed: _addZombie,
                    size: 56,
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomZombieOption {
  const _CustomZombieOption({
    required this.alias,
    required this.rtid,
  });

  final String alias;
  final String rtid;
}
