import 'package:flutter/material.dart';
import 'package:z_editor/data/registry/event_registry.dart';
import 'package:z_editor/data/level_parser.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/repository/grid_item_repository.dart';
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

/// Card-sized add button that matches item card dimensions.
/// Used in initial plant/zombie/grid entry screens.
class AddItemCard extends StatelessWidget {
  const AddItemCard({
    super.key,
    required this.onPressed,
    this.width = 100,
    this.minHeight,
  });

  final VoidCallback onPressed;
  /// Card width. Use 140 to match [RenaiModuleScreen] statue cards.
  final double width;
  /// When set, card uses this height and centers the plus button vertically.
  /// Use to align with taller item cards (e.g. Renai statue cards).
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final button = PvzAddButton(onPressed: onPressed, size: 56);
    final content = minHeight != null
        ? Center(
            child: SizedBox(
              width: 64,
              height: 64,
              child: Center(child: button),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Center(
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: Center(child: button),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 12),
                child: SizedBox.shrink(),
              ),
            ],
          );
    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,
        height: minHeight,
        child: content,
      ),
    );
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

    final displayLabel = alias;

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
                )
              else if (meta != null)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(
                    meta.icon,
                    size: 14,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              Flexible(
                child: Text(
                  displayLabel,
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

/// Fish icon card with blue C (custom) badge. Similar to ZombieIconCard.
class FishIconCard extends StatelessWidget {
  const FishIconCard({
    super.key,
    required this.iconPath,
    required this.isCustom,
    required this.onTap,
    this.size = 56,
  });

  final String? iconPath;
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
                      Icons.pets,
                      size: 24,
                      color: theme.colorScheme.onSurfaceVariant,
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
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF1976D2)
                            : const Color(0xFF42A5F5),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
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

/// Input decoration for editor screens.
/// When not focused: border and label (including floating label) use theme onSurface.
/// When focused and [focusColor] set: border and floating label use [focusColor].
/// Pass [isFocused] from the field's FocusNode so the floating label only uses [focusColor] when focused.
InputDecoration editorInputDecoration(
  BuildContext context, {
  String? labelText,
  String? hintText,
  Color? focusColor,
  bool isFocused = false,
  bool filled = false,
  Color? fillColor,
}) {
  final theme = Theme.of(context);
  final unfocusedColor = theme.colorScheme.onSurface;
  final baseDecoration = InputDecoration(
    labelText: labelText,
    hintText: hintText,
    border: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: unfocusedColor.withValues(alpha: 0.6)),
    ),
    labelStyle: TextStyle(color: unfocusedColor),
    hintStyle: TextStyle(color: unfocusedColor.withValues(alpha: 0.7)),
    filled: filled,
    fillColor: fillColor,
  );
  if (focusColor == null) return baseDecoration;
  return baseDecoration.copyWith(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: focusColor, width: 2),
    ),
    floatingLabelStyle: TextStyle(color: isFocused ? focusColor : unfocusedColor),
    focusColor: focusColor,
  );
}

/// Icon for grid items. For renai_zomboss_statue_zombie1_half,
/// overlays a purple "Z" badge on the base statue icon.
/// Use anywhere grid item icons are displayed (selection, grids, lists).
class GridItemIcon extends StatelessWidget {
  const GridItemIcon({
    super.key,
    required this.typeName,
    this.size = 40,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 8,
    this.iconScaleFactor = 1.0,
    this.badgeScaleFactor = 1.0,
  });

  final String typeName;
  final double size;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;
  /// Scale the icon (e.g. 1.25 for grid item editors).
  final double iconScaleFactor;
  /// Scale the zomboss badge (e.g. 2.0 for grid item editors).
  final double badgeScaleFactor;

  @override
  Widget build(BuildContext context) {
    final baseW = width ?? size;
    final baseH = height ?? size;
    var scale = iconScaleFactor;
    if (GridItemRepository.isRenaiStatueNonHalf(typeName)) {
      scale *= 0.55;
    }
    final w = baseW * scale;
    final h = baseH * scale;
    final path = GridItemRepository.getIconPath(typeName);
    final showBadge = GridItemRepository.needsZombossBadge(typeName);
    final effectiveFit = GridItemRepository.isRenaiStatue(typeName)
        ? BoxFit.contain
        : fit;
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AssetImageWidget(
        assetPath: path,
        width: w,
        height: h,
        fit: effectiveFit,
        altCandidates: imageAltCandidates(path),
      ),
    );
    if (!showBadge) return image;
    var badgeScale = (baseW < 48 || baseH < 48) ? 0.5 : 0.65;
    badgeScale *= badgeScaleFactor;
    final padH = (4.0 * badgeScale).clamp(2.0, 8.0);
    final padV = (2.0 * badgeScale).clamp(1.0, 4.0);
    final fSize = (10.0 * badgeScale).clamp(6.0, 20.0);
    final radius = (4.0 * badgeScale).clamp(2.0, 8.0);
    final offset = (2.0 * badgeScale).clamp(1.0, 4.0);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        image,
        Positioned(
          top: offset,
          left: offset,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
            decoration: BoxDecoration(
              color: const Color(0xFF7B1FA2),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Text(
              'Z',
              style: TextStyle(
                color: Colors.white,
                fontSize: fSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Alias for [GridItemIcon] when used for Renai statues. Maintains backward compatibility.
class RenaiStatueIcon extends StatelessWidget {
  const RenaiStatueIcon({
    super.key,
    required this.typeName,
    this.size = 40,
    this.fit = BoxFit.cover,
  });

  final String typeName;
  final double size;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) =>
      GridItemIcon(typeName: typeName, size: size, fit: fit);
}
