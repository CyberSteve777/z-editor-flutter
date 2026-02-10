import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/zombie_properties_repository.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/theme/app_theme.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Storm zombie spawner event editor. Ported from Z-Editor-master StormSpawnerEventEP.kt.
/// Uses jittered-style zombie icon cards, bottom sheet editing, and button handling.
/// Supports zombie levels (game supports this even though original editor did not).
class StormEventScreen extends StatefulWidget {
  const StormEventScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.onRequestZombieSelection,
    this.onEditCustomZombie,
    this.onInjectCustomZombie,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final void Function(void Function(String) onSelected) onRequestZombieSelection;
  final void Function(String rtid)? onEditCustomZombie;
  final String? Function(String alias)? onInjectCustomZombie;

  @override
  State<StormEventScreen> createState() => _StormEventScreenState();
}

class _StormEventScreenState extends State<StormEventScreen> {
  late PvzObject _moduleObj;
  late StormZombieSpawnerPropsData _data;

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
        objClass: 'StormZombieSpawnerProps',
        objData: StormZombieSpawnerPropsData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = StormZombieSpawnerPropsData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = StormZombieSpawnerPropsData();
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

  String _resolveBaseTypeName(StormZombieData z) {
    final info = RtidParser.parse(z.type);
    final alias = info?.alias ?? z.type;
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

  bool _isElite(StormZombieData z) {
    return ZombieRepository().isElite(_resolveBaseTypeName(z));
  }

  bool _isCustomZombie(StormZombieData z) {
    final info = RtidParser.parse(z.type);
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
    required StormZombieData zombie,
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
                  _replaceZombieType(index, opt.rtid, zombie.level);
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

  void _addZombie() {
    widget.onRequestZombieSelection((id) {
      final aliases = ZombieRepository().buildZombieAliases(id);
      final rtid = RtidParser.build(aliases, 'ZombieTypes');
      final isElite = ZombieRepository().isElite(id);
      _data = StormZombieSpawnerPropsData(
        columnStart: _data.columnStart,
        columnEnd: _data.columnEnd,
        groupSize: _data.groupSize,
        timeBetweenGroups: _data.timeBetweenGroups,
        type: _data.type,
        zombies: [..._data.zombies, StormZombieData(type: rtid, level: isElite ? null : 1)],
      );
      _sync();
    });
  }

  void _removeZombie(int index) {
    final zombies = List<StormZombieData>.from(_data.zombies)..removeAt(index);
    _data = StormZombieSpawnerPropsData(
      columnStart: _data.columnStart,
      columnEnd: _data.columnEnd,
      groupSize: _data.groupSize,
      timeBetweenGroups: _data.timeBetweenGroups,
      type: _data.type,
      zombies: zombies,
    );
    _sync();
  }

  void _replaceZombieType(int index, String newRtid, [int? preserveLevel]) {
    final zombies = List<StormZombieData>.from(_data.zombies);
    final current = zombies[index];
    final isEliteNew = ZombieRepository().isElite(
      ZombiePropertiesRepository.getTypeNameByAlias(
        RtidParser.parse(newRtid)?.alias ?? newRtid,
      ),
    );
    zombies[index] = StormZombieData(
      type: newRtid,
      level: isEliteNew ? null : (preserveLevel ?? current.level ?? 1),
    );
    _data = StormZombieSpawnerPropsData(
      columnStart: _data.columnStart,
      columnEnd: _data.columnEnd,
      groupSize: _data.groupSize,
      timeBetweenGroups: _data.timeBetweenGroups,
      type: _data.type,
      zombies: zombies,
    );
    _sync();
  }

  void _updateZombieLevel(int index, int? level) {
    final zombies = List<StormZombieData>.from(_data.zombies);
    zombies[index] = StormZombieData(type: zombies[index].type, level: level);
    _data = StormZombieSpawnerPropsData(
      columnStart: _data.columnStart,
      columnEnd: _data.columnEnd,
      groupSize: _data.groupSize,
      timeBetweenGroups: _data.timeBetweenGroups,
      type: _data.type,
      zombies: zombies,
    );
    _sync();
  }

  void _showZombieEditSheet(int index) {
    final z = _data.zombies[index];
    final isElite = _isElite(z);
    final baseType = _resolveBaseTypeName(z);
    final info = ZombieRepository().getZombieById(baseType);
    final displayName = info?.name ?? baseType;
    final iconPath = info?.iconAssetPath;
    final isCustom = _isCustomZombie(z);
    final compatibleCustom = _findCompatibleCustomZombies(baseType)
        .where((opt) => opt.rtid != z.type)
        .toList();
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        int levelValue = z.level ?? 0;
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
                  OutlinedButton.icon(
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
                          _replaceZombieType(
                            index,
                            rtid,
                            isEliteNew ? null : (levelValue == 0 ? null : levelValue),
                          );
                        });
                      });
                    },
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Change'),
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
                        _updateZombieLevel(index, v ? null : 1);
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
                              _updateZombieLevel(index, newLevel);
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
                            final copy = StormZombieData(
                              type: z.type,
                              level: isElite ? null : (levelValue == 0 ? null : levelValue),
                            );
                            _data = StormZombieSpawnerPropsData(
                              columnStart: _data.columnStart,
                              columnEnd: _data.columnEnd,
                              groupSize: _data.groupSize,
                              timeBetweenGroups: _data.timeBetweenGroups,
                              type: _data.type,
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
                                      currentRtid: z.type,
                                      zombie: z,
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
                                    widget.onEditCustomZombie!(z.type);
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
                                      _replaceZombieType(index, newRtid, z.level);
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
              'Event: Storm spawn',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Storm event',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: '沙尘暴或暴风雪将僵尸快速传送到前线。极寒风暴可冻结植物。',
                ),
                HelpSectionData(
                  title: 'Column range',
                  body: '场地左边界为0列，右边界为9列，起始列要小于结束列。',
                ),
                HelpSectionData(
                  title: 'Zombie levels',
                  body: 'Storm zombies support level 1-10. Elite zombies use default level.',
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
                        'Spawn parameters',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 16,
                        children: ['sandstorm', 'snowstorm', 'excoldstorm']
                            .map((t) => ChoiceChip(
                                  label: Text(t == 'sandstorm'
                                      ? 'Sandstorm'
                                      : t == 'snowstorm'
                                          ? 'Snowstorm'
                                          : 'Excold storm'),
                                  selected: _data.type == t,
                                  onSelected: (_) {
                                    _data = StormZombieSpawnerPropsData(
                                      columnStart: _data.columnStart,
                                      columnEnd: _data.columnEnd,
                                      groupSize: _data.groupSize,
                                      timeBetweenGroups: _data.timeBetweenGroups,
                                      type: t,
                                      zombies: _data.zombies,
                                    );
                                    _sync();
                                  },
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: _data.columnStart.toString(),
                              decoration: const InputDecoration(
                                labelText: 'Column start',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                final n = int.tryParse(v);
                                if (n != null) {
                                  _data = StormZombieSpawnerPropsData(
                                    columnStart: n,
                                    columnEnd: _data.columnEnd,
                                    groupSize: _data.groupSize,
                                    timeBetweenGroups: _data.timeBetweenGroups,
                                    type: _data.type,
                                    zombies: _data.zombies,
                                  );
                                  _sync();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              initialValue: _data.columnEnd.toString(),
                              decoration: const InputDecoration(
                                labelText: 'Column end',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                final n = int.tryParse(v);
                                if (n != null) {
                                  _data = StormZombieSpawnerPropsData(
                                    columnStart: _data.columnStart,
                                    columnEnd: n,
                                    groupSize: _data.groupSize,
                                    timeBetweenGroups: _data.timeBetweenGroups,
                                    type: _data.type,
                                    zombies: _data.zombies,
                                  );
                                  _sync();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: _data.groupSize.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Group size',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          final n = int.tryParse(v);
                          if (n != null) {
                            _data = StormZombieSpawnerPropsData(
                              columnStart: _data.columnStart,
                              columnEnd: _data.columnEnd,
                              groupSize: n,
                              timeBetweenGroups: _data.timeBetweenGroups,
                              type: _data.type,
                              zombies: _data.zombies,
                            );
                            _sync();
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: _data.timeBetweenGroups.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Time between groups',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          final n = int.tryParse(v);
                          if (n != null) {
                            _data = StormZombieSpawnerPropsData(
                              columnStart: _data.columnStart,
                              columnEnd: _data.columnEnd,
                              groupSize: _data.groupSize,
                              timeBetweenGroups: n,
                              type: _data.type,
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
