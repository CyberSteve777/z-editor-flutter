import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_editor/data/level_repository.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/l10n/app_localizations.dart';

const _fontSizeKey = 'json_viewer_font_size';

/// Cached font size for immediate apply on screen enter (before async load).
double? _cachedFontSize;

enum _JsonViewMode { rawText, structured }

/// JSON code viewer. Ported from Z-Editor-master JsonCodeViewerScreen.kt
/// Includes font size slider, edit/save, and scrollbar.
class JsonViewerScreen extends StatefulWidget {
  const JsonViewerScreen({
    super.key,
    required this.fileName,
    required this.filePath,
    required this.levelFile,
    required this.onBack,
    this.onSaved,
  });

  final String fileName;
  final String filePath;
  final PvzLevelFile levelFile;
  final VoidCallback onBack;
  final VoidCallback? onSaved;

  @override
  State<JsonViewerScreen> createState() => _JsonViewerScreenState();
}

class _JsonViewerScreenState extends State<JsonViewerScreen> {
  double _fontSize = _cachedFontSize ?? 12;
  final _verticalController = ScrollController();
  final _horizontalController = ScrollController();
  bool _isEditing = false;
  final _editController = TextEditingController();
  String? _syntaxError;
  _JsonViewMode _viewMode = _JsonViewMode.rawText;
  final Map<int, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getDouble(_fontSizeKey);
    if (saved != null && mounted) {
      final value = saved.clamp(6.0, 18.0);
      _cachedFontSize = value;
      setState(() => _fontSize = value);
    }
  }

  Future<void> _saveFontSize(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontSizeKey, value);
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    _editController.dispose();
    super.dispose();
  }

  void _startEdit() {
    final pretty =
        const JsonEncoder.withIndent('  ').convert(widget.levelFile.toJson());
    _editController.text = pretty;
    setState(() {
      _isEditing = true;
      _syntaxError = null;
    });
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _syntaxError = null;
    });
  }

  Future<void> _saveEdit() async {
    try {
      final json = jsonDecode(_editController.text) as Map<String, dynamic>;
      final newLevel = PvzLevelFile.fromJson(json);
      widget.levelFile.objects.clear();
      widget.levelFile.objects.addAll(newLevel.objects);
      await LevelRepository.saveAndExport(widget.filePath, widget.levelFile);
      if (mounted) {
        setState(() {
          _isEditing = false;
          _syntaxError = null;
        });
        widget.onSaved?.call();
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.saved ?? 'Saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _syntaxError = 'JSON error: $e');
        final l10n = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n?.saveFail ?? 'Save failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;
    final pretty = _isEditing
        ? ''
        : const JsonEncoder.withIndent('  ').convert(widget.levelFile.toJson());

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_isEditing) _cancelEdit();
        widget.onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.arrow_back),
            onPressed: () {
              if (_isEditing) _cancelEdit();
              widget.onBack();
            },
          ),
        title: Text(
          _isEditing
              ? 'Edit mode'
              : _viewMode == _JsonViewMode.structured
                  ? 'Object mode'
                  : widget.fileName,
        ),
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveEdit,
            )
          else ...[
            IconButton(
              icon: Icon(
                _viewMode == _JsonViewMode.structured
                    ? Icons.list
                    : Icons.data_object,
              ),
              onPressed: () {
                setState(() {
                  _viewMode = _viewMode == _JsonViewMode.rawText
                      ? _JsonViewMode.structured
                      : _JsonViewMode.rawText;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _startEdit,
            ),
          ],
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.format_size,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_fontSize.toInt()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Expanded(
                    child: Slider(
                      value: _fontSize,
                      min: 6,
                      max: 18,
                      divisions: 12,
                      onChanged: (v) {
                        _cachedFontSize = v;
                        setState(() => _fontSize = v);
                        _saveFontSize(v);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_syntaxError != null)
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.error,
              padding: const EdgeInsets.all(8),
              child: Text(
                _syntaxError!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                  fontSize: 12,
                ),
              ),
            ),
          Expanded(
            child: _isEditing
                ? _buildEditView()
                : _viewMode == _JsonViewMode.structured
                    ? _buildObjectMode(isDesktop)
                    : _buildViewMode(pretty, isDesktop),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildEditView() {
    return Scrollbar(
      controller: _verticalController,
      thumbVisibility: true,
      trackVisibility: true,
      child: SingleChildScrollView(
        controller: _verticalController,
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _editController,
          maxLines: null,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'monospace',
                fontSize: _fontSize,
                height: 1.3,
              ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildViewMode(String pretty, bool isDesktop) {
    return SelectionArea(
      child: _buildScrollLayout(pretty, isDesktop),
    );
  }

  Widget _buildObjectMode(bool isDesktop) {
    final objects = widget.levelFile.objects;
    return Scrollbar(
      controller: _verticalController,
      thumbVisibility: true,
      trackVisibility: isDesktop,
      child: ListView.builder(
        controller: _verticalController,
        padding: const EdgeInsets.all(16),
        itemCount: objects.length,
        itemBuilder: (context, index) {
          return _ObjectCodeCard(
            index: index,
            obj: objects[index],
            fontSize: _fontSize,
            expanded: _expandedStates[index] ?? true,
            onToggle: () {
              setState(() {
                _expandedStates[index] = !(_expandedStates[index] ?? false);
              });
            },
            onDelete: () => _deleteObjectAtIndex(index),
          );
        },
      ),
    );
  }

  void _deleteObjectAtIndex(int index) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n?.deleteObjectTitle ?? 'Delete object?'),
        content: Text(
          l10n?.deleteObjectConfirmMessage ??
              'Remove this object from the level file? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n?.cancel ?? 'Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n?.delete ?? 'Delete'),
          ),
        ],
      ),
    );
    if (ok == true && mounted) {
      widget.levelFile.objects.removeAt(index);
      await LevelRepository.saveAndExport(widget.filePath, widget.levelFile);
      widget.onSaved?.call();
      setState(() {});
      if (mounted) {
        final l10nAfter = AppLocalizations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10nAfter?.objectDeleted ?? 'Object deleted'),
          ),
        );
      }
    }
  }

  /// Scrollable JSON view. On desktop, vertical scrollbar stays visible on right.
  Widget _buildScrollLayout(String pretty, bool isDesktop) {
    return Scrollbar(
      controller: _verticalController,
      thumbVisibility: true,
      trackVisibility: isDesktop,
      interactive: isDesktop,
      child: SingleChildScrollView(
        controller: _verticalController,
        scrollDirection: Axis.vertical,
        child: Scrollbar(
          controller: _horizontalController,
          thumbVisibility: true,
          trackVisibility: isDesktop,
          notificationPredicate: (n) => n.depth == 1,
          child: SingleChildScrollView(
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                pretty,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                      fontSize: _fontSize,
                      height: 1.3,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ObjectCodeCard extends StatelessWidget {
  const _ObjectCodeCard({
    required this.index,
    required this.obj,
    required this.fontSize,
    required this.expanded,
    required this.onToggle,
    required this.onDelete,
  });

  final int index;
  final PvzObject obj;
  final double fontSize;
  final bool expanded;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isLevelDef = obj.objClass == 'LevelDefinition';
    final jsonContent =
        const JsonEncoder.withIndent('  ').convert(obj.objData);
    final headerBg = isDark
        ? const Color(0xFF2E7D32)
        : const Color(0xFF4CAF50);
    final deleteBtnBg = isDark
        ? const Color(0xFF66BB6A)
        : const Color(0xFF81C784);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: headerBg,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isLevelDef &&
                            obj.aliases != null &&
                            obj.aliases!.isNotEmpty)
                          Text(
                            'Aliases: ${obj.aliases!.join(', ')}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        Text(
                          'ObjClass: ${obj.objClass}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: deleteBtnBg,
                    borderRadius: BorderRadius.circular(6),
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: onDelete,
                      color: Colors.white,
                      iconSize: 20,
                      padding: const EdgeInsets.all(6),
                      constraints: const BoxConstraints(),
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            SelectionArea(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  jsonContent,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: 'monospace',
                    fontSize: fontSize,
                    height: 1.3,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
