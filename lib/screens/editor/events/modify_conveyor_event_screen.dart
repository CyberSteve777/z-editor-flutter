import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/widgets/asset_image.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Modify conveyor event editor. Ported from Z-Editor-master ModifyConveyorEventEP.kt
class ModifyConveyorEventScreen extends StatefulWidget {
  const ModifyConveyorEventScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.onRequestPlantSelection,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final void Function(void Function(String) onSelected) onRequestPlantSelection;

  @override
  State<ModifyConveyorEventScreen> createState() =>
      _ModifyConveyorEventScreenState();
}

class _ModifyConveyorEventScreenState extends State<ModifyConveyorEventScreen> {
  late PvzObject _moduleObj;
  late ModifyConveyorWaveActionData _data;

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
        objClass: 'ModifyConveyorWaveActionProps',
        objData: ModifyConveyorWaveActionData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = ModifyConveyorWaveActionData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = ModifyConveyorWaveActionData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  String _wrapRtid(String plantId) => 'RTID($plantId@PlantTypes)';
  String _unwrapRtid(String rtid) =>
      RtidParser.parse(rtid)?.alias ?? rtid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';
    final hasConveyor = widget.levelFile.objects
        .any((o) => o.objClass == 'ConveyorSeedBankProperties');

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
              'Event: Conveyor modify',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Conveyor modify event',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: 'Change conveyor belt configuration during a wave. Add or remove plants.',
                ),
                HelpSectionData(
                  title: 'Add',
                  body: 'Add plants to the conveyor belt.',
                ),
                HelpSectionData(
                  title: 'Remove',
                  body: 'Remove plants from the conveyor belt.',
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
              if (!hasConveyor)
                Card(
                  color: theme.colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: theme.colorScheme.error),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Level has no conveyor module. This event may not work.',
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (!hasConveyor) const SizedBox(height: 16),
              _buildAddListCard(theme),
              const SizedBox(height: 16),
              _buildRemoveListCard(theme),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddListCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add plants',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    widget.onRequestPlantSelection((id) {
                      final rtid = _wrapRtid(id);
                      final existing = _data.addList
                          .indexWhere((p) => p.type == rtid);
                      if (existing >= 0) {
                        _data.addList[existing] = ModifyConveyorPlantData(
                          type: rtid,
                          weight: _data.addList[existing].weight,
                          maxCount: _data.addList[existing].maxCount,
                        );
                      } else {
                        _data.addList.add(ModifyConveyorPlantData(
                          type: rtid,
                          weight: 100,
                          maxCount: 0,
                        ));
                      }
                      _sync();
                    });
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._data.addList.asMap().entries.map((e) {
              final idx = e.key;
              final p = e.value;
              final plantId = _unwrapRtid(p.type);
              final plant = PlantRepository().allPlants
                  .firstWhereOrNull((x) => x.id == plantId);
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: plant?.iconAssetPath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: AssetImageWidget(
                            assetPath: plant!.iconAssetPath!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.eco, color: theme.colorScheme.primary),
                  title: Text(plant?.name ?? plantId),
                  subtitle: Text('Weight: ${p.weight}, Max: ${p.maxCount}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      _data.addList.removeAt(idx);
                      _sync();
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRemoveListCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Remove plants',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    widget.onRequestPlantSelection((id) {
                      final rtid = _wrapRtid(id);
                      if (!_data.removeList.any((r) => r.type == rtid)) {
                        _data.removeList.add(ModifyConveyorRemoveData(type: rtid));
                        _sync();
                      }
                    });
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._data.removeList.asMap().entries.map((e) {
              final idx = e.key;
              final r = e.value;
              final plantId = _unwrapRtid(r.type);
              final plant = PlantRepository().allPlants
                  .firstWhereOrNull((x) => x.id == plantId);
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: plant?.iconAssetPath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: AssetImageWidget(
                            assetPath: plant!.iconAssetPath!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.eco, color: theme.colorScheme.primary),
                  title: Text(plant?.name ?? plantId),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      _data.removeList.removeAt(idx);
                      _sync();
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
