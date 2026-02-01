import 'package:flutter/material.dart';
import 'package:z_editor/data/plant_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/widgets/asset_image.dart';

/// Plant selection. Ported from Z-Editor-master PlantSelectionScreen.kt
class PlantSelectionScreen extends StatefulWidget {
  const PlantSelectionScreen({
    super.key,
    this.isMultiSelect = false,
    required this.onPlantSelected,
    this.onMultiPlantSelected,
    required this.onBack,
  });

  final bool isMultiSelect;
  final void Function(String) onPlantSelected;
  final void Function(List<String>)? onMultiPlantSelected;
  final VoidCallback onBack;

  @override
  State<PlantSelectionScreen> createState() => _PlantSelectionScreenState();
}

class _PlantSelectionScreenState extends State<PlantSelectionScreen> {
  String _searchQuery = '';
  final Set<String> _selectedIds = {};
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    PlantRepository().init().then((_) {
      if (mounted) setState(() => _isLoaded = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final repo = PlantRepository();
    final plants = _searchQuery.isEmpty
        ? repo.allPlants
        : repo.allPlants
            .where((p) =>
                p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                p.id.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.onBack),
        title: Text(l10n?.selectPlant ?? 'Select plant'),
        actions: [
          if (widget.isMultiSelect && _selectedIds.isNotEmpty)
            TextButton(
              onPressed: () {
                widget.onMultiPlantSelected?.call(_selectedIds.toList());
                widget.onBack();
              },
              child: Text(l10n?.done ?? 'Done'),
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: l10n?.searchPlant ?? 'Search plant',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              ),
            ),
          ),
          Expanded(
            child: !_isLoaded
                ? const Center(child: CircularProgressIndicator())
                : plants.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: theme.colorScheme.outline),
                        const SizedBox(height: 16),
                        Text(l10n?.noPlantFound ?? 'No plant found'),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 80,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: plants.length,
                    itemBuilder: (_, i) {
                      final plant = plants[i];
                      final isSelected = _selectedIds.contains(plant.id);
                      return _PlantGridItem(
                        plant: plant,
                        isSelected: isSelected,
                        onTap: () {
                          if (widget.isMultiSelect) {
                            setState(() {
                              if (isSelected) {
                                _selectedIds.remove(plant.id);
                              } else {
                                _selectedIds.add(plant.id);
                              }
                            });
                          } else {
                            widget.onPlantSelected(plant.id);
                            widget.onBack();
                          }
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

class _PlantGridItem extends StatelessWidget {
  const _PlantGridItem({
    required this.plant,
    required this.isSelected,
    required this.onTap,
  });

  final PlantInfo plant;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconPath = plant.iconAssetPath;

    return Material(
      color: isSelected ? theme.colorScheme.primaryContainer : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: iconPath != null
                      ? AssetImageWidget(
                          assetPath: iconPath,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.grass, size: 48, color: theme.colorScheme.outline),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                plant.name,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                plant.id,
                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
