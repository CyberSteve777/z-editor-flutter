import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/l10n/app_localizations.dart';

class IZombieTab extends StatefulWidget {
  const IZombieTab({
    super.key,
    required this.levelFile,
    required this.onChanged,
  });

  final PvzLevelFile levelFile;
  final VoidCallback onChanged;

  @override
  State<IZombieTab> createState() => _IZombieTabState();
}

class _IZombieTabState extends State<IZombieTab> {
  PvzObject? _evilDaveObj;
  late EvilDavePropertiesData _data;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _evilDaveObj = widget.levelFile.objects
        .where((o) => o.objClass == 'EvilDaveProperties')
        .firstOrNull;

    if (_evilDaveObj != null) {
      try {
        _data = EvilDavePropertiesData.fromJson(_evilDaveObj!.objData);
      } catch (e) {
        _data = EvilDavePropertiesData();
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _saveData() {
    if (_evilDaveObj != null) {
      _evilDaveObj!.objData = _data.toJson();
      widget.onChanged();
    }
  }

  void _updateData(int newDistance) {
    setState(() {
      _data.plantDistance = newDistance;
    });
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_evilDaveObj == null) {
      return Center(
        child: Text(l10n?.noLevelDefinition ?? 'Module not found'),
      );
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildStepper(l10n),
          const SizedBox(height: 16),
          _buildInfoCard(l10n),
        ],
      ),
    );
  }

  Widget _buildStepper(AppLocalizations? l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Plant Reserve Column (PlantDistance)'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _data.plantDistance > 0
                      ? () => _updateData(_data.plantDistance - 1)
                      : null,
                ),
                Text(
                  'Column ${_data.plantDistance}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _data.plantDistance < 9
                      ? () => _updateData(_data.plantDistance + 1)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(AppLocalizations? l10n) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'In I, Zombie mode, preset plants and zombies must be configured in the Level Module (Preset Plants) and Seed Bank respectively.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
