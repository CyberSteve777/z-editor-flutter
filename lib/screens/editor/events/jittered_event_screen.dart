import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/screens/editor/events/zombie_spawn_event_screen.dart';

/// Jittered / standard zombie spawn event. Wraps ZombieSpawnEventScreen.
class JitteredEventScreen extends StatelessWidget {
  const JitteredEventScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.onChanged,
    required this.onBack,
    required this.onRequestZombieSelection,
    this.onRequestPlantSelection,
    this.onEditCustomZombie,
    this.onInjectCustomZombie,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final VoidCallback onChanged;
  final VoidCallback onBack;
  final void Function(void Function(String) onSelected) onRequestZombieSelection;
  final void Function(void Function(String) onSelected)? onRequestPlantSelection;
  final void Function(String rtid)? onEditCustomZombie;
  final String? Function(String alias)? onInjectCustomZombie;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ZombieSpawnEventScreen(
      rtid: rtid,
      levelFile: levelFile,
      onChanged: onChanged,
      onBack: onBack,
      eventSubtitle: l10n?.eventTitle_SpawnZombiesJitteredWaveActionProps ?? 'Jittered Event',
      isGroundSpawner: false,
      onRequestZombieSelection: onRequestZombieSelection,
      onRequestPlantSelection: onRequestPlantSelection,
      onEditCustomZombie: onEditCustomZombie,
      onInjectCustomZombie: onInjectCustomZombie,
    );
  }
}
