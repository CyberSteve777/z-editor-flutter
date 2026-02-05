import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';

/// JSON code viewer. Ported from Z-Editor-master JsonCodeViewerScreen.kt
/// Includes font size slider for readability.
class JsonViewerScreen extends StatefulWidget {
  const JsonViewerScreen({
    super.key,
    required this.fileName,
    required this.levelFile,
    required this.onBack,
  });

  final String fileName;
  final PvzLevelFile levelFile;
  final VoidCallback onBack;

  @override
  State<JsonViewerScreen> createState() => _JsonViewerScreenState();
}

class _JsonViewerScreenState extends State<JsonViewerScreen> {
  double _fontSize = 12;
  final _verticalController = ScrollController();
  final _horizontalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pretty =
        const JsonEncoder.withIndent('  ').convert(widget.levelFile.toJson());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: widget.onBack),
        title: Text(widget.fileName),
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
                  Icon(Icons.format_size, size: 20, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 12),
                  Text('${_fontSize.toInt()}', style: Theme.of(context).textTheme.bodyMedium),
                  Expanded(
                    child: Slider(
                      value: _fontSize,
                      min: 6,
                      max: 18,
                      divisions: 12,
                      onChanged: (v) => setState(() => _fontSize = v),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SelectionArea(
              child: Scrollbar(
                controller: _verticalController,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _verticalController,
                  scrollDirection: Axis.vertical,
                  child: Scrollbar(
                    controller: _horizontalController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    notificationPredicate: (notif) => notif.depth == 1,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
