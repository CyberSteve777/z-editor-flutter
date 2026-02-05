import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';

/// Full-screen level basic info editor. Ported from Z-Editor-master LevelDefinitionEP.kt
class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({
    super.key,
    required this.levelFile,
    required this.levelDef,
    required this.onBack,
    required this.onStageTap,
    required this.onChanged,
  });

  final PvzLevelFile levelFile;
  final LevelDefinitionData levelDef;
  final VoidCallback onBack;
  final VoidCallback onStageTap;
  final VoidCallback onChanged;

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _levelNumCtrl;
  late TextEditingController _sunCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.levelDef.name);
    _descCtrl = TextEditingController(text: widget.levelDef.description);
    _levelNumCtrl = TextEditingController(text: '${widget.levelDef.levelNumber ?? 1}');
    _sunCtrl = TextEditingController(text: '${widget.levelDef.startingSun ?? 200}');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _levelNumCtrl.dispose();
    _sunCtrl.dispose();
    super.dispose();
  }

  void _sync() {
    final def = widget.levelDef;
    def.name = _nameCtrl.text;
    def.description = _descCtrl.text;
    def.levelNumber = int.tryParse(_levelNumCtrl.text) ?? 1;
    def.startingSun = int.tryParse(_sunCtrl.text) ?? 200;
    final obj = widget.levelFile.objects.where((o) => o.objClass == 'LevelDefinition').firstOrNull;
    if (obj != null) obj.objData = def.toJson();
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final def = widget.levelDef;
    final stageInfo = RtidParser.parse(def.stageModule);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.onBack),
        title: Text(l10n?.levelBasicInfo ?? 'Level basic info'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n?.levelBasicInfo ?? 'Basic info', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 12),
            TextField(
              controller: _nameCtrl,
              decoration: InputDecoration(labelText: l10n?.name ?? 'Name'),
              onChanged: (_) => _sync(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descCtrl,
              decoration: InputDecoration(labelText: l10n?.description ?? 'Description'),
              maxLines: 2,
              onChanged: (_) => _sync(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _levelNumCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n?.levelNumber ?? 'Level number'),
                    onChanged: (_) => _sync(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _sunCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: l10n?.startingSun ?? 'Starting sun'),
                    onChanged: (_) => _sync(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(l10n?.stageModule ?? 'Stage module', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.map),
                title: Text(stageInfo?.alias ?? def.stageModule),
                subtitle: Text(l10n?.stageModule ?? 'Stage module'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: widget.onStageTap,
              ),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: Text(l10n?.disablePeavine ?? 'Disable peavine', style: Theme.of(context).textTheme.bodyMedium),
              value: def.disablePeavine ?? false,
              onChanged: (v) {
                setState(() {
                  def.disablePeavine = v;
                  _sync();
                });
              },
            ),
            SwitchListTile(
              title: Text(l10n?.disableArtifact ?? 'Disable artifact', style: Theme.of(context).textTheme.bodyMedium),
              value: def.isArtifactDisabled ?? false,
              onChanged: (v) {
                setState(() {
                  def.isArtifactDisabled = v;
                  _sync();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull {
    final it = iterator;
    return it.moveNext() ? it.current : null;
  }
}
