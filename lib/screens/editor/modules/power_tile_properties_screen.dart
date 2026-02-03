import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Power tile properties. Ported from Z-Editor-master PowerTilePropertiesEP.kt
class PowerTilePropertiesScreen extends StatefulWidget {
  const PowerTilePropertiesScreen({
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
  State<PowerTilePropertiesScreen> createState() =>
      _PowerTilePropertiesScreenState();
}

class _PowerTilePropertiesScreenState extends State<PowerTilePropertiesScreen> {
  late PvzObject _moduleObj;
  late PowerTilePropertiesData _data;
  String _selectedGroup = 'alpha';

  static const _groups = [
    ('alpha', 'Alpha (Green)', Color(0xFF41FF4B), 'tool_powertile_alpha.webp'),
    ('beta', 'Beta (Red)', Color(0xFFFF493A), 'tool_powertile_beta.webp'),
    ('gamma', 'Gamma (Blue)', Color(0xFF3CFFFF), 'tool_powertile_gamma.webp'),
    ('delta', 'Delta (Yellow)', Color(0xFFFFE837), 'tool_powertile_delta.webp'),
  ];

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
        objClass: 'PowerTileProperties',
        objData: PowerTilePropertiesData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = PowerTilePropertiesData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = PowerTilePropertiesData();
    }
    _data = PowerTilePropertiesData(
      linkedTiles: List.from(_data.linkedTiles),
    );
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _handleGridTap(int mx, int my) {
    final existing = _data.linkedTiles
        .where((t) => t.location.mx == mx && t.location.my == my)
        .toList();
    final newList = List<LinkedTileData>.from(_data.linkedTiles);
    if (existing.isNotEmpty) {
      final tile = existing.first;
      if (tile.group == _selectedGroup) {
        newList.remove(tile);
      } else {
        final idx = newList.indexOf(tile);
        if (idx >= 0) {
          newList[idx] = LinkedTileData(
            group: _selectedGroup,
            propagationDelay: tile.propagationDelay,
            location: tile.location,
          );
        }
      }
    } else {
      newList.add(LinkedTileData(
        group: _selectedGroup,
        propagationDelay: 1.5,
        location: TileLocationData(mx: mx, my: my),
      ));
    }
    _data = PowerTilePropertiesData(linkedTiles: newList);
    _sync();
  }

  void _removeTile(LinkedTileData tile) {
    final newList = List<LinkedTileData>.from(_data.linkedTiles);
    newList.remove(tile);
    _data = PowerTilePropertiesData(linkedTiles: newList);
    _sync();
  }

  void _updateDelay(LinkedTileData tile, double delay) {
    final newList = _data.linkedTiles.map((t) {
      if (t == tile) {
        return LinkedTileData(
          group: t.group,
          propagationDelay: delay,
          location: t.location,
        );
      }
      return t;
    }).toList();
    _data = PowerTilePropertiesData(linkedTiles: newList);
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Power tile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select group',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _groups.map((g) {
                final isSelected = _selectedGroup == g.$1;
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: AssetImageWidget(
                          assetPath: 'assets/images/tools/${g.$4}',
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          altCandidates: imageAltCandidates(
                            'assets/images/tools/${g.$4}',
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(g.$2),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedGroup = g.$1),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Grid (tap to add/change, long-press to remove)',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            scaleTableForDesktop(
              context: context,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: AspectRatio(
                  aspectRatio: 1.8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 9,
                        childAspectRatio: 1,
                      ),
                      itemCount: 45,
                      itemBuilder: (context, index) {
                        final row = index ~/ 9;
                        final col = index % 9;
                        final tile = _data.linkedTiles
                            .where((t) =>
                                t.location.mx == col && t.location.my == row)
                            .firstOrNull;
                        final groupInfo = _groups
                            .firstWhere(
                              (g) => g.$1 == (tile?.group ?? ''),
                              orElse: () => _groups.first,
                            );
                        return GestureDetector(
                          onTap: () => _handleGridTap(col, row),
                          onLongPress: tile != null
                              ? () => _removeTile(tile)
                              : null,
                          child: Container(
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: tile != null
                                  ? groupInfo.$3.withValues(alpha: 0.5)
                                  : Colors.transparent,
                              border: Border.all(
                                color: tile != null
                                    ? groupInfo.$3
                                    : theme.dividerColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: tile != null
                                ? Center(
                                    child: AssetImageWidget(
                                      assetPath:
                                          'assets/images/tools/${groupInfo.$4}',
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.contain,
                                      altCandidates: imageAltCandidates(
                                        'assets/images/tools/${groupInfo.$4}',
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Linked tiles',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ..._data.linkedTiles.map((tile) {
              final g = _groups
                  .firstWhere(
                    (e) => e.$1 == tile.group,
                    orElse: () => _groups.first,
                  );
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: AssetImageWidget(
                      assetPath: 'assets/images/tools/${g.$4}',
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                      altCandidates:
                          imageAltCandidates('assets/images/tools/${g.$4}'),
                    ),
                  ),
                  title: Text(
                    '${g.$2} @ (${tile.location.mx}, ${tile.location.my})',
                  ),
                  subtitle: Slider(
                    value: tile.propagationDelay.clamp(0.0, 5.0),
                    min: 0,
                    max: 5,
                    onChanged: (v) => _updateDelay(tile, v),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeTile(tile),
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
