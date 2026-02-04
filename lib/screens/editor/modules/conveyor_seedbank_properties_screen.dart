import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/tool_repository.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/widgets/asset_image.dart';

/// Conveyor belt properties. Ported from Z-Editor-master ConveyorSeedBankPropertiesEP.kt
class ConveyorSeedBankPropertiesScreen extends StatefulWidget {
  const ConveyorSeedBankPropertiesScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.onRequestPlantSelection,
    required this.onRequestToolSelection,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final void Function(void Function(String) onSelected) onRequestPlantSelection;
  final void Function(void Function(String) onSelected) onRequestToolSelection;

  @override
  State<ConveyorSeedBankPropertiesScreen> createState() =>
      _ConveyorSeedBankPropertiesScreenState();
}

class _ConveyorSeedBankPropertiesScreenState
    extends State<ConveyorSeedBankPropertiesScreen> {
  late PvzObject _moduleObj;
  late ConveyorBeltData _data;
  int _listKey = 0;

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
        objClass: 'ConveyorSeedBankProperties',
        objData: _createDefaultConveyorData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = ConveyorBeltData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
      if (_data.dropDelayConditions.isEmpty && _data.speedConditions.isEmpty) {
        _data = _createDefaultConveyorData();
      }
    } catch (_) {
      _data = _createDefaultConveyorData();
    }
    _data = ConveyorBeltData(
      initialPlantList: List.from(_data.initialPlantList),
      dropDelayConditions: List.from(_data.dropDelayConditions),
      speedConditions: List.from(_data.speedConditions),
    );
  }

  ConveyorBeltData _createDefaultConveyorData() {
    return ConveyorBeltData(
      initialPlantList: [],
      speedConditions: [
        SpeedConditionData(maxPacketsSpeed: 0, speed: 100),
      ],
      dropDelayConditions: [
        DropDelayConditionData(maxPacketsDelay: 0, delay: 3),
        DropDelayConditionData(maxPacketsDelay: 2, delay: 6),
        DropDelayConditionData(maxPacketsDelay: 4, delay: 8),
        DropDelayConditionData(maxPacketsDelay: 9, delay: 10),
      ],
    );
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _addPlant() {
    widget.onRequestPlantSelection((id) {
      setState(() {
        _data.initialPlantList
            .add(InitialPlantListData(plantType: id));
        _listKey++;
        _sync();
      });
    });
  }

  void _addTool() {
    widget.onRequestToolSelection((id) {
      setState(() {
        _data.initialPlantList
            .add(InitialPlantListData(plantType: id));
        _listKey++;
        _sync();
      });
    });
  }

  void _removePlant(int index) {
    setState(() {
      _data.initialPlantList.removeAt(index);
      _listKey++;
      _sync();
    });
  }

  void _editPlant(InitialPlantListData item) {
    showDialog<void>(
      context: context,
      builder: (ctx) => _PlantDetailDialog(
        data: item,
        onDismiss: () => Navigator.pop(ctx),
        onConfirm: () {
          _listKey++;
          _sync();
          Navigator.pop(ctx);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Conveyor belt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelp(context),
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
              _ConveyorPlantListEditor(
                items: _data.initialPlantList,
                onAddPlant: _addPlant,
                onAddTool: _addTool,
                onEdit: _editPlant,
                onRemove: _removePlant,
                listKey: _listKey,
              ),
              const SizedBox(height: 20),
              _ConveyorConditionEditor(
                title: 'Drop delay (DropDelayConditions)',
                subtitle: 'Unit: seconds',
                headers: ('MaxPackets', 'Delay'),
                items: _data.dropDelayConditions,
                extractMaxPackets: (e) => e.maxPacketsDelay,
                onValueChange: _sync,
                onAdd: () {
                  var next = (_data.dropDelayConditions
                              .map((e) => e.maxPacketsDelay)
                              .fold<int>(0, (a, b) => a > b ? a : b)) +
                          2;
                  if (next >= 9) next = 9;
                  _data.dropDelayConditions
                      .add(DropDelayConditionData(delay: 6, maxPacketsDelay: next));
                  _sync();
                },
                onRemove: (i) {
                  _data.dropDelayConditions.removeAt(i);
                  _sync();
                },
                buildRow: (item, sync) => Row(
                  children: [
                    Expanded(
                      child: _NumberField(
                        label: 'Threshold',
                        value: item.maxPacketsDelay,
                        onChanged: (v) {
                          item.maxPacketsDelay = v;
                          sync();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _NumberField(
                        label: 'Delay',
                        value: item.delay,
                        onChanged: (v) {
                          item.delay = v;
                          sync();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _ConveyorConditionEditor(
                title: 'Speed (SpeedConditions)',
                subtitle: 'Standard value 100, higher = faster',
                headers: ('MaxPackets', 'Speed'),
                items: _data.speedConditions,
                extractMaxPackets: (e) => e.maxPacketsSpeed,
                onValueChange: _sync,
                onAdd: () {
                  var next = (_data.speedConditions
                              .map((e) => e.maxPacketsSpeed)
                              .fold<int>(0, (a, b) => a > b ? a : b)) +
                          2;
                  if (next >= 9) next = 9;
                  _data.speedConditions
                      .add(SpeedConditionData(speed: 100, maxPacketsSpeed: next));
                  _sync();
                },
                onRemove: (i) {
                  _data.speedConditions.removeAt(i);
                  _sync();
                },
                buildRow: (item, sync) => Row(
                  children: [
                    Expanded(
                      child: _NumberField(
                        label: 'Threshold',
                        value: item.maxPacketsSpeed,
                        onChanged: (v) {
                          item.maxPacketsSpeed = v;
                          sync();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _NumberField(
                        label: 'Speed',
                        value: item.speed,
                        onChanged: (v) {
                          item.speed = v;
                          sync();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showHelp(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Conveyor belt help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Conveyor mode randomly generates cards by weight. Configure plant pool and refresh delay.'),
              SizedBox(height: 8),
              Text('Plant pool & weight: Probability = weight / total weight. Use thresholds to adjust dynamically.'),
              SizedBox(height: 8),
              Text('Drop delay: Controls card spawn interval. More plants = slower.'),
              SizedBox(height: 8),
              Text('Speed: Physical belt speed. Standard = 100.'),
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

class _ConveyorPlantListEditor extends StatelessWidget {
  const _ConveyorPlantListEditor({
    required this.items,
    required this.onAddPlant,
    required this.onAddTool,
    required this.onEdit,
    required this.onRemove,
    required this.listKey,
  });

  final List<InitialPlantListData> items;
  final VoidCallback onAddPlant;
  final VoidCallback onAddTool;
  final void Function(InitialPlantListData) onEdit;
  final void Function(int) onRemove;
  final int listKey;

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
                Icon(Icons.linear_scale, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  'Conveyor card pool',
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
                  child: OutlinedButton.icon(
                    onPressed: onAddPlant,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add plant'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onAddTool,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add tool'),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'No cards yet. Add plants or tools.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              ...List.generate(items.length, (i) {
                final item = items[i];
                return _PlantRow(
                  key: ValueKey('$listKey-$i-${item.plantType}'),
                  plant: item,
                  onEdit: () => onEdit(item),
                  onDelete: () => onRemove(i),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class _PlantRow extends StatelessWidget {
  const _PlantRow({
    super.key,
    required this.plant,
    required this.onEdit,
    required this.onDelete,
  });

  final InitialPlantListData plant;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final toolInfo = ToolRepository.get(plant.plantType);
    final isTool = toolInfo != null;
    final plantInfo = PlantRepository().getPlantInfoById(plant.plantType);
    final displayName = toolInfo?.name ?? PlantRepository().getName(plant.plantType);
    final iconPath = isTool
        ? (toolInfo.icon != null ? 'assets/images/tools/${toolInfo.icon}' : null)
        : plantInfo?.iconAssetPath;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onEdit,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 44,
                    height: isTool ? 36 : 44,
                    child: iconPath != null
                        ? AssetImageWidget(
                            assetPath: iconPath,
                            width: 44,
                            height: isTool ? 36 : 44,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: theme.colorScheme.outline.withValues(alpha: 0.3),
                            alignment: Alignment.center,
                            child: Text(
                              displayName.isNotEmpty
                                  ? displayName[0].toUpperCase()
                                  : '?',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Weight: ${plant.weight}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (!isTool) ...[
                            const SizedBox(width: 8),
                            Text(
                              'Level: ${plant.iLevel ?? 'account'}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlantDetailDialog extends StatefulWidget {
  const _PlantDetailDialog({
    required this.data,
    required this.onDismiss,
    required this.onConfirm,
  });

  final InitialPlantListData data;
  final VoidCallback onDismiss;
  final VoidCallback onConfirm;

  @override
  State<_PlantDetailDialog> createState() => _PlantDetailDialogState();
}

class _PlantDetailDialogState extends State<_PlantDetailDialog> {
  late int _weight;
  late int _level;
  late int _maxCount;
  late double _maxWeightFactor;
  late int _minCount;
  late double _minWeightFactor;

  @override
  void initState() {
    super.initState();
    _weight = widget.data.weight;
    _level = widget.data.iLevel ?? 0;
    _maxCount = widget.data.maxCount;
    _maxWeightFactor = widget.data.maxWeightFactor;
    _minCount = widget.data.minCount;
    _minWeightFactor = widget.data.minWeightFactor;
  }

  void _save() {
    widget.data.weight = _weight;
    widget.data.iLevel = _level <= 0 ? null : _level;
    widget.data.maxCount = _maxCount;
    widget.data.maxWeightFactor = _maxWeightFactor;
    widget.data.minCount = _minCount;
    widget.data.minWeightFactor = _minWeightFactor;
    widget.onConfirm();
  }

  @override
  Widget build(BuildContext context) {
    final toolInfo = ToolRepository.get(widget.data.plantType);
    final isTool = toolInfo != null;
    final displayName = toolInfo?.name ??
        ResourceNames.lookup(context, PlantRepository().getName(widget.data.plantType));

    return AlertDialog(
      title: Text('Edit: $displayName'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: _NumberField(
                    label: 'Initial weight',
                    value: _weight,
                    onChanged: (v) => setState(() => _weight = v),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _NumberField(
                    label: 'Plant level',
                    value: _level,
                    onChanged: (v) =>
                        setState(() => _level = isTool ? 0 : v.clamp(0, 5)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isTool
                  ? 'Tool cards use fixed level'
                  : '0 = follow account level',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const Divider(height: 24),
            Text(
              'Max limits',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _NumberField(
                    label: 'Max count threshold',
                    value: _maxCount,
                    onChanged: (v) => setState(() => _maxCount = v),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _DoubleField(
                    label: 'Weight factor',
                    value: _maxWeightFactor,
                    onChanged: (v) => setState(() => _maxWeightFactor = v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Min limits',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _NumberField(
                    label: 'Min count threshold',
                    value: _minCount,
                    onChanged: (v) => setState(() => _minCount = v),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _DoubleField(
                    label: 'Weight factor',
                    value: _minWeightFactor,
                    onChanged: (v) => setState(() => _minWeightFactor = v),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.onDismiss,
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _ConveyorConditionEditor<T> extends StatelessWidget {
  const _ConveyorConditionEditor({
    required this.title,
    required this.subtitle,
    required this.headers,
    required this.items,
    required this.extractMaxPackets,
    required this.onValueChange,
    required this.onAdd,
    required this.onRemove,
    required this.buildRow,
  });

  final String title;
  final String subtitle;
  final (String, String) headers;
  final List<T> items;
  final int Function(T) extractMaxPackets;
  final VoidCallback onValueChange;
  final VoidCallback onAdd;
  final void Function(int) onRemove;
  final Widget Function(T, VoidCallback) buildRow;

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
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
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
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    headers.$1,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    headers.$2,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 32),
              ],
            ),
            const SizedBox(height: 4),
            ...items.asMap().entries.map((e) {
              final idx = e.key;
              final item = e.value;
              final isBase = extractMaxPackets(item) == 0;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(child: buildRow(item, onValueChange)),
                    if (isBase)
                      Icon(
                        Icons.lock,
                        size: 20,
                        color: theme.colorScheme.outline,
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => onRemove(idx),
                        iconSize: 20,
                      ),
                  ],
                ),
              );
            }),
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
      initialValue: value.toString(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (s) {
        final v = int.tryParse(s) ?? 0;
        onChanged(v);
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
      initialValue: value.toString(),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (s) {
        final v = double.tryParse(s) ?? 0.0;
        onChanged(v);
      },
    );
  }
}
