/// Stage data for level editor. Ported from Z-Editor-master StageRepository.kt
enum StageType { all, main, extra, seasons, special }

class StageItem {
  const StageItem({
    required this.alias,
    required this.name,
    this.iconName,
    required this.type,
  });

  final String alias;
  final String name;
  final String? iconName;
  final StageType type;
}

class StageRepository {
  StageRepository._();

  static const List<StageItem> _database = [
    // Main
    StageItem(alias: 'TutorialStage', name: '教程庭院', iconName: 'Stage_Modern.webp', type: StageType.main),
    StageItem(alias: 'EgyptStage', name: '神秘埃及', iconName: 'Stage_Egypt.webp', type: StageType.main),
    StageItem(alias: 'PirateStage', name: '海盗港湾', iconName: 'Stage_Pirate.webp', type: StageType.main),
    StageItem(alias: 'WestStage', name: '狂野西部', iconName: 'Stage_West.webp', type: StageType.main),
    StageItem(alias: 'KongfuStage', name: '功夫世界', iconName: 'Stage_Kongfu.webp', type: StageType.main),
    StageItem(alias: 'FutureStage', name: '遥远未来', iconName: 'Stage_Future.webp', type: StageType.main),
    StageItem(alias: 'DarkStage', name: '黑暗时代', iconName: 'Stage_Dark.webp', type: StageType.main),
    StageItem(alias: 'BeachStage', name: '巨浪沙滩', iconName: 'Stage_Beach.webp', type: StageType.main),
    StageItem(alias: 'IceageStage', name: '冰河世纪', iconName: 'Stage_Iceage.webp', type: StageType.main),
    StageItem(alias: 'LostCityStage', name: '失落之城', iconName: 'Stage_LostCity.webp', type: StageType.main),
    StageItem(alias: 'SkycityStage', name: '天空之城', iconName: 'Stage_Skycity.webp', type: StageType.main),
    StageItem(alias: 'EightiesStage', name: '摇滚年代', iconName: 'Stage_Eighties.webp', type: StageType.main),
    StageItem(alias: 'DinoStage', name: '恐龙危机', iconName: 'Stage_Dino.webp', type: StageType.main),
    StageItem(alias: 'ModernStage', name: '现代世界', iconName: 'Stage_Modern.webp', type: StageType.main),
    StageItem(alias: 'SteamStage', name: '蒸汽时代', iconName: 'Stage_Steam.webp', type: StageType.main),
    StageItem(alias: 'RenaiStage', name: '复兴时代', iconName: 'Stage_Renai.webp', type: StageType.main),
    StageItem(alias: 'HeianStage', name: '平安时代', iconName: 'Stage_Heian.webp', type: StageType.main),
    StageItem(alias: 'DeepseaStage', name: '深海地图', iconName: 'Stage_Atlantis.webp', type: StageType.main),
    StageItem(alias: 'DeepseaLandStage', name: '亚特兰蒂斯', iconName: 'Stage_Atlantis.webp', type: StageType.main),
    // Extra
    StageItem(alias: 'FairyTaleStage', name: '童话森林', iconName: 'Stage_Fairytale.webp', type: StageType.extra),
    StageItem(alias: 'ZCorpStage', name: 'Z公司', iconName: 'Stage_ZCorp.webp', type: StageType.extra),
    StageItem(alias: 'FrontLawnSpringStage', name: '复活节', iconName: 'Stage_Easter.webp', type: StageType.extra),
    StageItem(alias: 'ChildrenDayStage', name: '儿童节', iconName: 'Stage_ChildrenDay.webp', type: StageType.extra),
    StageItem(alias: 'HalloweenStage', name: '万圣节', iconName: 'Stage_Halloween.webp', type: StageType.extra),
    StageItem(alias: 'UnchartedAnniversaryStage', name: '周年庆', iconName: 'Stage_Anniversary.webp', type: StageType.extra),
    StageItem(alias: 'VacationLostCityStage', name: '失落火山', iconName: 'Stage_LostVolcano.webp', type: StageType.extra),
    StageItem(alias: 'UnchartedIceageStage', name: '冰河再临', iconName: 'Stage_FBCR.webp', type: StageType.extra),
    StageItem(alias: 'RunningNormalStage', name: '地铁酷跑联动', iconName: 'Stage_Subway.webp', type: StageType.extra),
    StageItem(alias: 'UnchartedNeedforspeedStage', name: '极品飞车联动', iconName: 'Stage_NFS.webp', type: StageType.extra),
    StageItem(alias: 'UnchartedNo42UniverseStage', name: '平行宇宙秘境', iconName: 'Stage_PU41.webp', type: StageType.extra),
    StageItem(alias: 'JourneyToTheWestStage', name: '西游地图', iconName: 'Stage_JTTW.webp', type: StageType.extra),
    StageItem(alias: 'UnchartedMausoleumStage', name: '地宫地图', iconName: 'Stage_Underground.webp', type: StageType.extra),
    StageItem(alias: 'RiftStage', name: '潘妮的追击', iconName: 'Stage_Rift.webp', type: StageType.extra),
    StageItem(alias: 'JoustStage', name: '超Z联赛', iconName: 'Stage_Joust.webp', type: StageType.extra),
    // Seasons
    StageItem(alias: 'TwisterStage', name: '前院白天', iconName: 'Stage_Twister.webp', type: StageType.seasons),
    StageItem(alias: 'NightStage', name: '前院夜晚', iconName: 'Stage_Night.webp', type: StageType.seasons),
    StageItem(alias: 'PoolDaylightStage', name: '泳池白天', iconName: 'Stage_PoolDaylight.webp', type: StageType.seasons),
    StageItem(alias: 'PoolNightStage', name: '泳池夜晚', iconName: 'Stage_PoolNight.webp', type: StageType.seasons),
    StageItem(alias: 'RoofStage', name: '屋顶白天', iconName: 'Stage_Roof.webp', type: StageType.seasons),
    StageItem(alias: 'RoofNightStage', name: '屋顶夜晚', iconName: 'Stage_RoofNight.webp', type: StageType.seasons),
    StageItem(alias: 'NewYearDaylightStage', name: '新春白天', iconName: 'Stage_NewYearDaylight.webp', type: StageType.seasons),
    StageItem(alias: 'NewYearNightStage', name: '新春黑夜', iconName: 'Stage_NewYearNight.webp', type: StageType.seasons),
    StageItem(alias: 'SpringDaylightStage', name: '春日白天', iconName: 'Stage_SpringDaylight.webp', type: StageType.seasons),
    StageItem(alias: 'SpringNightStage', name: '春日夜晚', iconName: 'Stage_SpringNight.webp', type: StageType.seasons),
    StageItem(alias: 'SummerDaylightStage', name: '仲夏白天', iconName: 'Stage_SummerDaylight.webp', type: StageType.seasons),
    StageItem(alias: 'SummerNightStage', name: '仲夏夜晚', iconName: 'Stage_SummerNight.webp', type: StageType.seasons),
    StageItem(alias: 'AutumnEarlyStage', name: '秋季初秋', iconName: 'Stage_Autumn.webp', type: StageType.seasons),
    StageItem(alias: 'AutumnLateStage', name: '秋季晚秋', iconName: 'Stage_Autumn.webp', type: StageType.seasons),
    StageItem(alias: 'SnowModernStage', name: '冬日白天', iconName: 'Stage_SnowModern.webp', type: StageType.seasons),
    StageItem(alias: 'SnowNightStage', name: '冬日夜晚', iconName: 'Stage_SnowNight.webp', type: StageType.seasons),
    StageItem(alias: 'SnowRoofStage', name: '冬日屋顶', iconName: 'Stage_SnowRoof.webp', type: StageType.seasons),
    StageItem(alias: 'UnchartedArbordayStage', name: '踏雪寻春', iconName: 'Stage_WSSS.webp', type: StageType.seasons),
    // Special
    StageItem(alias: 'TheatreDarkStage', name: '黑暗剧院', iconName: 'Stage_TheatreDark.webp', type: StageType.special),
    StageItem(alias: 'BeachSnakeStage', name: '鳄梨贪吃蛇', iconName: 'Stage_BeachSnake.webp', type: StageType.special),
    StageItem(alias: 'IceageRiverCrossingStage', name: '渡渡鸟历险', iconName: 'Stage_IceageRiverCrossing.webp', type: StageType.special),
    StageItem(alias: 'IceageEliminateStage', name: '冰河连连看', iconName: 'Stage_IceageEliminate.webp', type: StageType.special),
    StageItem(alias: 'SkycityFishingStage', name: '一炮当关', iconName: 'Stage_SkycityFishing.webp', type: StageType.special),
    StageItem(alias: 'SkycityPooyanStage', name: '壮植凌云', iconName: 'Stage_SkycityPooyan.webp', type: StageType.special),
    StageItem(alias: 'AquariumStage', name: '水族馆', iconName: 'Stage_Aquarium.webp', type: StageType.special),
    StageItem(alias: 'BowlingStage', name: '保龄球', iconName: 'Stage_Bowling.webp', type: StageType.special),
    StageItem(alias: 'WhackAMoleStage', name: '锤僵尸', iconName: 'Stage_WhackAMole.webp', type: StageType.special),
    StageItem(alias: 'CardGameStage', name: '牌面纷争', iconName: 'Stage_CardGame.webp', type: StageType.special),
    StageItem(alias: 'OverwhelmStage', name: '排山倒海', iconName: 'Stage_CLYSE.webp', type: StageType.special),
    StageItem(alias: 'OverwhelmSnowModernStage', name: '冬日排山倒海', iconName: 'Stage_SnowModern.webp', type: StageType.special),
    StageItem(alias: 'OverwhelmSnowRoofStage', name: '冬日排山倒海屋顶', iconName: 'Stage_SnowRoof.webp', type: StageType.special),
    StageItem(alias: 'OverwhelmSnowNightStage', name: '冬日排山倒海夜晚', iconName: 'Stage_SnowNight.webp', type: StageType.special),
  ];

  static List<StageItem> get allItems => List.unmodifiable(_database);

  static List<StageItem> getByType(StageType type) {
    if (type == StageType.all) return allItems;
    return _database.where((s) => s.type == type).toList();
  }

  /// Localization key for stage name. Use ResourceNames.lookup(context, getName(alias)).
  static String getName(String alias) => 'stage_$alias';
}
