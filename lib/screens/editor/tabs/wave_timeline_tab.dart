import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/event_registry.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/wave_point_analysis.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/theme/app_theme.dart';
import 'package:z_editor/widgets/editor_components.dart' show EventChipWidget, isDesktopPlatform;

/// Wave timeline tab with events. Ported from Z-Editor-master WaveTimelineTab.kt
class WaveTimelineTab extends StatefulWidget {
  const WaveTimelineTab({
    super.key,
    required this.levelFile,
    required this.parsed,
    required this.onChanged,
    required this.onEditEvent,
    required this.onAddEvent,
    required this.onEditWaveManagerSettings,
    this.onEditCustomZombie,
    this.openWaveSheetNotifier,
  });

  final PvzLevelFile levelFile;
  final ParsedLevelData parsed;
  final VoidCallback onChanged;
  final Future<void> Function(String rtid, int waveIndex) onEditEvent;
  final void Function(int waveIndex) onAddEvent;
  final VoidCallback onEditWaveManagerSettings;
  final void Function(String rtid)? onEditCustomZombie;
  final ValueNotifier<({int waveIndex, String? rtid})?>? openWaveSheetNotifier;

  @override
  State<WaveTimelineTab> createState() => _WaveTimelineTabState();
}

class _WaveTimelineTabState extends State<WaveTimelineTab> {
  VoidCallback? _notifierListener;

  @override
  void initState() {
    super.initState();
    _notifierListener = () {
      final payload = widget.openWaveSheetNotifier?.value;
      if (payload != null && mounted) {
        widget.openWaveSheetNotifier!.value = null;
        _showWaveManageSheet(context, payload.waveIndex);
      }
    };
    widget.openWaveSheetNotifier?.addListener(_notifierListener!);
  }

  @override
  void didUpdateWidget(covariant WaveTimelineTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.openWaveSheetNotifier != widget.openWaveSheetNotifier) {
      oldWidget.openWaveSheetNotifier?.removeListener(_notifierListener!);
      _notifierListener = () {
        final payload = widget.openWaveSheetNotifier?.value;
        if (payload != null && mounted) {
          widget.openWaveSheetNotifier!.value = null;
          _showWaveManageSheet(context, payload.waveIndex);
        }
      };
      widget.openWaveSheetNotifier?.addListener(_notifierListener!);
    }
  }

  @override
  void dispose() {
    widget.openWaveSheetNotifier?.removeListener(_notifierListener!);
    super.dispose();
  }

  int _pointsAtWave(
    WaveManagerModuleData module,
    int waveIndex,
    bool isFlag,
  ) {
    if (module.dynamicZombies.isEmpty) return 0;
    final g = module.dynamicZombies.first;
    final startEffectWave = g.startingWave + 1;
    if (waveIndex < startEffectWave) return 0;
    var basePoints =
        g.startingPoints + (waveIndex - startEffectWave) * g.pointIncrement;
    if (basePoints > 60000) basePoints = 60000;
    return isFlag ? (basePoints * 2.5).toInt() : basePoints;
  }

  Widget _buildHintCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? usageGuideDarkBg : usageGuideLightBg;
    final onBg = isDark ? Colors.white : usageGuideLightOnBg;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(Icons.lightbulb, color: onBg),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.waveTimelineGuideTitle ?? 'Usage guide',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: onBg,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n?.waveTimelineGuideBody ??
                        'Swipe right: manage wave events\nSwipe left: delete wave\nTap points: view expectation',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: onBg.withValues(alpha: 0.9),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeadLinksCard(BuildContext context, List<String> deadLinks) {
    final l10n = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).colorScheme.error,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.gpp_bad, color: Theme.of(context).colorScheme.onError),
                const SizedBox(width: 8),
                Text(
                  l10n?.waveDeadLinksTitle ?? 'Broken references',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...deadLinks.map(
              (rtid) => Text(
                rtid,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onError,
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () {
                  final wm = widget.parsed.waveManager;
                  if (wm is! WaveManagerData) return;
                  for (final wave in wm.waves) {
                    wave.removeWhere((r) => deadLinks.contains(r));
                  }
                  _syncWaves();
                  setState(() {});
                },
                child: Text(
                  l10n?.waveDeadLinksClear ?? 'Clear dead links',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomZombieCard(
    BuildContext context,
    List<_CustomZombieUsage> customZombies,
  ) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? pvzOrangeDark : pvzOrangeLight;
    // Distinct item backgrounds: light cream/beige so pills don't blend with card
    final itemBg = isDark
        ? const Color(0xFFE8D4C4) // Light beige-orange (matches reference photos)
        : const Color(0xFFFFF5D6); // Warm cream (matches reference photos)
    final onCard = isDark ? Colors.white : Colors.black87;
    final onItem = Colors.black87; // Dark text for readability on light item bg
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: cardBg,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.science, color: onCard),
                const SizedBox(width: 8),
                Text(
                  l10n?.customZombieManagerTitle ?? 'Custom zombie management',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: onCard,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (customZombies.isEmpty)
              Text(
                l10n?.customZombieEmpty ?? 'No custom zombie data',
                style: TextStyle(color: onCard.withValues(alpha: 0.9)),
              )
            else
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: customZombies.map((info) {
                  final icon = info.isUnused ? Icons.warning : Icons.check_circle;
                  final iconColor = info.isUnused
                      ? Colors.amber.shade700
                      : const Color(0xFF2E7D32); // Dark green for ok
                  return Material(
                    color: itemBg,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () => _showCustomZombieSheet(context, info),
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 18, color: iconColor),
                            const SizedBox(width: 8),
                            Text(
                              info.alias,
                              style: TextStyle(
                                color: onItem,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaveManagerSettingsCard(
    BuildContext context,
    int interval,
    double minPercent,
    double maxPercent,
  ) {
    final l10n = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.tune),
        title: Text(
          l10n?.waveManagerGlobalParams ?? 'Wave manager parameters',
        ),
        subtitle: Text(
          l10n?.waveManagerGlobalSummary(
                interval,
                (minPercent * 100).toInt(),
                (maxPercent * 100).toInt(),
              ) ??
              'Flag interval: $interval, health: ${(minPercent * 100).toInt()}% - ${(maxPercent * 100).toInt()}%',
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: widget.onEditWaveManagerSettings,
      ),
    );
  }

  Widget _buildEmptyWaveCard(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              l10n?.waveEmptyTitle ?? 'No waves yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.waveEmptySubtitle ??
                  'Add the first wave, or remove this empty container.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaveHeaderRow(BuildContext context, int total) {
    final l10n = AppLocalizations.of(context);
    final color = Theme.of(context).colorScheme.onSurfaceVariant;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Text('#',
                style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ),
          Expanded(
            child: Text(
              l10n?.waveHeaderPreview ?? 'Content & points preview',
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ),
          Text(
            l10n?.waveTotalLabel(total) ?? 'Total: $total',
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeBackground(
    BuildContext context, {
    required Alignment alignment,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: alignment,
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildWaveRowItem(
    BuildContext context, {
    required int waveIndex,
    required bool isFlagWave,
    required List<String> rtidList,
    required Map<String, PvzObject> objectMap,
    required int points,
    required VoidCallback onInfoClick,
    required VoidCallback? onRowTap,
  }) {
    final l10n = AppLocalizations.of(context);
    final rowContent = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 52,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$waveIndex',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                if (isFlagWave)
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Icon(
                      Icons.flag,
                      size: 12,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: onRowTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (rtidList.isEmpty)
                    Text(
                      l10n?.waveEmptyRowHint ??
                          'Empty wave (swipe left/right)',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    )
                  else
                    ...rtidList.map(
                      (rtid) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: EventChipWidget(
                          rtid: rtid,
                          objectMap: objectMap,
                          onTap: () => _showEventActionSheet(
                            context: context,
                            waveIndex: waveIndex,
                            rtid: rtid,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (points != 0)
          InkWell(
            onTap: onInfoClick,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    '${points}pt',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 2),
                  Icon(
                    Icons.info,
                    size: 14,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
    return Column(
      children: [
        rowContent,
        Divider(height: 1, color: Theme.of(context).colorScheme.surfaceContainerHighest),
      ],
    );
  }

  Map<String, List<int>> _collectCustomZombieWaveUsage() {
    final result = <String, Set<int>>{};
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return {};
    final aliasToObj = <String, PvzObject>{};
    for (final obj in widget.levelFile.objects) {
      if (obj.aliases?.isNotEmpty == true) {
        for (final a in obj.aliases!) {
          aliasToObj[a] = obj;
        }
      }
    }
    for (var i = 0; i < wm.waves.length; i++) {
      final waveIndex = i + 1;
      for (final eventRtid in wm.waves[i]) {
        final alias = LevelParser.extractAlias(eventRtid);
        final obj = aliasToObj[alias];
        if (obj == null) continue;
        final usedAliases = <String>{};
        if (obj.objClass == 'SpawnZombiesJitteredWaveActionProps') {
          try {
            final data = WaveActionData.fromJson(
              Map<String, dynamic>.from(obj.objData as Map),
            );
            for (final z in data.zombies) {
              final info = RtidParser.parse(z.type);
              if (info?.source == 'CurrentLevel') {
                usedAliases.add(info!.alias);
              }
            }
          } catch (_) {}
        } else if (obj.objClass == 'SpawnZombiesFromGroundSpawnerProps') {
          try {
            final data = SpawnZombiesFromGroundData.fromJson(
              Map<String, dynamic>.from(obj.objData as Map),
            );
            for (final z in data.zombies) {
              final info = RtidParser.parse(z.type);
              if (info?.source == 'CurrentLevel') {
                usedAliases.add(info!.alias);
              }
            }
          } catch (_) {}
        }
        for (final a in usedAliases) {
          final set = result.putIfAbsent(a, () => <int>{});
          set.add(waveIndex);
        }
      }
    }
    return result.map((k, v) => MapEntry(k, (v.toList()..sort())));
  }

  List<_CustomZombieUsage> _collectCustomZombies() {
    final waveUsage = _collectCustomZombieWaveUsage();
    final customObjects = widget.levelFile.objects
        .where((o) => o.objClass == 'ZombieType')
        .where((o) => o.aliases?.isNotEmpty == true)
        .toList();
    return customObjects.map((o) {
      final alias = o.aliases!.first;
      final rtid = RtidParser.build(alias, 'CurrentLevel');
      final waveIndices = waveUsage[alias] ?? [];
      return _CustomZombieUsage(
        alias: alias,
        rtid: rtid,
        isUnused: waveIndices.isEmpty,
        waveIndices: waveIndices,
      );
    }).toList();
  }

  void _showCustomZombieSheet(BuildContext context, _CustomZombieUsage info) {
    final l10n = AppLocalizations.of(context);
    final canDelete = info.isUnused;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              info.alias,
              style: Theme.of(ctx)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              l10n?.customZombieAppearanceLocation ?? 'Appearance location:',
              style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
                    color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              info.waveIndices.isEmpty
                  ? (l10n?.customZombieNotUsed ??
                      'This custom zombie is not used by any wave or module.')
                  : info.waveIndices
                      .map((n) => l10n?.customZombieWaveItem(n) ?? 'Wave $n')
                      .join(', '),
              style: Theme.of(ctx).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            if (widget.onEditCustomZombie != null)
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  widget.onEditCustomZombie!(info.rtid);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(ctx).brightness == Brightness.dark ? pvzYellowDark : pvzYellowLight,
                  foregroundColor: Colors.black87,
                ),
                icon: const Icon(Icons.edit),
                label: Text(l10n?.editProperties ?? 'Edit properties'),
              ),
            if (widget.onEditCustomZombie != null) const SizedBox(height: 8),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(ctx).colorScheme.error,
              ),
              onPressed: canDelete
                  ? () async {
                      Navigator.pop(ctx);
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (dctx) => AlertDialog(
                          title: Text(l10n?.deleteEntity ?? 'Delete entity'),
                          content: Text(
                            l10n?.customZombieDeleteConfirm ??
                                'Remove this custom zombie and its property data.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dctx, false),
                              child: Text(l10n?.cancel ?? 'Cancel'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(dctx, true),
                              child: Text(l10n?.confirm ?? 'Confirm'),
                            ),
                          ],
                        ),
                      );
                      if (ok == true) {
                        _deleteCustomZombie(info);
                      }
                    }
                  : null,
              icon: const Icon(Icons.delete),
              label: Text(l10n?.deleteEntity ?? 'Delete entity'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteCustomZombie(_CustomZombieUsage custom) {
    final typeObj = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(custom.alias) == true,
    );
    if (typeObj != null) {
      final data = typeObj.objData;
      if (data is Map<String, dynamic>) {
        final propsRtid = data['Properties'] as String?;
        final propsInfo = propsRtid != null ? RtidParser.parse(propsRtid) : null;
        if (propsInfo?.source == 'CurrentLevel') {
          widget.levelFile.objects.removeWhere(
            (o) => o.aliases?.contains(propsInfo!.alias) == true,
          );
        }
      }
      widget.levelFile.objects.remove(typeObj);
    }

    for (final obj in widget.levelFile.objects) {
      if (obj.objClass == 'SpawnZombiesJitteredWaveActionProps') {
        try {
          final data = WaveActionData.fromJson(
            Map<String, dynamic>.from(obj.objData as Map),
          );
          final filtered = data.zombies.where((z) {
            final info = RtidParser.parse(z.type);
            return !(info?.source == 'CurrentLevel' &&
                info?.alias == custom.alias);
          }).toList();
          final updated = WaveActionData(
            notificationEvents: data.notificationEvents,
            additionalPlantFood: data.additionalPlantFood,
            spawnPlantName: data.spawnPlantName,
            zombies: filtered,
          );
          obj.objData = updated.toJson();
        } catch (_) {}
      }
      if (obj.objClass == 'SpawnZombiesFromGroundSpawnerProps') {
        try {
          final data = SpawnZombiesFromGroundData.fromJson(
            Map<String, dynamic>.from(obj.objData as Map),
          );
          final filtered = data.zombies.where((z) {
            final info = RtidParser.parse(z.type);
            return !(info?.source == 'CurrentLevel' &&
                info?.alias == custom.alias);
          }).toList();
          final updated = SpawnZombiesFromGroundData(
            columnStart: data.columnStart,
            columnEnd: data.columnEnd,
            additionalPlantFood: data.additionalPlantFood,
            spawnPlantName: data.spawnPlantName,
            zombies: filtered,
          );
          obj.objData = updated.toJson();
        } catch (_) {}
      }
    }
    widget.onChanged();
    setState(() {});
  }

  void _syncWaves() {
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    final wmObj = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.objClass == 'WaveManagerProperties',
    );
    if (wmObj != null) {
      wmObj.objData = wm.toJson();
      widget.onChanged();
    }
  }

  void _addWave() {
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    wm.waves.add(<String>[]);
    wm.waveCount = wm.waves.length;
    _syncWaves();
    setState(() {});
  }

  void _removeEventFromWave(int waveIndex, String rtid) {
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    if (waveIndex <= 0 || waveIndex > wm.waves.length) return;
    wm.waves[waveIndex - 1].remove(rtid);
    _syncWaves();
    setState(() {});
  }

  void _performGlobalRename(String oldRtid, String newAlias) {
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    final oldAlias = LevelParser.extractAlias(oldRtid);
    if (oldAlias == newAlias) return;
    if (widget.levelFile.objects.any((o) => o.aliases?.contains(newAlias) == true)) return;
    final newRtid = RtidParser.build(newAlias, 'CurrentLevel');
    final objIdx = widget.levelFile.objects.indexWhere(
      (o) => o.aliases?.contains(oldAlias) == true,
    );
    if (objIdx >= 0) {
      widget.levelFile.objects[objIdx] = PvzObject(
        aliases: [newAlias],
        objClass: widget.levelFile.objects[objIdx].objClass,
        objData: widget.levelFile.objects[objIdx].objData,
      );
    }
    for (final wave in wm.waves) {
      for (var i = 0; i < wave.length; i++) {
        if (wave[i] == oldRtid) wave[i] = newRtid;
      }
    }
    _syncWaves();
    widget.onChanged();
    setState(() {});
  }

  void _performCopyReference(String rtid, int targetWaveIndex) {
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    if (targetWaveIndex < 1 || targetWaveIndex > wm.waves.length) return;
    final targetIdx = targetWaveIndex - 1;
    wm.waves[targetIdx] = [...wm.waves[targetIdx], rtid];
    _syncWaves();
    setState(() {});
  }

  void _performDeepCopy(String rtid, String newAlias, int targetWaveIndex) {
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    final oldAlias = LevelParser.extractAlias(rtid);
    final obj = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(oldAlias) == true,
    );
    if (obj == null) return;
    if (widget.levelFile.objects.any((o) => o.aliases?.contains(newAlias) == true)) return;
    final newRtid = RtidParser.build(newAlias, 'CurrentLevel');
    final dataCopy = obj.objData is Map
        ? jsonDecode(jsonEncode(obj.objData)) as Map<String, dynamic>
        : obj.objData;
    widget.levelFile.objects.add(PvzObject(
      aliases: [newAlias],
      objClass: obj.objClass,
      objData: dataCopy,
    ));
    if (targetWaveIndex >= 1 && targetWaveIndex <= wm.waves.length) {
      wm.waves[targetWaveIndex - 1] = [...wm.waves[targetWaveIndex - 1], newRtid];
    }
    _syncWaves();
    widget.onChanged();
    setState(() {});
  }

  void _performMove(String rtid, int sourceWaveIndex, int targetWaveIndex) {
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    if (sourceWaveIndex == targetWaveIndex) return;
    final srcIdx = sourceWaveIndex - 1;
    final tgtIdx = targetWaveIndex - 1;
    if (srcIdx < 0 || srcIdx >= wm.waves.length || tgtIdx < 0 || tgtIdx >= wm.waves.length) return;
    wm.waves[srcIdx] = wm.waves[srcIdx].where((r) => r != rtid).toList();
    wm.waves[tgtIdx] = [...wm.waves[tgtIdx], rtid];
    _syncWaves();
    setState(() {});
  }

  void _smartDeleteEvent(int waveIndex, String rtid) {
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    final alias = LevelParser.extractAlias(rtid);
    final allRefs = wm.waves.expand((w) => w).toList();
    final refCount = allRefs.where((r) => r == rtid).length;
    if (refCount > 1) {
      _removeEventFromWave(waveIndex, rtid);
      return;
    }
    for (final wave in wm.waves) {
      wave.removeWhere((r) => r == rtid);
    }
    widget.levelFile.objects
        .removeWhere((o) => o.aliases?.contains(alias) == true);
    _syncWaves();
    setState(() {});
  }

  void _showRenameDialog(
    BuildContext context,
    String rtid,
    String alias,
    VoidCallback? onEditFinished,
  ) {
    final l10n = AppLocalizations.of(context);
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    final ctrl = TextEditingController(text: alias);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.rename ?? 'Rename'),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            labelText: l10n?.newName ?? 'New name',
          ),
          onChanged: (_) {},
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final newAlias = ctrl.text.trim();
              Navigator.pop(ctx);
              if (newAlias.isEmpty) return;
              if (widget.levelFile.objects.any((o) => o.aliases?.contains(newAlias) == true)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n?.renameFail ?? 'Rename failed, alias already exists')),
                );
                return;
              }
              _performGlobalRename(rtid, newAlias);
              onEditFinished?.call();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n?.confirm ?? 'Confirm'),
          ),
        ],
      ),
    );
  }

  void _showCopyChoiceDialog(
    BuildContext context,
    String rtid,
    String alias,
    int waveIndex,
    VoidCallback? onEditFinished,
  ) {
    final l10n = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.copy ?? 'Copy'),
        content: Text(
          l10n?.copyReferenceOrDeep ?? 'Copy reference or make a deep copy?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showCopyTargetWaveDialog(context, rtid, null, waveIndex, onEditFinished);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.primary,
            ),
            child: Text(l10n?.copyReference ?? 'Copy reference'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showDeepCopyNameDialog(context, rtid, alias, waveIndex, onEditFinished);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.primary,
            ),
            child: Text(l10n?.deepCopy ?? 'Deep copy'),
          ),
        ],
      ),
    );
  }

  void _showDeepCopyNameDialog(
    BuildContext context,
    String rtid,
    String alias,
    int waveIndex,
    VoidCallback? onEditFinished,
  ) {
    final l10n = AppLocalizations.of(context);
    final defaultName = '${alias}_copy';
    final ctrl = TextEditingController(text: defaultName);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.deepCopy ?? 'Deep copy'),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            labelText: l10n?.newName ?? 'New name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final newAlias = ctrl.text.trim();
              Navigator.pop(ctx);
              if (newAlias.isEmpty) return;
              if (widget.levelFile.objects.any((o) => o.aliases?.contains(newAlias) == true)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n?.renameFail ?? 'Rename failed, alias already exists')),
                );
                return;
              }
              _showCopyTargetWaveDialog(context, rtid, newAlias, waveIndex, onEditFinished);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n?.confirm ?? 'Confirm'),
          ),
        ],
      ),
    );
  }

  void _showCopyTargetWaveDialog(
    BuildContext context,
    String rtid,
    String? newAlias,
    int sourceWaveIndex,
    VoidCallback? onEditFinished,
  ) {
    final l10n = AppLocalizations.of(context);
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    final ctrl = TextEditingController(text: '1');
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.copyEventTarget ?? 'Target wave'),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            labelText: l10n?.targetWaveIndex ?? 'Target wave index',
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final target = int.tryParse(ctrl.text.trim());
              Navigator.pop(ctx);
              if (target == null || target < 1 || target > wm.waves.length) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n?.invalidWaveIndex ?? 'Invalid wave index')),
                );
                return;
              }
              if (newAlias != null) {
                _performDeepCopy(rtid, newAlias, target);
              } else {
                _performCopyReference(rtid, target);
              }
              onEditFinished?.call();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n?.copy ?? 'Copy'),
          ),
        ],
      ),
    );
  }

  void _showMoveDialog(
    BuildContext context,
    String rtid,
    int waveIndex,
    VoidCallback? onEditFinished,
  ) {
    final l10n = AppLocalizations.of(context);
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    final ctrl = TextEditingController(text: waveIndex.toString());
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.move ?? 'Move'),
        content: TextField(
          controller: ctrl,
          decoration: InputDecoration(
            labelText: l10n?.moveToWaveIndex ?? 'Move to wave index',
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final target = int.tryParse(ctrl.text.trim());
              Navigator.pop(ctx);
              if (target == null || target < 1 || target > wm.waves.length) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n?.invalidWaveIndex ?? 'Invalid wave index')),
                );
                return;
              }
              _performMove(rtid, waveIndex, target);
              onEditFinished?.call();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n?.move ?? 'Move'),
          ),
        ],
      ),
    );
  }

  void _showEventActionSheet({
    required BuildContext context,
    required int waveIndex,
    required String rtid,
    VoidCallback? onEditFinished,
  }) {
    final l10n = AppLocalizations.of(context);
    final alias = LevelParser.extractAlias(rtid);
    final obj = widget.parsed.objectMap[alias];
    final meta = EventRegistry.getByObjClass(obj?.objClass);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (meta != null) ...[
                  Icon(meta.icon, color: meta.color),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    alias,
                    style: Theme.of(ctx)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            if (obj?.objClass != null)
              Text(
                obj!.objClass,
                style: Theme.of(ctx).textTheme.bodySmall,
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      Navigator.pop(ctx);
                      await widget.onEditEvent(rtid, waveIndex);
                      // Do not re-open wave sheet when exiting event editor
                    },
                    icon: const Icon(Icons.edit),
                    label: Text(l10n?.editProperties ?? 'Edit properties'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _showRenameDialog(context, rtid, alias, onEditFinished),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(ctx).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(ctx).brightness == Brightness.dark
                          ? Colors.black
                          : Theme.of(ctx).colorScheme.primary,
                    ),
                    icon: const Icon(Icons.drive_file_rename_outline),
                    label: Text(l10n?.rename ?? 'Rename'),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _showCopyChoiceDialog(context, rtid, alias, waveIndex, onEditFinished),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(ctx).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(ctx).brightness == Brightness.dark
                          ? Colors.black
                          : Theme.of(ctx).colorScheme.primary,
                    ),
                    icon: const Icon(Icons.copy),
                    label: Text(l10n?.copy ?? 'Copy'),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _showMoveDialog(context, rtid, waveIndex, onEditFinished),
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(ctx).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(ctx).brightness == Brightness.dark
                          ? Colors.black
                          : Theme.of(ctx).colorScheme.primary,
                    ),
                    icon: const Icon(Icons.drive_file_move),
                    label: Text(l10n?.move ?? 'Move'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(ctx).colorScheme.error,
                    ),
                    onPressed: () async {
                      Navigator.pop(ctx);
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (dctx) => AlertDialog(
                          title: Text(
                            l10n?.confirmRemoveRef ??
                                'Remove reference',
                          ),
                          content: Text(
                            l10n?.confirmRemoveRefMessage ??
                                'Remove this reference? The entity data will remain until all references are removed.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dctx, false),
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(dctx).colorScheme.primary,
                              ),
                              child: Text(l10n?.cancel ?? 'Cancel'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(dctx, true),
                              style: FilledButton.styleFrom(
                                backgroundColor: Theme.of(dctx).colorScheme.error,
                                foregroundColor: Colors.white,
                              ),
                              child: Text(l10n?.confirmRemoveRef ?? 'Remove reference'),
                            ),
                          ],
                        ),
                      );
                      if (ok == true) {
                        _smartDeleteEvent(waveIndex, rtid);
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    label: Text(l10n?.removeFromWave ?? 'Remove from wave'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showWaveManageSheet(BuildContext context, int waveIndex) {
    final l10n = AppLocalizations.of(context);
    final wm = widget.parsed.waveManager;
    if (wm is! WaveManagerData) return;
    if (waveIndex <= 0 || waveIndex > wm.waves.length) return;
    final rtidList = wm.waves[waveIndex - 1];
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.waveEventsTitle(waveIndex) ??
                  'Wave $waveIndex events',
              style: Theme.of(ctx)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (rtidList.isEmpty)
              Text(
                l10n?.emptyWave ?? 'Empty wave',
                style: Theme.of(ctx).textTheme.bodySmall,
              )
            else
              ...rtidList.map((rtid) {
                final alias = LevelParser.extractAlias(rtid);
                final obj = widget.parsed.objectMap[alias];
                final meta = EventRegistry.getByObjClass(obj?.objClass);
                final color = meta?.color ?? Theme.of(ctx).colorScheme.primary;
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(meta?.icon ?? Icons.event, color: color),
                    title: Text(alias),
                    subtitle: Text(meta?.titleKey ?? 'Unknown event'),
                    onTap: () {
                      Navigator.pop(ctx);
                      _showEventActionSheet(
                        context: context,
                        waveIndex: waveIndex,
                        rtid: rtid,
                        onEditFinished: () =>
                            _showWaveManageSheet(context, waveIndex),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        Navigator.pop(ctx);
                        _smartDeleteEvent(waveIndex, rtid);
                        setState(() {});
                      },
                    ),
                  ),
                );
              }),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      widget.onAddEvent(waveIndex);
                    },
                    icon: const Icon(Icons.add),
                    label: Text(l10n?.addEvent ?? 'Add event'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(ctx).colorScheme.error,
                  foregroundColor: Theme.of(ctx).colorScheme.onError,
                ),
                onPressed: () async {
                  Navigator.pop(ctx);
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (dctx) => AlertDialog(
                      title: Text(
                        (l10n?.deleteWave != null && l10n?.waveLabel != null)
                            ? '${l10n?.deleteWave} ${l10n?.waveLabel} $waveIndex?'
                            : 'Delete Wave $waveIndex?',
                      ),
                      content: Text(
                        l10n?.deleteWaveConfirm(rtidList.length) ??
                            'This will remove this wave and its ${rtidList.length} events.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dctx, false),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(dctx).colorScheme.error,
                          ),
                          child: Text(l10n?.cancel ?? 'Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(dctx, true),
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(dctx).colorScheme.primary,
                          ),
                          child: Text(l10n?.confirm ?? 'Confirm'),
                        ),
                      ],
                    ),
                  );
                  if (ok == true && mounted) {
                    final wm = widget.parsed.waveManager;
                    if (wm is WaveManagerData && waveIndex >= 1 && waveIndex <= wm.waves.length) {
                      wm.waves.removeAt(waveIndex - 1);
                      wm.waveCount = wm.waves.length;
                      _syncWaves();
                      setState(() {});
                    }
                  }
                },
                icon: const Icon(Icons.delete),
                label: Text(l10n?.deleteWave ?? 'Delete wave'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final wm = widget.parsed.waveManager is WaveManagerData
        ? widget.parsed.waveManager as WaveManagerData
        : null;
    final module = widget.parsed.waveModule is WaveManagerModuleData
        ? widget.parsed.waveModule as WaveManagerModuleData
        : null;
    final objectMap = widget.parsed.objectMap;

    if (wm == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox,
                size: 64,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                l10n?.noWaveManager ?? 'No wave manager found',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n?.noWaveManagerHint ??
                    'This level has wave management but no WaveManagerProperties object.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final waves = wm.waves;
    final interval = wm.flagWaveInterval <= 0 ? 10 : wm.flagWaveInterval;

    final deadLinks = wm.waves
        .expand((w) => w)
        .toSet()
        .where((rtid) => !objectMap.containsKey(LevelParser.extractAlias(rtid)))
        .toList();
    final customZombies = _collectCustomZombies();

    return ListView(
      padding: const EdgeInsets.only(bottom: 80),
      children: [
        _buildHintCard(context),
        if (deadLinks.isNotEmpty) _buildDeadLinksCard(context, deadLinks),
        _buildCustomZombieCard(context, customZombies),
        _buildWaveManagerSettingsCard(
          context,
          interval,
          wm.minNextWaveHealthPercentage,
          wm.maxNextWaveHealthPercentage,
        ),
        const SizedBox(height: 16),
        if (waves.isEmpty)
          _buildEmptyWaveCard(context)
        else ...[
          _buildWaveHeaderRow(context, waves.length),
          ...List.generate(waves.length, (index) {
            final waveIndex = index + 1;
            final waveEvents = waves[index];
            final isFlagWave =
                waveIndex % interval == 0 || waveIndex == waves.length;
            final points = module != null
                ? _pointsAtWave(module, waveIndex, isFlagWave)
                : 0;
            final isDesktop = isDesktopPlatform(context);
            final rowWidget = _buildWaveRowItem(
              context,
              waveIndex: waveIndex,
              isFlagWave: isFlagWave,
              rtidList: waveEvents,
              objectMap: objectMap,
              points: points,
              onInfoClick: () =>
                  _showExpectationDialog(context, waveIndex, points),
              onRowTap: isDesktop ? () => _showWaveManageSheet(context, waveIndex) : null,
            );
            if (isDesktop) {
              return rowWidget;
            }
            return Dismissible(
              key: ValueKey('wave_row_$index'),
              direction: DismissDirection.horizontal,
              confirmDismiss: (dir) async {
                if (dir == DismissDirection.startToEnd) {
                  _showWaveManageSheet(context, waveIndex);
                  return false;
                }
                if (dir == DismissDirection.endToStart) {
                  return await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(
                        '${l10n?.deleteWave ?? "Delete"} ${l10n?.waveLabel ?? "Wave"} $waveIndex?',
                      ),
                      content: Text(
                        l10n?.deleteWaveConfirm(waveEvents.length) ??
                            'This will remove this wave and its ${waveEvents.length} events.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(ctx).colorScheme.error,
                          ),
                          child: Text(l10n?.cancel ?? 'Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(ctx).colorScheme.error,
                          ),
                          child: Text(l10n?.delete ?? 'Delete'),
                        ),
                      ],
                    ),
                  );
                }
                return false;
              },
              onDismissed: (dir) {
                if (dir == DismissDirection.endToStart) {
                  wm.waves.removeAt(index);
                  wm.waveCount = wm.waves.length;
                  _syncWaves();
                  setState(() {});
                }
              },
              background: _buildSwipeBackground(
                context,
                alignment: Alignment.centerLeft,
                color: Theme.of(context).colorScheme.primary,
                icon: Icons.settings,
              ),
              secondaryBackground: _buildSwipeBackground(
                context,
                alignment: Alignment.centerRight,
                color: Theme.of(context).colorScheme.error,
                icon: Icons.delete,
              ),
              child: rowWidget,
            );
          }),
        ],
        Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: FilledButton.icon(
              onPressed: _addWave,
              icon: const Icon(Icons.add),
              label: Text(l10n?.addWave ?? 'Add wave'),
            ),
          ),
        ),
      ],
    );
  }

  void _showExpectationDialog(BuildContext context, int waveIndex, int points) {
    final expectation = WavePointAnalysis.calculateExpectation(
      points,
      widget.parsed,
    );
    final sorted = expectation.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final items = sorted.where((e) => e.value > 0).toList();

    showDialog<void>(
      context: context,
      builder: (ctx) {
        final scrollController = ScrollController();
        return AlertDialog(
          title: Text('${AppLocalizations.of(ctx)?.waveLabel ?? "Wave"} $waveIndex ${AppLocalizations.of(ctx)?.expectation ?? "Expectation"}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppLocalizations.of(ctx)?.pointsLabel ?? "Points"}: $points'),
              const SizedBox(height: 16),
              if (items.isEmpty)
                Text(
                  AppLocalizations.of(ctx)?.noDynamicZombies ?? 'No dynamic zombies',
                  style: Theme.of(ctx).textTheme.bodySmall,
                )
              else
                SizedBox(
                  width: 360,
                  height: 320,
                  child: Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.only(right: 14),
                      itemCount: items.length,
                      itemBuilder: (_, i) {
                        final e = items[i];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  e.key,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(e.value.toStringAsFixed(2)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(ctx)?.close ?? 'Close'),
          ),
        ],
      );
    },
    );
  }
}

class _CustomZombieUsage {
  const _CustomZombieUsage({
    required this.alias,
    required this.rtid,
    required this.isUnused,
    required this.waveIndices,
  });

  final String alias;
  final String rtid;
  final bool isUnused;
  final List<int> waveIndices;
}
