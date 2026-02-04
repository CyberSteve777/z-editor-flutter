import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Beach stage / low tide event editor. Ported from Z-Editor-master BeachStageEventEP.kt
class BeachStageEventScreen extends StatefulWidget {
  const BeachStageEventScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.onRequestZombieSelection,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final void Function(void Function(String) onSelected) onRequestZombieSelection;

  @override
  State<BeachStageEventScreen> createState() => _BeachStageEventScreenState();
}

class _BeachStageEventScreenState extends State<BeachStageEventScreen> {
  late PvzObject _moduleObj;
  late BeachStageEventData _data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';
    final existing = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (existing != null) {
      _moduleObj = existing;
    } else {
      _moduleObj = PvzObject(
        aliases: [alias],
        objClass: 'BeachStageEventZombieSpawnerProps',
        objData: BeachStageEventData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = BeachStageEventData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = BeachStageEventData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
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
              'Event: Low tide spawn',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Low tide event',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: 'Zombies spawn at low tide. Used for Pirate Seas.',
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
              _buildZombieConfigCard(theme),
              const SizedBox(height: 16),
              _buildCountCard(theme),
              const SizedBox(height: 16),
              _buildRangeTimeCard(theme),
              const SizedBox(height: 16),
              _buildMessageCard(theme),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildZombieConfigCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Zombie type (ZombieName)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _data.zombieName.isEmpty ? 'None' : _data.zombieName,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    widget.onRequestZombieSelection((id) {
                      _data = BeachStageEventData(
                        columnStart: _data.columnStart,
                        columnEnd: _data.columnEnd,
                        groupSize: _data.groupSize,
                        zombieCount: _data.zombieCount,
                        zombieName: id,
                        timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                        timeBetweenGroups: _data.timeBetweenGroups,
                        waveStartMessage: _data.waveStartMessage,
                      );
                      _sync();
                    });
                  },
                  child: const Text('Select zombie'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spawn count',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _data.zombieCount.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Zombie count',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final n = int.tryParse(v);
                      if (n != null) {
                        _data = BeachStageEventData(
                          columnStart: _data.columnStart,
                          columnEnd: _data.columnEnd,
                          groupSize: _data.groupSize,
                          zombieCount: n,
                          zombieName: _data.zombieName,
                          timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                          timeBetweenGroups: _data.timeBetweenGroups,
                          waveStartMessage: _data.waveStartMessage,
                        );
                        _sync();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: _data.groupSize.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Group size',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final n = int.tryParse(v);
                      if (n != null) {
                        _data = BeachStageEventData(
                          columnStart: _data.columnStart,
                          columnEnd: _data.columnEnd,
                          groupSize: n,
                          zombieCount: _data.zombieCount,
                          zombieName: _data.zombieName,
                          timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                          timeBetweenGroups: _data.timeBetweenGroups,
                          waveStartMessage: _data.waveStartMessage,
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

  Widget _buildRangeTimeCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Column range & timing',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _data.columnStart.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Start column',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final n = int.tryParse(v);
                      if (n != null) {
                        _data = BeachStageEventData(
                          columnStart: n,
                          columnEnd: _data.columnEnd,
                          groupSize: _data.groupSize,
                          zombieCount: _data.zombieCount,
                          zombieName: _data.zombieName,
                          timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                          timeBetweenGroups: _data.timeBetweenGroups,
                          waveStartMessage: _data.waveStartMessage,
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
                      labelText: 'End column',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      final n = int.tryParse(v);
                      if (n != null) {
                        _data = BeachStageEventData(
                          columnStart: _data.columnStart,
                          columnEnd: n,
                          groupSize: _data.groupSize,
                          zombieCount: _data.zombieCount,
                          zombieName: _data.zombieName,
                          timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                          timeBetweenGroups: _data.timeBetweenGroups,
                          waveStartMessage: _data.waveStartMessage,
                        );
                        _sync();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _data.timeBetweenGroups.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Time between groups (s)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (v) {
                      final n = double.tryParse(v);
                      if (n != null) {
                        _data = BeachStageEventData(
                          columnStart: _data.columnStart,
                          columnEnd: _data.columnEnd,
                          groupSize: _data.groupSize,
                          zombieCount: _data.zombieCount,
                          zombieName: _data.zombieName,
                          timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                          timeBetweenGroups: n,
                          waveStartMessage: _data.waveStartMessage,
                        );
                        _sync();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: _data.timeBeforeFullSpawn.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Time before spawn (s)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (v) {
                      final n = double.tryParse(v);
                      if (n != null) {
                        _data = BeachStageEventData(
                          columnStart: _data.columnStart,
                          columnEnd: _data.columnEnd,
                          groupSize: _data.groupSize,
                          zombieCount: _data.zombieCount,
                          zombieName: _data.zombieName,
                          timeBeforeFullSpawn: n,
                          timeBetweenGroups: _data.timeBetweenGroups,
                          waveStartMessage: _data.waveStartMessage,
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

  Widget _buildMessageCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wave start message',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _data.waveStartMessage,
              decoration: const InputDecoration(
                hintText: 'Optional',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                _data = BeachStageEventData(
                  columnStart: _data.columnStart,
                  columnEnd: _data.columnEnd,
                  groupSize: _data.groupSize,
                  zombieCount: _data.zombieCount,
                  zombieName: _data.zombieName,
                  timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                  timeBetweenGroups: _data.timeBetweenGroups,
                  waveStartMessage: v,
                );
                _sync();
              },
            ),
          ],
        ),
      ),
    );
  }
}
