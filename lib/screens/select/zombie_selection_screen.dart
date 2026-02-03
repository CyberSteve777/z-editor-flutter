import 'package:flutter/material.dart';
import 'package:z_editor/data/zombie_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/widgets/asset_image.dart'
    show AssetImageWidget, imageAltCandidates;

/// Zombie selection. Ported from Z-Editor-master ZombieSelectionScreen.kt
class ZombieSelectionScreen extends StatefulWidget {
  const ZombieSelectionScreen({
    super.key,
    this.multiSelect = false,
    required this.onZombieSelected,
    this.onMultiZombieSelected,
    required this.onBack,
  });

  final bool multiSelect;
  final void Function(String) onZombieSelected;
  final void Function(List<String>)? onMultiZombieSelected;
  final VoidCallback onBack;

  @override
  State<ZombieSelectionScreen> createState() => _ZombieSelectionScreenState();
}

class _ZombieSelectionScreenState extends State<ZombieSelectionScreen> {
  String _searchQuery = '';
  final Set<String> _selectedIds = {};
  bool _isLoaded = false;
  ZombieCategory _selectedCategory = ZombieCategory.main;
  ZombieTag _selectedTag = ZombieTag.all;

  @override
  void initState() {
    super.initState();
    ZombieRepository().init().then((_) {
      if (mounted) setState(() => _isLoaded = true);
    });
  }

  List<ZombieTag> _visibleTagsFor(ZombieCategory category) {
    if (category == ZombieCategory.collection) return [];
    return [
      ZombieTag.all,
      ...ZombieTag.values.where(
        (t) => t != ZombieTag.all && t.category == category,
      ),
    ];
  }

  void _setCategory(ZombieCategory category) {
    if (_selectedCategory == category) return;
    setState(() {
      _selectedCategory = category;
      final tags = _visibleTagsFor(category);
      _selectedTag = tags.isNotEmpty ? tags.first : ZombieTag.all;
    });
  }

  void _toggleFavorite(BuildContext context, String id) async {
    await ZombieRepository().toggleFavorite(id);
    if (!mounted) return;
    final isFav = ZombieRepository().isFavorite(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFav ? 'Added to favorites' : 'Removed from favorites'),
        duration: const Duration(milliseconds: 1200),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final repo = ZombieRepository();
    final zombies = repo.search(
      _searchQuery,
      _selectedCategory == ZombieCategory.collection ? null : _selectedTag,
      _selectedCategory,
    );
    final visibleTags = _visibleTagsFor(_selectedCategory);
    final tagIndex = visibleTags.indexOf(_selectedTag);
    final safeTagIndex = tagIndex < 0 ? 0 : tagIndex;
    if (_selectedCategory != ZombieCategory.collection &&
        !visibleTags.contains(_selectedTag)) {
      _selectedTag = visibleTags.first;
    }
    final themeColor = theme.colorScheme.primary;

    final appBarHeight =
        _selectedCategory == ZombieCategory.collection ? 120.0 : 168.0;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: Container(
          color: themeColor,
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: theme.colorScheme.surface,
                        onPressed: widget.onBack,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (v) => setState(() => _searchQuery = v),
                          decoration: InputDecoration(
                            hintText: widget.multiSelect
                                ? 'Selected ${_selectedIds.length}, tap to search'
                                : (l10n?.searchZombie ?? 'Search zombie'),
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () =>
                                        setState(() => _searchQuery = ''),
                                  )
                                : null,
                            filled: true,
                            fillColor: theme.colorScheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                  key: ValueKey(_selectedCategory),
                  length: ZombieCategory.values.length,
                  initialIndex:
                      ZombieCategory.values.indexOf(_selectedCategory),
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: theme.colorScheme.surface,
                    labelColor: theme.colorScheme.surface,
                    unselectedLabelColor:
                        theme.colorScheme.surface.withValues(alpha: 0.6),
                    onTap: (index) =>
                        _setCategory(ZombieCategory.values[index]),
                    tabs: ZombieCategory.values.map((category) {
                      final isSelected = _selectedCategory == category;
                      return Tab(
                        child: Row(
                          children: [
                            if (category == ZombieCategory.collection) ...[
                              Icon(
                                Icons.star,
                                size: 16,
                                color: isSelected
                                    ? theme.colorScheme.surface
                                    : theme.colorScheme.surface
                                        .withValues(alpha: 0.6),
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              category.getLabel(context),
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if (_selectedCategory != ZombieCategory.collection)
                  DefaultTabController(
                    key: ValueKey('${_selectedCategory.name}_tags'),
                    length: visibleTags.length,
                    initialIndex: safeTagIndex,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor:
                          theme.colorScheme.surface.withValues(alpha: 0.8),
                      labelColor: theme.colorScheme.surface,
                      unselectedLabelColor:
                          theme.colorScheme.surface.withValues(alpha: 0.6),
                      onTap: (index) =>
                          setState(() => _selectedTag = visibleTags[index]),
                      tabs: visibleTags.map((tag) {
                        final isSelected = _selectedTag == tag;
                        final iconName = tag.iconName;
                        return Tab(
                          child: Row(
                            children: [
                              if (iconName != null) ...[
                                AssetImageWidget(
                                  assetPath: 'assets/images/tags/$iconName',
                                  width: 18,
                                  height: 18,
                                  altCandidates:
                                      imageAltCandidates('assets/images/tags/$iconName'),
                                ),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                tag.getLabel(context),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: widget.multiSelect
          ? FloatingActionButton(
              onPressed: () {
                widget.onMultiZombieSelected?.call(_selectedIds.toList());
                widget.onBack();
              },
              child: const Icon(Icons.check),
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: !_isLoaded
                ? const Center(child: CircularProgressIndicator())
                : zombies.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 64,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _selectedCategory == ZombieCategory.collection
                                  ? 'No favorites. Long-press to favorite.'
                                  : (l10n?.noZombieFound ?? 'No zombie found'),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 72,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: zombies.length,
                        itemBuilder: (_, i) {
                          final zombie = zombies[i];
                          final isSelected =
                              _selectedIds.contains(zombie.id);
                          final isFavorite = repo.isFavorite(zombie.id);
                          return _ZombieGridItem(
                            zombie: zombie,
                            isSelected: isSelected,
                            isFavorite: isFavorite,
                            onTap: () {
                              if (widget.multiSelect) {
                                setState(() {
                                  if (isSelected) {
                                    _selectedIds.remove(zombie.id);
                                  } else {
                                    _selectedIds.add(zombie.id);
                                  }
                                });
                              } else {
                                widget.onZombieSelected(zombie.id);
                                widget.onBack();
                              }
                            },
                            onLongPress: () => _toggleFavorite(context, zombie.id),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _ZombieGridItem extends StatelessWidget {
  const _ZombieGridItem({
    required this.zombie,
    required this.isSelected,
    required this.isFavorite,
    required this.onTap,
    required this.onLongPress,
  });

  final ZombieInfo zombie;
  final bool isSelected;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconPath = zombie.iconAssetPath;

    final borderColor =
        isSelected ? theme.colorScheme.primary : Colors.transparent;
    final bgColor = isSelected
        ? theme.colorScheme.primary.withValues(alpha: 0.08)
        : Colors.transparent;
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: isSelected ? 2 : 0),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: iconPath != null
                          ? AssetImageWidget(
                              assetPath: iconPath,
                              altCandidates: imageAltCandidates(iconPath),
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            )
                          : const AssetImageWidget(
                              assetPath: 'assets/images/others/unknown.webp',
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  if (isFavorite)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFFFC107),
                            width: 0.5,
                          ),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(
                          Icons.star,
                          size: 12,
                          color: Color(0xFFFFC107),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                ResourceNames.lookup(context, zombie.name),
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 9,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                zombie.id,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
