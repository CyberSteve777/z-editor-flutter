import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/widgets/editor_components.dart' show editorInputDecoration;

/// Death hole module editor. Ported from Z-Editor-master DeathHoleModuleEP.kt
class DeathHoleModuleScreen extends StatefulWidget {
  const DeathHoleModuleScreen({
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
  State<DeathHoleModuleScreen> createState() => _DeathHoleModuleScreenState();
}

class _DeathHoleModuleScreenState extends State<DeathHoleModuleScreen> {
  late PvzObject _moduleObj;
  late DeathHoleModuleData _data;
  late TextEditingController _lifeTimeCtrl;
  late FocusNode _lifeTimeFocusNode;

  @override
  void initState() {
    super.initState();
    _loadData();
    _lifeTimeFocusNode = FocusNode();
    _lifeTimeFocusNode.addListener(() => setState(() {}));
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
        objClass: 'DeathHoleModuleProperties',
        objData: DeathHoleModuleData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = DeathHoleModuleData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = DeathHoleModuleData();
    }
    _lifeTimeCtrl = TextEditingController(text: '${_data.lifeTime}');
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  @override
  void dispose() {
    _lifeTimeFocusNode.dispose();
    _lifeTimeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.onBack),
        title: Text(l10n?.deathHole ?? 'Death Hole'),
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
                  l10n?.duration ?? 'Duration',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  focusNode: _lifeTimeFocusNode,
                  controller: _lifeTimeCtrl,
                  keyboardType: TextInputType.number,
                  decoration: editorInputDecoration(
                    context,
                    labelText: l10n?.holeLifetimeSeconds ?? 'Hole lifetime (seconds)',
                    focusColor: Theme.of(context).colorScheme.primary,
                    isFocused: _lifeTimeFocusNode.hasFocus,
                  ),
                  onChanged: (v) {
                    final n = int.tryParse(v);
                    if (n != null) {
                      _data.lifeTime = n;
                      _sync();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
