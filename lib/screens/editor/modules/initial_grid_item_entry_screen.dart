import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/grid_item_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/screens/select/grid_item_selection_screen.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;
import 'package:z_editor/widgets/editor_components.dart';

/// Initial grid item entry. Ported from Z-Editor-master InitialGridItemEntryEP.kt
class InitialGridItemEntryScreen extends StatefulWidget {
  const InitialGridItemEntryScreen({
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
  State<InitialGridItemEntryScreen> createState() =>
      _InitialGridItemEntryScreenState();
}

class _InitialGridItemEntryScreenState extends State<InitialGridItemEntryScreen> {
  late PvzObject _moduleObj;
  late InitialGridItemEntryData _data;
  int _selectedX = 0;
  int _selectedY = 0;
  InitialGridItemData? _itemToDelete;

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
        objClass: 'InitialGridItemProperties',
        objData: InitialGridItemEntryData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = InitialGridItemEntryData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = InitialGridItemEntryData();
    }
    _data = InitialGridItemEntryData(placements: List.from(_data.placements));
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  void _handleSelectItem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GridItemSelectionScreen(
          onGridItemSelected: (typeName) {
            Navigator.pop(context);
            final newList = List<InitialGridItemData>.from(_data.placements);
            newList.add(InitialGridItemData(
              gridX: _selectedX,
              gridY: _selectedY,
              typeName: typeName,
            ));
            _data = InitialGridItemEntryData(placements: newList);
            _sync();
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _deleteItem(InitialGridItemData target) {
    final newList = List<InitialGridItemData>.from(_data.placements);
    newList.remove(target);
    _data = InitialGridItemEntryData(placements: newList);
    _sync();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sortedItems = List<InitialGridItemData>.from(_data.placements)
      ..sort((a, b) {
        final c = a.gridY.compareTo(b.gridY);
        return c != 0 ? c : a.gridX.compareTo(b.gridX);
      });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid item layout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected position',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                Text(
                                  'R${_selectedY + 1} : C${_selectedX + 1}',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            FilledButton.icon(
                              onPressed: _handleSelectItem,
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Add item'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildGrid(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Item list (row-first)',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                ...sortedItems.map((item) => _GridItemCard(
                  item: item,
                  isSelected: item.gridX == _selectedX && item.gridY == _selectedY,
                  onTap: () => setState(() {
                    _selectedX = item.gridX;
                    _selectedY = item.gridY;
                  }),
                  onDelete: () => setState(() => _itemToDelete = item),
                )),
              ],
            ),
          ),
          if (_itemToDelete != null) _buildDeleteDialog(),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final theme = Theme.of(context);
    return scaleTableForDesktop(
      context: context,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        child: AspectRatio(
          aspectRatio: 1.8,
          child: Container(
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF31383B)
                  : const Color(0xFFD7ECF1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF6B899A), width: 1),
            ),
            child: Column(
              children: List.generate(5, (row) {
                return Expanded(
                  child: Row(
                    children: List.generate(9, (col) {
                      final isSelected = row == _selectedY && col == _selectedX;
                      final cellItems = _data.placements
                          .where((p) => p.gridX == col && p.gridY == row)
                          .toList();
                      final firstItem = cellItems.firstOrNull;
                      final count = cellItems.length;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _selectedX = col;
                            _selectedY = row;
                          }),
                          child: Container(
                            margin: const EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colorScheme.primary.withValues(
                                      alpha: 0.2,
                                    )
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : const Color(0xFF6B899A),
                                width: 0.5,
                              ),
                            ),
                            child: count > 0 && firstItem != null
                                ? Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Center(
                                        child:
                                            _GridItemIconSmall(firstItem.typeName),
                                      ),
                                      if (count > 1)
                                        Positioned(
                                          top: 2,
                                          right: 2,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: theme.colorScheme
                                                  .onSurfaceVariant,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(4),
                                              ),
                                            ),
                                            child: Text(
                                              '+$count',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  )
                                : null,
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
    );
  }

  Widget _buildDeleteDialog() {
    final item = _itemToDelete!;
    final name = GridItemRepository.getName(item.typeName);
    return AlertDialog(
      title: const Text('Remove item'),
      content: Text(
        'Remove R${item.gridY + 1}:C${item.gridX + 1} $name?',
      ),
      actions: [
        TextButton(
          onPressed: () => setState(() => _itemToDelete = null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _deleteItem(item);
            setState(() => _itemToDelete = null);
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Remove'),
        ),
      ],
    );
  }
}

class _GridItemIconSmall extends StatelessWidget {
  const _GridItemIconSmall(this.typeName);

  final String typeName;

  @override
  Widget build(BuildContext context) {
    final path = GridItemRepository.getIconPath(typeName);
    if (path != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: AssetImageWidget(
          assetPath: path,
          fit: BoxFit.cover,
          width: 32,
          height: 32,
          altCandidates: imageAltCandidates(path),
        ),
      );
    }
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFF407A9A),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        typeName.isNotEmpty ? typeName[0].toUpperCase() : '?',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _GridItemCard extends StatelessWidget {
  const _GridItemCard({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
  });

  final InitialGridItemData item;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final path = GridItemRepository.getIconPath(item.typeName);
    final name = GridItemRepository.getName(item.typeName);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isSelected
          ? (theme.brightness == Brightness.dark
              ? const Color(0xFF31383B)
              : const Color(0xFFD7ECF1))
          : theme.cardTheme.color,
      shape: RoundedRectangleBorder(
        side: isSelected
            ? BorderSide(color: theme.colorScheme.primary, width: 1)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: Colors.grey,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: path != null
                        ? AssetImageWidget(
                            assetPath: path,
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                            altCandidates: imageAltCandidates(path),
                            errorWidget: Container(
                              color: const Color(0xFFF5EEE8),
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              child: Text(
                                item.typeName.isNotEmpty
                                    ? item.typeName[0]
                                    : '?',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF407A9A),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: 36,
                            height: 36,
                            color: const Color(0xFFF5EEE8),
                            alignment: Alignment.center,
                            child: Text(
                              item.typeName.isNotEmpty
                                  ? item.typeName[0]
                                  : '?',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF407A9A),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'R${item.gridY + 1}:C${item.gridX + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF407A9A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
