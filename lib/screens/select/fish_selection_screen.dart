import 'package:flutter/material.dart';
import 'package:z_editor/data/repository/fish_type_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/l10n/resource_names.dart';
import 'package:z_editor/theme/app_theme.dart' show pvzFishDark, pvzFishLight;
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;

/// Fish selection for ZombieFishWaveEvent. Selects creature types (fish).
class FishSelectionScreen extends StatefulWidget {
  const FishSelectionScreen({
    super.key,
    required this.onFishSelected,
    required this.onBack,
  });

  final void Function(String fishAlias) onFishSelected;
  final VoidCallback onBack;

  @override
  State<FishSelectionScreen> createState() => _FishSelectionScreenState();
}

class _FishSelectionScreenState extends State<FishSelectionScreen> {
  String _searchQuery = '';

  List<FishInfo> get _displayList {
    final repo = FishTypeRepository();
    if (!repo.isLoaded) return [];
    var list = repo.allFishes;
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list
          .where((f) =>
              f.typeName.toLowerCase().contains(q) ||
              f.alias.toLowerCase().contains(q))
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final themeColor = isDark ? pvzFishDark : pvzFishLight;
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
              hintText: l10n?.searchFish ?? 'Search fish',
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
                child: Text(
                  l10n?.noFishFound ?? 'No fish found',
                  style: theme.textTheme.bodyLarge,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: displayList.length,
                itemBuilder: (_, i) {
                  final fish = displayList[i];
                  final nameKey = 'creature_${fish.typeName}';
                  final name = ResourceNames.lookup(context, nameKey) != nameKey
                      ? ResourceNames.lookup(context, nameKey)
                      : fish.typeName;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AssetImageWidget(
                          assetPath: fish.iconAssetPath,
                          altCandidates: imageAltCandidates(fish.iconAssetPath),
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(name),
                      subtitle: Text(fish.creatureClass),
                      onTap: () => widget.onFishSelected(fish.alias),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
