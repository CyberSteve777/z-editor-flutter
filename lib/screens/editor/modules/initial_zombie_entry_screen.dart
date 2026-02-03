import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/screens/select/zombie_selection_screen.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Initial zombie entry. Ported from Z-Editor-master InitialZombieEntryEP.kt
class InitialZombieEntryScreen extends StatefulWidget {
  const InitialZombieEntryScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;

  @override
  State<InitialZombieEntryScreen> createState() =>
      _InitialZombieEntryScreenState();
}

class _InitialZombieEntryScreenState extends State<InitialZombieEntryScreen> {
  late PvzObject _moduleObj;
  late InitialZombieEntryData _data;
  int _selectedX = 0;
  int _selectedY = 0;
  InitialZombieData? _editingPlacement;

  static const _zombieConditions = [
    ('icecubed', 'Icecubed (icecubed)'),
    ('freeze', 'Frozen (freeze)'),
    ('stun', 'Stunned (stun)'),
  ];

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
        objClass: 'InitialZombieProperties',
        objData: InitialZombieEntryData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = InitialZombieEntryData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = InitialZombieEntryData();
    }
    _data = InitialZombieEntryData(placements: List.from(_data.placements));
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _handleAddZombie() {
    final repo = ZombieRepository();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ZombieSelectionScreen(
          multiSelect: false,
          onZombieSelected: (id) {
            Navigator.pop(context);
            final isElite = repo.getZombieById(id)?.tags.contains(ZombieTag.elite) ?? false;
            if (isElite) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cannot add elite zombies')),
              );
              return;
            }
            final aliases = repo.buildZombieAliases(id);
            final newList = List<InitialZombieData>.from(_data.placements);
            newList.add(InitialZombieData(
              gridX: _selectedX,
              gridY: _selectedY,
              typeName: aliases,
              condition: 'icecubed',
            ));
            _data = InitialZombieEntryData(placements: newList);
            _sync();
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _updatePlacement(InitialZombieData oldItem, InitialZombieData newItem) {
    final newList = List<InitialZombieData>.from(_data.placements);
    final idx = newList.indexOf(oldItem);
    if (idx >= 0) {
      newList[idx] = newItem;
      _data = InitialZombieEntryData(placements: newList);
      _sync();
    }
  }

  void _deletePlacement(InitialZombieData target) {
    final newList = List<InitialZombieData>.from(_data.placements);
    newList.remove(target);
    _data = InitialZombieEntryData(placements: newList);
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sortedPlacements = List<InitialZombieData>.from(_data.placements)
      ..sort((a, b) {
        final c = a.gridY.compareTo(b.gridY);
        return c != 0 ? c : a.gridX.compareTo(b.gridX);
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial zombie layout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected position',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  'R${_selectedY + 1} : C${_selectedX + 1}',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            FilledButton.icon(
                              onPressed: _handleAddZombie,
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Place zombie'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildGrid(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Zombie list (row-first)',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                ...sortedPlacements.map((p) => _InitialZombieCard(
                  item: p,
                  isSelected: p.gridX == _selectedX && p.gridY == _selectedY,
                  onTap: () {
                    setState(() {
                      _selectedX = p.gridX;
                      _selectedY = p.gridY;
                      _editingPlacement = p;
                    });
                  },
                )),
              ],
            ),
          ),
          if (_editingPlacement != null) _buildEditDialog(),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final theme = Theme.of(context);
    return scaleTableForDesktop(
      context: context,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        child: AspectRatio(
          aspectRatio: 1.8,
          child: Container(
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF40404B)
                  : const Color(0xFFEFEFFF),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFBAC4FA), width: 1),
            ),
            child: Column(
              children: List.generate(5, (row) {
                return Expanded(
                  child: Row(
                    children: List.generate(9, (col) {
                      final isSelected = row == _selectedY && col == _selectedX;
                      final cellZombies = _data.placements
                          .where((p) => p.gridX == col && p.gridY == row)
                          .toList();
                      final firstZombie = cellZombies.firstOrNull;
                      final count = cellZombies.length;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _selectedX = col;
                            _selectedY = row;
                          }),
                          child: Container(
                            margin: const EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colorScheme.primary.withValues(
                                      alpha: 0.2,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : const Color(0xFF8581FA),
                                width: 0.5,
                              ),
                            ),
                            child: count > 0 && firstZombie != null
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Center(
                                        child:
                                            _ZombieIconSmall(firstZombie.typeName),
                                      ),
                                      if (count > 1)
                                        Positioned(
                                          top: 2,
                                          right: 2,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: theme.colorScheme
                                                  .onSurfaceVariant,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(4),
                                              ),
                                            ),
                                            child: Text(
                                              '+$count',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditDialog() {
    final placement = _editingPlacement!;
    return _InitialZombieEditDialog(
      placement: placement,
      onSave: (updated) {
        _updatePlacement(placement, updated);
        setState(() => _editingPlacement = null);
      },
      onDelete: () {
        _deletePlacement(placement);
        setState(() => _editingPlacement = null);
      },
      onCancel: () => setState(() => _editingPlacement = null),
    );
  }
}

class _ZombieIconSmall extends StatelessWidget {
  const _ZombieIconSmall(this.typeName);

  final String typeName;

  @override
  Widget build(BuildContext context) {
    final info = ZombieRepository().getZombieById(typeName) ??
        ZombieRepository().getZombieById(
          typeName.replaceAll('_elite', ''),
        );
    final path = info?.icon != null
        ? 'assets/images/zombies/${info!.icon}'
        : 'assets/images/others/unknown.webp';
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: AssetImageWidget(
        assetPath: path,
        fit: BoxFit.cover,
        width: 32,
        height: 32,
        altCandidates: imageAltCandidates(path),
      ),
    );
  }
}

class _InitialZombieCard extends StatelessWidget {
  const _InitialZombieCard({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final InitialZombieData item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final info = ZombieRepository().getZombieById(item.typeName) ??
        ZombieRepository().getZombieById(
          item.typeName.replaceAll('_elite', ''),
        );
    final path = info?.icon != null
        ? 'assets/images/zombies/${info!.icon}'
        : 'assets/images/others/unknown.webp';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isSelected
          ? (theme.brightness == Brightness.dark
              ? const Color(0xFF40404B)
              : const Color(0xFFD9D7F6))
          : theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        side: isSelected
            ? BorderSide(color: theme.colorScheme.primary, width: 1)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AssetImageWidget(
                  assetPath: path,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  altCandidates: imageAltCandidates(path),
                  errorWidget: Container(
                    color: theme.colorScheme.onSurfaceVariant,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'R${item.gridY + 1}:C${item.gridX + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xFF654B80),
                    ),
                  ),
                  Text(
                    item.condition,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InitialZombieEditDialog extends StatefulWidget {
  const _InitialZombieEditDialog({
    required this.placement,
    required this.onSave,
    required this.onDelete,
    required this.onCancel,
  });

  final InitialZombieData placement;
  final void Function(InitialZombieData) onSave;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  @override
  State<_InitialZombieEditDialog> createState() =>
      _InitialZombieEditDialogState();
}

class _InitialZombieEditDialogState extends State<_InitialZombieEditDialog> {
  late String _condition;
  late bool _isCustomInput;
  late TextEditingController _conditionController;

  @override
  void initState() {
    super.initState();
    _condition = widget.placement.condition;
    _isCustomInput = !_InitialZombieEntryScreenState._zombieConditions
        .any((e) => e.$1 == _condition);
    _conditionController = TextEditingController(text: _condition);
  }

  @override
  void dispose() {
    _conditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = ZombieRepository().getName(widget.placement.typeName);
    return AlertDialog(
      title: Text('Edit preset zombie: $name'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Manual input'),
              value: _isCustomInput,
              onChanged: (v) => setState(() => _isCustomInput = v),
            ),
            if (_isCustomInput) ...[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Enter condition value',
                  border: OutlineInputBorder(),
                ),
                controller: _conditionController,
                onChanged: (v) => setState(() => _condition = v),
              ),
              const SizedBox(height: 8),
              Text(
                'Custom input must be accurate',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ] else ...[
              DropdownButtonFormField<String>(
                value: _InitialZombieEntryScreenState._zombieConditions
                        .any((e) => e.$1 == _condition)
                    ? _condition
                    : _InitialZombieEntryScreenState._zombieConditions.first.$1,
                decoration: const InputDecoration(
                  labelText: 'Preset conditions',
                  border: OutlineInputBorder(),
                ),
                items: _InitialZombieEntryScreenState._zombieConditions
                    .map((e) => DropdownMenuItem(
                          value: e.$1,
                          child: Text(e.$2),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _condition = v);
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Select from preset condition list',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onDelete();
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Delete'),
        ),
        TextButton(onPressed: widget.onCancel, child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            final cond = _isCustomInput
                ? _conditionController.text
                : _condition;
            widget.onSave(InitialZombieData(
              gridX: widget.placement.gridX,
              gridY: widget.placement.gridY,
              typeName: widget.placement.typeName,
              condition: cond,
            ));
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
