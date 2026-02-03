import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/data/zombie_properties_repository.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/widgets/asset_image.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Zombie spawn event editor for JitteredWave and GroundSpawner.
/// Ported from Z-Editor-master JitteredWaveEventEP.kt, SpawnZombiesFromGroundEventEP.kt
class ZombieSpawnEventScreen extends StatefulWidget {
  const ZombieSpawnEventScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.eventSubtitle,
    required this.isGroundSpawner,
    required this.onRequestZombieSelection,
    this.onRequestPlantSelection,
    this.onEditCustomZombie,
    this.onInjectCustomZombie,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final String eventSubtitle;
  final bool isGroundSpawner;
  final void Function(void Function(String) onSelected) onRequestZombieSelection;
  final void Function(void Function(String) onSelected)? onRequestPlantSelection;
  final void Function(String rtid)? onEditCustomZombie;
  final String? Function(String alias)? onInjectCustomZombie;

  @override
  State<ZombieSpawnEventScreen> createState() => _ZombieSpawnEventScreenState();
}

class _ZombieSpawnEventScreenState extends State<ZombieSpawnEventScreen> {
  late PvzObject _moduleObj;
  late dynamic _data;
  double _batchLevel = 1;

  static const _jamOptions = [
    (null, 'None'),
    ('jam_pop', 'Pop'),
    ('jam_rap', 'Rap'),
    ('jam_metal', 'Metal'),
    ('jam_punk', 'Punk'),
    ('jam_8bit', '8-Bit'),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';
    final objClass = widget.isGroundSpawner
        ? 'SpawnZombiesFromGroundSpawnerProps'
        : 'SpawnZombiesJitteredWaveActionProps';
    final existing = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (existing != null) {
      _moduleObj = existing;
    } else {
      _moduleObj = PvzObject(
        aliases: [alias],
        objClass: objClass,
        objData: widget.isGroundSpawner
            ? SpawnZombiesFromGroundData().toJson()
            : WaveActionData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      if (widget.isGroundSpawner) {
        _data = SpawnZombiesFromGroundData.fromJson(
          Map<String, dynamic>.from(_moduleObj.objData as Map),
        );
      } else {
        _data = WaveActionData.fromJson(
          Map<String, dynamic>.from(_moduleObj.objData as Map),
        );
      }
    } catch (_) {
      _data = widget.isGroundSpawner
          ? SpawnZombiesFromGroundData()
          : WaveActionData();
    }
    for (final zombie in _zombies) {
      if (_isElite(zombie)) {
        zombie.level = null;
      } else if ((zombie.level ?? 1) < 1) {
        zombie.level = 1;
      }
    }
  }

  List<ZombieSpawnData> get _zombies =>
      widget.isGroundSpawner
          ? (_data as SpawnZombiesFromGroundData).zombies
          : (_data as WaveActionData).zombies;

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
    final baseType = _resolveBaseTypeName(zombie);
    return ZombieRepository().isElite(baseType);
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

  void _sync() {
    _moduleObj.objData = widget.isGroundSpawner
        ? (_data as SpawnZombiesFromGroundData).toJson()
        : (_data as WaveActionData).toJson();
    widget.onChanged();
    setState(() {});
  }

  void _addZombie({int? row}) {
    widget.onRequestZombieSelection((id) {
      final aliases = ZombieRepository().buildZombieAliases(id);
      final rtid = RtidParser.build(aliases, 'ZombieTypes');
      final zombies = List<ZombieSpawnData>.from(_zombies)
        ..add(ZombieSpawnData(type: rtid, level: null, row: row));
      _updateZombies(zombies);
    });
  }

  void _updateZombies(List<ZombieSpawnData> zombies) {
    if (widget.isGroundSpawner) {
      _data = SpawnZombiesFromGroundData(
        columnStart: (_data as SpawnZombiesFromGroundData).columnStart,
        columnEnd: (_data as SpawnZombiesFromGroundData).columnEnd,
        additionalPlantFood: (_data as SpawnZombiesFromGroundData).additionalPlantFood,
        spawnPlantName: (_data as SpawnZombiesFromGroundData).spawnPlantName,
        zombies: zombies,
      );
    } else {
      _data = WaveActionData(
        notificationEvents: (_data as WaveActionData).notificationEvents,
        additionalPlantFood: (_data as WaveActionData).additionalPlantFood,
        spawnPlantName: (_data as WaveActionData).spawnPlantName,
        zombies: zombies,
      );
    }
    _sync();
  }

  void _removeZombie(int index) {
    final zombies = List<ZombieSpawnData>.from(_zombies)..removeAt(index);
    _updateZombies(zombies);
  }

  void _updateZombie(int index, ZombieSpawnData zombie) {
    final zombies = List<ZombieSpawnData>.from(_zombies);
    zombies[index] = zombie;
    _updateZombies(zombies);
  }

  void _applyBatchLevel() {
    final level = _batchLevel.round();
    final zombies = _zombies.map((z) {
      if (_isElite(z)) {
        return ZombieSpawnData(type: z.type, row: z.row, level: null);
      }
      return ZombieSpawnData(type: z.type, row: z.row, level: level);
    }).toList();
    _updateZombies(zombies);
  }

  void _updateNotificationEvent(String? value) {
    if (widget.isGroundSpawner) return;
    final list = value == null ? null : <String>[value];
    _data = WaveActionData(
      notificationEvents: list,
      additionalPlantFood: (_data as WaveActionData).additionalPlantFood,
      spawnPlantName: (_data as WaveActionData).spawnPlantName,
      zombies: _zombies,
    );
    _sync();
  }

  void _updateAdditionalPlantFood(int count) {
    if (widget.isGroundSpawner) {
      final data = _data as SpawnZombiesFromGroundData;
      final currentPlants = List<String>.from(data.spawnPlantName ?? []);
      if (currentPlants.length > count) {
        currentPlants.removeRange(count, currentPlants.length);
      }
      _data = SpawnZombiesFromGroundData(
        columnStart: data.columnStart,
        columnEnd: data.columnEnd,
        additionalPlantFood: count == 0 ? null : count,
        spawnPlantName: currentPlants.isEmpty ? null : currentPlants,
        zombies: data.zombies,
      );
    } else {
      final data = _data as WaveActionData;
      final currentPlants = List<String>.from(data.spawnPlantName ?? []);
      if (currentPlants.length > count) {
        currentPlants.removeRange(count, currentPlants.length);
      }
      _data = WaveActionData(
        notificationEvents: data.notificationEvents,
        additionalPlantFood: count == 0 ? null : count,
        spawnPlantName: currentPlants.isEmpty ? null : currentPlants,
        zombies: data.zombies,
      );
    }
    _sync();
  }

  void _addSpawnPlant(String plantId) {
    if (widget.isGroundSpawner) {
      final data = _data as SpawnZombiesFromGroundData;
      final list = List<String>.from(data.spawnPlantName ?? []);
      list.add(plantId);
      final count = data.additionalPlantFood ?? 0;
      final nextCount = count < list.length ? list.length : count;
      _data = SpawnZombiesFromGroundData(
        columnStart: data.columnStart,
        columnEnd: data.columnEnd,
        additionalPlantFood: nextCount == 0 ? null : nextCount,
        spawnPlantName: list,
        zombies: data.zombies,
      );
    } else {
      final data = _data as WaveActionData;
      final list = List<String>.from(data.spawnPlantName ?? []);
      list.add(plantId);
      final count = data.additionalPlantFood ?? 0;
      final nextCount = count < list.length ? list.length : count;
      _data = WaveActionData(
        notificationEvents: data.notificationEvents,
        additionalPlantFood: nextCount == 0 ? null : nextCount,
        spawnPlantName: list,
        zombies: data.zombies,
      );
    }
    _sync();
  }

  void _removeSpawnPlantAt(int index) {
    if (widget.isGroundSpawner) {
      final data = _data as SpawnZombiesFromGroundData;
      final list = List<String>.from(data.spawnPlantName ?? []);
      if (index >= 0 && index < list.length) {
        list.removeAt(index);
      }
      _data = SpawnZombiesFromGroundData(
        columnStart: data.columnStart,
        columnEnd: data.columnEnd,
        additionalPlantFood: data.additionalPlantFood,
        spawnPlantName: list.isEmpty ? null : list,
        zombies: data.zombies,
      );
    } else {
      final data = _data as WaveActionData;
      final list = List<String>.from(data.spawnPlantName ?? []);
      if (index >= 0 && index < list.length) {
        list.removeAt(index);
      }
      _data = WaveActionData(
        notificationEvents: data.notificationEvents,
        additionalPlantFood: data.additionalPlantFood,
        spawnPlantName: list.isEmpty ? null : list,
        zombies: data.zombies,
      );
    }
    _sync();
  }

  void _showZombieEditSheet(int index) {
    final zombie = _zombies[index];
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
                      if (iconPath != null)
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
                        child: Text(
                          ResourceNames.lookup(context, displayName),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: rowValue,
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
                            final updated = ZombieSpawnData(
                              type: zombie.type,
                              row: v == 0 ? null : v,
                              level: zombie.level,
                            );
                            _updateZombie(index, updated);
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
                                final isEliteNew =
                                    ZombieRepository().isElite(id);
                                _updateZombie(
                                  index,
                                  ZombieSpawnData(
                                    type: rtid,
                                    row: zombie.row,
                                    level: isEliteNew ? null : zombie.level,
                                  ),
                                );
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
                        final updated = ZombieSpawnData(
                          type: zombie.type,
                          row: zombie.row,
                          level: v ? null : 1,
                        );
                        _updateZombie(index, updated);
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
                              setModalState(() => levelValue = v.round());
                              final updated = ZombieSpawnData(
                                type: zombie.type,
                                row: zombie.row,
                                level: levelValue,
                              );
                              _updateZombie(index, updated);
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
                              row: zombie.row,
                              level: zombie.level,
                            );
                            final list = List<ZombieSpawnData>.from(_zombies)
                              ..add(copy);
                            _updateZombies(list);
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
                  if (compatibleCustom.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
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
                      icon: const Icon(Icons.swap_horiz),
                      label: Text(
                        'Switch custom (${compatibleCustom.length})',
                      ),
                    ),
                  ],
                  if (isCustom && widget.onEditCustomZombie != null) ...[
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        widget.onEditCustomZombie!(zombie.type);
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit custom zombie'),
                    ),
                  ] else if (!isCustom &&
                      widget.onInjectCustomZombie != null) ...[
                    const SizedBox(height: 8),
                    FilledButton.icon(
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
                      icon: const Icon(Icons.build),
                      label: const Text('Inject custom zombie'),
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
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';

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
              widget.eventSubtitle,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: widget.isGroundSpawner ? 'Ground spawn event' : 'Standard spawn event',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: 'Configure zombies that spawn in this wave. Level 0 follows map tier.',
                ),
                HelpSectionData(
                  title: 'Row',
                  body: 'Row 0-4. Leave unset for random row.',
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
              if (widget.isGroundSpawner) _buildColumnRangeCard(theme),
              if (widget.isGroundSpawner) const SizedBox(height: 16),
              if (!widget.isGroundSpawner) _buildNotificationCard(theme),
              if (!widget.isGroundSpawner) const SizedBox(height: 16),
              if (!widget.isGroundSpawner) _buildLaneRows(context, theme),
              if (widget.isGroundSpawner) _buildZombieListCard(context, theme),
              if (!widget.isGroundSpawner) const SizedBox(height: 16),
              if (!widget.isGroundSpawner) _buildBatchLevelCard(theme),
              const SizedBox(height: 16),
              _buildDropConfigCard(context, theme),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumnRangeCard(ThemeData theme) {
    final d = _data as SpawnZombiesFromGroundData;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Column range',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: d.columnStart.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Start',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final n = int.tryParse(v);
                      if (n != null) {
                        _data = SpawnZombiesFromGroundData(
                          columnStart: n,
                          columnEnd: d.columnEnd,
                          additionalPlantFood: d.additionalPlantFood,
                          spawnPlantName: d.spawnPlantName,
                          zombies: d.zombies,
                        );
                        _sync();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: d.columnEnd.toString(),
                    decoration: const InputDecoration(
                      labelText: 'End',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final n = int.tryParse(v);
                      if (n != null) {
                        _data = SpawnZombiesFromGroundData(
                          columnStart: d.columnStart,
                          columnEnd: n,
                          additionalPlantFood: d.additionalPlantFood,
                          spawnPlantName: d.spawnPlantName,
                          zombies: d.zombies,
                        );
                        _sync();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(ThemeData theme) {
    final data = _data as WaveActionData;
    final current = data.notificationEvents?.isNotEmpty == true
        ? data.notificationEvents!.first
        : null;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.music_note, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  'Background music (LevelJam)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              value: current,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: _jamOptions
                  .map(
                    (e) => DropdownMenuItem<String?>(
                      value: e.$1,
                      child: Text(e.$2),
                    ),
                  )
                  .toList(),
              onChanged: _updateNotificationEvent,
            ),
            const SizedBox(height: 8),
            Text(
              'Only applies to Rock era maps.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLaneRows(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        for (var row = 1; row <= 5; row++) ...[
          _buildLaneRow(
            context,
            theme,
            label: 'Row $row',
            rowValue: row,
            zombies: _zombies
                .asMap()
                .entries
                .where((e) => e.value.row == row)
                .toList(),
          ),
          const SizedBox(height: 8),
        ],
        _buildLaneRow(
          context,
          theme,
          label: 'Random row',
          rowValue: 0,
          zombies: _zombies
              .asMap()
              .entries
              .where((e) => (e.value.row ?? 0) == 0)
              .toList(),
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ],
    );
  }

  Widget _buildLaneRow(
    BuildContext context,
    ThemeData theme, {
    required String label,
    required int rowValue,
    required List<MapEntry<int, ZombieSpawnData>> zombies,
    Color? color,
  }) {
    final laneColor = color ?? theme.colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: laneColor,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _addZombie(
                    row: rowValue == 0 ? null : rowValue,
                  ),
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (zombies.isEmpty)
              Text(
                'No zombies in this lane',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: zombies.map((entry) {
                  final idx = entry.key;
                  final z = entry.value;
                  final baseType = _resolveBaseTypeName(z);
                  final info = ZombieRepository().getZombieById(baseType);
                  final name = info?.name ?? baseType;
                  final iconPath = info?.iconAssetPath;
                  final levelText = _isElite(z)
                      ? 'Elite'
                      : (z.level == null ? 'Auto' : 'Lv${z.level}');
                  return InputChip(
                    label: Text('${ResourceNames.lookup(context, name)} ($levelText)'),
                    avatar: iconPath != null
                        ? ClipOval(
                            child: AssetImageWidget(
                              assetPath: iconPath,
                              altCandidates: imageAltCandidates(iconPath),
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.warning, size: 16),
                    onPressed: () => _showZombieEditSheet(idx),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatchLevelCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.layers, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  'Batch level',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_batchLevel.round()}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _batchLevel,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _batchLevel.round().toString(),
                    onChanged: (v) => setState(() => _batchLevel = v),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Apply batch level?'),
                        content: Text(
                          'Set all zombies in this wave to level ${_batchLevel.round()} (elite unchanged).',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('Apply'),
                          ),
                        ],
                      ),
                    );
                    if (ok == true) _applyBatchLevel();
                  },
                  child: const Text('Apply'),
                ),
              ],
            ),
            Text(
              'Applies to all non-elite zombies in this wave.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropConfigCard(BuildContext context, ThemeData theme) {
    final int count;
    final List<String> plants;
    if (widget.isGroundSpawner) {
      final data = _data as SpawnZombiesFromGroundData;
      count = data.additionalPlantFood ?? 0;
      plants = List<String>.from(data.spawnPlantName ?? []);
    } else {
      final data = _data as WaveActionData;
      count = data.additionalPlantFood ?? 0;
      plants = List<String>.from(data.spawnPlantName ?? []);
    }
    final isDroppingPlants = plants.length == count && plants.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.eco, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  isDroppingPlants
                      ? 'Drop config (Plants)'
                      : 'Drop config (Plant Food)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: count > 0
                      ? () => _updateAdditionalPlantFood(count - 1)
                      : null,
                ),
                Text('$count'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _updateAdditionalPlantFood(count + 1),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isDroppingPlants
                        ? 'Zombies carrying plants'
                        : 'Zombies carrying plant food',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (plants.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: plants.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final id = entry.value;
                  final info = PlantRepository().getPlantInfoById(id);
                  final name = info?.name ?? id;
                  final iconPath = info?.iconAssetPath;
                  return InputChip(
                    label: Text(ResourceNames.lookup(context, name)),
                    avatar: iconPath != null
                        ? ClipOval(
                            child: AssetImageWidget(
                              assetPath: iconPath,
                              altCandidates: imageAltCandidates(iconPath),
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.local_florist, size: 16),
                    onDeleted: () => _removeSpawnPlantAt(idx),
                  );
                }).toList(),
              ),
            if (widget.onRequestPlantSelection != null) ...[
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {
                  widget.onRequestPlantSelection!.call((id) {
                    _addSpawnPlant(id);
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add plant'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildZombieListCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Zombies (${_zombies.length})',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _addZombie(),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add zombie'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._zombies.asMap().entries.map((e) {
              final idx = e.key;
              final z = e.value;
              return _buildZombieTile(context, theme, idx, z);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildZombieTile(BuildContext context, ThemeData theme, int index, ZombieSpawnData z) {
    final parsed = RtidParser.parse(z.type);
    final alias = parsed?.alias ?? z.type;
    final isCustom = parsed?.source == 'CurrentLevel';
    final name = isCustom
        ? alias
        : ResourceNames.lookup(context, ZombieRepository().getName(alias));

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 48,
                height: 48,
                child: () {
                  final zombie = ZombieRepository().getZombieById(alias);
                  final path = zombie?.iconAssetPath;
                  if (path != null) {
                    return AssetImageWidget(
                      assetPath: path,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    );
                  }
                  return Container(
                    color: theme.colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  );
                }(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isCustom ? 'Custom: $alias' : alias,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isCustom && widget.onEditCustomZombie != null)
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Edit custom',
                onPressed: () => widget.onEditCustomZombie?.call(z.type),
              ),
            SizedBox(
              width: 70,
              child: DropdownButtonFormField<int?>(
                value: z.row,
                decoration: const InputDecoration(
                  labelText: 'Row',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Any')),
                  ...List.generate(5, (i) => DropdownMenuItem(value: i, child: Text('$i'))),
                ],
                onChanged: (v) {
                  _updateZombie(index, ZombieSpawnData(type: z.type, level: z.level, row: v));
                },
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 70,
              child: TextFormField(
                initialValue: z.level?.toString() ?? '0',
                decoration: const InputDecoration(
                  labelText: 'Lvl',
                  isDense: true,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  final n = int.tryParse(v);
                  _updateZombie(
                    index,
                    ZombieSpawnData(
                      type: z.type,
                      level: n == 0 ? null : n,
                      row: z.row,
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _removeZombie(index),
            ),
          ],
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
