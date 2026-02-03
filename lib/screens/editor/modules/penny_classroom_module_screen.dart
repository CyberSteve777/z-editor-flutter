import 'package:flutter/material.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/screens/select/plant_selection_screen.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Penny classroom module (global plant levels). Ported from PennyClassroomModulePropertiesEP.kt
class PennyClassroomModuleScreen extends StatefulWidget {
  const PennyClassroomModuleScreen({
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
  State<PennyClassroomModuleScreen> createState() =>
      _PennyClassroomModuleScreenState();
}

class _PennyClassroomModuleScreenState extends State<PennyClassroomModuleScreen> {
  late PvzObject _moduleObj;
  late PennyClassroomModuleData _data;
  double _batchLevel = 1.0;

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
        objClass: 'PennyClassroomModuleProperties',
        objData: PennyClassroomModuleData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = PennyClassroomModuleData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = PennyClassroomModuleData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _addPlants() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlantSelectionScreen(
          isMultiSelect: true,
          onPlantSelected: (_) {},
          onMultiPlantSelected: (ids) {
            Navigator.pop(context);
            final map = Map<String, int>.from(_data.plantMap);
            final level = _batchLevel.round();
            for (final id in ids) {
              map.putIfAbsent(id, () => level);
            }
            _data = PennyClassroomModuleData(plantMap: map);
            _sync();
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _applyBatch() {
    final level = _batchLevel.round();
    final map = Map<String, int>.from(_data.plantMap);
    for (final key in map.keys) {
      map[key] = level;
    }
    _data = PennyClassroomModuleData(plantMap: map);
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = _data.plantMap.entries.toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Plant levels'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Global plant levels',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: 'Defines global levels for specified plants.',
                ),
                HelpSectionData(
                  title: 'Scope',
                  body:
                      'Applies to protect plants, seed rain, and other modules.',
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.layers),
                      const SizedBox(width: 8),
                      Text(
                        'Batch level: ${_batchLevel.round()}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: entries.isEmpty ? null : _applyBatch,
                        child: const Text('Apply batch'),
                      ),
                    ],
                  ),
                  Slider(
                    value: _batchLevel,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _batchLevel.round().toString(),
                    onChanged: (v) => setState(() => _batchLevel = v),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _addPlants,
                    icon: const Icon(Icons.add),
                    label: const Text('Add plants'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: entries.isEmpty
                ? Center(
                    child: Text(
                      'No plants configured',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return _PlantLevelRow(
                        plantId: entry.key,
                        level: entry.value,
                        onLevelChange: (val) {
                          final map = Map<String, int>.from(_data.plantMap);
                          map[entry.key] = val;
                          _data = PennyClassroomModuleData(plantMap: map);
                          _sync();
                        },
                        onDelete: () {
                          final map = Map<String, int>.from(_data.plantMap);
                          map.remove(entry.key);
                          _data = PennyClassroomModuleData(plantMap: map);
                          _sync();
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PlantLevelRow extends StatelessWidget {
  const _PlantLevelRow({
    required this.plantId,
    required this.level,
    required this.onLevelChange,
    required this.onDelete,
  });

  final String plantId;
  final int level;
  final ValueChanged<int> onLevelChange;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final info = PlantRepository().getPlantInfoById(plantId);
    final path = info?.icon != null
        ? 'assets/images/plants/${info!.icon}'
        : 'assets/images/others/unknown.webp';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AssetImageWidget(
                assetPath: path,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
                altCandidates: imageAltCandidates(path),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(info?.name ?? plantId),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('Level: '),
                      Expanded(
                        child: Slider(
                          value: level.toDouble(),
                          min: 1,
                          max: 5,
                          divisions: 4,
                          label: level.toString(),
                          onChanged: (v) => onLevelChange(v.round()),
                        ),
                      ),
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
    );
  }
}
