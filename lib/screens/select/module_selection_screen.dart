import 'package:flutter/material.dart';
import 'package:z_editor/data/module_registry.dart';
import 'package:z_editor/l10n/app_localizations.dart';

/// Full-screen module selection. Ported from Z-Editor-master ModuleSelectionScreen.kt
class ModuleSelectionScreen extends StatefulWidget {
  const ModuleSelectionScreen({
    super.key,
    required this.existingObjClasses,
    required this.onModuleSelected,
    required this.onBack,
  });

  final Set<String> existingObjClasses;
  final ValueChanged<ModuleMetadata> onModuleSelected;
  final VoidCallback onBack;

  @override
  State<ModuleSelectionScreen> createState() => _ModuleSelectionScreenState();
}

class _ModuleSelectionScreenState extends State<ModuleSelectionScreen> {
  String _searchQuery = '';
  ModuleCategory _selectedCategory = ModuleCategory.base;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final filtered = ModuleRegistry.getAllModules()
        .where((m) {
          final catMatch = m.category == _selectedCategory;
          final searchMatch = _searchQuery.isEmpty ||
              m.getTitle(context).toLowerCase().contains(_searchQuery.toLowerCase()) ||
              m.getDescription(context).toLowerCase().contains(_searchQuery.toLowerCase()) ||
              m.defaultAlias.toLowerCase().contains(_searchQuery.toLowerCase());
          
          // Filter out single instance modules that are already present
          final alreadyExists = widget.existingObjClasses.contains(m.objClass);
          if (!m.allowMultiple && alreadyExists) return false;

          return catMatch && searchMatch;
        })
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.onBack),
        title: Text(l10n?.addModule ?? 'Add module'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search',
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: ModuleCategory.values.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(cat.name.toUpperCase()),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _selectedCategory = cat),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: filtered.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    _searchQuery.isNotEmpty
                        ? 'No results for "$_searchQuery"'
                        : 'No modules in this category',
                    style: theme.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final meta = filtered[index];
                final isAdded = widget.existingObjClasses.contains(meta.objClass);
                final enabled = !isAdded || meta.allowMultiple;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(meta.icon, color: theme.colorScheme.primary),
                    ),
                    title: Text(
                      meta.getTitle(context),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      meta.getDescription(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: isAdded
                        ? Icon(
                            meta.allowMultiple ? Icons.add_circle : Icons.check_circle,
                            color: Colors.green,
                          )
                        : null,
                    enabled: enabled,
                    onTap: enabled
                        ? () {
                            widget.onModuleSelected(meta);
                            widget.onBack();
                          }
                        : null,
                  ),
                );
              },
            ),
    );
  }
}
