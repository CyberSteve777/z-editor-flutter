import 'package:z_editor/data/repository/reference_repository.dart';

/// Grid item info. Ported from Z-Editor-master GridItemRepository.kt
/// For display use ResourceNames.lookup(context, 'griditem_$typeName').
enum GridItemFilterMode { all, restricted }

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
    const GridItemInfo(typeName: 'printer_small_paper', category: GridItemCategory.scene),
    const GridItemInfo(typeName: 'pvz1grid', category: GridItemCategory.scene),
    const GridItemInfo(typeName: 'score_2x_tile', category: GridItemCategory.scene),
    const GridItemInfo(typeName: 'score_3x_tile', category: GridItemCategory.scene),
    const GridItemInfo(typeName: 'score_5x_tile', category: GridItemCategory.scene),
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
    const GridItemInfo(typeName: 'christmas_protect', category: GridItemCategory.trap, tag: GridItemTag.special),
    const GridItemInfo(typeName: 'dumpling', category: GridItemCategory.trap),
    const GridItemInfo(typeName: 'turkey', category: GridItemCategory.trap),
    const GridItemInfo(typeName: 'tangyuan', category: GridItemCategory.trap),
    const GridItemInfo(typeName: 'lilypad', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'flowerpot', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'FrozenIcebloom', category: GridItemCategory.spawnableObjects, tag: GridItemTag.special),
    const GridItemInfo(typeName: 'FrozenChillyPepper', category: GridItemCategory.spawnableObjects, tag: GridItemTag.special),
    const GridItemInfo(typeName: 'cavalrygun', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'surfboard', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'backpack', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'eightiesarcadecabinet', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'gridItem_sushi', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'dinoegg_zomshell', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'dinoegg_ptero', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'dinoegg_bronto', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'dinoegg_tyranno', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'lollipops', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'gliding', category: GridItemCategory.spawnableObjects),
    const GridItemInfo(typeName: 'heavy_shield', category: GridItemCategory.spawnableObjects),
  ];

  static List<GridItemInfo> get allItems => staticItems;

  static List<GridItemInfo> getByCategory(GridItemCategory category) {
    if (category == GridItemCategory.all) return allItems;
    return allItems.where((i) => i.category == category).toList();
  }

  static List<GridItemInfo> getAll() => allItems;

  /// Returns asset path for icon, or unknown placeholder if no icon.
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
