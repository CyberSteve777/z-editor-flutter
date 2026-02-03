import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/screens/select/plant_selection_screen.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Initial plant entry. Ported from Z-Editor-master InitialPlantEntryEP.kt
class InitialPlantEntryScreen extends StatefulWidget {
  const InitialPlantEntryScreen({
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
  State<InitialPlantEntryScreen> createState() => _InitialPlantEntryScreenState();
}

class _InitialPlantEntryScreenState extends State<InitialPlantEntryScreen> {
  late PvzObject _moduleObj;
  late InitialPlantEntryData _data;
  int _selectedX = 0;
  int _selectedY = 0;
  InitialPlantData? _editingPlant;

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
        objClass: 'InitialPlantEntryProperties',
        objData: InitialPlantEntryData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = InitialPlantEntryData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = InitialPlantEntryData();
    }
    _data = InitialPlantEntryData(plants: List.from(_data.plants));
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _handleSelectPlant() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlantSelectionScreen(
          isMultiSelect: false,
          onPlantSelected: (id) {
            Navigator.pop(context);
            final newList = List<InitialPlantData>.from(_data.plants);
            newList.add(InitialPlantData(
              gridX: _selectedX,
              gridY: _selectedY,
              level: 1,
              plantTypes: [id],
              avatar: false,
            ));
            _data = InitialPlantEntryData(plants: newList);
            _sync();
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _updatePlant(InitialPlantData oldPlant, InitialPlantData newPlant) {
    final newList = List<InitialPlantData>.from(_data.plants);
    final idx = newList.indexOf(oldPlant);
    if (idx >= 0) {
      newList[idx] = newPlant;
      _data = InitialPlantEntryData(plants: newList);
      _sync();
    }
  }

  void _deletePlant(InitialPlantData target) {
    final newList = List<InitialPlantData>.from(_data.plants);
    newList.remove(target);
    _data = InitialPlantEntryData(plants: newList);
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sortedPlants = List<InitialPlantData>.from(_data.plants)
      ..sort((a, b) {
        final c = a.gridY.compareTo(b.gridY);
        return c != 0 ? c : a.gridX.compareTo(b.gridX);
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial plant layout'),
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
                              onPressed: _handleSelectPlant,
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Place here'),
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
                  'Plant list (row-first)',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                ...sortedPlants.map((p) => _InitialPlantCard(
                  plant: p,
                  isSelected: p.gridX == _selectedX && p.gridY == _selectedY,
                  onTap: () {
                    setState(() {
                      _selectedX = p.gridX;
                      _selectedY = p.gridY;
                      _editingPlant = p;
                    });
                  },
                )),
              ],
            ),
          ),
          if (_editingPlant != null) _buildEditDialog(),
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
                  ? const Color(0xFF3C483D)
                  : const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFC8E6C9), width: 1),
            ),
            child: Column(
              children: List.generate(5, (row) {
                return Expanded(
                  child: Row(
                    children: List.generate(9, (col) {
                      final isSelected = row == _selectedY && col == _selectedX;
                      final cellPlants = _data.plants
                          .where((p) => p.gridX == col && p.gridY == row)
                          .toList();
                      final firstPlant =
                          cellPlants.isNotEmpty ? cellPlants.first : null;
                      final count = cellPlants.length;
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
                                    : const Color(0xFFA5D6A7),
                                width: 0.5,
                              ),
                            ),
                            child: count > 0 && firstPlant != null
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Center(
                                        child: _PlantIconSmall(
                                          firstPlant.plantTypes.firstOrNull ??
                                              '',
                                        ),
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
    final plant = _editingPlant!;
    return _InitialPlantEditDialog(
      plant: plant,
      onSave: (updated) {
        _updatePlant(plant, updated);
        setState(() => _editingPlant = null);
      },
      onDelete: () {
        _deletePlant(plant);
        setState(() => _editingPlant = null);
      },
      onCancel: () => setState(() => _editingPlant = null),
    );
  }
}

class _PlantIconSmall extends StatelessWidget {
  const _PlantIconSmall(this.plantType);

  final String plantType;

  @override
  Widget build(BuildContext context) {
    final info = PlantRepository().getPlantInfoById(plantType);
    final path = info?.icon != null
        ? 'assets/images/plants/${info!.icon}'
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

class _InitialPlantCard extends StatelessWidget {
  const _InitialPlantCard({
    required this.plant,
    required this.isSelected,
    required this.onTap,
  });

  final InitialPlantData plant;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final plantType = plant.plantTypes.firstOrNull ?? '';
    final info = PlantRepository().getPlantInfoById(plantType);
    final path = info?.icon != null
        ? 'assets/images/plants/${info!.icon}'
        : 'assets/images/others/unknown.webp';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isSelected
          ? (theme.brightness == Brightness.dark
              ? const Color(0xFF3C483D)
              : const Color(0xFFD5F3D6))
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
              Stack(
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
                  if (plant.avatar)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Icon(
                          Icons.star,
                          size: 12,
                          color: Color(0xFFFFC107),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'R${plant.gridY + 1}:C${plant.gridX + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  Text(
                    'Level: ${plant.level}',
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

class _InitialPlantEditDialog extends StatefulWidget {
  const _InitialPlantEditDialog({
    required this.plant,
    required this.onSave,
    required this.onDelete,
    required this.onCancel,
  });

  final InitialPlantData plant;
  final void Function(InitialPlantData) onSave;
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  @override
  State<_InitialPlantEditDialog> createState() => _InitialPlantEditDialogState();
}

class _InitialPlantEditDialogState extends State<_InitialPlantEditDialog> {
  late int _level;
  late bool _avatar;

  @override
  void initState() {
    super.initState();
    _level = widget.plant.level;
    _avatar = widget.plant.avatar;
  }

  @override
  Widget build(BuildContext context) {
    final name = PlantRepository().getName(
      widget.plant.plantTypes.firstOrNull ?? '',
    );
    return AlertDialog(
      title: Text('Edit $name'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Level: $_level', style: const TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _level.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: (v) => setState(() => _level = v.round()),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('First costume (Avatar)'),
            value: _avatar,
            onChanged: (v) => setState(() => _avatar = v),
          ),
        ],
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
            widget.onSave(InitialPlantData(
              gridX: widget.plant.gridX,
              gridY: widget.plant.gridY,
              level: _level,
              avatar: _avatar,
              plantTypes: widget.plant.plantTypes,
            ));
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
