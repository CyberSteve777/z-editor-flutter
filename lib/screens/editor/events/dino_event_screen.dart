import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Dino event editor. Ported from Z-Editor-master DinoEventEP.kt
class DinoEventScreen extends StatefulWidget {
  const DinoEventScreen({
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
  State<DinoEventScreen> createState() => _DinoEventScreenState();
}

class _DinoEventScreenState extends State<DinoEventScreen> {
  late PvzObject _moduleObj;
  late DinoWaveActionPropsData _data;

  static const _dinoOptions = [
    ('raptor', 'Raptor'),
    ('stego', 'Stego'),
    ('ptero', 'Ptero'),
    ('tyranno', 'Tyranno'),
    ('ankylo', 'Ankylo'),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final alias = LevelParser.extractAlias(widget.rtid);
    final existing = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (existing != null) {
      _moduleObj = existing;
    } else {
      _moduleObj = PvzObject(
        aliases: [alias],
        objClass: 'DinoWaveActionProps',
        objData: DinoWaveActionPropsData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = DinoWaveActionPropsData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = DinoWaveActionPropsData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final alias = LevelParser.extractAlias(widget.rtid);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit $alias'),
            Text(
              'Event: Dino summon',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Dino event',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: '恐龙危机专属事件。在指定的行召唤一只指定的恐龙进入场地，恐龙会协助僵尸进攻。',
                ),
                HelpSectionData(
                  title: 'Duration',
                  body: '恐龙在场上停留的时间，单位为波次。',
                ),
              ],
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.pets, color: theme.colorScheme.secondary),
                          const SizedBox(width: 8),
                          Text(
                            'Dino type (DinoType)',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        initialValue: _dinoOptions
                                .any((e) => e.$1 == _data.dinoType)
                            ? _data.dinoType
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Dino type',
                          border: OutlineInputBorder(),
                        ),
                        items: _dinoOptions
                            .map((e) => DropdownMenuItem(
                                  value: e.$1,
                                  child: Text(e.$2),
                                ))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            _data = DinoWaveActionPropsData(
                              dinoRow: _data.dinoRow,
                              dinoType: v,
                              dinoWaveDuration: _data.dinoWaveDuration,
                            );
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
                        'Position & duration',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Row (DinoRow): ${_data.dinoRow + 1}'),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _data.dinoRow > 0
                                ? () {
                                    _data = DinoWaveActionPropsData(
                                      dinoRow: _data.dinoRow - 1,
                                      dinoType: _data.dinoType,
                                      dinoWaveDuration: _data.dinoWaveDuration,
                                    );
                                    _sync();
                                  }
                                : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _data.dinoRow < 4
                                ? () {
                                    _data = DinoWaveActionPropsData(
                                      dinoRow: _data.dinoRow + 1,
                                      dinoType: _data.dinoType,
                                      dinoWaveDuration: _data.dinoWaveDuration,
                                    );
                                    _sync();
                                  }
                                : null,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: _data.dinoWaveDuration.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Duration (DinoWaveDuration)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (v) {
                          final n = int.tryParse(v);
                          if (n != null) {
                            _data = DinoWaveActionPropsData(
                              dinoRow: _data.dinoRow,
                              dinoType: _data.dinoType,
                              dinoWaveDuration: n,
                            );
                            _sync();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
