import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';

/// War mist properties. Ported from Z-Editor-master WarMistPropertiesEP.kt
class WarMistPropertiesScreen extends StatefulWidget {
  const WarMistPropertiesScreen({
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
  State<WarMistPropertiesScreen> createState() =>
      _WarMistPropertiesScreenState();
}

class _WarMistPropertiesScreenState extends State<WarMistPropertiesScreen> {
  late PvzObject _moduleObj;
  late WarMistPropertiesData _data;
  late TextEditingController _initPosController;
  late TextEditingController _normValController;
  late TextEditingController _bloverController;

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
        objClass: 'WarMistProperties',
        objData: WarMistPropertiesData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = WarMistPropertiesData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = WarMistPropertiesData();
    }
    _initPosController =
        TextEditingController(text: '${_data.initMistPosX}');
    _normValController = TextEditingController(text: '${_data.normValX}');
    _bloverController =
        TextEditingController(text: '${_data.bloverEffectInterval}');
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  @override
  void dispose() {
    _initPosController.dispose();
    _normValController.dispose();
    _bloverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('War mist'),
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
                      'Mist parameters',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _initPosController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Initial mist position X',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null && n >= 0) {
                          _data.initMistPosX = n;
                          _sync();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _normValController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Normal value X',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null && n >= 0) {
                          _data.normValX = n;
                          _sync();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _bloverController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Blover effect interval (seconds)',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) {
                        final n = int.tryParse(v);
                        if (n != null && n >= 0) {
                          _data.bloverEffectInterval = n;
                          _sync();
                        }
                      },
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
