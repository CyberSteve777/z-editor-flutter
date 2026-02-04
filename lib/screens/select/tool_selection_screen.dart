import 'package:flutter/material.dart';
import 'package:z_editor/data/tool_repository.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget;

/// Tool selection. Ported from Z-Editor-master ToolSelectionScreen.kt
class ToolSelectionScreen extends StatelessWidget {
  const ToolSelectionScreen({
    super.key,
    required this.onToolSelected,
    required this.onBack,
  });

  final void Function(String id) onToolSelected;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final tools = ToolRepository.getAll();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: const Text(
          'Select tool card',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.85,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: tools.length,
        itemBuilder: (context, index) {
          final tool = tools[index];
          final iconPath = tool.icon != null
              ? 'assets/images/tools/${tool.icon}'
              : null;
          return Card(
            child: InkWell(
              onTap: () => onToolSelected(tool.id),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconPath != null)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: AssetImageWidget(
                          assetPath: iconPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Icon(
                        Icons.build,
                        size: 32,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      tool.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
