import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/zomboss_repository.dart';
import 'package:z_editor/screens/editor/modules/zomboss_selection_screen.dart';
import 'package:z_editor/widgets/asset_image.dart';

class ZombossBattleTab extends StatefulWidget {
  const ZombossBattleTab({
    super.key,
    required this.levelFile,
    required this.onChanged,
  });

  final PvzLevelFile levelFile;
  final VoidCallback onChanged;

  @override
  State<ZombossBattleTab> createState() => _ZombossBattleTabState();
}

class _ZombossBattleTabState extends State<ZombossBattleTab> {
  PvzObject? _battleObj;
  PvzObject? _introObj;
  late ZombossBattleModuleData _battleData;
  late ZombossBattleIntroData? _introData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _battleObj = widget.levelFile.objects
        .where((o) => o.objClass == 'ZombossBattleModuleProperties')
        .firstOrNull;
    _introObj = widget.levelFile.objects
        .where((o) => o.objClass == 'ZombossBattleIntroProperties')
        .firstOrNull;

    if (_battleObj != null) {
      if (_battleObj!.objData is Map) {
         _battleData = ZombossBattleModuleData.fromJson(_battleObj!.objData);
      } else {
         _battleData = ZombossBattleModuleData();
      }
    } else {
      _battleData = ZombossBattleModuleData(); // Should not happen if tab is enabled
    }

    if (_introObj != null) {
       if (_introObj!.objData is Map) {
         _introData = ZombossBattleIntroData.fromJson(_introObj!.objData);
       } else {
         _introData = ZombossBattleIntroData();
       }
    } else {
      _introData = null;
    }
  }

  void _saveData() {
    if (_battleObj != null) {
      _battleObj!.objData = _battleData.toJson();
    }
    if (_introObj != null && _introData != null) {
      _introObj!.objData = _introData!.toJson();
    }
    widget.onChanged();
  }

  void _onZombossChanged(String newType) {
    final newInfo = ZombossRepository.get(newType);
    if (newInfo == null) return;

    final newPhaseCount = newInfo.defaultPhaseCount;
    LocationData? newSpawnPosition;

    const noSpawnPos = [
      "zombossmech_pvz1_robot_hard", "zombossmech_pvz1_robot_normal", "zombossmech_pvz1_robot_1",
      "zombossmech_pvz1_robot_2", "zombossmech_pvz1_robot_3", "zombossmech_pvz1_robot_4",
      "zombossmech_pvz1_robot_5", "zombossmech_pvz1_robot_6", "zombossmech_pvz1_robot_7",
      "zombossmech_pvz1_robot_8", "zombossmech_pvz1_robot_9"
    ];

    const specificSpawnPos = [
      "zombossmech_iceage", "zombossmech_eighties", "zombossmech_renai", "zombossmech_modern_iceage",
      "zombossmech_modern_eighties", "zombossmech_iceage_vacation", "zombossmech_eighties_vacation",
      "zombossmech_iceage_12th", "zombossmech_eighties_12th", "zombossmech_renai_12th"
    ];

    if (noSpawnPos.contains(newType)) {
      newSpawnPosition = LocationData(x: 0, y: 0);
    } else if (specificSpawnPos.contains(newType)) {
      newSpawnPosition = LocationData(x: 6, y: 4);
    } else {
      newSpawnPosition = LocationData(x: 6, y: 3);
    }

    setState(() {
      _battleData.zombossMechType = newType;
      _battleData.zombossStageCount = newPhaseCount;
      if (!noSpawnPos.contains(newType)) {
          // Update spawn position if not PVZ1 robot (which doesn't use it?)
          // Actually Kotlin implementation sets it to null for PVZ1 robots, 
          // but LocationData is non-nullable in Dart model usually.
          // Let's check model definition.
          // In pvz_models.dart: LocationData zombossSpawnGridPosition; (non-nullable in class, but json parsing handles it)
          // Wait, the constructor has default LocationData().
          // If Kotlin sets it to null, maybe we should set it to LocationData(0,0) or similar?
          // Actually the Kotlin code sets it to null, but Dart model requires non-null.
          // Let's just update it if it's not null in logic.
           _battleData.zombossSpawnGridPosition = newSpawnPosition!;
      }
      
      if (_introData != null) {
        _introData!.zombossPhaseCount = newPhaseCount;
      }
    });
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    if (_battleObj == null) {
       return const Center(child: Text('Missing ZombossBattleModuleProperties'));
    }

    final theme = Theme.of(context);
    final currentBossInfo = ZombossRepository.get(_battleData.zombossMechType);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (_introObj == null)
          Card(
            color: theme.colorScheme.errorContainer,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.warning, color: theme.colorScheme.onErrorContainer),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Missing Intro Module', // TODO: Localize
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onErrorContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Level is missing ZombossBattleIntroProperties. Please add it.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        Text(
          'Zomboss Type', // TODO: Localize
          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 8),
        Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ZombossSelectionScreen(
                    onSelected: (id) {
                      _onZombossChanged(id);
                      Navigator.pop(context);
                    },
                    onBack: () => Navigator.pop(context),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: currentBossInfo?.icon != null
                        ? AssetImageWidget(
                            assetPath: 'assets/images/zombies/${currentBossInfo!.icon}',
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.warning_amber,
                            color: theme.colorScheme.outline,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentBossInfo?.name ?? 'Unknown Zomboss',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _battleData.zombossMechType,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.edit),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Parameters', // TODO: Localize
          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 8),
        _StepperControl(
          label: 'Reserved Column Count', // TODO: Localize
          value: _battleData.reservedColumnCount,
          onChanged: (val) {
             setState(() => _battleData.reservedColumnCount = val);
             _saveData();
          },
          min: 0,
          max: 9,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: Text(
            'Columns reserved from the right where plants cannot be planted.',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _StepperControl extends StatelessWidget {
  const _StepperControl({
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyLarge)),
        IconButton(
          onPressed: value > min ? () => onChanged(value - 1) : null,
          icon: const Icon(Icons.remove_circle_outline),
        ),
        Text('$value', style: Theme.of(context).textTheme.titleMedium),
        IconButton(
          onPressed: value < max ? () => onChanged(value + 1) : null,
          icon: const Icon(Icons.add_circle_outline),
        ),
      ],
    );
  }
}
