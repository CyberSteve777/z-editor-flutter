import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';

/// JSON code viewer. Ported from Z-Editor-master JsonCodeViewerScreen.kt
class JsonViewerScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final pretty = const JsonEncoder.withIndent('  ').convert(levelFile.toJson());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: onBack),
        title: Text(fileName),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(right: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SelectableText(
                    pretty,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                      fontSize: 12,
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
