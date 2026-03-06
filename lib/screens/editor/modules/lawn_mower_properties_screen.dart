import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/theme/app_theme.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Lawn mower style settings. Ported from LawnMowerPropertiesEP.kt
class LawnMowerPropertiesScreen extends StatefulWidget {
  const LawnMowerPropertiesScreen({
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
  State<LawnMowerPropertiesScreen> createState() =>
      _LawnMowerPropertiesScreenState();
}

class _LawnMowerPropertiesScreenState extends State<LawnMowerPropertiesScreen> {
  static const _mowerOptions = [
    ('FrontLawnMowers', 'Front lawn'),
    ('EgyptMowers', 'Egypt'),
    ('PirateMowers', 'Pirate'),
    ('WestMowers', 'West'),
    ('KongFuMowers', 'Kung Fu'),
    ('FutureMowers', 'Future'),
    ('DarkMowers', 'Dark'),
    ('BeachMowers', 'Beach'),
    ('IceageMowers', 'Ice Age'),
    ('IceageZombossMowers', 'Ice Age Zomboss'),
    ('LostCityMowers', 'Lost City'),
    ('EightiesMowers', 'Eighties'),
    ('EightiesZombossMowers', 'Eighties Zomboss'),
    ('DinoMowers', 'Dino'),
    ('ModernMowers', 'Modern'),
    ('SteamMowers', 'Steam'),
    ('RenaiMowers', 'Renai'),
    ('HeianMowers', 'Heian'),
    ('FairyTaleMowers', 'Fairy Tale'),
    ('ZCorpMowers', 'Z Corp'),
    ('RunningSubwayMowers', 'Running Subway'),
    ('MausoleumMowers', 'Mausoleum'),
  ];

  static final _targetAliases = _mowerOptions.map((e) => e.$1).toSet();

  void _selectOption(String newAlias) {
    final def = widget.levelFile.objects
        .where((o) => o.objClass == 'LevelDefinition')
        .map((o) => LevelDefinitionData.fromJson(
            Map<String, dynamic>.from(o.objData as Map)))
        .firstOrNull;
    if (def == null) return;

    var index = def.modules.indexWhere((rtid) {
      final info = RtidParser.parse(rtid);
      return info != null && _targetAliases.contains(info.alias);
    });
    if (index == -1) {
      index = def.modules.indexWhere((rtid) => rtid == widget.rtid);
    }
    if (index == -1) return;

    def.modules[index] = RtidParser.build(newAlias, 'LevelModules');
    final defObj = widget.levelFile.objects
        .firstWhereOrNull((o) => o.objClass == 'LevelDefinition');
    if (defObj != null) {
      defObj.objData = def.toJson();
    }
    widget.onChanged();
    setState(() {});
  }

  String get _activeAlias {
    final def = widget.levelFile.objects
        .where((o) => o.objClass == 'LevelDefinition')
        .map((o) => LevelDefinitionData.fromJson(
            Map<String, dynamic>.from(o.objData as Map)))
        .firstOrNull;
    if (def == null) return RtidParser.parse(widget.rtid)?.alias ?? 'LawnMower';

    final found = def.modules.where((rtid) {
      final info = RtidParser.parse(rtid);
      return info != null && _targetAliases.contains(info.alias);
    }).firstOrNull;
    if (found != null) {
      return RtidParser.parse(found)?.alias ?? 'LawnMower';
    }
    return RtidParser.parse(widget.rtid)?.alias ?? 'LawnMower';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = isDark ? pvzGreenDark : pvzGreenLight;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n?.back ?? 'Back',
          onPressed: widget.onBack,
        ),
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        title: Text(
          l10n?.lawnMowerTitle ?? 'Lawn mower style',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: l10n?.tooltipAboutModule ?? 'About this module',
            onPressed: () {
              showEditorHelpDialog(
                context,
                title: l10n?.lawnMowerTitle ?? 'Lawn mower style',
                themeColor: accentColor,
                sections: [
                  HelpSectionData(
                    title: l10n?.overview ?? 'Overview',
                    body: l10n?.lawnMowerHelpOverview ??
                        'Controls lawn mower appearance. Lawn mowers are ineffective in Yard module.',
                  ),
                  HelpSectionData(
                    title: l10n?.lawnMowerNotes ?? 'Notes',
                    body: l10n?.lawnMowerHelpNotes ??
                        'Lawn mower module typically references LevelModules directly.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n?.lawnMowerSelectType ?? 'Select mower type',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _mowerOptions.length,
              itemBuilder: (context, i) {
                final option = _mowerOptions[i];
                final isSelected = option.$1 == _activeAlias;
                return Card(
                  color: theme.colorScheme.surface,
                  elevation: isSelected ? 4 : 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: isSelected
                        ? BorderSide(color: accentColor, width: 2)
                        : BorderSide.none,
                  ),
                  child: InkWell(
                    onTap: () => _selectOption(option.$1),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: option.$1,
                            groupValue: _activeAlias,
                            onChanged: (v) {
                              if (v != null) _selectOption(v);
                            },
                            activeColor: accentColor,
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.cleaning_services,
                            size: 20,
                            color: isSelected
                                ? accentColor
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            option.$2,
                            style: TextStyle(
                              fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
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
