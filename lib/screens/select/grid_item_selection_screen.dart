import 'package:flutter/material.dart';
import 'package:z_editor/data/repository/grid_item_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/theme/app_theme.dart' show pvzBrownDark, pvzBrownLight;
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;

/// Grid item selection. Ported from Z-Editor-master GridItemSelectionScreen.kt
class GridItemSelectionScreen extends StatefulWidget {
  const GridItemSelectionScreen({
    super.key,
    required this.onGridItemSelected,
    required this.onBack,
    required this.filterMode,
  });

  final void Function(String id) onGridItemSelected;
  final VoidCallback onBack;
  final GridItemFilterMode filterMode;

  @override
  State<GridItemSelectionScreen> createState() => _GridItemSelectionScreenState();
}

class _GridItemSelectionScreenState extends State<GridItemSelectionScreen> {
  String _searchQuery = '';
  GridItemCategory _selectedCategory = GridItemCategory.all;

  List<GridItemInfo> get _displayList {
    final baseList = _selectedCategory == GridItemCategory.all
        ? GridItemRepository.getAll()
        : GridItemRepository.getByCategory(_selectedCategory);

    return baseList.where((item) {
      final isModeMatched = switch (widget.filterMode) {
        GridItemFilterMode.all => true,
        GridItemFilterMode.restricted => item.tag == GridItemTag.normal,
      };
      final isSearchMatched = _searchQuery.trim().isEmpty ||
          item.typeName.toLowerCase().contains(_searchQuery.toLowerCase());
      return isModeMatched && isSearchMatched;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeColor = isDark ? pvzBrownDark : pvzBrownLight;
    final displayList = _displayList;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          backgroundColor: themeColor,
          foregroundColor: Colors.white,
          title: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: InputDecoration(
              hintText: l10n?.searchGridItems ?? 'Search grid items',
              prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.9)),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.white.withValues(alpha: 0.9)),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.2),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: themeColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: GridItemCategory.values.map((cat) {
                    final selected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          _categoryLabel(cat, l10n),
                          style: TextStyle(
                            color: selected ? themeColor : Colors.white.withValues(alpha: 0.8),
                            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        selected: selected,
                        onSelected: (_) => setState(() => _selectedCategory = cat),
                        selectedColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: theme.colorScheme.surface,
                child: displayList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.view_module,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n?.noItems ?? 'No items',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final isDesktop = constraints.maxWidth > 600;
                          final crossAxisCount = isDesktop ? 6 : 3;
                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: 0.85,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: displayList.length,
                            itemBuilder: (context, index) {
                              final item = displayList[index];
                              final iconPath = GridItemRepository.getIconPath(item.typeName);
                              final displayName = ResourceNames.lookup(
                                context,
                                'griditem_${item.typeName}',
                              );
                              final name = displayName != 'griditem_${item.typeName}'
                                  ? displayName
                                  : item.typeName;
                              return _GridItemCard(
                                item: item,
                                name: name,
                                iconPath: iconPath,
                                theme: theme,
                                onTap: () => widget.onGridItemSelected(item.typeName),
                              );
                            },
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(GridItemCategory cat, AppLocalizations? l10n) {
    if (l10n == null) return cat.label;
    switch (cat) {
      case GridItemCategory.all:
        return l10n.gridItemCategoryAll;
      case GridItemCategory.scene:
        return l10n.gridItemCategoryScene;
      case GridItemCategory.trap:
        return l10n.gridItemCategoryTrap;
      case GridItemCategory.spawnableObjects:
        return l10n.gridItemCategorySpawnableObjects;
    }
  }
}

class _GridItemCard extends StatelessWidget {
  const _GridItemCard({
    required this.item,
    required this.name,
    required this.iconPath,
    required this.theme,
    required this.onTap,
  });

  final GridItemInfo item;
  final String name;
  final String iconPath;
  final ThemeData theme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AssetImageWidget(
                    assetPath: iconPath,
                    altCandidates: imageAltCandidates(iconPath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item.typeName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
