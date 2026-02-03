import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/l10n/resource_names.dart';

/// Seed bank properties. Ported from Z-Editor-master SeedBankPropertiesEP.kt
class SeedBankPropertiesScreen extends StatefulWidget {
  const SeedBankPropertiesScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.onRequestPlantSelection,
    required this.onRequestZombieSelection,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final void Function(void Function(List<String>) onSelected)
      onRequestPlantSelection;
  final void Function(void Function(List<String>) onSelected)
      onRequestZombieSelection;

  @override
  State<SeedBankPropertiesScreen> createState() =>
      _SeedBankPropertiesScreenState();
}

class _SeedBankPropertiesScreenState extends State<SeedBankPropertiesScreen> {
  late PvzObject _moduleObj;
  late SeedBankData _data;

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
        objClass: 'SeedBankProperties',
        objData: SeedBankData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = SeedBankData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = SeedBankData();
    }
    _data = SeedBankData(
      presetPlantList: List.from(_data.presetPlantList),
      plantWhiteList: List.from(_data.plantWhiteList),
      plantBlackList: List.from(_data.plantBlackList),
      selectionMethod: _data.selectionMethod,
      globalLevel: _data.globalLevel,
      overrideSeedSlotsCount: _data.overrideSeedSlotsCount,
      zombieMode: _data.zombieMode,
      seedPacketType: _data.seedPacketType,
    );
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _addToPresetPlants() {
    widget.onRequestPlantSelection((ids) {
      setState(() {
        _data.presetPlantList.addAll(ids);
        _sync();
      });
    });
  }

  void _addToWhiteList() {
    widget.onRequestPlantSelection((ids) {
      setState(() {
        _data.plantWhiteList.addAll(ids);
        _sync();
      });
    });
  }

  void _addToBlackList() {
    widget.onRequestPlantSelection((ids) {
      setState(() {
        _data.plantBlackList.addAll(ids);
        _sync();
      });
    });
  }

  void _addToZombieList() {
    widget.onRequestZombieSelection((ids) {
      setState(() {
        for (final id in ids) {
          _data.presetPlantList.add(ZombieRepository().buildZombieAliases(id));
        }
        _sync();
      });
    });
  }

  void _removeFromList(List<String> list, int index) {
    setState(() {
      list.removeAt(index);
      _sync();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isZombieMode = _data.zombieMode == true;
    final isReversedZombie =
        _data.seedPacketType == 'UIIZombieSeedPacket';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Text(isZombieMode ? 'Seed bank (I, Zombie)' : 'Seed bank'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelp(context, isZombieMode),
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
              _buildBasicRulesCard(context, isZombieMode),
              const SizedBox(height: 16),
              if (isZombieMode)
                _ResourceListEditor(
                  title: 'Available zombies',
                  description: 'Zombies available for I, Zombie mode',
                  items: _data.presetPlantList,
                  accentColor: theme.colorScheme.secondary,
                  isZombie: true,
                  onAdd: _addToZombieList,
                  onRemove: (i) => _removeFromList(_data.presetPlantList, i),
                )
              else ...[
                _ResourceListEditor(
                  title: 'Preset plants (PresetPlantList)',
                  description: 'Plants available at start',
                  items: _data.presetPlantList,
                  accentColor: theme.colorScheme.secondary,
                  isZombie: false,
                  onAdd: _addToPresetPlants,
                  onRemove: (i) => _removeFromList(_data.presetPlantList, i),
                ),
                const SizedBox(height: 16),
                _ResourceListEditor(
                  title: 'White list (WhiteList)',
                  description: 'Only these plants allowed (empty = no limit)',
                  items: _data.plantWhiteList,
                  accentColor: theme.colorScheme.primary,
                  isZombie: false,
                  onAdd: _addToWhiteList,
                  onRemove: (i) => _removeFromList(_data.plantWhiteList, i),
                ),
                const SizedBox(height: 16),
                _ResourceListEditor(
                  title: 'Black list (BlackList)',
                  description: 'These plants are forbidden',
                  items: _data.plantBlackList,
                  accentColor: theme.colorScheme.error,
                  isZombie: false,
                  onAdd: _addToBlackList,
                  onRemove: (i) => _removeFromList(_data.plantBlackList, i),
                ),
              ],
              if (isZombieMode)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Only some zombies have IZ card slots. Check Other category in zombie selection.',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              _buildZombieModeSwitch(context, isZombieMode),
              const SizedBox(height: 16),
              if (isZombieMode)
                _buildReversedZombieSwitch(context, isReversedZombie),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicRulesCard(BuildContext context, bool isZombieMode) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.yard,
                  color: isZombieMode
                      ? theme.colorScheme.onSurfaceVariant
                      : theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Basic rules',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              'Selection method',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Chooser'),
                  selected:
                      _data.selectionMethod == 'chooser' && !isZombieMode,
                  onSelected: isZombieMode
                      ? null
                      : (v) {
                          setState(() {
                            _data.selectionMethod = 'chooser';
                            _sync();
                          });
                        },
                ),
                FilterChip(
                  label: const Text('Preset'),
                  selected:
                      _data.selectionMethod == 'preset' || isZombieMode,
                  onSelected: isZombieMode
                      ? null
                      : (v) {
                          setState(() {
                            _data.selectionMethod = 'preset';
                            _sync();
                          });
                        },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Preset mode enters game immediately regardless of card count.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Opacity(
              opacity: isZombieMode ? 0.5 : 1,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '${_data.globalLevel ?? 0}',
                      decoration: const InputDecoration(
                        labelText: 'Plant level (0-5)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (s) {
                        final v = int.tryParse(s) ?? 0;
                        final clamped = v.clamp(0, 5);
                        _data.globalLevel =
                            clamped == 0 ? null : clamped;
                        _sync();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      initialValue: '${_data.overrideSeedSlotsCount ?? 0}',
                      decoration: const InputDecoration(
                        labelText: 'Slot count (0-9)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (s) {
                        final v = int.tryParse(s) ?? 0;
                        _data.overrideSeedSlotsCount = v.clamp(0, 9);
                        _sync();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Courtyard mode ignores slot count. Chooser locks 8 slots.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZombieModeSwitch(BuildContext context, bool isZombieMode) {
    final theme = Theme.of(context);

    return Card(
      child: SwitchListTile(
        title: const Text(
          'I, Zombie mode',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Enable to place zombies. Locks selection method.',
        ),
        value: isZombieMode,
        onChanged: (v) {
          setState(() {
            _data.zombieMode = v;
            if (v) {
              _data.selectionMethod = 'preset';
              _data.seedPacketType = null;
            } else {
              _data.seedPacketType = null;
            }
            _sync();
          });
        },
      ),
    );
  }

  Widget _buildReversedZombieSwitch(
      BuildContext context, bool isReversedZombie) {
    final theme = Theme.of(context);

    return Card(
      child: SwitchListTile(
        title: const Text(
          'Reverse zombie faction',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          'Enable to make zombies plant faction. For ZvZ.',
        ),
        value: isReversedZombie,
        onChanged: (v) {
          setState(() {
            _data.seedPacketType =
                v ? 'UIIZombieSeedPacket' : null;
            _sync();
          });
        },
      ),
    );
  }

  void _showHelp(BuildContext context, bool isZombieMode) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Seed bank help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Seed bank lets players choose plants. In courtyard mode you can set global level and all plants.'),
              SizedBox(height: 8),
              Text('White list: empty = no limit. Black list overrides white list.'),
              SizedBox(height: 8),
              Text(
                  'I, Zombie mode: preset zombies for player. Selection locked to preset.'),
              SizedBox(height: 8),
              Text(
                  'Invalid IDs leave empty slots. Zombie IDs in plant mode and vice versa. Put zombie slots first.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _ResourceListEditor extends StatelessWidget {
  const _ResourceListEditor({
    required this.title,
    required this.description,
    required this.items,
    required this.accentColor,
    required this.isZombie,
    required this.onAdd,
    required this.onRemove,
  });

  final String title;
  final String description;
  final List<String> items;
  final Color accentColor;
  final bool isZombie;
  final VoidCallback onAdd;
  final void Function(int) onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                      Text(
                        description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: onAdd,
                  color: accentColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (items.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Empty list',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(items.length, (i) {
                  final id = items[i];
                  final name = isZombie
                      ? ResourceNames.lookup(context, ZombieRepository().getName(id))
                      : ResourceNames.lookup(context, PlantRepository().getName(id));
                  return InputChip(
                    label: Text(name),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => onRemove(i),
                    backgroundColor:
                        accentColor.withValues(alpha: 0.1),
                    side: BorderSide(
                      color: accentColor.withValues(alpha: 0.3),
                    ),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }
}
