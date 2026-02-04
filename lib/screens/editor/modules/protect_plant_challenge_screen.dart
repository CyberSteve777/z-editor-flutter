import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/screens/select/plant_selection_screen.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Protect-the-plant challenge. Ported from ProtectThePlantChallengePropertiesEP.kt
class ProtectPlantChallengeScreen extends StatefulWidget {
  const ProtectPlantChallengeScreen({
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
  State<ProtectPlantChallengeScreen> createState() =>
      _ProtectPlantChallengeScreenState();
}

class _ProtectPlantChallengeScreenState
    extends State<ProtectPlantChallengeScreen> {
  late PvzObject _moduleObj;
  late ProtectThePlantChallengePropertiesData _data;
  int _selectedX = 0;
  int _selectedY = 0;

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
        objClass: 'ProtectThePlantChallengeProperties',
        objData: ProtectThePlantChallengePropertiesData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = ProtectThePlantChallengePropertiesData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = ProtectThePlantChallengePropertiesData();
    }
  }

  void _sync() {
    _data.mustProtectCount = _data.plants.length;
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _addPlant() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlantSelectionScreen(
          isMultiSelect: false,
          onPlantSelected: (id) {
            Navigator.pop(context);
            final list = List<ProtectPlantData>.from(_data.plants)
              ..removeWhere((e) => e.gridX == _selectedX && e.gridY == _selectedY)
              ..add(ProtectPlantData(
                gridX: _selectedX,
                gridY: _selectedY,
                plantType: id,
              ));
            _data = ProtectThePlantChallengePropertiesData(plants: list);
            _sync();
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _removePlant(ProtectPlantData plant) {
    final list = List<ProtectPlantData>.from(_data.plants)..remove(plant);
    _data = ProtectThePlantChallengePropertiesData(plants: list);
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sorted = List<ProtectPlantData>.from(_data.plants)
      ..sort((a, b) {
        final c = a.gridY.compareTo(b.gridY);
        return c != 0 ? c : a.gridX.compareTo(b.gridX);
      });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Protect plants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Protect plants',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: 'Plants listed here must survive; losing them fails the level.',
                ),
                HelpSectionData(
                  title: 'Auto count',
                  body: 'The required count follows the number of listed plants.',
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
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.info, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Plant levels follow global level definitions. Seed bank levels are overridden.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
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
                          onPressed: _addPlant,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add plant'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildGrid(theme),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Protected list',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            ...sorted.map((p) => _PlantListTile(
                  plant: p,
                  onDelete: () => _removePlant(p),
                  onSelect: () => setState(() {
                    _selectedX = p.gridX;
                    _selectedY = p.gridY;
                  }),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(ThemeData theme) {
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
              border: Border.all(color: const Color(0xFFA5D6A7), width: 1),
            ),
            child: Column(
              children: List.generate(5, (row) {
                return Expanded(
                  child: Row(
                    children: List.generate(9, (col) {
                      final isSelected = row == _selectedY && col == _selectedX;
                      final plant = _data.plants.firstWhereOrNull(
                        (p) => p.gridX == col && p.gridY == row,
                      );
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
                                  ? theme.colorScheme.primary
                                      .withValues(alpha: 0.2)
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : const Color(0xFFA5D6A7),
                                width: 0.5,
                              ),
                            ),
                            child: plant != null
                                ? Center(
                                    child: _PlantIconSmall(plant.plantType),
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
        width: 32,
        height: 32,
        fit: BoxFit.cover,
        altCandidates: imageAltCandidates(path),
      ),
    );
  }
}

class _PlantListTile extends StatelessWidget {
  const _PlantListTile({
    required this.plant,
    required this.onDelete,
    required this.onSelect,
  });

  final ProtectPlantData plant;
  final VoidCallback onDelete;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final info = PlantRepository().getPlantInfoById(plant.plantType);
    final path = info?.icon != null
        ? 'assets/images/plants/${info!.icon}'
        : 'assets/images/others/unknown.webp';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onSelect,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AssetImageWidget(
            assetPath: path,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            altCandidates: imageAltCandidates(path),
          ),
        ),
        title: Text(
          info?.name ?? plant.plantType,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'R${plant.gridY + 1}:C${plant.gridX + 1}',
          style: theme.textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
