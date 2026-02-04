import 'package:flutter/material.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/data/stage_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;

/// Full-screen stage selection. Ported from Z-Editor-master StageSelectionScreen.kt
class StageSelectionScreen extends StatefulWidget {
  const StageSelectionScreen({
    super.key,
    required this.currentStageRtid,
    required this.onStageSelected,
    required this.onBack,
  });

  final String currentStageRtid;
  final void Function(String) onStageSelected;
  final VoidCallback onBack;

  @override
  State<StageSelectionScreen> createState() => _StageSelectionScreenState();
}

class _StageSelectionScreenState extends State<StageSelectionScreen> {
  StageType _selectedType = StageType.all;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currentAlias = RtidParser.parse(widget.currentStageRtid)?.alias ?? '';
    var items = StageRepository.getByType(_selectedType);
    if (_searchQuery.isNotEmpty) {
      items = items.where((s) =>
          s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          s.alias.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.onBack),
        title: Text(l10n?.selectStage ?? 'Select stage'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: l10n?.searchStage ?? 'Search stage',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => setState(() => _searchQuery = ''),
                          )
                        : null,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: StageType.values.map((t) {
                    final isSelected = _selectedType == t;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(_typeLabel(t, l10n)),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _selectedType = t),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    l10n?.noStageFound ?? 'No stage found',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 140,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final stage = items[i];
                final isSelected = stage.alias == currentAlias;
                return _StageGridItem(
                  stage: stage,
                  isSelected: isSelected,
                  onTap: () {
                    widget.onStageSelected(RtidParser.build(stage.alias, 'LevelModules'));
                    widget.onBack();
                  },
                );
              },
            ),
    );
  }

  String _typeLabel(StageType t, AppLocalizations? l10n) {
    switch (t) {
      case StageType.all: return l10n?.stageTypeAll ?? 'All';
      case StageType.main: return l10n?.stageTypeMain ?? 'Main';
      case StageType.extra: return l10n?.stageTypeExtra ?? 'Extra';
      case StageType.seasons: return l10n?.stageTypeSeasons ?? 'Seasons';
      case StageType.special: return l10n?.stageTypeSpecial ?? 'Special';
    }
  }
}

class _StageGridItem extends StatelessWidget {
  const _StageGridItem({
    required this.stage,
    required this.isSelected,
    required this.onTap,
  });

  final StageItem stage;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: isSelected ? theme.colorScheme.primaryContainer : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: stage.iconName != null
                      ? AssetImageWidget(
                          assetPath: 'assets/images/stages/${stage.iconName!}',
                          altCandidates: imageAltCandidates('assets/images/stages/${stage.iconName!}'),
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        )
                      : const AssetImageWidget(
                          assetPath: 'assets/images/others/unknown.webp',
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                stage.name,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                stage.alias,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
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
