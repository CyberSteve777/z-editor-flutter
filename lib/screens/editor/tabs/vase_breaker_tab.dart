import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/screens/common/selection_dialog.dart';

class VaseBreakerTab extends StatefulWidget {
  const VaseBreakerTab({
    super.key,
    required this.levelFile,
    required this.onChanged,
  });

  final PvzLevelFile levelFile;
  final VoidCallback onChanged;

  @override
  State<VaseBreakerTab> createState() => _VaseBreakerTabState();
}

class _VaseBreakerTabState extends State<VaseBreakerTab> {
  PvzObject? _presetObj;
  late VaseBreakerPresetData _data;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _presetObj = widget.levelFile.objects
        .where((o) => o.objClass == 'VaseBreakerPresetProperties')
        .firstOrNull;

    if (_presetObj != null) {
      try {
        _data = VaseBreakerPresetData.fromJson(_presetObj!.objData);
      } catch (e) {
        _data = VaseBreakerPresetData();
      }
    } else {
      // Fallback or handle missing object if needed
      // For now, we assume it exists if the tab is shown,
      // or we show an error in build
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _saveData() {
    if (_presetObj != null) {
      _presetObj!.objData = _data.toJson();
      widget.onChanged();
    }
  }

  void _updateData(void Function(VaseBreakerPresetData) update) {
    setState(() {
      update(_data);
    });
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_presetObj == null) {
      return Center(child: Text(l10n?.noLevelDefinition ?? 'Module not found'));
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final minCol = _data.minColumnIndex;
    final maxCol = _data.maxColumnIndex;
    final blacklistCount = _data.gridSquareBlacklist.where((loc) {
      return loc.x >= minCol && loc.x <= maxCol && loc.y >= 0 && loc.y <= 4;
    }).length;

    final totalSlots = (maxCol - minCol + 1) * 5 - blacklistCount;
    final currentAssigned = _data.vases.fold(0, (sum, v) => sum + v.count);
    final isCapacityError = totalSlots != currentAssigned;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRangeSection(l10n),
          const SizedBox(height: 16),
          _buildGridSection(l10n),
          const SizedBox(height: 16),
          _buildCapacityInfo(
            l10n,
            totalSlots,
            currentAssigned,
            isCapacityError,
          ),
          const SizedBox(height: 16),
          _buildVaseList(l10n),
        ],
      ),
    );
  }

  Widget _buildRangeSection(AppLocalizations? l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vase Generation Range & Blacklist',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepper(
                  'Start Col (Min)',
                  _data.minColumnIndex,
                  (val) => _updateData((d) => d.minColumnIndex = val),
                  0,
                  _data.maxColumnIndex,
                ),
                _buildStepper(
                  'End Col (Max)',
                  _data.maxColumnIndex,
                  (val) => _updateData((d) => d.maxColumnIndex = val),
                  _data.minColumnIndex,
                  8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper(
    String label,
    int value,
    ValueChanged<int> onChanged,
    int min,
    int max,
  ) {
    return Column(
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: value > min ? () => onChanged(value - 1) : null,
            ),
            Text(value.toString()),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: value < max ? () => onChanged(value + 1) : null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGridSection(AppLocalizations? l10n) {
    // 5 rows, 9 columns (0-8)
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Click to toggle blacklist'),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final cellSize = (constraints.maxWidth / 9).floorToDouble();
                return Column(
                  children: List.generate(5, (row) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(9, (col) {
                        final isBlacklisted = _data.gridSquareBlacklist.any(
                          (loc) => loc.x == col && loc.y == row,
                        );
                        final isInRange =
                            col >= _data.minColumnIndex &&
                            col <= _data.maxColumnIndex;

                        Color color;
                        if (!isInRange) {
                          color = Colors.grey.withOpacity(0.3);
                        } else if (isBlacklisted) {
                          color = Colors.red.withOpacity(0.5);
                        } else {
                          color = Colors.green.withOpacity(0.5);
                        }

                        return GestureDetector(
                          onTap: () {
                            if (!isInRange) return;
                            _toggleBlacklist(col, row);
                          },
                          child: Container(
                            width: cellSize,
                            height: cellSize,
                            decoration: BoxDecoration(
                              color: color,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: isBlacklisted
                                ? const Icon(Icons.block, size: 16)
                                : null,
                          ),
                        );
                      }),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _toggleBlacklist(int x, int y) {
    _updateData((d) {
      final index = d.gridSquareBlacklist.indexWhere(
        (loc) => loc.x == x && loc.y == y,
      );
      if (index != -1) {
        d.gridSquareBlacklist.removeAt(index);
      } else {
        d.gridSquareBlacklist.add(LocationData(x: x, y: y));
      }
    });
  }

  Widget _buildCapacityInfo(
    AppLocalizations? l10n,
    int total,
    int current,
    bool isError,
  ) {
    return Card(
      color: isError ? Theme.of(context).colorScheme.errorContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              isError ? Icons.warning : Icons.check_circle,
              color: isError
                  ? Theme.of(context).colorScheme.error
                  : Colors.green,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vase Capacity',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Assigned: $current / Total Slots: $total',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVaseList(AppLocalizations? l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Vase List',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddVaseDialog(),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _data.vases.length,
          itemBuilder: (context, index) {
            final vase = _data.vases[index];
            return Card(
              child: ListTile(
                leading: _buildVaseIcon(vase),
                title: Text(_getVaseTitle(vase)),
                subtitle: Text(_getVaseSubtitle(vase)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: vase.count > 1
                          ? () => _updateData((_) => vase.count--)
                          : null,
                    ),
                    Text('${vase.count}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _updateData((_) => vase.count++),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _updateData((d) => d.vases.removeAt(index)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildVaseIcon(VaseDefinition vase) {
    IconData icon = Icons.question_mark;
    Color? color;

    if (vase.plantTypeName != null) {
      icon = Icons.local_florist;
      color = Colors.green;
    } else if (vase.zombieTypeName != null) {
      icon = Icons.android;
      color = Colors.red;
    } else if (vase.collectableTypeName != null) {
      icon = Icons.inventory;
      color = Colors.amber;
    }

    return Icon(icon, color: color);
  }

  String _getVaseTitle(VaseDefinition vase) {
    if (vase.plantTypeName != null) {
      final plants = PlantRepository().allPlants
          .where((p) => p.id == vase.plantTypeName);
      return plants.isNotEmpty ? plants.first.name : vase.plantTypeName!;
    }
    if (vase.zombieTypeName != null) {
      final zombies = ZombieRepository().allZombies
          .where((z) => z.id == vase.zombieTypeName);
      return zombies.isNotEmpty ? zombies.first.name : vase.zombieTypeName!;
    }
    return vase.collectableTypeName ?? 'Unknown Vase';
  }

  String _getVaseSubtitle(VaseDefinition vase) {
    final parts = <String>[];
    if (vase.plantTypeName != null) parts.add('Plant: ${vase.plantTypeName}');
    if (vase.zombieTypeName != null) parts.add('Zombie: ${vase.zombieTypeName}');
    if (vase.collectableTypeName != null) parts.add('Item: ${vase.collectableTypeName}');
    return parts.isEmpty ? '${vase.count} vase(s)' : parts.join(', ');
  }

  void _showAddVaseDialog() {
    // TODO: Implement dialog to select Plant or Zombie and add vase
    // For now, simple dialog
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Vase'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Plant Vase'),
              onTap: () {
                Navigator.pop(ctx);
                _showPlantPicker();
              },
            ),
            ListTile(
              title: const Text('Zombie Vase'),
              onTap: () {
                Navigator.pop(ctx);
                _showZombiePicker();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPlantPicker() {
    showDialog(
      context: context,
      builder: (ctx) => SelectionDialog<PlantInfo>(
        title: 'Select Plant',
        items: PlantRepository().allPlants,
        filter: (item, query) =>
            item.name.toLowerCase().contains(query) ||
            item.id.toLowerCase().contains(query),
        onSelected: (item) {
          _addVase(
            VaseDefinition(plantTypeName: item.id, count: 1),
          );
        },
        itemBuilder: (context, item) =>
            ListTile(title: Text(item.name), subtitle: Text(item.id)),
      ),
    );
  }

  void _showZombiePicker() {
    showDialog(
      context: context,
      builder: (ctx) => SelectionDialog<ZombieInfo>(
        title: 'Select Zombie',
        items: ZombieRepository().allZombies,
        filter: (item, query) =>
            item.name.toLowerCase().contains(query) ||
            item.id.toLowerCase().contains(query),
        onSelected: (item) {
          _addVase(
            VaseDefinition(zombieTypeName: item.id, count: 1),
          );
        },
        itemBuilder: (context, item) =>
            ListTile(title: Text(item.name), subtitle: Text(item.id)),
      ),
    );
  }

  void _addVase(VaseDefinition vase) {
    _updateData((d) => d.vases.add(vase));
  }
}
