import 'package:flutter/material.dart';
import 'package:z_editor/data/zomboss_repository.dart';
import 'package:z_editor/l10n/app_localizations.dart';

class ZombossSelectionScreen extends StatefulWidget {
  const ZombossSelectionScreen({
    super.key,
    required this.onSelected,
    required this.onBack,
  });

  final ValueChanged<String> onSelected;
  final VoidCallback onBack;

  @override
  State<ZombossSelectionScreen> createState() => _ZombossSelectionScreenState();
}

class _ZombossSelectionScreenState extends State<ZombossSelectionScreen> {
  String _searchQuery = '';
  ZombossTag _selectedTag = ZombossTag.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final displayList = ZombossRepository.search(_searchQuery, _selectedTag);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: TextField(
          onChanged: (v) => setState(() => _searchQuery = v),
          decoration: InputDecoration(
            hintText: l10n?.search ?? 'Search',
            border: InputBorder.none,
            hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: ZombossTag.values.map((tag) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(tag.getLabel(l10n!)),
                    selected: _selectedTag == tag,
                    onSelected: (_) => setState(() => _selectedTag = tag),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: displayList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    'No zomboss found', // TODO: Localize
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final boss = displayList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ZombossItemCard(
                    boss: boss,
                    onClick: () => widget.onSelected(boss.id),
                  ),
                );
              },
            ),
    );
  }
}

class _ZombossItemCard extends StatelessWidget {
  const _ZombossItemCard({required this.boss, required this.onClick});

  final ZombossInfo boss;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image.asset(
                    'assets/images/zombies/${boss.icon}',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.warning_amber,
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      boss.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      boss.id,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
