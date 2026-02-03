import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/widgets/editor_components.dart';
import 'package:z_editor/widgets/asset_image.dart'
    show AssetImageWidget, imageAltCandidates;

/// Railcart properties editor. Ported from Z-Editor-master RailcartPropertiesEP.kt
enum _RailEditMode { rails, carts }

class RailcartPropertiesScreen extends StatefulWidget {
  const RailcartPropertiesScreen({
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
  State<RailcartPropertiesScreen> createState() =>
      _RailcartPropertiesScreenState();
}

class _RailcartPropertiesScreenState extends State<RailcartPropertiesScreen> {
  late PvzObject _moduleObj;
  late RailcartPropertiesData _data;
  _RailEditMode _editMode = _RailEditMode.rails;
  late List<List<bool>> _railsGrid;
  late Set<String> _cartSet;

  static const _cartTypeOptions = [
    ('railcart_cowboy', 'Cowboy (railcart_cowboy)'),
    ('railcart_future', 'Future (railcart_future)'),
    ('railcart_egypt', 'Egypt (railcart_egypt)'),
    ('railcart_pirate', 'Pirate (railcart_pirate)'),
    ('railcart_worldcup', 'World Cup (railcart_worldcup)'),
  ];
  static const _railsAssetPath = 'assets/images/others/rails.webp';
  static const _cartsAssetPath = 'assets/images/others/railcarts.webp';

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
        objClass: 'RailcartProperties',
        objData: RailcartPropertiesData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = RailcartPropertiesData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = RailcartPropertiesData();
    }
    _railsGrid = List.generate(9, (_) => List.filled(5, false));
    for (final rail in _data.rails) {
      for (var r = rail.rowStart; r <= rail.rowEnd; r++) {
        if (rail.column >= 0 && rail.column < 9 && r >= 0 && r < 5) {
          _railsGrid[rail.column][r] = true;
        }
      }
    }
    _cartSet = _data.railcarts
        .map((c) => '${c.column},${c.row}')
        .toSet();
  }

  void _sync() {
    final newRails = <RailData>[];
    for (var c = 0; c < 9; c++) {
      int? start;
      for (var r = 0; r < 5; r++) {
        final hasRail = _railsGrid[c][r];
        if (hasRail) {
          start ??= r;
        } else {
          if (start != null) {
            newRails.add(RailData(column: c, rowStart: start, rowEnd: r - 1));
            start = null;
          }
        }
      }
      if (start != null) {
        newRails.add(RailData(column: c, rowStart: start, rowEnd: 4));
      }
    }
    final newCarts = _cartSet.map((s) {
      final parts = s.split(',');
      return RailcartData(
        column: int.tryParse(parts[0]) ?? 0,
        row: int.tryParse(parts[1]) ?? 0,
      );
    }).toList();
    _data = RailcartPropertiesData(
      railcartType: _data.railcartType,
      rails: newRails,
      railcarts: newCarts,
    );
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _handleGridClick(int col, int row) {
    if (_editMode == _RailEditMode.rails) {
      _railsGrid[col][row] = !_railsGrid[col][row];
    } else {
      final key = '$col,$row';
      if (_cartSet.contains(key)) {
        _cartSet.remove(key);
      } else {
        _cartSet.add(key);
      }
    }
    _sync();
  }

  void _clearAll() {
    for (var c = 0; c < 9; c++) {
      for (var r = 0; r < 5; r++) {
        _railsGrid[c][r] = false;
      }
    }
    _cartSet.clear();
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final gridColor = isDark ? const Color(0xFF503C34) : const Color(0xFFD7CCC8);
    final borderColor = isDark ? Colors.grey.shade700 : Colors.grey.shade400;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Text(l10n?.railcartSettings ?? 'Railcart settings'),
      ),
      body: SingleChildScrollView(
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
                    DropdownButtonFormField<String>(
                      key: ValueKey(_data.railcartType),
                      initialValue: _cartTypeOptions
                              .any((e) => e.$1 == _data.railcartType)
                          ? _data.railcartType
                          : _cartTypeOptions.first.$1,
                      decoration: InputDecoration(
                        labelText: l10n?.railcartType ?? 'Railcart type',
                        border: const OutlineInputBorder(),
                      ),
                      items: _cartTypeOptions
                          .map((e) => DropdownMenuItem(
                                value: e.$1,
                                child: Text(e.$2),
                              ))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          _data = RailcartPropertiesData(
                            railcartType: v,
                            rails: _data.rails,
                            railcarts: _data.railcarts,
                          );
                          _sync();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _ModeChip(
                            icon: Icons.add_road,
                            label: l10n?.layRails ?? 'Lay rails',
                            selected: _editMode == _RailEditMode.rails,
                            onTap: () =>
                                setState(() => _editMode = _RailEditMode.rails),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _ModeChip(
                            icon: Icons.inbox,
                            label: l10n?.placeCarts ?? 'Place carts',
                            selected: _editMode == _RailEditMode.carts,
                            onTap: () =>
                                setState(() => _editMode = _RailEditMode.carts),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            scaleTableForDesktop(
              context: context,
              desktopScale: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: gridColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: borderColor),
                ),
                child: AspectRatio(
                  aspectRatio: 1.8,
                  child: Column(
                    children: List.generate(5, (r) {
                      return Expanded(
                        child: Row(
                          children: List.generate(9, (c) {
                            final hasRail = _railsGrid[c][r];
                            final hasCart = _cartSet.contains('$c,$r');
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => _handleGridClick(c, r),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: borderColor, width: 0.5),
                                      bottom: BorderSide(
                                          color: borderColor, width: 0.5),
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (hasRail)
                                      Positioned.fill(
                                        child: Opacity(
                                          opacity: 0.85,
                                          child: AssetImageWidget(
                                            assetPath: _railsAssetPath,
                                            altCandidates: imageAltCandidates(
                                              _railsAssetPath,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      if (hasCart)
                                        Positioned.fill(
                                          child: Center(
                                            child: Transform.scale(
                                              scale: 0.9,
                                              child: AssetImageWidget(
                                                assetPath: _cartsAssetPath,
                                                altCandidates:
                                                    imageAltCandidates(
                                                  _cartsAssetPath,
                                                ),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
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
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${l10n?.railSegments ?? 'Rail segments'}: ${_data.rails.length}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          '${l10n?.railcartCount ?? 'Railcart count'}: ${_data.railcarts.length}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      onPressed: _clearAll,
                      icon: const Icon(Icons.delete, size: 18),
                      label: Text(l10n?.clearAll ?? 'Clear all'),
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: selected
          ? theme.colorScheme.primary
          : theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: selected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: selected
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
