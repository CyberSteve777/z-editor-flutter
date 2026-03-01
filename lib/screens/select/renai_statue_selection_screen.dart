import 'package:flutter/material.dart';
import 'package:z_editor/data/repository/grid_item_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/theme/app_theme.dart' show pvzBrownDark, pvzBrownLight;
import 'package:z_editor/widgets/asset_image.dart'
    show AssetImageWidget, imageAltCandidates;

/// Dedicated statue selection for Renai module. Shows all Renai statue types.
class RenaiStatueSelectionScreen extends StatefulWidget {
  const RenaiStatueSelectionScreen({
    super.key,
    required this.onStatueSelected,
    required this.onBack,
  });

  final void Function(String typeName) onStatueSelected;
  final VoidCallback onBack;

  @override
  State<RenaiStatueSelectionScreen> createState() =>
      _RenaiStatueSelectionScreenState();
}

class _RenaiStatueSelectionScreenState extends State<RenaiStatueSelectionScreen> {
  String _searchQuery = '';

  List<GridItemInfo> get _displayList {
    return GridItemRepository.getRenaiStatueItems().where((item) {
      return _searchQuery.trim().isEmpty ||
          item.typeName.toLowerCase().contains(_searchQuery.toLowerCase());
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
              hintText: l10n?.searchStatues ?? 'Search statues',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
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
        body: displayList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.view_module,
                      size: 64,
                      color: theme.colorScheme.onSurfaceVariant
                          .withValues(alpha: 0.5),
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
                      final iconPath =
                          GridItemRepository.getIconPath(item.typeName);
                      final displayName = ResourceNames.lookup(
                        context,
                        'griditem_${item.typeName}',
                      );
                      final name = displayName != 'griditem_${item.typeName}'
                          ? displayName
                          : item.typeName;
                      return _RenaiStatueCard(
                        item: item,
                        name: name,
                        iconPath: iconPath,
                        theme: theme,
                        showZombossBadge:
                            GridItemRepository.needsZombossBadge(
                              item.typeName,
                            ),
                        onTap: () =>
                            widget.onStatueSelected(item.typeName),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class _RenaiStatueCard extends StatelessWidget {
  const _RenaiStatueCard({
    required this.item,
    required this.name,
    required this.iconPath,
    required this.theme,
    this.showZombossBadge = false,
    required this.onTap,
  });

  final GridItemInfo item;
  final String name;
  final String iconPath;
  final ThemeData theme;
  final bool showZombossBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isNonHalf = GridItemRepository.isRenaiStatueNonHalf(item.typeName);
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: AssetImageWidget(
        assetPath: iconPath,
        altCandidates: imageAltCandidates(iconPath),
        fit: BoxFit.contain,
      ),
    );
    final scaledImage = isNonHalf
        ? Center(
            child: FractionallySizedBox(
              widthFactor: 0.55,
              heightFactor: 0.55,
              child: image,
            ),
          )
        : image;
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
                child: showZombossBadge
                    ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(child: scaledImage),
                          Positioned(
                            top: 2,
                            left: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF7B1FA2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Z',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : scaledImage,
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
