import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/zombie_properties_repository.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/widgets/asset_image.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Storm zombie spawner event editor. Ported from Z-Editor-master StormSpawnerEventEP.kt
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
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _addZombie() {
    widget.onRequestZombieSelection((id) {
      final aliases = ZombieRepository().buildZombieAliases(id);
      final rtid = RtidParser.build(aliases, 'ZombieTypes');
      _data = StormZombieSpawnerPropsData(
        columnStart: _data.columnStart,
        columnEnd: _data.columnEnd,
        groupSize: _data.groupSize,
        timeBetweenGroups: _data.timeBetweenGroups,
        type: _data.type,
        zombies: [..._data.zombies, StormZombieData(type: rtid)],
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

  void _replaceZombieType(int index, String newRtid) {
    final zombies = List<StormZombieData>.from(_data.zombies);
    zombies[index] = StormZombieData(type: newRtid);
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
                  FilledButton.icon(
                    onPressed: _addZombie,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add zombie'),
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
                          : ResourceNames.lookup(context, zombieRepo.getName(alias)),
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
