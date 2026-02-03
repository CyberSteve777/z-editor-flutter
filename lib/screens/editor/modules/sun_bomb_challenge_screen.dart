import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Sun bomb challenge editor. Ported from SunBombChallengePropertiesEP.kt
class SunBombChallengeScreen extends StatefulWidget {
  const SunBombChallengeScreen({
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
  State<SunBombChallengeScreen> createState() => _SunBombChallengeScreenState();
}

class _SunBombChallengeScreenState extends State<SunBombChallengeScreen> {
  late PvzObject _moduleObj;
  late SunBombChallengeData _data;
  late TextEditingController _plantRadiusCtrl;
  late TextEditingController _zombieRadiusCtrl;
  late TextEditingController _plantDamageCtrl;
  late TextEditingController _zombieDamageCtrl;

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
        objClass: 'SunBombChallengeProperties',
        objData: SunBombChallengeData().toJson(),
      ),
    );
    if (!widget.levelFile.objects.contains(_moduleObj)) {
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = SunBombChallengeData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = SunBombChallengeData();
    }
    _plantRadiusCtrl =
        TextEditingController(text: '${_data.plantBombExplosionRadius}');
    _zombieRadiusCtrl =
        TextEditingController(text: '${_data.zombieBombExplosionRadius}');
    _plantDamageCtrl = TextEditingController(text: '${_data.plantDamage}');
    _zombieDamageCtrl = TextEditingController(text: '${_data.zombieDamage}');
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  @override
  void dispose() {
    _plantRadiusCtrl.dispose();
    _zombieRadiusCtrl.dispose();
    _plantDamageCtrl.dispose();
    _zombieDamageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Sun bomb'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Sun bomb',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body:
                      'Turns falling sun into explosive sun bombs. Configure radius and damage.',
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
                      'Explosion radius',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _intField(
                            controller: _plantRadiusCtrl,
                            label: 'Plant radius',
                            onChanged: (v) {
                              final n = int.tryParse(v);
                              if (n != null) {
                                _data.plantBombExplosionRadius = n;
                                _sync();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _intField(
                            controller: _zombieRadiusCtrl,
                            label: 'Zombie radius',
                            onChanged: (v) {
                              final n = int.tryParse(v);
                              if (n != null) {
                                _data.zombieBombExplosionRadius = n;
                                _sync();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Damage',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _intField(
                            controller: _plantDamageCtrl,
                            label: 'Plant damage',
                            onChanged: (v) {
                              final n = int.tryParse(v);
                              if (n != null) {
                                _data.plantDamage = n;
                                _sync();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _intField(
                            controller: _zombieDamageCtrl,
                            label: 'Zombie damage',
                            onChanged: (v) {
                              final n = int.tryParse(v);
                              if (n != null) {
                                _data.zombieDamage = n;
                                _sync();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Radius is in pixels. One tile is about 60px.',
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

  Widget _intField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      onChanged: onChanged,
    );
  }
}
