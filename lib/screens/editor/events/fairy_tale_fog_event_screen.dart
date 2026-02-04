import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Fairy tale fog event editor. Ported from Z-Editor-master FairyTaleFogWaveActionPropsEP.kt
class FairyTaleFogEventScreen extends StatefulWidget {
  const FairyTaleFogEventScreen({
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
  State<FairyTaleFogEventScreen> createState() => _FairyTaleFogEventScreenState();
}

class _FairyTaleFogEventScreenState extends State<FairyTaleFogEventScreen> {
  late PvzObject _moduleObj;
  late FairyTaleFogWaveActionData _data;

  static const _fogOptions = [
    ('fairy_tale_fog_lvl1', 'Level 1'),
    ('fairy_tale_fog_lvl2', 'Level 2'),
    ('fairy_tale_fog_lvl3', 'Level 3'),
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
        objClass: 'FairyTaleFogWaveActionProps',
        objData: FairyTaleFogWaveActionData().toJson(),
      );
      widget.levelFile.objects.add(_moduleObj);
    }
    try {
      _data = FairyTaleFogWaveActionData.fromJson(
        Map<String, dynamic>.from(_moduleObj.objData as Map),
      );
    } catch (_) {
      _data = FairyTaleFogWaveActionData();
    }
  }

  void _sync() {
    _moduleObj.objData = _data.toJson();
    widget.onChanged();
    setState(() {});
  }

  bool _isCellInFog(int col, int row) {
    final r = _data.range;
    return col >= r.mX &&
        col < r.mX + r.mWidth &&
        row >= r.mY &&
        row < r.mY + r.mHeight;
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
              'Event: Fairy fog',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Fairy fog event',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body: '本事件用于生成覆盖场地、给僵尸提供护盾的迷雾，常用于童话森林关卡，只有微风事件才能吹散。',
                ),
                HelpSectionData(
                  title: 'Range',
                  body: 'mX 和 mY 为计算中心点，mWidth 和 mHeight 分别表示含中心点向右和向下延伸的距离。',
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
                      Text(
                        'Fog parameters',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        initialValue: _fogOptions
                                .any((e) => e.$1 == _data.fogType)
                            ? _data.fogType
                            : null,
                        decoration: const InputDecoration(
                          labelText: 'Fog type (FogType)',
                          border: OutlineInputBorder(),
                        ),
                        items: _fogOptions
                            .map((e) => DropdownMenuItem(
                                  value: e.$1,
                                  child: Text(e.$2),
                                ))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            _data = FairyTaleFogWaveActionData(
                              movingTime: _data.movingTime,
                              fogType: v,
                              range: _data.range,
                            );
                            _sync();
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: _data.movingTime.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Moving time (MovingTime)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: (v) {
                          final n = double.tryParse(v);
                          if (n != null) {
                            _data = FairyTaleFogWaveActionData(
                              movingTime: n,
                              fogType: _data.fogType,
                              range: _data.range,
                            );
                            _sync();
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Range (Range)',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: _data.range.mX.toString(),
                              decoration: const InputDecoration(
                                labelText: 'mX',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                final n = int.tryParse(v);
                                if (n != null) {
                                  _data = FairyTaleFogWaveActionData(
                                    movingTime: _data.movingTime,
                                    fogType: _data.fogType,
                                    range: FogRangeData(
                                      mX: n,
                                      mY: _data.range.mY,
                                      mWidth: _data.range.mWidth,
                                      mHeight: _data.range.mHeight,
                                    ),
                                  );
                                  _sync();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              initialValue: _data.range.mY.toString(),
                              decoration: const InputDecoration(
                                labelText: 'mY',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                final n = int.tryParse(v);
                                if (n != null) {
                                  _data = FairyTaleFogWaveActionData(
                                    movingTime: _data.movingTime,
                                    fogType: _data.fogType,
                                    range: FogRangeData(
                                      mX: _data.range.mX,
                                      mY: n,
                                      mWidth: _data.range.mWidth,
                                      mHeight: _data.range.mHeight,
                                    ),
                                  );
                                  _sync();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: _data.range.mWidth.toString(),
                              decoration: const InputDecoration(
                                labelText: 'mWidth',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                final n = int.tryParse(v);
                                if (n != null) {
                                  _data = FairyTaleFogWaveActionData(
                                    movingTime: _data.movingTime,
                                    fogType: _data.fogType,
                                    range: FogRangeData(
                                      mX: _data.range.mX,
                                      mY: _data.range.mY,
                                      mWidth: n,
                                      mHeight: _data.range.mHeight,
                                    ),
                                  );
                                  _sync();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              initialValue: _data.range.mHeight.toString(),
                              decoration: const InputDecoration(
                                labelText: 'mHeight',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {
                                final n = int.tryParse(v);
                                if (n != null) {
                                  _data = FairyTaleFogWaveActionData(
                                    movingTime: _data.movingTime,
                                    fogType: _data.fogType,
                                    range: FogRangeData(
                                      mX: _data.range.mX,
                                      mY: _data.range.mY,
                                      mWidth: _data.range.mWidth,
                                      mHeight: n,
                                    ),
                                  );
                                  _sync();
                                }
                              },
                            ),
                          ),
                        ],
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
                        'Fog preview',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AspectRatio(
                        aspectRatio: 9 / 5,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9,
                            childAspectRatio: 1,
                          ),
                          itemCount: 45,
                          itemBuilder: (context, i) {
                            final col = i % 9;
                            final row = i ~/ 9;
                            final inFog = _isCellInFog(col, row);
                            return Container(
                              decoration: BoxDecoration(
                                color: inFog
                                    ? Colors.purple.withValues(alpha: 0.5)
                                    : theme.colorScheme.surfaceContainerHighest,
                                border: Border.all(
                                  color: theme.colorScheme.outlineVariant,
                                ),
                              ),
                            );
                          },
                        ),
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
