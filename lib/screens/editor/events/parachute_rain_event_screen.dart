import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Parachute/Bass/Spider rain event editor. Ported from Z-Editor-master
/// ParachuteRainEventEP.kt, BassRainEventEP.kt, SpiderRainEventEP.kt
class ParachuteRainEventScreen extends StatefulWidget {
  const ParachuteRainEventScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.eventSubtitle,
    required this.onRequestZombieSelection,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final String eventSubtitle;
  final void Function(void Function(String) onSelected) onRequestZombieSelection;

  @override
  State<ParachuteRainEventScreen> createState() =>
      _ParachuteRainEventScreenState();
}

class _ParachuteRainEventScreenState extends State<ParachuteRainEventScreen> {
  late PvzObject _moduleObj;
  late ParachuteRainEventData _data;

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
        objClass: 'ParachuteRainZombieSpawnerProps',
        objData: ParachuteRainEventData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = ParachuteRainEventData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = ParachuteRainEventData();
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
              title: 'Parachute/Bass/Spider rain event',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: 'Zombies drop from the sky during a wave. Used for Lost Pilot, Bass zombies, Spider zombies, etc.',
                ),
                HelpSectionData(
                  title: 'Logic',
                  body: 'Zombies spawn in batches. Control total count, batch size, column range, and timing. Red subtitle appears before spawn.',
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
            Row(
              children: [
                Icon(Icons.groups, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  'Zombie type (SpiderZombieName)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _data.spiderZombieName.isEmpty
                        ? 'None selected'
                        : _data.spiderZombieName,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    widget.onRequestZombieSelection((id) {
                      _data = ParachuteRainEventData(
                        columnStart: _data.columnStart,
                        columnEnd: _data.columnEnd,
                        groupSize: _data.groupSize,
                        spiderCount: _data.spiderCount,
                        spiderZombieName: id,
                        timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                        timeBetweenGroups: _data.timeBetweenGroups,
                        zombieFallTime: _data.zombieFallTime,
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
                  child: _NumberField(
                    label: 'Total (SpiderCount)',
                    value: _data.spiderCount,
                    onChanged: (v) {
                      _data = ParachuteRainEventData(
                        columnStart: _data.columnStart,
                        columnEnd: _data.columnEnd,
                        groupSize: _data.groupSize,
                        spiderCount: v,
                        spiderZombieName: _data.spiderZombieName,
                        timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                        timeBetweenGroups: _data.timeBetweenGroups,
                        zombieFallTime: _data.zombieFallTime,
                        waveStartMessage: _data.waveStartMessage,
                      );
                      _sync();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumberField(
                    label: 'Per batch (GroupSize)',
                    value: _data.groupSize,
                    onChanged: (v) {
                      _data = ParachuteRainEventData(
                        columnStart: _data.columnStart,
                        columnEnd: _data.columnEnd,
                        groupSize: v,
                        spiderCount: _data.spiderCount,
                        spiderZombieName: _data.spiderZombieName,
                        timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                        timeBetweenGroups: _data.timeBetweenGroups,
                        zombieFallTime: _data.zombieFallTime,
                        waveStartMessage: _data.waveStartMessage,
                      );
                      _sync();
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
                  child: _NumberField(
                    label: 'Start column',
                    value: _data.columnStart,
                    onChanged: (v) {
                      _data = ParachuteRainEventData(
                        columnStart: v,
                        columnEnd: _data.columnEnd,
                        groupSize: _data.groupSize,
                        spiderCount: _data.spiderCount,
                        spiderZombieName: _data.spiderZombieName,
                        timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                        timeBetweenGroups: _data.timeBetweenGroups,
                        zombieFallTime: _data.zombieFallTime,
                        waveStartMessage: _data.waveStartMessage,
                      );
                      _sync();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumberField(
                    label: 'End column',
                    value: _data.columnEnd,
                    onChanged: (v) {
                      _data = ParachuteRainEventData(
                        columnStart: _data.columnStart,
                        columnEnd: v,
                        groupSize: _data.groupSize,
                        spiderCount: _data.spiderCount,
                        spiderZombieName: _data.spiderZombieName,
                        timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                        timeBetweenGroups: _data.timeBetweenGroups,
                        zombieFallTime: _data.zombieFallTime,
                        waveStartMessage: _data.waveStartMessage,
                      );
                      _sync();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DoubleField(
                    label: 'Time between batches (s)',
                    value: _data.timeBetweenGroups,
                    onChanged: (v) {
                      _data = ParachuteRainEventData(
                        columnStart: _data.columnStart,
                        columnEnd: _data.columnEnd,
                        groupSize: _data.groupSize,
                        spiderCount: _data.spiderCount,
                        spiderZombieName: _data.spiderZombieName,
                        timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                        timeBetweenGroups: v,
                        zombieFallTime: _data.zombieFallTime,
                        waveStartMessage: _data.waveStartMessage,
                      );
                      _sync();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DoubleField(
                    label: 'Fall time (s)',
                    value: _data.zombieFallTime,
                    onChanged: (v) {
                      _data = ParachuteRainEventData(
                        columnStart: _data.columnStart,
                        columnEnd: _data.columnEnd,
                        groupSize: _data.groupSize,
                        spiderCount: _data.spiderCount,
                        spiderZombieName: _data.spiderZombieName,
                        timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                        timeBetweenGroups: _data.timeBetweenGroups,
                        zombieFallTime: v,
                        waveStartMessage: _data.waveStartMessage,
                      );
                      _sync();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _DoubleField(
              label: 'Time before full spawn (s)',
              value: _data.timeBeforeFullSpawn,
              onChanged: (v) {
                _data = ParachuteRainEventData(
                  columnStart: _data.columnStart,
                  columnEnd: _data.columnEnd,
                  groupSize: _data.groupSize,
                  spiderCount: _data.spiderCount,
                  spiderZombieName: _data.spiderZombieName,
                  timeBeforeFullSpawn: v,
                  timeBetweenGroups: _data.timeBetweenGroups,
                  zombieFallTime: _data.zombieFallTime,
                  waveStartMessage: _data.waveStartMessage,
                );
                _sync();
              },
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
              'Red subtitle (WaveStartMessage)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _data.waveStartMessage,
              decoration: const InputDecoration(
                hintText: 'Optional warning text before spawn',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                _data = ParachuteRainEventData(
                  columnStart: _data.columnStart,
                  columnEnd: _data.columnEnd,
                  groupSize: _data.groupSize,
                  spiderCount: _data.spiderCount,
                  spiderZombieName: _data.spiderZombieName,
                  timeBeforeFullSpawn: _data.timeBeforeFullSpawn,
                  timeBetweenGroups: _data.timeBetweenGroups,
                  zombieFallTime: _data.zombieFallTime,
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

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      initialValue: value.toString(),
      keyboardType: TextInputType.number,
      onChanged: (v) {
        final n = int.tryParse(v);
        if (n != null) onChanged(n);
      },
    );
  }
}

class _DoubleField extends StatelessWidget {
  const _DoubleField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double value;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      initialValue: value.toString(),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (v) {
        final n = double.tryParse(v);
        if (n != null) onChanged(n);
      },
    );
  }
}
