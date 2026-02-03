import 'package:flutter/material.dart';
import 'package:z_editor/data/conflict_registry.dart';
import 'package:z_editor/data/module_registry.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/reference_repository.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';

class ModuleUIInfo {
  final String rtid;
  final String alias;
  final String objClass;
  final String friendlyName;
  final String description;
  final IconData icon;
  final bool isCore;

  const ModuleUIInfo({
    required this.rtid,
    required this.alias,
    required this.objClass,
    required this.friendlyName,
    required this.description,
    required this.icon,
    required this.isCore,
  });
}

class LevelSettingsTab extends StatefulWidget {
  const LevelSettingsTab({
    super.key,
    required this.levelDef,
    required this.objectMap,
    required this.missingModules,
    required this.onEditBasicInfo,
    required this.onEditModule,
    required this.onRemoveModule,
    required this.onNavigateToAddModule,
  });

  final LevelDefinitionData? levelDef;
  final Map<String, PvzObject> objectMap;
  final List<ModuleMetadata> missingModules;
  final VoidCallback onEditBasicInfo;
  final ValueChanged<String> onEditModule;
  final ValueChanged<String> onRemoveModule;
  final VoidCallback onNavigateToAddModule;

  @override
  State<LevelSettingsTab> createState() => _LevelSettingsTabState();
}

class _LevelSettingsTabState extends State<LevelSettingsTab> {
  String? pendingDeleteRtid;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final levelDef = widget.levelDef;

    if (levelDef == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.settings,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                l10n?.noLevelDefinition ?? 'No level definition',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n?.noLevelDefinitionHint ??
                    'Level definition module is missing.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final currentModulesList = levelDef.modules.map((rtid) {
      final info = RtidParser.parse(rtid);
      final alias = info?.alias ?? 'Unknown';
      String? objClass;

      if (info?.source == 'CurrentLevel') {
        objClass = widget.objectMap[alias]?.objClass;
      } else {
        objClass = ReferenceRepository.instance.getObjClass(alias);
      }
      objClass ??= 'UnknownObject';

      final metadata = ModuleRegistry.getMetadata(objClass);

      return ModuleUIInfo(
        rtid: rtid,
        alias: alias,
        objClass: objClass,
        friendlyName: metadata.getTitle(context),
        description: metadata.getDescription(context),
        icon: metadata.icon,
        isCore: metadata.isCore,
      );
    }).toList();

    final coreModules = currentModulesList.where((m) => m.isCore).toList();
    final miscModules = currentModulesList.where((m) => !m.isCore).toList();

    final existingObjClasses = currentModulesList
        .map((m) => m.objClass)
        .toSet();
    final activeConflicts = ConflictRegistry.getActiveConflicts(
      context,
      existingObjClasses,
    );

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SettingEntryCard(
              title: l10n?.levelBasicInfo ?? 'Level basic info',
              subtitle:
                  l10n?.levelBasicInfoSubtitle ??
                  'Name, number, description, stage',
              icon: Icons.edit_note,
              onClick: widget.onEditBasicInfo,
            ),
            const SizedBox(height: 20),
            Text(
              l10n?.editableModules ?? 'Editable modules',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            ...coreModules.map(
              (item) => ModuleCard(
                info: item,
                onClick: () => widget.onEditModule(item.rtid),
                onDelete: () => setState(() => pendingDeleteRtid = item.rtid),
              ),
            ),
            const SizedBox(height: 20),
            if (miscModules.isNotEmpty) ...[
              Text(
                l10n?.parameterModules ?? 'Parameter modules',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              ...miscModules.map(
                (item) => MiscModuleRow(
                  info: item,
                  onDelete: () => setState(() => pendingDeleteRtid = item.rtid),
                ),
              ),
              const SizedBox(height: 8),
            ],

            // Add Module Button
            InkWell(
              onTap: widget.onNavigateToAddModule,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n?.addNewModule ?? 'Add new module',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Conflicts
            ...activeConflicts.map(
              (pair) => Card(
                color: Theme.of(context).colorScheme.errorContainer,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: Theme.of(
                              context,
                            ).colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            pair.first.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pair.second,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Missing Essentials
            if (widget.missingModules.isNotEmpty)
              Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Theme.of(
                              context,
                            ).colorScheme.onTertiaryContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n?.missingModules ?? 'Missing modules',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onTertiaryContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'The level might not function correctly. Recommended to add:',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onTertiaryContainer,
                        ),
                      ),
                      ...widget.missingModules.map(
                        (meta) => Text(
                          '• ${meta.getTitle(context)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(
                              context,
                            ).colorScheme.onTertiaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        if (pendingDeleteRtid != null)
          AlertDialog(
            title: Text(l10n?.removeModule ?? 'Remove module'),
            content: Text(
              l10n?.removeModuleConfirm ??
                  'Remove this module? Local custom modules (@CurrentLevel) and their data will be deleted permanently.',
            ),
            actions: [
              TextButton(
                onPressed: () => setState(() => pendingDeleteRtid = null),
                child: Text(l10n?.cancel ?? 'Cancel'),
              ),
              TextButton(
                onPressed: () {
                  widget.onRemoveModule(pendingDeleteRtid!);
                  setState(() => pendingDeleteRtid = null);
                },
                child: Text(
                  l10n?.confirmRemove ?? 'Remove',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class _SettingEntryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onClick;

  const _SettingEntryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class ModuleCard extends StatelessWidget {
  final ModuleUIInfo info;
  final VoidCallback onClick;
  final VoidCallback onDelete;

  const ModuleCard({
    super.key,
    required this.info,
    required this.onClick,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                info.icon,
                color: Theme.of(context).colorScheme.primary,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.friendlyName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      info.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      info.alias,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.close), onPressed: onDelete),
            ],
          ),
        ),
      ),
    );
  }
}

class MiscModuleRow extends StatelessWidget {
  final ModuleUIInfo info;
  final VoidCallback onDelete;

  const MiscModuleRow({super.key, required this.info, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: [
          Icon(info.icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${info.friendlyName} (${info.alias})',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 16, color: Colors.grey),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
