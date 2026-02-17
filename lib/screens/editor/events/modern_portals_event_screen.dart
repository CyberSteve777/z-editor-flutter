import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/repository/portal_repository.dart';
import 'package:z_editor/data/repository/zombie_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/widgets/asset_image.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Spawn modern portals event editor. Ported from Z-Editor-master ModernPortalEventEP.kt
class ModernPortalsEventScreen extends StatefulWidget {
  const ModernPortalsEventScreen({
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
  State<ModernPortalsEventScreen> createState() =>
      _ModernPortalsEventScreenState();
}

class _ModernPortalsEventScreenState extends State<ModernPortalsEventScreen> {
  late PvzObject _moduleObj;
  late PortalEventData _data;

  bool get _isDeepSeaLawn {
    final parsed = LevelParser.parseLevel(widget.levelFile);
    return LevelParser.isDeepSeaLawn(parsed.levelDef);
  }

  int get _gridCols => _isDeepSeaLawn ? 10 : 9;
  int get _gridRows => _isDeepSeaLawn ? 6 : 5;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final alias = LevelParser.extractAlias(widget.rtid);
    final existing = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (existing != null) {
      _moduleObj = existing;
    } else {
      _moduleObj = PvzObject(
        aliases: [alias],
        objClass: 'SpawnModernPortalsWaveActionProps',
        objData: PortalEventData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = PortalEventData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = PortalEventData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _showPreviewDialog(BuildContext context, AppLocalizations? l10n, PortalWorldDef def) {
    showDialog(
      context: context,
      builder: (ctx) => _buildPreviewDialog(ctx, l10n, def),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final alias = LevelParser.extractAlias(widget.rtid);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n?.editAlias(alias) ?? 'Edit $alias'),
            Text(
              l10n?.eventTimeRift ?? 'Event: Time rift',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: l10n?.eventTimeRift ?? 'Time rift event',
              sections: [
                HelpSectionData(
                  title: l10n?.overview ?? 'Overview',
                  body: l10n?.eventHelpModernPortalsBody ?? '',
                ),
                HelpSectionData(
                  title: l10n?.portalType ?? 'Portal type',
                  body: l10n?.eventHelpModernPortalsType ?? '',
                ),
                HelpSectionData(
                  title: l10n?.ignoreGravestone ?? 'Ignore gravestone',
                  body: l10n?.eventHelpModernPortalsIgnore ?? '',
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n?.position ?? 'Position',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R${_data.portalRow + 1} : C${_data.portalColumn + 1}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      scaleTableForDesktop(
                        context: context,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: AspectRatio(
                            aspectRatio: _gridCols / _gridRows,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _gridCols,
                                childAspectRatio: 1,
                              ),
                              itemCount: _gridCols * _gridRows,
                              itemBuilder: (context, i) {
                                final col = i % _gridCols;
                                final row = i ~/ _gridCols;
                            final isSelected =
                                row == _data.portalRow && col == _data.portalColumn;
                            return GestureDetector(
                              onTap: () {
                                _data = PortalEventData(
                                  portalType: _data.portalType,
                                  portalColumn: col,
                                  portalRow: row,
                                  spawnEffect: _data.spawnEffect,
                                  spawnSoundID: _data.spawnSoundID,
                                  ignoreGraveStone: _data.ignoreGraveStone,
                                );
                                _sync();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.surfaceContainerHighest,
                                  border: Border.all(
                                    color: theme.colorScheme.outlineVariant,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(
                                        Icons.check,
                                        color: theme.colorScheme.onPrimary,
                                        size: 16,
                                      )
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n?.portalType ?? 'Portal type',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: PortalRepository.portalDefinitions.map((def) {
                          final isSelected =
                              def.typeCode == _data.portalType;
                          return SizedBox(
                            width: 120,
                            child: Card(
                              color: isSelected
                                  ? theme.colorScheme.primaryContainer
                                  : null,
                              child: InkWell(
                                onTap: () {
                                  _data = PortalEventData(
                                    portalType: def.typeCode,
                                    portalColumn: _data.portalColumn,
                                    portalRow: _data.portalRow,
                                    spawnEffect: _data.spawnEffect,
                                    spawnSoundID: _data.spawnSoundID,
                                    ignoreGraveStone: _data.ignoreGraveStone,
                                  );
                                  _sync();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          def.name,
                                          style: theme.textTheme.bodySmall,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                        IconButton(
                                        icon: const Icon(Icons.info_outline),
                                        iconSize: 18,
                                        onPressed: () =>
                                            _showPreviewDialog(context, l10n, def),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: SwitchListTile(
                  title: Text(l10n?.ignoreGravestone ?? 'Ignore gravestone (IgnoreGraveStone)'),
                  subtitle: Text(
                    l10n?.ignoreGravestoneSubtitle ?? 'Enable to spawn regardless of obstacles',
                  ),
                  value: _data.ignoreGraveStone,
                  onChanged: (v) {
                    _data = PortalEventData(
                      portalType: _data.portalType,
                      portalColumn: _data.portalColumn,
                      portalRow: _data.portalRow,
                      spawnEffect: _data.spawnEffect,
                      spawnSoundID: _data.spawnSoundID,
                      ignoreGraveStone: v,
                    );
                    _sync();
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewDialog(BuildContext context, AppLocalizations? l10n, PortalWorldDef def) {
    final theme = Theme.of(context);
    final zombieRepo = ZombieRepository();

    return AlertDialog(
      title: Text(l10n?.zombiePreview(def.name) ?? '${def.name} - Zombie preview'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n?.thisPortalSpawns ?? 'This portal spawns:',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            ...def.representativeZombies.map((typeName) {
              final zombie = zombieRepo.getZombieById(typeName);
              final iconPath = zombie?.iconAssetPath;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    iconPath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: AssetImageWidget(
                              assetPath: iconPath,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CircleAvatar(
                            child: Text(
                              zombieRepo.getName(typeName).isNotEmpty
                                  ? zombieRepo.getName(typeName)[0].toUpperCase()
                                  : '?',
                            ),
                          ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ResourceNames.lookup(context, zombieRepo.getName(typeName)),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          typeName,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n?.close ?? 'Close'),
        ),
      ],
    );
  }
}
