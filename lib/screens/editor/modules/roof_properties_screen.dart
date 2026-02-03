import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';

/// Roof properties. Ported from Z-Editor-master RoofPropertiesEP.kt
class RoofPropertiesScreen extends StatefulWidget {
  const RoofPropertiesScreen({
    super.key,
    required this.rtid,
    required this.levelFile,
    required this.levelDef,
    required this.onChanged,
    required this.onBack,
  });

  final String rtid;
  final PvzLevelFile levelFile;
  final LevelDefinitionData levelDef;
  final VoidCallback onChanged;
  final VoidCallback onBack;

  @override
  State<RoofPropertiesScreen> createState() => _RoofPropertiesScreenState();
}

class _RoofPropertiesScreenState extends State<RoofPropertiesScreen> {
  late PvzObject _moduleObj;
  late RoofPropertiesData _data;
  late TextEditingController _startColController;
  late TextEditingController _endColController;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';
    _moduleObj = widget.levelFile.objects.firstWhere(
      (o) => o.aliases?.contains(alias) == true,
      orElse: () => PvzObject(
        aliases: [alias],
        objClass: 'RoofProperties',
        objData: RoofPropertiesData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = RoofPropertiesData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = RoofPropertiesData();
    }
    _startColController =
        TextEditingController(text: '${_data.flowerPotStartColumn}');
    _endColController =
        TextEditingController(text: '${_data.flowerPotEndColumn}');
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  @override
  void dispose() {
    _startColController.dispose();
    _endColController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roof flower pot'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
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
                      'Flower pot columns (0-8)',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _startColController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Start column',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (v) {
                              final n = int.tryParse(v);
                              if (n != null && n >= 0 && n <= 8) {
                                _data.flowerPotStartColumn = n;
                                _sync();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _endColController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'End column',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (v) {
                              final n = int.tryParse(v);
                              if (n != null && n >= 0 && n <= 8) {
                                _data.flowerPotEndColumn = n;
                                _sync();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Columns ${_data.flowerPotStartColumn} to ${_data.flowerPotEndColumn} will have flower pots.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
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
