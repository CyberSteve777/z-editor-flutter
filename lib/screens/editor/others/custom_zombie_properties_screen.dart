import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/rtid_parser.dart';
import 'package:z_editor/widgets/asset_image.dart';
import 'package:z_editor/widgets/editor_components.dart';

/// Custom zombie properties. Ported from CustomZombiePropertiesEP.kt
class CustomZombiePropertiesScreen extends StatefulWidget {
  const CustomZombiePropertiesScreen({
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
  State<CustomZombiePropertiesScreen> createState() =>
      _CustomZombiePropertiesScreenState();
}

class _CustomZombiePropertiesScreenState
    extends State<CustomZombiePropertiesScreen> {
  PvzObject? _typeObj;
  PvzObject? _propsObj;
  late ZombieTypeData _typeData;
  late ZombiePropertySheetData _propsData;
  final List<double> _resistances = List<double>.filled(7, 0.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final info = RtidParser.parse(widget.rtid);
    final alias = info?.alias ?? '';
    _typeObj = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(alias) == true,
    );
    if (_typeObj == null) {
      setState(() {});
      return;
    }
    _typeData = ZombieTypeData.fromJson(
      Map<String, dynamic>.from(_typeObj!.objData as Map),
    );
    final propsAlias = RtidParser.parse(_typeData.properties)?.alias ?? '';
    _propsObj = widget.levelFile.objects.firstWhereOrNull(
      (o) => o.aliases?.contains(propsAlias) == true,
    );
    if (_propsObj != null) {
      _propsData = ZombiePropertySheetData.fromJson(
        Map<String, dynamic>.from(_propsObj!.objData as Map),
      );
    }
    final list = _typeData.resistences ?? const [];
    for (var i = 0; i < 7; i++) {
      _resistances[i] = i < list.length ? list[i] : 0.0;
    }
  }

  void _sync() {
    final allZero = _resistances.every((e) => e == 0.0);
    _typeData.resistences = allZero ? null : List<double>.from(_resistances);
    _typeObj?.objData = _typeData.toJson();
    _propsObj?.objData = _propsData.toJson();
    widget.onChanged();
    setState(() {});
  }

  String _formatRect(RectData? rect) {
    if (rect == null) return 'Default';
    return 'X:${rect.mX}, Y:${rect.mY}, W:${rect.mWidth}, H:${rect.mHeight}';
  }

  String _formatPoint(Point2D? pt) {
    if (pt == null) return 'Default';
    return 'X:${pt.x}, Y:${pt.y}';
  }

  String _formatPoint3D(Point3DDouble? pt) {
    if (pt == null) return 'Default';
    return 'X:${pt.x}, Y:${pt.y}, Z:${pt.z}';
  }

  Future<void> _showRectDialog({
    required String title,
    required RectData initial,
    required ValueChanged<RectData> onConfirm,
  }) async {
    final xController = TextEditingController(text: '${initial.mX}');
    final yController = TextEditingController(text: '${initial.mY}');
    final wController = TextEditingController(text: '${initial.mWidth}');
    final hController = TextEditingController(text: '${initial.mHeight}');
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: _numberField(xController, label: 'X'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _numberField(yController, label: 'Y'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _numberField(wController, label: 'Width'),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _numberField(hController, label: 'Height'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              onConfirm(
                RectData(
                  mX: int.tryParse(xController.text) ?? initial.mX,
                  mY: int.tryParse(yController.text) ?? initial.mY,
                  mWidth: int.tryParse(wController.text) ?? initial.mWidth,
                  mHeight: int.tryParse(hController.text) ?? initial.mHeight,
                ),
              );
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showPoint2Dialog({
    required String title,
    required Point2D initial,
    required ValueChanged<Point2D> onConfirm,
  }) async {
    final xController = TextEditingController(text: '${initial.x}');
    final yController = TextEditingController(text: '${initial.y}');
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Row(
          children: [
            Expanded(child: _numberField(xController, label: 'X')),
            const SizedBox(width: 8),
            Expanded(child: _numberField(yController, label: 'Y')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              onConfirm(
                Point2D(
                  x: int.tryParse(xController.text) ?? initial.x,
                  y: int.tryParse(yController.text) ?? initial.y,
                ),
              );
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showPoint3Dialog({
    required String title,
    required Point3DDouble initial,
    required ValueChanged<Point3DDouble> onConfirm,
  }) async {
    final xController = TextEditingController(text: '${initial.x}');
    final yController = TextEditingController(text: '${initial.y}');
    final zController = TextEditingController(text: '${initial.z}');
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _numberField(xController, label: 'X', isDouble: true),
            const SizedBox(height: 8),
            _numberField(yController, label: 'Y', isDouble: true),
            const SizedBox(height: 8),
            _numberField(zController, label: 'Z', isDouble: true),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              onConfirm(
                Point3DDouble(
                  x: double.tryParse(xController.text) ?? initial.x,
                  y: double.tryParse(yController.text) ?? initial.y,
                  z: double.tryParse(zController.text) ?? initial.z,
                ),
              );
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSizeTypeDialog() async {
    final options = <String?>[null, 'small', 'mid', 'large'];
    var selected = _propsData.sizeType;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((opt) {
            return RadioListTile<String?>(
              value: opt,
              groupValue: selected,
              title: Text(opt ?? 'null'),
              onChanged: (val) {
                selected = val;
                setState(() {});
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _propsData.sizeType = selected;
              _sync();
              Navigator.pop(ctx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _numberField(
    TextEditingController controller, {
    required String label,
    bool isDouble = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      onChanged: (_) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_typeObj == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          title: const Text('Custom zombie'),
        ),
        body: Center(
          child: Text(
            'Zombie type object not found.',
            style: theme.textTheme.titleMedium,
          ),
        ),
      );
    }
    if (_propsObj == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: widget.onBack,
          ),
          title: const Text('Custom zombie'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, size: 64, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                'Missing property sheet',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'This custom zombie does not reference a local property sheet.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('Custom zombie properties'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => showEditorHelpDialog(
              context,
              title: 'Custom zombie',
              sections: const [
                HelpSectionData(
                  title: 'Overview',
                  body:
                      'Adjust common zombie properties. Special attributes may still require manual JSON edits.',
                ),
                HelpSectionData(
                  title: 'Hit/Attack',
                  body:
                      'X/Y are offsets, W/H are sizes. ArtCenter can hide the sprite.',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Base stats',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  )),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _doubleInput(
                        label: 'Hitpoints',
                        value: _propsData.hitpoints,
                        onChanged: (v) {
                          _propsData.hitpoints = v;
                          _sync();
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _doubleInput(
                              label: 'Speed',
                              value: _propsData.speed,
                              onChanged: (v) {
                                _propsData.speed = v;
                                _sync();
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _doubleInput(
                              label: 'Speed variance',
                              value: _propsData.speedVariance ?? 0.1,
                              onChanged: (v) {
                                _propsData.speedVariance = v;
                                _sync();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _doubleInput(
                        label: 'EatDPS',
                        value: _propsData.eatDPS,
                        onChanged: (v) {
                          _propsData.eatDPS = v;
                          _sync();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Hit / position',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  )),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    _editRow(
                      title: 'HitRect',
                      subtitle: _formatRect(_propsData.hitRect),
                      icon: Icons.aspect_ratio,
                      onTap: () => _showRectDialog(
                        title: 'Edit HitRect',
                        initial: _propsData.hitRect ??
                            RectData(mX: 10, mY: 10, mWidth: 32, mHeight: 95),
                        onConfirm: (r) {
                          _propsData.hitRect = r;
                          _sync();
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    _editRow(
                      title: 'AttackRect',
                      subtitle: _formatRect(_propsData.attackRect),
                      icon: Icons.aspect_ratio,
                      onTap: () => _showRectDialog(
                        title: 'Edit AttackRect',
                        initial: _propsData.attackRect ??
                            RectData(mX: 15, mY: 0, mWidth: 20, mHeight: 95),
                        onConfirm: (r) {
                          _propsData.attackRect = r;
                          _sync();
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    _editRow(
                      title: 'ArtCenter',
                      subtitle: _formatPoint(_propsData.artCenter),
                      icon: Icons.center_focus_strong,
                      onTap: () => _showPoint2Dialog(
                        title: 'Edit ArtCenter',
                        initial:
                            _propsData.artCenter ?? Point2D(x: 90, y: 125),
                        onConfirm: (p) {
                          _propsData.artCenter = p;
                          _sync();
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    _editRow(
                      title: 'ShadowOffset',
                      subtitle: _formatPoint3D(_propsData.shadowOffset),
                      icon: Icons.layers,
                      onTap: () => _showPoint3Dialog(
                        title: 'Edit ShadowOffset',
                        initial: _propsData.shadowOffset ??
                            Point3DDouble(x: 5.0, y: 0.0, z: 1.2),
                        onConfirm: (p) {
                          _propsData.shadowOffset = p;
                          _sync();
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: DropdownButtonFormField<String>(
                        initialValue: _propsData.groundTrackName,
                        decoration: const InputDecoration(
                          labelText: 'GroundTrackName',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'ground_swatch',
                            child: Text('ground_swatch'),
                          ),
                          DropdownMenuItem(
                            value: '',
                            child: Text('null'),
                          ),
                        ],
                        onChanged: (val) {
                          if (val == null) return;
                          _propsData.groundTrackName = val;
                          _sync();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('Appearance & behavior',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  )),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: _showSizeTypeDialog,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('SizeType',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    _propsData.sizeType ?? 'null',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.edit, size: 18),
                          ],
                        ),
                      ),
                      const Divider(height: 24),
                      _switchRow(
                        title: 'Disable drop fractions',
                        checked: _propsData.armDropFraction != null ||
                            _propsData.headDropFraction != null,
                        onChanged: (checked) {
                          if (checked) {
                            _propsData.armDropFraction = -1;
                            _propsData.headDropFraction = 0;
                          } else {
                            _propsData.armDropFraction = null;
                            _propsData.headDropFraction = null;
                          }
                          _sync();
                        },
                      ),
                      _switchRow(
                        title: 'Immune to knockback',
                        checked: _propsData.canBeLaunchedByPlants != null ||
                            _propsData.canBePlantTossedStrong != null ||
                            _propsData.canBePlantTossedweak != null,
                        onChanged: (checked) {
                          if (checked) {
                            _propsData.canBeLaunchedByPlants = false;
                            _propsData.canBePlantTossedweak = false;
                            _propsData.canBePlantTossedStrong = false;
                          } else {
                            _propsData.canBeLaunchedByPlants = null;
                            _propsData.canBePlantTossedweak = null;
                            _propsData.canBePlantTossedStrong = null;
                          }
                          _sync();
                        },
                      ),
                      _switchRow(
                        title: 'Show health bar on damage',
                        checked: _propsData.enableShowHealthBarByDamage == true,
                        onChanged: (checked) {
                          _propsData.enableShowHealthBarByDamage =
                              checked ? true : null;
                          _propsData.drawHealthBarTime = checked
                              ? (_propsData.drawHealthBarTime ?? 4.0)
                              : null;
                          _sync();
                        },
                      ),
                      if (_propsData.enableShowHealthBarByDamage == true)
                        _doubleInput(
                          label: 'DrawHealthBarTime',
                          value: _propsData.drawHealthBarTime ?? 4.0,
                          onChanged: (v) {
                            _propsData.drawHealthBarTime = v;
                            _sync();
                          },
                        ),
                      _switchRow(
                        title: 'Enable elite scale',
                        checked: _propsData.enableEliteScale == true,
                        onChanged: (checked) {
                          _propsData.enableEliteScale = checked ? true : null;
                          _propsData.eliteScale = checked
                              ? (_propsData.eliteScale ?? 1.2)
                              : null;
                          _sync();
                        },
                      ),
                      if (_propsData.enableEliteScale == true)
                        _doubleInput(
                          label: 'EliteScale',
                          value: _propsData.eliteScale ?? 1.2,
                          onChanged: (v) {
                            _propsData.eliteScale = v;
                            _sync();
                          },
                        ),
                      _switchRow(
                        title: 'Enable elite immunities',
                        checked: _propsData.enableEliteImmunities == true,
                        onChanged: (checked) {
                          _propsData.enableEliteImmunities =
                              checked ? true : null;
                          _sync();
                        },
                      ),
                      _switchRow(
                        title: 'Can spawn plant food',
                        checked: _propsData.canSpawnPlantFood,
                        onChanged: (checked) {
                          _propsData.canSpawnPlantFood = checked;
                          _sync();
                        },
                      ),
                      _switchRow(
                        title: 'Can surrender',
                        checked: _propsData.canSurrender == true,
                        onChanged: (checked) {
                          _propsData.canSurrender = checked ? true : null;
                          _sync();
                        },
                      ),
                      _switchRow(
                        title: 'Can trigger zombie win',
                        checked: _propsData.canTriggerZombieWin != false,
                        onChanged: (checked) {
                          _propsData.canTriggerZombieWin = checked ? null : false;
                          _sync();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Resistences',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  )),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _resistanceInput(
                        index: 0,
                        label: 'Instant kill resistance',
                        iconPath: null,
                      ),
                      const SizedBox(height: 8),
                      for (var i = 0; i < 3; i++)
                        Row(
                          children: [
                            Expanded(
                              child: _resistanceInput(
                                index: 1 + i * 2,
                                label: _resLabels[1 + i * 2],
                                iconPath: _resIcons[1 + i * 2],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _resistanceInput(
                                index: 2 + i * 2,
                                label: _resLabels[2 + i * 2],
                                iconPath: _resIcons[2 + i * 2],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      Text(
                        '0.0 = none, 1.0 = full immunity',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Zombie type: ${_typeData.typeName}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                'Property alias: ${RtidParser.parse(_typeData.properties)?.alias ?? ''}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  static const _resLabels = [
    'Instant kill',
    'Physics',
    'Poison',
    'Electric',
    'Magic',
    'Ice',
    'Fire',
  ];

  static const _resIcons = [
    null,
    'assets/images/tags/Plant_Physics.webp',
    'assets/images/tags/Plant_Poison.webp',
    'assets/images/tags/Plant_Electric.webp',
    'assets/images/tags/Plant_Magic.webp',
    'assets/images/tags/Plant_Ice.webp',
    'assets/images/tags/Plant_Fire.webp',
  ];

  Widget _resistanceInput({
    required int index,
    required String label,
    required String? iconPath,
  }) {
    final controller = TextEditingController(
      text: _resistances[index].toStringAsFixed(2),
    );
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: iconPath != null
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: AssetImageWidget(
                  assetPath: iconPath,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  altCandidates: imageAltCandidates(iconPath),
                ),
              )
            : null,
      ),
      onChanged: (v) {
        final val = double.tryParse(v);
        if (val != null) {
          _resistances[index] = val.clamp(0.0, 1.0);
          _sync();
        }
      },
    );
  }

  Widget _editRow({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _switchRow({
    required String title,
    required bool checked,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        Switch(value: checked, onChanged: onChanged),
      ],
    );
  }

  Widget _doubleInput({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    final controller = TextEditingController(text: value.toString());
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      onChanged: (v) {
        final n = double.tryParse(v);
        if (n != null) onChanged(n);
      },
    );
  }
}
