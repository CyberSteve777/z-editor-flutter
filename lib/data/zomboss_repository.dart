import 'package:collection/collection.dart';
import 'package:z_editor/l10n/app_localizations.dart';

enum ZombossTag {
  all,
  main,
  challenge,
  pvz1;

  String getLabel(AppLocalizations? l10n) {
    switch (this) {
      case ZombossTag.all:
        return '全部僵王'; // TODO: Localize
      case ZombossTag.main:
        return '主线/摩登';
      case ZombossTag.challenge:
        return '挑战/周年';
      case ZombossTag.pvz1:
        return '回忆之旅';
    }
  }
}

class ZombossInfo {
  const ZombossInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.tag,
    required this.defaultPhaseCount,
  });

  final String id;
  final String name;
  final String icon;
  final ZombossTag tag;
  final int defaultPhaseCount;
}

class ZombossRepository {
  static const List<ZombossInfo> allZombosses = [
    ZombossInfo(id: "zombossmech_egypt", name: "神秘埃及僵王 (狮身终结者)", icon: "zombossmech_egypt.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_pirate", name: "海盗港湾僵王 (甲板漫步者)", icon: "zombossmech_pirate.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_cowboy", name: "狂野西部僵王 (牛车格斗者)", icon: "zombossmech_cowboy.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_future", name: "遥远未来僵王 (明日破译者)", icon: "zombossmech_future.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_dark", name: "黑暗时代僵王 (巨龙驾驭者)", icon: "zombossmech_dark.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_beach", name: "巨浪沙滩僵王 (狂鲨潜袭者)", icon: "zombossmech_beach.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_iceage", name: "冰河世界僵王 (獠牙征服者)", icon: "zombossmech_iceage.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_skycity", name: "天空之城僵王 (秃鹫战机)", icon: "zombossmech_skycity.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_lostcity", name: "失落之城僵王 (云霄航行者)", icon: "zombossmech_lostcity.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_eighties", name: "摇滚年代僵王 (狂舞灭碎者)", icon: "zombossmech_eighties.webp", tag: ZombossTag.main, defaultPhaseCount: 5),
    ZombossInfo(id: "zombossmech_dino", name: "恐龙危机僵王 (金刚咆哮者)", icon: "zombossmech_dino.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_steam", name: "蒸汽时代僵王 (蒸汽火车头)", icon: "zombossmech_steam.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_renai", name: "复兴时代僵王 (剧团操纵者)", icon: "zombossmech_renai.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_hydra", name: "童话森林僵王 (魔咒吟唱者)", icon: "zombossmech_hydra.webp", tag: ZombossTag.main, defaultPhaseCount: 3),

    ZombossInfo(id: "zombossmech_modern_egypt", name: "摩登埃及僵王 (狮身终结者)", icon: "zombossmech_egypt.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_modern_pirate", name: "摩登海盗僵王 (甲板漫步者)", icon: "zombossmech_pirate.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_modern_cowboy", name: "摩登西部僵王 (牛车格斗者)", icon: "zombossmech_cowboy.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_modern_future", name: "摩登未来僵王 (明日破译者)", icon: "zombossmech_future.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_modern_dark", name: "摩登黑暗僵王 (巨龙驾驭者)", icon: "zombossmech_dark.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_modern_beach", name: "摩登沙滩僵王 (狂鲨潜袭者)", icon: "zombossmech_beach.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_modern_iceage", name: "摩登冰河僵王 (獠牙征服者)", icon: "zombossmech_iceage.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_modern_lostcity", name: "摩登失落僵王 (云霄航行者)", icon: "zombossmech_lostcity.webp", tag: ZombossTag.main, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_modern_eighties", name: "摩登摇滚僵王 (狂舞灭碎者)", icon: "zombossmech_eighties.webp", tag: ZombossTag.main, defaultPhaseCount: 5),
    ZombossInfo(id: "zombossmech_modern_dino", name: "摩登恐龙僵王 (金刚咆哮者)", icon: "zombossmech_dino.webp", tag: ZombossTag.main, defaultPhaseCount: 3),

    ZombossInfo(id: "zombossmech_egypt_vacation", name: "挑战埃及僵王 (狮身终结者)", icon: "zombossmech_egypt.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_pirate_vacation", name: "挑战海盗僵王 (甲板漫步者)", icon: "zombossmech_pirate.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_cowboy_vacation", name: "挑战西部僵王 (牛车格斗者)", icon: "zombossmech_cowboy.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_future_vacation", name: "挑战未来僵王 (明日破译者)", icon: "zombossmech_future.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_dark_vacation", name: "挑战黑暗僵王 (巨龙驾驭者)", icon: "zombossmech_dark.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_beach_vacation", name: "挑战沙滩僵王 (狂鲨潜袭者)", icon: "zombossmech_beach.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_iceage_vacation", name: "挑战冰河僵王 (獠牙征服者)", icon: "zombossmech_iceage.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_skycity_vacation", name: "挑战天空僵王 (秃鹫战机)", icon: "zombossmech_skycity.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_lostcity_vacation", name: "挑战失落僵王 (云霄航行者)", icon: "zombossmech_lostcity.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_eighties_vacation", name: "挑战摇滚僵王 (狂舞灭碎者)", icon: "zombossmech_eighties.webp", tag: ZombossTag.challenge, defaultPhaseCount: 5),
    ZombossInfo(id: "zombossmech_dino_vacation", name: "挑战恐龙僵王 (金刚咆哮者)", icon: "zombossmech_dino.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),

    ZombossInfo(id: "zombossmech_egypt_12th", name: "周年埃及僵王 (狮身终结者)", icon: "zombossmech_egypt.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_pirate_12th", name: "周年海盗僵王 (甲板漫步者)", icon: "zombossmech_pirate.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_cowboy_12th", name: "周年西部僵王 (牛车格斗者)", icon: "zombossmech_cowboy.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_future_12th", name: "周年未来僵王 (明日破译者)", icon: "zombossmech_future.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_dark_12th", name: "周年黑暗僵王 (巨龙驾驭者)", icon: "zombossmech_dark.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_beach_12th", name: "周年沙滩僵王 (狂鲨潜袭者)", icon: "zombossmech_beach.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_iceage_12th", name: "周年冰河僵王 (獠牙征服者)", icon: "zombossmech_iceage.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_skycity_12th", name: "周年天空僵王 (秃鹫战机)", icon: "zombossmech_skycity.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_lostcity_12th", name: "周年失落僵王 (云霄航行者)", icon: "zombossmech_lostcity.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_eighties_12th", name: "周年摇滚僵王 (狂舞灭碎者)", icon: "zombossmech_eighties.webp", tag: ZombossTag.challenge, defaultPhaseCount: 5),
    ZombossInfo(id: "zombossmech_dino_12th", name: "周年恐龙僵王 (金刚咆哮者)", icon: "zombossmech_dino.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_steam_12th", name: "周年蒸汽僵王 (蒸汽火车头)", icon: "zombossmech_steam.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_renai_12th", name: "周年复兴僵王 (剧团操纵者)", icon: "zombossmech_renai.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),
    ZombossInfo(id: "zombossmech_hydra_12th", name: "周年童话僵王 (魔咒吟唱者)", icon: "zombossmech_hydra.webp", tag: ZombossTag.challenge, defaultPhaseCount: 3),

    ZombossInfo(id: "zombossmech_pvz1_robot_normal", name: "无畏者2号简单版 (优化版本)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_hard", name: "无畏者2号困难版 (优化版本)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_1", name: "无畏者2号第1种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_2", name: "无畏者2号第2种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_3", name: "无畏者2号第3种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_4", name: "无畏者2号第4种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_5", name: "无畏者2号第5种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_6", name: "无畏者2号第6种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_7", name: "无畏者2号第7种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_8", name: "无畏者2号第8种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
    ZombossInfo(id: "zombossmech_pvz1_robot_9", name: "无畏者2号第9种 (旧版回忆)", icon: "zombossmech_pvz1_robot.webp", tag: ZombossTag.pvz1, defaultPhaseCount: 4),
  ];

  static ZombossInfo? get(String id) {
    return allZombosses.where((e) => e.id == id).firstOrNull;
  }

  static String getName(String id) {
    return get(id)?.name ?? id;
  }

  static List<ZombossInfo> search(String query, ZombossTag selectedTag) {
    var tagFiltered = allZombosses;
    if (selectedTag != ZombossTag.all) {
      tagFiltered = allZombosses.where((e) => e.tag == selectedTag).toList();
    }

    if (query.trim().isEmpty) return tagFiltered;

    final lowerQ = query.toLowerCase();
    return tagFiltered.where((e) =>
      e.id.toLowerCase().contains(lowerQ) || e.name.contains(lowerQ)
    ).toList();
  }
}
