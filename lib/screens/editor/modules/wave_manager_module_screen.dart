import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/zombie_properties_repository.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/widgets/asset_image.dart'
    show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Wave manager module editor. Ported from WaveManagerModulesPropertiesEP.kt
class WaveManagerModuleScreen extends StatefulWidget {
  const WaveManagerModuleScreen({
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
  State<WaveManagerModuleScreen> createState() =>
      _WaveManagerModuleScreenState();
}

class _WaveManagerModuleScreenState extends State<WaveManagerModuleScreen> {
  late PvzObject _moduleObj;
  late WaveManagerModuleData _data;
  late TextEditingController _startWaveCtrl;
  late TextEditingController _startPointsCtrl;
  late TextEditingController _pointIncrementCtrl;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';
    _moduleObj = widget.levelFile.objects.firstWhere(
      (o) => o.aliases?.contains(alias) == true,
      orElse: () => PvzObject(
        aliases: [alias],
        objClass: 'WaveManagerModuleProperties',
        objData: WaveManagerModuleData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }

    try {
      _data = WaveManagerModuleData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = WaveManagerModuleData();
    }

    if (_data.dynamicZombies.isEmpty) {
      _data.dynamicZombies.add(DynamicZombieGroup());
    } else {
      for (final group in _data.dynamicZombies) {
        while (group.zombieLevel.length < group.zombiePool.length) {
          group.zombieLevel.add(1);
        }
      }
    }

    final hasLastStand = widget.levelFile.objects.any(
      (o) => o.objClass == 'LastStandMinigameProperties',
    );
    if (hasLastStand && _data.manualStartup != true) {
      _data.manualStartup = true;
      _sync();
    }

    final first = _data.dynamicZombies.first;
    _startWaveCtrl =
        TextEditingController(text: '${first.startingWave}');
    _startPointsCtrl =
        TextEditingController(text: '${first.startingPoints}');
    _pointIncrementCtrl =
        TextEditingController(text: '${first.pointIncrement}');
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  DynamicZombieGroup get _firstGroup => _data.dynamicZombies.first;

  void _updateFirstGroup({
    int? startingWave,
    int? startingPoints,
    int? pointIncrement,
  }) {
    _firstGroup.startingWave = startingWave ?? _firstGroup.startingWave;
    _firstGroup.startingPoints =
        startingPoints ?? _firstGroup.startingPoints;
    _firstGroup.pointIncrement = pointIncrement ?? _firstGroup.pointIncrement;
    _sync();
  }

  void _addZombie() {
    widget.onRequestZombieSelection((selectedId) {
      final isElite = ZombieRepository().isElite(selectedId);
      if (isElite) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Elite zombies are not allowed here')),
        );
        return;
      }
      final aliases = ZombieRepository().buildZombieAliases(selectedId);
      final rtid = RtidParser.build(aliases, 'ZombieTypes');
      _firstGroup.zombiePool.add(rtid);
      _firstGroup.zombieLevel.add(1);
      _sync();
    });
  }

  void _removeZombie(int index) {
    if (index < _firstGroup.zombiePool.length) {
      _firstGroup.zombiePool.removeAt(index);
      if (index < _firstGroup.zombieLevel.length) {
        _firstGroup.zombieLevel.removeAt(index);
      }
      _sync();
    }
  }

  void _changeLevel(int index, int delta) {
    final current = _firstGroup.zombieLevel[index];
    final next = (current + delta).clamp(1, 10);
    _firstGroup.zombieLevel[index] = next;
    _sync();
  }

  @override
  void dispose() {
    _startWaveCtrl.dispose();
    _startPointsCtrl.dispose();
    _pointIncrementCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final propsObj = widget.levelFile.objects.firstWhere(
      (o) => o.objClass == 'WaveManagerProperties',
      orElse: () => PvzObject(objClass: '', objData: {}),
    );
    final aliases = propsObj.aliases;
    final actualWaveMgrAlias =
        aliases != null && aliases.isNotEmpty ? aliases.first : null;

    final currentPropsAlias =
        RtidParser.parse(_data.waveManagerProps ?? '')?.alias;
    final isPropsValid = actualWaveMgrAlias != null &&
        currentPropsAlias == actualWaveMgrAlias;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Wave manager module'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Wave manager module',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body:
                      'Enables wave manager. Without this module, wave editing is disabled.',
                ),
                HelpSectionData(
                  title: 'Points',
                  body:
                      'Point-based spawning uses this pool. Avoid elite and custom zombies.',
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: isPropsValid
                  ? theme.colorScheme.outlineVariant
                  : theme.colorScheme.error,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isPropsValid ? Icons.check_circle : Icons.warning,
                          color: isPropsValid
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onError,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'WaveManagerProps',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Current: ${_data.waveManagerProps ?? "null"}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (actualWaveMgrAlias == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'No WaveManagerProperties object found.',
                          style: TextStyle(
                            color: theme.colorScheme.onError,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    if (!isPropsValid && actualWaveMgrAlias != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: theme.colorScheme.onError,
                            foregroundColor: theme.colorScheme.onPrimary,
                          ),
                          onPressed: () {
                            _data.waveManagerProps =
                                RtidParser.build(actualWaveMgrAlias, 'CurrentLevel');
                            _sync();
                          },
                          child: Text('Fix to $actualWaveMgrAlias'),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Point settings',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _intField(
                      controller: _startWaveCtrl,
                      label: 'Starting wave',
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null) _updateFirstGroup(startingWave: n);
                      },
                    ),
                    const SizedBox(height: 8),
                    _intField(
                      controller: _startPointsCtrl,
                      label: 'Starting points',
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null) _updateFirstGroup(startingPoints: n);
                      },
                    ),
                    const SizedBox(height: 8),
                    _intField(
                      controller: _pointIncrementCtrl,
                      label: 'Point increment',
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null) _updateFirstGroup(pointIncrement: n);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Zombie pool',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: _addZombie,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ..._firstGroup.zombiePool.asMap().entries.map((entry) {
              final idx = entry.key;
              final rtid = entry.value;
              final alias = RtidParser.parse(rtid)?.alias ?? rtid;
              final typeName = ZombiePropertiesRepository.getTypeNameByAlias(alias);
              final displayName = ZombieRepository().getName(typeName);
              final info = ZombieRepository().getZombieById(typeName);
              final level = _firstGroup.zombieLevel.elementAt(idx);
              final iconPath = info?.iconAssetPath;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: iconPath != null
                              ? AssetImageWidget(
                                  assetPath: iconPath,
                                  altCandidates: imageAltCandidates(iconPath),
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: theme.colorScheme.surfaceVariant,
                                  alignment: Alignment.center,
                                  child: Text(
                                    displayName.isNotEmpty
                                        ? displayName[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              displayName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              typeName,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              'Level: $level',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: level >= 6
                                    ? theme.colorScheme.error
                                    : theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: level > 1 ? () => _changeLevel(idx, -1) : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: level < 10 ? () => _changeLevel(idx, 1) : null,
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _intField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      onChanged: onChanged,
    );
  }
}
