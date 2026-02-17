import 'package:flutter/material.dart';
import 'package:z_editor/data/registry/event_registry.dart';
import 'package:z_editor/l10n/app_localizations.dart';

/// Event selection for wave timeline. Ported from Z-Editor-master EventSelectionScreen.kt
class EventSelectionScreen extends StatelessWidget {
  const EventSelectionScreen({
    super.key,
    required this.waveIndex,
    required this.onEventSelected,
    required this.onBack,
  });

  final int waveIndex;
  final void Function(EventMetadata meta) onEventSelected;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final events = EventRegistry.getAll();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: Text(
          l10n?.addEventForWave(waveIndex) ?? 'Add event for wave $waveIndex',
          style: const TextStyle(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final meta = events[index];
          final isDark = theme.brightness == Brightness.dark;
          final bgColor = isDark ? meta.darkColor : meta.color;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => onEventSelected(meta),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: bgColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(meta.icon, color: bgColor, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getTitle(context, meta, l10n),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getDescription(context, meta, l10n),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getTitle(BuildContext context, EventMetadata meta, AppLocalizations? l10n) {
    return _resolveEventKey(context, meta.titleKey, 'eventTitle_', l10n);
  }

  String _getDescription(BuildContext context, EventMetadata meta, AppLocalizations? l10n) {
    return _resolveEventKey(context, meta.descriptionKey, 'eventDesc_', l10n);
  }

  String _resolveEventKey(BuildContext context, String key, String prefix, AppLocalizations? l10n) {
    if (l10n == null) return key.replaceAll(prefix, '');
    try {
      final name = key.replaceAll(prefix, '');
      final isTitle = prefix == 'eventTitle_';
      switch (name) {
        case 'SpawnZombiesFromGroundSpawnerProps':
          return isTitle ? l10n.eventTitle_SpawnZombiesFromGroundSpawnerProps : l10n.eventDesc_SpawnZombiesFromGroundSpawnerProps;
        case 'SpawnZombiesJitteredWaveActionProps':
          return isTitle ? l10n.eventTitle_SpawnZombiesJitteredWaveActionProps : l10n.eventDesc_SpawnZombiesJitteredWaveActionProps;
        case 'FrostWindWaveActionProps':
          return isTitle ? l10n.eventTitle_FrostWindWaveActionProps : l10n.eventDesc_FrostWindWaveActionProps;
        case 'BeachStageEventZombieSpawnerProps':
          return isTitle ? l10n.eventTitle_BeachStageEventZombieSpawnerProps : l10n.eventDesc_BeachStageEventZombieSpawnerProps;
        case 'TidalChangeWaveActionProps':
          return isTitle ? l10n.eventTitle_TidalChangeWaveActionProps : l10n.eventDesc_TidalChangeWaveActionProps;
        case 'ModifyConveyorWaveActionProps':
          return isTitle ? l10n.eventTitle_ModifyConveyorWaveActionProps : l10n.eventDesc_ModifyConveyorWaveActionProps;
        case 'DinoWaveActionProps':
          return isTitle ? l10n.eventTitle_DinoWaveActionProps : l10n.eventDesc_DinoWaveActionProps;
        case 'SpawnModernPortalsWaveActionProps':
          return isTitle ? l10n.eventTitle_SpawnModernPortalsWaveActionProps : l10n.eventDesc_SpawnModernPortalsWaveActionProps;
        case 'StormZombieSpawnerProps':
          return isTitle ? l10n.eventTitle_StormZombieSpawnerProps : l10n.eventDesc_StormZombieSpawnerProps;
        case 'RaidingPartyZombieSpawnerProps':
          return isTitle ? l10n.eventTitle_RaidingPartyZombieSpawnerProps : l10n.eventDesc_RaidingPartyZombieSpawnerProps;
        case 'ZombiePotionActionProps':
          return isTitle ? l10n.eventTitle_ZombiePotionActionProps : l10n.eventDesc_ZombiePotionActionProps;
        case 'SpawnGravestonesWaveActionProps':
          return isTitle ? l10n.eventTitle_SpawnGravestonesWaveActionProps : l10n.eventDesc_SpawnGravestonesWaveActionProps;
        case 'SpawnZombiesFromGridItemSpawnerProps':
          return isTitle ? l10n.eventTitle_SpawnZombiesFromGridItemSpawnerProps : l10n.eventDesc_SpawnZombiesFromGridItemSpawnerProps;
        case 'FairyTaleFogWaveActionProps':
          return isTitle ? l10n.eventTitle_FairyTaleFogWaveActionProps : l10n.eventDesc_FairyTaleFogWaveActionProps;
        case 'FairyTaleWindWaveActionProps':
          return isTitle ? l10n.eventTitle_FairyTaleWindWaveActionProps : l10n.eventDesc_FairyTaleWindWaveActionProps;
        case 'SpiderRainZombieSpawnerProps':
          return isTitle ? l10n.eventTitle_SpiderRainZombieSpawnerProps : l10n.eventDesc_SpiderRainZombieSpawnerProps;
        case 'ParachuteRainZombieSpawnerProps':
          return isTitle ? l10n.eventTitle_ParachuteRainZombieSpawnerProps : l10n.eventDesc_ParachuteRainZombieSpawnerProps;
        case 'BassRainZombieSpawnerProps':
          return isTitle ? l10n.eventTitle_BassRainZombieSpawnerProps : l10n.eventDesc_BassRainZombieSpawnerProps;
        case 'BlackHoleWaveActionProps':
          return isTitle ? l10n.eventTitle_BlackHoleWaveActionProps : l10n.eventDesc_BlackHoleWaveActionProps;
        case 'MagicMirrorWaveActionProps':
        case 'WaveActionMagicMirrorTeleportationArrayProps':
          return isTitle ? l10n.eventTitle_MagicMirrorWaveActionProps : l10n.eventDesc_MagicMirrorWaveActionProps;
        default:
          return name;
      }
    } catch (_) {
      return key.replaceAll(prefix, '');
    }
  }
}
