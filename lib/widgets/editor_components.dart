import 'package:flutter/material.dart';
import 'package:z_editor/data/event_registry.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/theme/app_theme.dart';
import 'package:z_editor/widgets/asset_image.dart' show AssetImageWidget, imageAltCandidates;

/// Shared editor UI components. Ported from Z-Editor-master EditorComponents.kt

/// Square add button with rounded corners and + symbol.
/// Used in jittered, groundspawn and similar row-based editors.
/// Green for numbered rows, gray for random row.
class PvzAddButton extends StatelessWidget {
  const PvzAddButton({
    super.key,
    required this.onPressed,
    this.size = 48,
    this.label,
    this.useSecondaryColor = false,
  });

  final VoidCallback onPressed;
  final double size;
  final String? label;
  /// When true, uses gray (surface variant) instead of green (e.g. for random row).
  final bool useSecondaryColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color bgColor;
    final Color iconColor;
    if (useSecondaryColor) {
      bgColor = theme.colorScheme.surfaceContainerHighest;
      iconColor = theme.colorScheme.onSurfaceVariant;
    } else {
      bgColor = isDark ? pvzGreenDark.withValues(alpha: 0.35) : const Color(0xFFC8E6C9);
      iconColor = pvzGreenDark;
    }
    final btn = Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(Icons.add, color: iconColor, size: size * 0.55),
        ),
      ),
    );
    if (label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          btn,
          if (label!.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(label!, style: Theme.of(context).textTheme.labelLarge),
          ],
        ],
      );
    }
    return btn;
  }
}

/// Event chip for wave timeline. Ported from EventChip in EditorComponents.kt
class EventChipWidget extends StatelessWidget {
  const EventChipWidget({
    super.key,
    required this.rtid,
    required this.objectMap,
    required this.onTap,
  });

  final String rtid;
  final Map<String, PvzObject> objectMap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final alias = LevelParser.extractAlias(rtid);
    final obj = objectMap[alias];
    final isInvalid = obj == null;
    final meta = EventRegistry.getByObjClass(obj?.objClass);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isInvalid
        ? theme.colorScheme.error
        : (isDark ? (meta?.darkColor ?? theme.colorScheme.primary) : (meta?.color ?? theme.colorScheme.primary));

    String? summaryText;
    if (!isInvalid) {
      try {
        summaryText = meta?.summaryProvider?.call(obj);
      } catch (_) {}
    }

    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isInvalid)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(Icons.error_outline, size: 14, color: theme.colorScheme.onError),
                ),
              Flexible(
                child: Text(
                  alias,
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (summaryText != null && summaryText.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    summaryText,
                    style: TextStyle(color: theme.colorScheme.onPrimary, fontSize: 10),
                    maxLines: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Help dialog for editor screens.
void showEditorHelpDialog(
  BuildContext context, {
  required String title,
  required List<HelpSectionData> sections,
  Color? themeColor,
}) {
  showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Row(
        children: [
          Icon(Icons.help_outline, color: themeColor ?? Theme.of(ctx).colorScheme.primary),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: sections
              .map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ${s.title}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: themeColor ?? Theme.of(ctx).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            s.body,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text('OK', style: TextStyle(color: themeColor ?? Theme.of(ctx).colorScheme.primary)),
        ),
      ],
    ),
  );
}

class HelpSectionData {
  const HelpSectionData({required this.title, required this.body});
  final String title;
  final String body;
}

/// Zombie icon card with C (custom) badge in top-left, level badge in top-right.
/// Reused by jittered, storm, grid item spawn and similar zombie editors.
class ZombieIconCard extends StatelessWidget {
  const ZombieIconCard({
    super.key,
    required this.iconPath,
    required this.levelDisplay,
    required this.isElite,
    required this.isCustom,
    required this.onTap,
    this.size = 56,
  });

  final String? iconPath;
  final String levelDisplay;
  final bool isElite;
  final bool isCustom;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (iconPath != null && iconPath!.isNotEmpty)
                  AssetImageWidget(
                    assetPath: iconPath!,
                    altCandidates: imageAltCandidates(iconPath!),
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  )
                else
                  Center(
                    child: Icon(
                      Icons.warning,
                      size: 24,
                      color: theme.colorScheme.error,
                    ),
                  ),
                if (isCustom)
                  Positioned(
                    top: 2,
                    left: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: pvzOrangeLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'C',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.9,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      levelDisplay,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isDesktopPlatform(BuildContext context) {
  final platform = Theme.of(context).platform;
  return platform == TargetPlatform.windows ||
      platform == TargetPlatform.macOS ||
      platform == TargetPlatform.linux;
}

Widget scaleTableForDesktop({
  required BuildContext context,
  required Widget child,
  double desktopScale = 0.6,
}) {
  if (!isDesktopPlatform(context)) return child;
  return Center(
    child: FractionallySizedBox(widthFactor: desktopScale, child: child),
  );
}
