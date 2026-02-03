import 'package:flutter/material.dart';
import 'package:z_editor/data/grid_item_repository.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;

/// Grid item selection. Ported from Z-Editor-master GridItemSelectionScreen.kt
class GridItemSelectionScreen extends StatefulWidget {
  const GridItemSelectionScreen({
    super.key,
    required this.onGridItemSelected,
    required this.onBack,
  });

  final void Function(String id) onGridItemSelected;
  final VoidCallback onBack;

  @override
  State<GridItemSelectionScreen> createState() => _GridItemSelectionScreenState();
}

class _GridItemSelectionScreenState extends State<GridItemSelectionScreen> {
  String _searchQuery = '';
  GridItemCategory _selectedCategory = GridItemCategory.all;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayList = _searchQuery.trim().isEmpty
        ? GridItemRepository.getByCategory(_selectedCategory)
        : GridItemRepository.search(_searchQuery)
            .where((i) =>
                _selectedCategory == GridItemCategory.all ||
                i.category == _selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: TextField(
          onChanged: (v) => setState(() => _searchQuery = v),
          decoration: InputDecoration(
            hintText: 'Search grid items',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _searchQuery = ''),
                  )
                : null,
            border: InputBorder.none,
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: GridItemCategory.values.map((cat) {
                final selected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat.label),
                    selected: selected,
                    onSelected: (_) =>
                        setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: displayList.isEmpty
                ? Center(
                    child: Text(
                      'No items',
                      style: theme.textTheme.bodyLarge,
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      final item = displayList[index];
                      final iconPath = GridItemRepository.getIconPath(item.typeName);
                      return Card(
                        child: InkWell(
                          onTap: () =>
                              widget.onGridItemSelected(item.typeName),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: iconPath != null
                                      ? AssetImageWidget(
                                          assetPath: iconPath,
                                          altCandidates: imageAltCandidates(iconPath),
                                          fit: BoxFit.contain,
                                        )
                                      : AssetImageWidget(
                                          assetPath: 'assets/images/others/unknown.webp',
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
