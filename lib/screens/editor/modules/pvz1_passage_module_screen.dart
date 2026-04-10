import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/theme/app_theme.dart' show pvzBrownDark, pvzBrownLight;
import 'package:z_editor/widgets/editor_components.dart'
    show editorInputDecoration, HelpSectionData, showEditorHelpDialog;

/// Editor for PVZ1-style passage (portal) combat module properties.
class PVZ1PassageModuleScreen extends StatefulWidget {
  const PVZ1PassageModuleScreen({
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
  State<PVZ1PassageModuleScreen> createState() =>
      _PVZ1PassageModuleScreenState();
}

class _FieldSpec {
  const _FieldSpec({
    required this.label,
    required this.tooltip,
    required this.getter,
    required this.setter,
  });

  final String label;
  final String tooltip;
  final int Function(PVZ1PassageModulePropertiesData) getter;
  final void Function(PVZ1PassageModulePropertiesData, int) setter;
}

class _PVZ1PassageModuleScreenState extends State<PVZ1PassageModuleScreen> {
  late PvzObject _moduleObj;
  late PVZ1PassageModulePropertiesData _data;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _loadData();
    _focusNodes = List.generate(6, (_) => FocusNode());
    for (final n in _focusNodes) {
      n.addListener(() => setState(() {}));
    }
    _controllers = [
      TextEditingController(text: '${_data.groupAmount}'),
      TextEditingController(text: '${_data.passageAmount}'),
      TextEditingController(text: '${_data.gridXMin}'),
      TextEditingController(text: '${_data.gridXMax}'),
      TextEditingController(text: '${_data.transferCooldown}'),
      TextEditingController(text: '${_data.refreshTime}'),
    ];
  }

  void _loadData() {
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';
    final existing = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (existing != null) {
      _moduleObj = existing;
    } else {
      _moduleObj = PvzObject(
        aliases: [alias],
        objClass: 'PVZ1PassageModuleProperties',
        objData: PVZ1PassageModulePropertiesData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = PVZ1PassageModulePropertiesData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = PVZ1PassageModulePropertiesData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  List<_FieldSpec> _fieldSpecs(AppLocalizations? l10n) {
    return [
      _FieldSpec(
        label: l10n?.pvz1PassageFieldGroupAmount ?? 'Group amount (GroupAmount)',
        tooltip: l10n?.pvz1PassageHelpGroupAmount ??
            'Number of distinct portal group types.',
        getter: (d) => d.groupAmount,
        setter: (d, v) => d.groupAmount = v,
      ),
      _FieldSpec(
        label: l10n?.pvz1PassageFieldPassageAmount ?? 'Passages per group (PassageAmount)',
        tooltip: l10n?.pvz1PassageHelpPassageAmount ??
            'How many portals exist in each group.',
        getter: (d) => d.passageAmount,
        setter: (d, v) => d.passageAmount = v,
      ),
      _FieldSpec(
        label: l10n?.pvz1PassageFieldGridXMin ?? 'Min column (GridXMin)',
        tooltip: l10n?.pvz1PassageHelpGridXMin ??
            'Minimum lawn column where portals can spawn.',
        getter: (d) => d.gridXMin,
        setter: (d, v) => d.gridXMin = v,
      ),
      _FieldSpec(
        label: l10n?.pvz1PassageFieldGridXMax ?? 'Max column (GridXMax)',
        tooltip: l10n?.pvz1PassageHelpGridXMax ??
            'Maximum lawn column where portals can spawn.',
        getter: (d) => d.gridXMax,
        setter: (d, v) => d.gridXMax = v,
      ),
      _FieldSpec(
        label: l10n?.pvz1PassageFieldTransferCooldown ??
            'Per-zombie transfer cooldown (transferCooldown)',
        tooltip: l10n?.pvz1PassageHelpTransferCooldown ??
            'Minimum time between teleports for the same zombie.',
        getter: (d) => d.transferCooldown,
        setter: (d, v) => d.transferCooldown = v,
      ),
      _FieldSpec(
        label: l10n?.pvz1PassageFieldRefreshTime ?? 'Portal reposition interval (refreshTime)',
        tooltip: l10n?.pvz1PassageHelpRefreshTime ??
            'How often portal positions are regenerated.',
        getter: (d) => d.refreshTime,
        setter: (d, v) => d.refreshTime = v,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = isDark ? pvzBrownDark : pvzBrownLight;
    final specs = _fieldSpecs(l10n);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n?.back ?? 'Back',
          onPressed: widget.onBack,
        ),
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        title: Text(l10n?.pvz1PassageModuleTitle ?? 'Portal combat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: l10n?.tooltipAboutModule ?? 'About this module',
            onPressed: () {
              showEditorHelpDialog(
                context,
                title: l10n?.pvz1PassageModuleTitle ?? 'Portal combat',
                themeColor: accentColor,
                sections: [
                  HelpSectionData(
                    title: l10n?.overview ?? 'Overview',
                    body: l10n?.pvz1PassageHelpOverview ??
                        'PVZ1-style passage portals: configure how many portal groups appear, '
                        'how many portals per group, spawn columns on the lawn, and timing '
                        'for zombie teleports and portal repositioning.',
                  ),
                  HelpSectionData(
                    title: l10n?.pvz1PassageHelpFieldsTitle ?? 'Fields',
                    body: specs
                        .map((s) => '${s.label}\n${s.tooltip}')
                        .join('\n\n'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n?.pvz1PassageSectionParams ?? 'Portal parameters',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 16),
                for (var i = 0; i < specs.length; i++) ...[
                  if (i > 0) const SizedBox(height: 12),
                  Tooltip(
                    message: specs[i].tooltip,
                    child: TextField(
                      focusNode: _focusNodes[i],
                      controller: _controllers[i],
                      keyboardType: TextInputType.number,
                      decoration: editorInputDecoration(
                        context,
                        labelText: specs[i].label,
                        focusColor: accentColor,
                        isFocused: _focusNodes[i].hasFocus,
                      ),
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null) {
                          specs[i].setter(_data, n);
                          _sync();
                        }
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
