import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Tide properties editor. Ported from Z-Editor-master TidePropertiesEP.kt
class TidePropertiesScreen extends StatefulWidget {
  const TidePropertiesScreen({
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
  State<TidePropertiesScreen> createState() => _TidePropertiesScreenState();
}

class _TidePropertiesScreenState extends State<TidePropertiesScreen> {
  late PvzObject _moduleObj;
  late TidePropertiesData _data;
  late TextEditingController _startLocCtrl;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? 'Tide';
    final existing = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (existing != null) {
      _moduleObj = existing;
    } else {
      _moduleObj = PvzObject(
        aliases: [alias],
        objClass: 'TideProperties',
        objData: TidePropertiesData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = TidePropertiesData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = TidePropertiesData();
    }
    _startLocCtrl = TextEditingController(text: '${_data.startingWaveLocation}');
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  @override
  void dispose() {
    _startLocCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final waterStart = 9 - _data.startingWaveLocation;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Tide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Tide',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: 'Enables tide system and sets initial tide position.',
                ),
                HelpSectionData(
                  title: 'Position',
                  body: 'Right edge is 0, left edge is 9. Negative values allowed.',
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Initial tide position',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _startLocCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Starting wave location',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null) {
                          _data.startingWaveLocation = n;
                          _sync();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preview',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    scaleTableForDesktop(
                      context: context,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: AspectRatio(
                          aspectRatio: 1.8,
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.brightness == Brightness.dark
                                  ? const Color(0xFF2A2A2A)
                                  : const Color(0xFFE0F2F1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: theme.dividerColor),
                            ),
                            child: Column(
                              children: List.generate(5, (row) {
                                return Expanded(
                                  child: Row(
                                    children: List.generate(9, (col) {
                                      final isWater = col >= waterStart;
                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.all(0.5),
                                          decoration: BoxDecoration(
                                            color: isWater
                                                ? Colors.blue.withValues(alpha: 0.4)
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: theme.dividerColor,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
