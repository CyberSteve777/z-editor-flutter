import 'package:z_editor/data/repository/reference_repository.dart';

/// Grid item info. Ported from Z-Editor-master GridItemRepository.kt
/// For display use ResourceNames.lookup(context, 'griditem_$typeName').
enum GridItemFilterMode { all, restricted, renaiStatues }

enum GridItemTag { normal, special }

class GridItemInfo {
  const GridItemInfo({
    required this.typeName,
    required this.category,
    this.icon,
    this.tag = GridItemTag.normal,
  });

  final String typeName;
  final GridItemCategory category;
  /// Icon filename in assets/images/griditems/ (e.g. 'gravestone_egypt.webp').
  /// Null = use placeholder icon.
  final String? icon;
  final GridItemTag tag;
}

enum GridItemCategory {
  all('All'),
  scene('Scene'),
  trap('Trap'),
  spawnableObjects('Spawnable Objects');

  const GridItemCategory(this.label);
  final String label;
}

/// Grid item repository. Icons from assets/images/griditems/.
/// Items without matching icon use placeholder.
/// For localized display use getLocalizedName(context, typeName) via ResourceNames.
class GridItemRepository {
  GridItemRepository._();

  static final List<GridItemInfo> staticItems = [
    const GridItemInfo(typeName: 'gravestone_egypt', category: GridItemCategory.scene, icon: 'gravestone_egypt.webp'),
    const GridItemInfo(typeName: 'gravestone_dark', category: GridItemCategory.scene, icon: 'gravestone_dark.webp'),
    const GridItemInfo(typeName: 'gravestoneZombieOnDestruction', category: GridItemCategory.scene, icon: 'gravestone_dark.webp'),
    const GridItemInfo(typeName: 'gravestonePlantfoodOnDestruction', category: GridItemCategory.scene, icon: 'gravestonePlantfoodOnDestruction.webp'),
    const GridItemInfo(typeName: 'gravestoneSunOnDestruction', category: GridItemCategory.scene, icon: 'gravestoneSunOnDestruction.webp'),
    const GridItemInfo(typeName: 'gravestone_battlez_sun', category: GridItemCategory.scene, icon: 'gravestoneSunOnDestruction.webp'),
    const GridItemInfo(typeName: 'heian_box_sun', category: GridItemCategory.scene, icon: 'heian_box_sun.webp'),
    const GridItemInfo(typeName: 'heian_box_plantfood', category: GridItemCategory.scene, icon: 'heian_box_plantfood.webp'),
    const GridItemInfo(typeName: 'heian_box_levelup', category: GridItemCategory.scene, icon: 'heian_box_levelup.webp'),
    const GridItemInfo(typeName: 'heian_box_seedpacket', category: GridItemCategory.scene, icon: 'heian_box_seedpacket.webp'),
    const GridItemInfo(typeName: 'goldtile', category: GridItemCategory.scene, icon: 'goldtile.webp', tag: GridItemTag.special),
    const GridItemInfo(typeName: 'fake_mold', category: GridItemCategory.scene, icon: 'fake_mold.webp', tag: GridItemTag.special),
    const GridItemInfo(typeName: 'printer_small_paper', category: GridItemCategory.scene, icon: 'printer_small_paper.webp'),
    const GridItemInfo(typeName: 'pvz1grid', category: GridItemCategory.scene, icon: 'pvz1grid.webp'),
    const GridItemInfo(typeName: 'score_2x_tile', category: GridItemCategory.scene, icon: 'score_2x_tile.webp'),
    const GridItemInfo(typeName: 'score_3x_tile', category: GridItemCategory.scene, icon: 'score_3x_file.webp'),
    const GridItemInfo(typeName: 'score_5x_tile', category: GridItemCategory.scene, icon: 'score_5x_tile.webp'),
    const GridItemInfo(typeName: 'zombiepotion_speed', category: GridItemCategory.trap, icon: 'zombiepotion_speed.webp'),
    const GridItemInfo(typeName: 'zombiepotion_toughness', category: GridItemCategory.trap, icon: 'zombiepotion_toughness.webp'),
    const GridItemInfo(typeName: 'zombiepotion_invisible', category: GridItemCategory.trap, icon: 'zombiepotion_invisible.webp'),
    const GridItemInfo(typeName: 'zombiepotion_poison', category: GridItemCategory.trap, icon: 'zombiepotion_poison.webp'),
    const GridItemInfo(typeName: 'boulder_trap_falling_forward', category: GridItemCategory.trap, icon: 'boulder_trap_falling_forward.webp'),
    const GridItemInfo(typeName: 'flame_spreader_trap', category: GridItemCategory.trap, icon: 'flame_spreader_trap.webp'),
    const GridItemInfo(typeName: 'bufftile_shield', category: GridItemCategory.trap, icon: 'bufftile_shield.webp'),
    const GridItemInfo(typeName: 'bufftile_speed', category: GridItemCategory.trap, icon: 'bufftile_speed.webp'),
    const GridItemInfo(typeName: 'bufftile_attack', category: GridItemCategory.trap, icon: 'bufftile_attack.webp'),
    const GridItemInfo(typeName: 'zombie_bound_tile', category: GridItemCategory.trap, icon: 'zombie_bound_tile.webp'),
    const GridItemInfo(typeName: 'zombie_changer', category: GridItemCategory.trap, icon: 'zombie_changer.webp'),
    const GridItemInfo(typeName: 'slider_up', category: GridItemCategory.trap, icon: 'slider_up.webp'),
    const GridItemInfo(typeName: 'slider_down', category: GridItemCategory.trap, icon: 'slider_down.webp'),
    const GridItemInfo(typeName: 'slider_up_modern', category: GridItemCategory.trap, icon: 'slider_up_modern.webp'),
    const GridItemInfo(typeName: 'slider_down_modern', category: GridItemCategory.trap, icon: 'slider_down_modern.webp'),
    const GridItemInfo(typeName: 'christmas_protect', category: GridItemCategory.trap, icon: 'christmas_protect.webp', tag: GridItemTag.special),
    const GridItemInfo(typeName: 'dumpling', category: GridItemCategory.trap, icon: 'dumpling.webp'),
    const GridItemInfo(typeName: 'turkey', category: GridItemCategory.trap, icon: 'turkey.webp'),
    const GridItemInfo(typeName: 'tangyuan', category: GridItemCategory.trap, icon: 'tangyuan.webp'),
    const GridItemInfo(typeName: 'atlantis_shell', category: GridItemCategory.spawnableObjects, icon: 'atlantis_shell.webp'),
    const GridItemInfo(typeName: 'lilypad', category: GridItemCategory.spawnableObjects, icon: 'lilypad.webp'),
    const GridItemInfo(typeName: 'flowerpot', category: GridItemCategory.spawnableObjects, icon: 'flowerpot.webp'),
    const GridItemInfo(typeName: 'FrozenIcebloom', category: GridItemCategory.spawnableObjects, icon: 'FrozenIcebloom.webp', tag: GridItemTag.special),
    const GridItemInfo(typeName: 'FrozenChillyPepper', category: GridItemCategory.spawnableObjects, icon: 'FrozenChillyPepper.webp', tag: GridItemTag.special),
    const GridItemInfo(typeName: 'cavalrygun', category: GridItemCategory.spawnableObjects, icon: 'cavalrygun.webp'),
    const GridItemInfo(typeName: 'surfboard', category: GridItemCategory.spawnableObjects, icon: 'surfboard.webp'),
    const GridItemInfo(typeName: 'backpack', category: GridItemCategory.spawnableObjects, icon: 'backpack.webp'),
    const GridItemInfo(typeName: 'eightiesarcadecabinet', category: GridItemCategory.spawnableObjects, icon: 'eightiesarcadecabinet.webp'),
    const GridItemInfo(typeName: 'gridItem_sushi', category: GridItemCategory.spawnableObjects, icon: 'griditem_sushi.webp'),
    const GridItemInfo(typeName: 'dinoegg_zomshell', category: GridItemCategory.spawnableObjects, icon: 'dinoegg_zomshell.webp'),
    const GridItemInfo(typeName: 'dinoegg_ptero', category: GridItemCategory.spawnableObjects, icon: 'dinoegg_ptero.webp'),
    const GridItemInfo(typeName: 'dinoegg_bronto', category: GridItemCategory.spawnableObjects, icon: 'dinoegg_bronto.webp'),
    const GridItemInfo(typeName: 'dinoegg_tyranno', category: GridItemCategory.spawnableObjects, icon: 'dinoegg_tyranno.webp'),
    const GridItemInfo(typeName: 'lollipops', category: GridItemCategory.spawnableObjects, icon: 'lolipops.webp'),
    const GridItemInfo(typeName: 'gliding', category: GridItemCategory.spawnableObjects, icon: 'gliding.webp'),
    const GridItemInfo(typeName: 'heavy_shield', category: GridItemCategory.spawnableObjects, icon: 'heavy_shield.webp'),
    // Renai (Renaissance)
    const GridItemInfo(typeName: 'renai_roller', category: GridItemCategory.scene, icon: 'renai_roller.webp'),
    const GridItemInfo(typeName: 'renai_tile_left', category: GridItemCategory.scene, icon: 'renai_tile_left.webp'),
    const GridItemInfo(typeName: 'renai_tile_right', category: GridItemCategory.scene, icon: 'renai_tile_right.webp'),
    const GridItemInfo(typeName: 'renai_statue_zombie1', category: GridItemCategory.scene, icon: 'renai_statue_zombie1.png'),
    const GridItemInfo(typeName: 'renai_statue_zombie_armor1', category: GridItemCategory.scene, icon: 'renai_statue_zombie_armor1.png'),
    const GridItemInfo(typeName: 'renai_statue_zombie_armor2', category: GridItemCategory.scene, icon: 'renai_statue_zombie_armor2.png'),
    const GridItemInfo(typeName: 'renai_statue_zombie_carver', category: GridItemCategory.scene, icon: 'renai_statue_zombie_carver.png'),
    const GridItemInfo(typeName: 'renai_statue_zombie_perfumer', category: GridItemCategory.scene, icon: 'renai_statue_zombie_perfumer.png'),
    const GridItemInfo(typeName: 'renai_statue_zombie1_half', category: GridItemCategory.scene, icon: 'renai_statue_zombie1_half.png'),
    const GridItemInfo(typeName: 'renai_zomboss_statue_zombie1_half', category: GridItemCategory.scene, icon: 'renai_statue_zombie1_half.png'),
    const GridItemInfo(typeName: 'renai_statue_zombie_armor2_half', category: GridItemCategory.scene, icon: 'renai_statue_zombie_armor2_half.png'),
    const GridItemInfo(typeName: 'renai_statue_zombie_armor1_half', category: GridItemCategory.scene, icon: 'renai_statue_zombie_armor1_half.png'),
    const GridItemInfo(typeName: 'renai_statue_zombie_perfumer_half', category: GridItemCategory.scene, icon: 'renai_statue_zombie_perfumer_half.png'),
  ];

  static List<GridItemInfo> get allItems => staticItems;

  static List<GridItemInfo> getByCategory(GridItemCategory category) {
    if (category == GridItemCategory.all) return allItems;
    return allItems.where((i) => i.category == category).toList();
  }

  static List<GridItemInfo> getAll() => allItems;

  /// Returns asset path for icon, or unknown placeholder if no icon.
  /// For renai_zomboss_statue_zombie1_half, returns base statue icon path;
  /// caller should overlay purple "Z" badge when [needsZombossBadge] is true.
  static String getIconPath(String aliases) {
    final typeName = aliases == 'gravestone' ? 'gravestone_egypt' : aliases;
    try {
      final item = allItems.firstWhere((i) => i.typeName == typeName);
      final icon = item.icon;
      return icon != null
          ? 'assets/images/griditems/$icon'
          : 'assets/images/others/unknown.webp';
    } catch (_) {
      return 'assets/images/others/unknown.webp';
    }
  }

  /// True for renai_zomboss_statue_zombie1_half; caller should overlay purple "Z" badge.
  static bool needsZombossBadge(String typeName) =>
      typeName == 'renai_zomboss_statue_zombie1_half';

  /// True for Renai statue types that use full-body (non-half) icons.
  /// These are scaled down in [GridItemIcon] for better fit in grids and lists.
  static bool isRenaiStatueNonHalf(String typeName) =>
      _renaiStatueTypeNames.contains(typeName) && !typeName.endsWith('_half');

  /// True for any Renai statue type (half or non-half).
  static bool isRenaiStatue(String typeName) =>
      _renaiStatueTypeNames.contains(typeName);

  static const List<String> _renaiStatueTypeNames = [
    'renai_statue_zombie1',
    'renai_statue_zombie_armor1',
    'renai_statue_zombie_armor2',
    'renai_statue_zombie_carver',
    'renai_statue_zombie_perfumer',
    'renai_statue_zombie1_half',
    'renai_zomboss_statue_zombie1_half',
    'renai_statue_zombie_armor2_half',
    'renai_statue_zombie_armor1_half',
    'renai_statue_zombie_perfumer_half',
  ];

  /// Renai statue types only (for statue picker in Renai module).
  static List<GridItemInfo> getRenaiStatueItems() =>
      allItems.where((i) => _renaiStatueTypeNames.contains(i.typeName)).toList();

  static bool isValid(String typeName) {
    if (allItems.any((i) => i.typeName == typeName)) return true;
    return ReferenceRepository.instance.isValidGridItem(typeName);
  }

  static String buildGridAliases(String id) {
    if (id == 'gravestone_egypt') return 'gravestone';
    return id;
  }

  static List<GridItemInfo> search(String query) {
    if (query.trim().isEmpty) return allItems;
    final lower = query.toLowerCase();
    return allItems
        .where((i) => i.typeName.toLowerCase().contains(lower))
        .toList();
  }
}
