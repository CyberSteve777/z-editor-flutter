import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/repository/zombie_repository.dart';
import 'package:z_editor/data/repository/zombie_properties_repository.dart';
import 'package:z_editor/data/repository/plant_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/theme/app_theme.dart';
import 'package:z_editor/widgets/asset_image.dart';
import 'package:z_editor/widgets/editor_components.dart';
import 'package:z_editor/screens/editor/events/fish_properties_entry_screen.dart';

/// Zombie + fish wave event for submarine levels.
class ZombieFishWaveEventScreen extends StatefulWidget {
  const ZombieFishWaveEventScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.onRequestZombieSelection,
    this.onRequestPlantSelection,
    this.onEditCustomZombie,
    this.onInjectCustomZombie,
    this.onEditCustomFish,
    this.onInjectCustomFish,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final void Function(void Function(String) onSelected) onRequestZombieSelection;
  final void Function(void Function(String) onSelected)? onRequestPlantSelection;
  final void Function(String rtid)? onEditCustomZombie;
  final String? Function(String baseType)? onInjectCustomZombie;
  final void Function(String rtid)? onEditCustomFish;
  final String? Function(String baseFishAlias)? onInjectCustomFish;

  @override
  State<ZombieFishWaveEventScreen> createState() =>
      _ZombieFishWaveEventScreenState();
}

class _ZombieFishWaveEventScreenState extends State<ZombieFishWaveEventScreen> {
  late PvzObject _moduleObj;
  late SpawnZombiesFishWaveActionPropsData _data;
  double _batchLevel = 1;

  bool get _isDeepSeaLawn => LevelParser.isDeepSeaLawnFromFile(widget.levelFile);
  int get _maxRow => _isDeepSeaLawn ? 6 : 5;

  static const _jamOptions = [
    (null, 'None'),
    ('jam_pop', 'Pop'),
    ('jam_rap', 'Rap'),
    ('jam_metal', 'Metal'),
    ('jam_punk', 'Punk'),
    ('jam_8bit', '8-Bit'),
  ];

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
        objClass: 'SpawnZombiesFishWaveActionProps',
        objData: SpawnZombiesFishWaveActionPropsData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = SpawnZombiesFishWaveActionPropsData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = SpawnZombiesFishWaveActionPropsData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  String _resolveBaseTypeName(ZombieSpawnData z) {
    final info = RtidParser.parse(z.type);
    final alias = info?.alias ?? z.type;
    final obj = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (obj != null && obj.objClass == 'ZombieType') {
      final d = obj.objData;
      if (d is Map<String, dynamic> && d['TypeName'] is String) {
        return d['TypeName'] as String;
      }
    }
    return ZombiePropertiesRepository.getTypeNameByAlias(alias);
  }

  bool _isElite(ZombieSpawnData z) =>
      ZombieRepository().isElite(_resolveBaseTypeName(z));

  bool _isCustomZombie(ZombieSpawnData z) {
    final info = RtidParser.parse(z.type);
    return info?.source == 'CurrentLevel';
  }

  List<_CustomZombieOption> _findCompatibleCustomZombies(String baseType) {
    return widget.levelFile.objects
        .where((o) => o.objClass == 'ZombieType')
        .where((o) => o.aliases?.isNotEmpty == true)
        .map((o) {
      try {
        final data = o.objData;
        if (data is Map<String, dynamic> && data['TypeName'] == baseType) {
          final alias = o.aliases!.first;
          return _CustomZombieOption(
            alias: alias,
            rtid: RtidParser.build(alias, 'CurrentLevel'),
          );
        }
      } catch (_) {}
      return null;
    }).whereType<_CustomZombieOption>().toList();
  }

  void _showCustomZombieSwapDialog(
    BuildContext context, {
    required List<_CustomZombieOption> options,
    required String currentRtid,
    required ZombieSpawnData zombie,
    required int index,
  }) {
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.selectCustomZombie ?? 'Select custom zombie'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final opt = options[i];
              final isCurrent = opt.rtid == currentRtid;
              return ListTile(
                title: Text(opt.alias),
                trailing: isCurrent
                    ? Text(
                        l10n?.current ?? 'Current',
                        style: Theme.of(ctx).textTheme.bodySmall?.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                      )
                    : null,
                onTap: () {
                  _updateZombie(
                    index,
                    ZombieSpawnData(
                      type: opt.rtid,
                      row: zombie.row,
                      level: zombie.level,
                      direction: zombie.direction == 'left' ? 'left' : null,
                    ),
                  );
                  Navigator.pop(ctx);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
        ],
      ),
    );
  }

  void _addZombie({int? row}) {
    widget.onRequestZombieSelection((id) {
      final aliases = ZombieRepository().buildZombieAliases(id);
      final rtid = RtidParser.build(aliases, 'ZombieTypes');
      final zombies = List<ZombieSpawnData>.from(_data.zombies)
        ..add(ZombieSpawnData(type: rtid, level: 1, row: row));
      _data = SpawnZombiesFishWaveActionPropsData(
        notificationEvents: _data.notificationEvents,
        additionalPlantFood: _data.additionalPlantFood,
        spawnPlantName: _data.spawnPlantName,
        zombies: zombies,
        fishes: _data.fishes,
      );
      _sync();
    });
  }

  void _updateZombie(int index, ZombieSpawnData z) {
    final zombies = List<ZombieSpawnData>.from(_data.zombies);
    zombies[index] = z;
    _data = SpawnZombiesFishWaveActionPropsData(
      notificationEvents: _data.notificationEvents,
      additionalPlantFood: _data.additionalPlantFood,
      spawnPlantName: _data.spawnPlantName,
      zombies: zombies,
      fishes: _data.fishes,
    );
    _sync();
  }

  void _removeZombie(int index) {
    final zombies = List<ZombieSpawnData>.from(_data.zombies)..removeAt(index);
    _data = SpawnZombiesFishWaveActionPropsData(
      notificationEvents: _data.notificationEvents,
      additionalPlantFood: _data.additionalPlantFood,
      spawnPlantName: _data.spawnPlantName,
      zombies: zombies,
      fishes: _data.fishes,
    );
    _sync();
  }

  void _openFishProperties() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FishPropertiesEntryScreen(
          levelFile: widget.levelFile,
          fishes: _data.fishes,
          onChanged: (newFishes) {
            _data = SpawnZombiesFishWaveActionPropsData(
              notificationEvents: _data.notificationEvents,
              additionalPlantFood: _data.additionalPlantFood,
              spawnPlantName: _data.spawnPlantName,
              zombies: _data.zombies,
              fishes: newFishes,
            );
            _sync();
          },
          onBack: () => Navigator.pop(context),
          onEditCustomFish: widget.onEditCustomFish,
          onInjectCustomFish: widget.onInjectCustomFish,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';
    final hasFishes = _data.fishes.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.onBack),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n?.editAlias(alias) ?? 'Edit $alias'),
            Text(
              l10n?.eventZombieFishWave ?? 'Zombie Fish Wave',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: l10n?.eventZombieFishWave ?? 'Zombie Fish Wave',
              sections: [
                HelpSectionData(
                  title: l10n?.overview ?? 'Overview',
                  body: l10n?.eventHelpZombieFishWaveBody ?? '',
                ),
                HelpSectionData(
                  title: l10n?.fishPropertiesGrid ?? 'Fish placement',
                  body: l10n?.eventHelpZombieFishWaveFish ?? '',
                ),
                HelpSectionData(
                  title: l10n?.batchLevel ?? 'Batch level',
                  body: l10n?.eventHelpBatchLevel ?? 'Set level for all non-elite zombies in this wave.',
                ),
                HelpSectionData(
                  title: l10n?.backgroundMusicLevelJam ?? 'Level Jam',
                  body: l10n?.onlyAppliesRockEra ?? 'Only applies to Rock era maps.',
                ),
                HelpSectionData(
                  title: l10n?.dropConfigPlantFood ?? 'Drop config',
                  body: l10n?.eventHelpDropConfig ?? 'Plant food or plant cards carried by zombies.',
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
              Text(
                l10n?.zombieList ?? 'Zombies',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(_maxRow, (row) {
                final rowVal = row + 1;
                final zombies = _data.zombies
                    .asMap()
                    .entries
                    .where((e) => (e.value.row ?? 0) == rowVal)
                    .toList();
                return _buildLaneRow(
                  context,
                  theme,
                  l10n,
                  label: '${l10n?.row ?? "Row"} $rowVal',
                  rowValue: rowVal,
                  zombies: zombies,
                );
              }),
              _buildLaneRow(
                context,
                theme,
                l10n,
                label: l10n?.randomRow ?? 'Random row',
                rowValue: 0,
                zombies: _data.zombies
                    .asMap()
                    .entries
                    .where((e) => (e.value.row ?? 0) == 0)
                    .toList(),
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              _buildNotificationCard(theme, l10n),
              const SizedBox(height: 16),
              _buildBatchLevelCard(theme, l10n),
              const SizedBox(height: 16),
              _buildDropConfigCard(context, theme, l10n),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pets, color: theme.colorScheme.secondary),
                          const SizedBox(width: 8),
                          Text(
                            l10n?.fishPropertiesButton ?? 'Fish properties',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: _openFishProperties,
                        icon: Icon(hasFishes ? Icons.edit : Icons.add),
                        label: Text(
                          hasFishes
                              ? (l10n?.editFishProperties ?? 'Edit fish properties')
                              : (l10n?.addFishProperties ?? 'Add fish properties'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _applyBatchLevel() {
    final level = _batchLevel.round();
    final zombies = _data.zombies.map((z) {
      if (_isElite(z)) {
        return ZombieSpawnData(type: z.type, row: z.row, level: null);
      }
      return ZombieSpawnData(type: z.type, row: z.row, level: level);
    }).toList();
    _data = SpawnZombiesFishWaveActionPropsData(
      notificationEvents: _data.notificationEvents,
      additionalPlantFood: _data.additionalPlantFood,
      spawnPlantName: _data.spawnPlantName,
      zombies: zombies,
      fishes: _data.fishes,
    );
    _sync();
  }

  void _updateNotificationEvent(String? value) {
    final list = value == null ? null : <String>[value];
    _data = SpawnZombiesFishWaveActionPropsData(
      notificationEvents: list,
      additionalPlantFood: _data.additionalPlantFood,
      spawnPlantName: _data.spawnPlantName,
      zombies: _data.zombies,
      fishes: _data.fishes,
    );
    _sync();
  }

  void _updateAdditionalPlantFood(int count) {
    final plants = _data.spawnPlantName ?? [];
    final newPlants = count <= plants.length
        ? plants.take(count).toList()
        : [...plants, ...List.filled(count - plants.length, 'sunflower')];
    _data = SpawnZombiesFishWaveActionPropsData(
      notificationEvents: _data.notificationEvents,
      additionalPlantFood: count,
      spawnPlantName: newPlants.isEmpty ? null : newPlants,
      zombies: _data.zombies,
      fishes: _data.fishes,
    );
    _sync();
  }

  void _addSpawnPlant(String id) {
    final plants = List<String>.from(_data.spawnPlantName ?? []);
    plants.add(id);
    _data = SpawnZombiesFishWaveActionPropsData(
      notificationEvents: _data.notificationEvents,
      additionalPlantFood: (_data.additionalPlantFood ?? 0) + 1,
      spawnPlantName: plants,
      zombies: _data.zombies,
      fishes: _data.fishes,
    );
    _sync();
  }

  void _removeSpawnPlantAt(int index) {
    final plants = List<String>.from(_data.spawnPlantName ?? []);
    plants.removeAt(index);
    _data = SpawnZombiesFishWaveActionPropsData(
      notificationEvents: _data.notificationEvents,
      additionalPlantFood: (plants.length) > 0 ? plants.length : null,
      spawnPlantName: plants.isEmpty ? null : plants,
      zombies: _data.zombies,
      fishes: _data.fishes,
    );
    _sync();
  }

  Widget _buildNotificationCard(ThemeData theme, AppLocalizations? l10n) {
    final current = _data.notificationEvents?.isNotEmpty == true
        ? _data.notificationEvents!.first
        : null;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.music_note, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  l10n?.backgroundMusicLevelJam ?? 'Background music (LevelJam)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              value: current,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _jamOptions
                  .map(
                    (e) => DropdownMenuItem<String?>(
                      value: e.$1,
                      child: Text(e.$2),
                    ),
                  )
                  .toList(),
              onChanged: _updateNotificationEvent,
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.onlyAppliesRockEra ?? 'Only applies to Rock era maps.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatchLevelCard(ThemeData theme, AppLocalizations? l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.layers, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  l10n?.batchLevel ?? 'Batch level',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_batchLevel.round()}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _batchLevel,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _batchLevel.round().toString(),
                    onChanged: (v) => setState(() => _batchLevel = v),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(l10n?.applyBatchLevel ?? 'Apply batch level?'),
                        content: Text(
                          l10n?.applyBatchLevelContent(_batchLevel.round()) ??
                              'Set all zombies in this wave to level ${_batchLevel.round()} (elite unchanged).',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: Text(l10n?.cancel ?? 'Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: Text(l10n?.apply ?? 'Apply'),
                          ),
                        ],
                      ),
                    );
                    if (ok == true) _applyBatchLevel();
                  },
                  child: Text(l10n?.apply ?? 'Apply'),
                ),
              ],
            ),
            Text(
              l10n?.appliesToAllNonElite ??
                  'Applies to all non-elite zombies in this wave.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropConfigCard(
      BuildContext context, ThemeData theme, AppLocalizations? l10n) {
    final count = _data.additionalPlantFood ?? 0;
    final plants = List<String>.from(_data.spawnPlantName ?? []);
    final isDroppingPlants = plants.length == count && plants.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.eco, color: theme.colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  isDroppingPlants
                      ? (l10n?.dropConfigPlants ?? 'Drop config (Plants)')
                      : (l10n?.dropConfigPlantFood ?? 'Drop config (Plant Food)'),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed:
                      count > 0 ? () => _updateAdditionalPlantFood(count - 1) : null,
                ),
                Text('$count'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _updateAdditionalPlantFood(count + 1),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isDroppingPlants
                        ? (l10n?.zombiesCarryingPlants ?? 'Zombies carrying plants')
                        : (l10n?.zombiesCarryingPlantFood ??
                            'Zombies carrying plant food'),
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (plants.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: plants.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final id = entry.value;
                  final info = PlantRepository().getPlantInfoById(id);
                  final name = info?.name ?? id;
                  final iconPath = info?.iconAssetPath;
                  return InputChip(
                    label: Text(ResourceNames.lookup(context, name)),
                    avatar: iconPath != null
                        ? ClipOval(
                            child: AssetImageWidget(
                              assetPath: iconPath,
                              altCandidates: imageAltCandidates(iconPath),
                              width: 20,
                              height: 20,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.local_florist, size: 16),
                    onDeleted: () => _removeSpawnPlantAt(idx),
                  );
                }).toList(),
              ),
            if (widget.onRequestPlantSelection != null) ...[
              const SizedBox(height: 8),
              InputChip(
                avatar: Icon(
                  Icons.add_circle_outline,
                  size: 18,
                  color: theme.colorScheme.primary,
                ),
                label: Text(l10n?.addPlant ?? 'Add plant'),
                onPressed: () {
                  widget.onRequestPlantSelection!.call((id) {
                    _addSpawnPlant(id);
                  });
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLaneRow(
    BuildContext context,
    ThemeData theme,
    AppLocalizations? l10n, {
    required String label,
    required int rowValue,
    required List<MapEntry<int, ZombieSpawnData>> zombies,
    Color? color,
  }) {
    final laneColor = color ?? theme.colorScheme.primary;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: laneColor,
                  ),
                ),
                const Spacer(),
                Text('${zombies.length}', style: theme.textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...zombies.map((entry) {
                  final idx = entry.key;
                  final z = entry.value;
                  final baseType = _resolveBaseTypeName(z);
                  final info = ZombieRepository().getZombieById(baseType);
                  final iconPath = info?.iconAssetPath;
                  final isElite = _isElite(z);
                  return ZombieIconCard(
                    iconPath: iconPath,
                    levelDisplay: isElite ? 'E' : '${z.level ?? 1}',
                    isElite: isElite,
                    isCustom: _isCustomZombie(z),
                    onTap: () => _showZombieEditSheet(idx, z),
                  );
                }),
                PvzAddButton(
                  onPressed: () => _addZombie(row: rowValue == 0 ? null : rowValue),
                  useSecondaryColor: rowValue == 0,
                  size: 56,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showZombieEditSheet(int index, ZombieSpawnData zombie) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final baseType = _resolveBaseTypeName(zombie);
    final info = ZombieRepository().getZombieById(baseType);
    final isCustom = _isCustomZombie(zombie);
    final compatibleCustom = _findCompatibleCustomZombies(baseType)
        .where((opt) => opt.rtid != zombie.type)
        .toList();
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        int rowValue = zombie.row ?? 0;
        int levelValue = zombie.level ?? 1;
        bool fromLeft = zombie.direction == 'left';
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (info?.iconAssetPath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AssetImageWidget(
                              assetPath: info!.iconAssetPath!,
                              altCandidates: imageAltCandidates(info.iconAssetPath!),
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  info != null
                                      ? ResourceNames.lookup(context, info.name)
                                      : baseType,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isCustom) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: pvzOrangeLight,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    l10n?.customLabel ?? 'Custom',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      value: rowValue.clamp(0, _maxRow),
                      decoration: const InputDecoration(
                        labelText: 'Row',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(value: 0, child: Text(l10n?.random ?? 'Random')),
                        ...List.generate(_maxRow, (i) => i + 1)
                            .map((v) => DropdownMenuItem(value: v, child: Text('$v'))),
                      ],
                      onChanged: (v) {
                        if (v == null) return;
                        setModalState(() => rowValue = v);
                        _updateZombie(index, ZombieSpawnData(
                          type: zombie.type,
                          row: v == 0 ? null : v,
                          level: levelValue,
                          direction: fromLeft ? 'left' : null,
                        ));
                      },
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      title: Text(l10n?.zombieFromLeft ?? 'From left'),
                      value: fromLeft,
                      onChanged: (v) {
                        setModalState(() => fromLeft = v);
                        _updateZombie(index, ZombieSpawnData(
                          type: zombie.type,
                          row: rowValue == 0 ? null : rowValue,
                          level: levelValue,
                          direction: v ? 'left' : null,
                        ));
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              final copy = ZombieSpawnData(
                                type: zombie.type,
                                row: rowValue == 0 ? null : rowValue,
                                level: levelValue,
                                direction: fromLeft ? 'left' : null,
                              );
                              _data = SpawnZombiesFishWaveActionPropsData(
                                notificationEvents: _data.notificationEvents,
                                additionalPlantFood: _data.additionalPlantFood,
                                spawnPlantName: _data.spawnPlantName,
                                zombies: [..._data.zombies, copy],
                                fishes: _data.fishes,
                              );
                              _sync();
                              Navigator.pop(ctx);
                            },
                            icon: const Icon(Icons.copy),
                            label: Text(l10n?.copy ?? 'Copy'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.error,
                            ),
                            onPressed: () {
                              _removeZombie(index);
                              Navigator.pop(ctx);
                            },
                            icon: const Icon(Icons.delete),
                            label: Text(l10n?.delete ?? 'Delete'),
                          ),
                        ),
                      ],
                    ),
                    if (compatibleCustom.isNotEmpty ||
                        (isCustom && widget.onEditCustomZombie != null) ||
                        (!isCustom && widget.onInjectCustomZombie != null)) ...[
                      const SizedBox(height: 8),
                      Builder(
                        builder: (ctx) {
                          final isDark =
                              Theme.of(ctx).brightness == Brightness.dark;
                          final primaryYellow =
                              isDark ? pvzYellowDark : pvzYellowLight;
                          final secondaryYellow =
                              isDark ? pvzYellowDarkMuted : pvzYellowLightMuted;
                          return Row(
                            children: [
                              if (compatibleCustom.isNotEmpty)
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      _showCustomZombieSwapDialog(
                                        context,
                                        options: compatibleCustom,
                                        currentRtid: zombie.type,
                                        zombie: zombie,
                                        index: index,
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: secondaryYellow,
                                      side: BorderSide(color: secondaryYellow),
                                    ),
                                    icon: const Icon(Icons.swap_horiz),
                                    label: Text(
                                      '${l10n?.switchCustomZombie ?? 'Switch'} (${compatibleCustom.length})',
                                    ),
                                  ),
                                ),
                              if (compatibleCustom.isNotEmpty &&
                                  ((isCustom &&
                                          widget.onEditCustomZombie != null) ||
                                      (!isCustom &&
                                          widget.onInjectCustomZombie != null)))
                                const SizedBox(width: 8),
                              if (isCustom &&
                                  widget.onEditCustomZombie != null)
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      widget.onEditCustomZombie!(zombie.type);
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: primaryYellow,
                                      foregroundColor: Colors.black87,
                                    ),
                                    icon: const Icon(Icons.edit),
                                    label: Text(
                                      l10n?.editCustomZombieProperties ??
                                          l10n?.editProperties ??
                                          'Edit properties',
                                    ),
                                  ),
                                )
                              else if (!isCustom &&
                                  widget.onInjectCustomZombie != null)
                                Expanded(
                                  child: FilledButton.icon(
                                    onPressed: () {
                                      final newRtid =
                                          widget.onInjectCustomZombie!(baseType);
                                      if (newRtid != null) {
                                        _updateZombie(
                                          index,
                                          ZombieSpawnData(
                                            type: newRtid,
                                            row: zombie.row,
                                            level: zombie.level,
                                            direction: zombie.direction == 'left'
                                                ? 'left'
                                                : null,
                                          ),
                                        );
                                      }
                                      Navigator.pop(ctx);
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: primaryYellow,
                                      foregroundColor: Colors.black87,
                                    ),
                                    icon: const Icon(Icons.build),
                                    label: Text(
                                      l10n?.makeZombieAsCustom ??
                                          l10n?.makeCustom ??
                                          'Make custom',
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _CustomZombieOption {
  const _CustomZombieOption({
    required this.alias,
    required this.rtid,
  });

  final String alias;
  final String rtid;
}
