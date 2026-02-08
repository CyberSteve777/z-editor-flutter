// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '我的关卡库';

  @override
  String get about => '关于';

  @override
  String get back => '返回';

  @override
  String get refresh => '刷新';

  @override
  String get toggleTheme => '切换主题';

  @override
  String get switchFolder => '切换目录';

  @override
  String get clearCache => '释放缓存';

  @override
  String get uiSize => '界面大小';

  @override
  String get aboutSoftware => '关于软件';

  @override
  String get selectFolder => '选择文件夹';

  @override
  String get storagePermissionHint => '需要存储权限。请在设置中开启「允许管理所有文件」以打开关卡文件。';

  @override
  String get initSetup => '初始化设置';

  @override
  String get selectFolderPrompt => '请选择一个文件夹作为关卡存储目录。';

  @override
  String get selectFolderButton => '选择文件夹';

  @override
  String get emptyFolder => '文件夹为空';

  @override
  String get newFolder => '新建文件夹';

  @override
  String get newLevel => '新建关卡';

  @override
  String get rename => '重命名';

  @override
  String get delete => '删除';

  @override
  String get copy => '复制';

  @override
  String get move => '移动';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确定';

  @override
  String get create => '创建';

  @override
  String get newName => '新名称';

  @override
  String get folderName => '文件夹名称';

  @override
  String get confirmDelete => '确认删除';

  @override
  String confirmDeleteMessage(Object detail, Object name) {
    return '确定要删除 \"$name\" 吗？$detail';
  }

  @override
  String get folderDeleteDetail => '如果是文件夹，其内容也将被删除。';

  @override
  String get levelDeleteDetail => '此操作不可恢复。';

  @override
  String get confirmDeleteCheckbox => '我确定要永久删除';

  @override
  String get renameSuccess => '重命名成功';

  @override
  String get renameFail => '重命名失败，已有同名文件';

  @override
  String get deleted => '已删除';

  @override
  String get copyLevel => '复制关卡';

  @override
  String get newFileName => '新文件名';

  @override
  String get copySuccess => '复制成功';

  @override
  String get copyFail => '复制失败';

  @override
  String moving(Object name) {
    return '正在移动: $name';
  }

  @override
  String get movePrompt => '请导航至目标文件夹，然后点击粘贴';

  @override
  String get paste => '粘贴';

  @override
  String get folderCreated => '文件夹创建成功';

  @override
  String get createFail => '创建失败';

  @override
  String get noTemplates => '未找到模板';

  @override
  String get newLevelTemplate => '新建关卡 - 选择模板';

  @override
  String get nameLevel => '命名关卡';

  @override
  String get levelCreated => '创建成功';

  @override
  String get levelCreateFail => '创建失败，已有同名文件';

  @override
  String get adjustUiSize => '调整界面大小';

  @override
  String currentScale(Object percent) {
    return '当前缩放: $percent%';
  }

  @override
  String get small => '小';

  @override
  String get standard => '标准';

  @override
  String get large => '大';

  @override
  String get done => '完成';

  @override
  String get reset => '重置';

  @override
  String cacheCleared(Object count) {
    return '已清理 $count 个缓存文件';
  }

  @override
  String get returnUp => '返回上一级';

  @override
  String get jsonFile => 'JSON 文件';

  @override
  String get softwareIntro => '软件介绍';

  @override
  String get zEditor => 'Z-Editor';

  @override
  String get pvzEditorSubtitle => 'PVZ2 关卡可视化编辑器';

  @override
  String get introSection => '简介';

  @override
  String get introText =>
      'Z-Editor 是一款专为《植物大战僵尸2》设计的可视化关卡编辑工具。它旨在解决直接修改 JSON 文件繁琐、易错的问题，提供直观的图形界面来管理关卡配置。';

  @override
  String get featuresSection => '核心功能';

  @override
  String get feature1 => '模块化编辑：对关卡模块和事件进行模块化管理。';

  @override
  String get feature2 => '多模式支持：我是僵尸、砸罐子、坚不可摧、僵王战等。';

  @override
  String get feature3 => '自定义注入：在关卡内注入并管理自定义僵尸。';

  @override
  String get feature4 => '智能校验：检测模块依赖缺失、引用失效等问题。';

  @override
  String get usageSection => '使用说明';

  @override
  String get usageText =>
      '1. 目录设置：首次进入请选择存放 JSON 关卡文件的目录。\n2. 导入/新建：点击列表项编辑现有关卡，或使用右下角按钮基于模板新建。\n3. 模块管理：在编辑器中可添加新模块。\n4. 保存关卡：编辑完成后点击保存，文件将回写到原 JSON。\n交流 QQ 群：562251204';

  @override
  String get creditsSection => '致谢名单';

  @override
  String get authorLabel => '软件作者：';

  @override
  String get authorName => '降维打击';

  @override
  String get thanksLabel => '特别鸣谢：';

  @override
  String get thanksNames =>
      '星寻、metal海枣、超越自我3333、桃酱、凉沈、小小师、顾小言、PhiLia093、咖啡、不留名';

  @override
  String get tagline => '穿越时空 创造无穷可能';

  @override
  String version(Object version) {
    return '版本 $version';
  }

  @override
  String get language => '语言';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '中文';

  @override
  String get languageRussian => 'Русский';

  @override
  String get templateBlankLevel => '空白关卡';

  @override
  String get templateCardPickExample => '自选卡示例';

  @override
  String get templateConveyorExample => '传送带示例';

  @override
  String get templateLastStandExample => '坚不可摧示例';

  @override
  String get templateIZombieExample => '我是僵尸示例';

  @override
  String get templateVaseBreakerExample => '砸罐子示例';

  @override
  String get templateZombossExample => '僵王战示例';

  @override
  String get templateCustomZombieExample => '自定义僵尸示例';

  @override
  String get templateIPlantExample => '我是植物示例';

  @override
  String get unsavedChanges => '未保存的更改';

  @override
  String get saveBeforeLeaving => '离开前是否保存？';

  @override
  String get discard => '放弃';

  @override
  String get saved => '已保存';

  @override
  String get failedToLoadLevel => '加载关卡失败';

  @override
  String get noLevelDefinition => '未找到关卡定义';

  @override
  String get noLevelDefinitionHint =>
      '当前关卡内未找到关卡定义模块 (LevelDefinition)，这是关卡文件的基础节点。请尝试手动添加。';

  @override
  String get levelBasicInfo => '关卡基本信息';

  @override
  String get levelBasicInfoSubtitle => '名称、序号、描述、地图背景';

  @override
  String get removeModule => '移除模块';

  @override
  String get zombieCategoryMain => '按世界';

  @override
  String get zombieCategorySize => '按体型';

  @override
  String get zombieCategoryOther => '其他';

  @override
  String get zombieCategoryCollection => '我的收藏';

  @override
  String get zombieTagAll => '全部僵尸';

  @override
  String get zombieTagEgyptPirate => '埃及/海盗';

  @override
  String get zombieTagWestFuture => '西部/未来';

  @override
  String get zombieTagDarkBeach => '黑暗/沙滩';

  @override
  String get zombieTagIceageLostcity => '冰河/失落之城';

  @override
  String get zombieTagKongfuSkycity => '功夫/天空之城';

  @override
  String get zombieTagEightiesDino => '80年代/恐龙';

  @override
  String get zombieTagModernPvz1 => '现代/一代';

  @override
  String get zombieTagSteamRenai => '蒸汽/文艺复兴';

  @override
  String get zombieTagHenaiAtlantis => '平安/亚特兰蒂斯';

  @override
  String get zombieTagTaleZCorp => '童话/Z公司';

  @override
  String get zombieTagParkourSpeed => '跑酷/极速';

  @override
  String get zombieTagTothewest => '西游';

  @override
  String get zombieTagMemory => '回忆之旅';

  @override
  String get zombieTagUniverse => '平行宇宙';

  @override
  String get zombieTagFestival1 => '节日1';

  @override
  String get zombieTagFestival2 => '节日2';

  @override
  String get zombieTagRoman => '罗马';

  @override
  String get zombieTagPet => '宠物';

  @override
  String get zombieTagImp => '小鬼';

  @override
  String get zombieTagBasic => '基础';

  @override
  String get zombieTagFat => '胖子';

  @override
  String get zombieTagStrong => '强壮';

  @override
  String get zombieTagGargantuar => '巨人';

  @override
  String get zombieTagElite => '精英';

  @override
  String get zombieTagEvildave => '邪恶戴夫';

  @override
  String get plantCategoryQuality => '按品质';

  @override
  String get plantCategoryRole => '按角色';

  @override
  String get plantCategoryAttribute => '按属性';

  @override
  String get plantCategoryOther => '其他';

  @override
  String get plantCategoryCollection => '我的收藏';

  @override
  String get plantTagAll => '全部植物';

  @override
  String get plantTagWhite => '白品质';

  @override
  String get plantTagGreen => '绿品质';

  @override
  String get plantTagBlue => '蓝品质';

  @override
  String get plantTagPurple => '紫品质';

  @override
  String get plantTagOrange => '橙品质';

  @override
  String get plantTagAssist => '辅助';

  @override
  String get plantTagRemote => '远程';

  @override
  String get plantTagProductor => '生产';

  @override
  String get plantTagDefence => '防御';

  @override
  String get plantTagVanguard => '先锋';

  @override
  String get plantTagTrapper => '陷阱';

  @override
  String get plantTagFire => '火焰';

  @override
  String get plantTagIce => '寒冰';

  @override
  String get plantTagMagic => '魔法';

  @override
  String get plantTagPoison => '毒系';

  @override
  String get plantTagElectric => '电能';

  @override
  String get plantTagPhysics => '物理';

  @override
  String get plantTagOriginal => '一代原版';

  @override
  String get plantTagParallel => '平行世界';

  @override
  String get removeModuleConfirm =>
      '确定要移除该模块吗？本地自定义模块(@CurrentLevel)及其关联数据将一并删除，不可恢复。';

  @override
  String get confirmRemove => '确认移除';

  @override
  String get addModule => '添加模块';

  @override
  String get settings => '设置';

  @override
  String get timeline => '波次时间线';

  @override
  String get iZombie => '我是僵尸';

  @override
  String get vaseBreaker => '砸罐子';

  @override
  String get zomboss => '僵王战';

  @override
  String get moveSourceSameAsDest => '源目录和目标目录相同';

  @override
  String get moveSuccess => '移动成功';

  @override
  String get moveFail => '移动失败';

  @override
  String get rootFolder => '根目录';

  @override
  String get createEmptyWave => '创建空波次容器';

  @override
  String get noWaveManager => '未找到波次管理器';

  @override
  String get noWaveManagerHint => '此关卡有波次管理模块但缺少 WaveManagerProperties 对象。';

  @override
  String get waveTimelineHint => '点击事件编辑，点击 + 添加事件。';

  @override
  String get waveTimelineHintDetail => '左滑波次可删除。';

  @override
  String get waveTimelineGuideTitle => '操作指引';

  @override
  String get waveTimelineGuideBody => '右滑：管理波次事件\n左滑：删除该波次\n点击pt：查看期望';

  @override
  String get waveDeadLinksTitle => '引用失效报警';

  @override
  String get waveDeadLinksClear => '一键清理失效波次';

  @override
  String get customZombieManagerTitle => '自定义僵尸管理';

  @override
  String get customZombieEmpty => '暂无自定义僵尸数据';

  @override
  String get switchCustomZombie => '切换自定义僵尸';

  @override
  String get customZombieAppearanceLocation => '出现位置：';

  @override
  String get customZombieNotUsed => '此自定义僵尸当前未被任何波次或模块使用。';

  @override
  String customZombieWaveItem(int n) {
    return '第 $n 波';
  }

  @override
  String get customZombieDeleteConfirm => '将移除僵尸实体及其属性数据。';

  @override
  String get editCustomZombieProperties => '编辑自定义属性数值';

  @override
  String get makeZombieAsCustom => '注入为自定义僵尸';

  @override
  String get customLabel => '自定义';

  @override
  String get waveManagerGlobalParams => '波次管理器全局参数';

  @override
  String waveManagerGlobalSummary(
    int interval,
    int minPercent,
    int maxPercent,
  ) {
    return '旗帜间隔: $interval, 刷新血线: $minPercent% - $maxPercent%';
  }

  @override
  String get waveEmptyTitle => '当前波次列表为空';

  @override
  String get waveEmptySubtitle => '您可以添加第一个波次，或者删除这个空的容器。';

  @override
  String get waveHeaderPreview => '内容及点数预览';

  @override
  String waveTotalLabel(int total) {
    return '总计: $total';
  }

  @override
  String get waveEmptyRowHint => '空波次 (左右划操作)';

  @override
  String get removeFromWave => '从波次移除';

  @override
  String get deleteEventEntityTitle => '删除事件实体？';

  @override
  String get deleteEventEntityBody => '这会从关卡中移除该事件对象。';

  @override
  String waveEventsTitle(int wave) {
    return '第 $wave 波事件';
  }

  @override
  String get waveManagerSettings => '波次管理器设置';

  @override
  String get flagInterval => '旗帜间隔';

  @override
  String get waveManagerHelpTitle => '波次管理器';

  @override
  String get waveManagerHelpOverviewTitle => '简要介绍';

  @override
  String get waveManagerHelpOverviewBody => '全局参数与血线阈值设置。';

  @override
  String get waveManagerHelpFlagTitle => '旗帜间隔';

  @override
  String get waveManagerHelpFlagBody => '每 N 波为旗帜波，最后一波始终为旗帜波。';

  @override
  String get waveManagerHelpTimeTitle => '时间控制';

  @override
  String get waveManagerHelpTimeBody => '传送带关卡会使用不同的首波延迟。';

  @override
  String get waveManagerHelpMusicTitle => '音乐类型';

  @override
  String get waveManagerHelpMusicBody => '仅现代世界有效，设置固定背景音乐。';

  @override
  String get waveManagerBasicParams => '基础参数';

  @override
  String get waveManagerMaxHealthThreshold => '最大血线阈值';

  @override
  String get waveManagerMinHealthThreshold => '最小血线阈值';

  @override
  String get waveManagerThresholdHint => '阈值必须在 0 到 1 之间。';

  @override
  String get waveManagerTimeControl => '时间控制';

  @override
  String get waveManagerFirstWaveDelayConveyor => '首波延迟（传送带）';

  @override
  String get waveManagerFirstWaveDelayNormal => '首波延迟（常规）';

  @override
  String get waveManagerFlagWaveDelay => '旗帜波延迟';

  @override
  String get waveManagerConveyorDetected => '检测到传送带模块，使用传送带延迟。';

  @override
  String get waveManagerConveyorNotDetected => '未检测到传送带模块，使用常规延迟。';

  @override
  String get waveManagerSpecial => '特殊';

  @override
  String get waveManagerSuppressFlagZombieTitle => '禁用旗帜僵尸';

  @override
  String get waveManagerSuppressFlagZombieField => 'SuppressFlagZombie';

  @override
  String get waveManagerSuppressFlagZombieHint => '开启后旗帜波不再生成旗帜僵尸。';

  @override
  String get waveManagerLevelJam => '关卡 Jam';

  @override
  String get waveManagerLevelJamHint => '仅现代世界有效，设置固定背景音乐。';

  @override
  String get jamNone => '无';

  @override
  String get jamPop => '流行';

  @override
  String get jamRap => '说唱';

  @override
  String get jamMetal => '金属';

  @override
  String get jamPunk => '朋克';

  @override
  String get jam8Bit => '8 位';

  @override
  String get noWaves => '暂无波次';

  @override
  String get addFirstWave => '添加第一个波次。';

  @override
  String get deleteWave => '删除';

  @override
  String deleteWaveConfirm(int count) {
    return '将移除此波次及其 $count 个事件。';
  }

  @override
  String get addEvent => '添加事件';

  @override
  String get emptyWave => '空波次';

  @override
  String get addWave => '添加波次';

  @override
  String get expectation => '期望';

  @override
  String get close => '关闭';

  @override
  String get editProperties => '编辑属性';

  @override
  String get deleteEntity => '删除实体';

  @override
  String get deleteObjectTitle => '删除对象？';

  @override
  String get deleteObjectConfirmMessage => '从关卡文件中移除此对象？此操作不可撤销。';

  @override
  String get objectDeleted => '对象已删除';

  @override
  String get moduleEditorInProgress => '模块编辑器开发中';

  @override
  String get dataEmpty => '数据为空';

  @override
  String get saveSuccess => '保存成功';

  @override
  String get saveFail => '保存失败';

  @override
  String get confirmRemoveRef => '移除引用';

  @override
  String get confirmRemoveRefMessage => '确定要移除此引用吗？实体数据将保留直至所有引用被移除。';

  @override
  String get code => '代码';

  @override
  String get name => '名称';

  @override
  String get description => '描述';

  @override
  String get levelNumber => '关卡序号';

  @override
  String get startingSun => '初始阳光';

  @override
  String get stageModule => '关卡地图';

  @override
  String get musicType => '音乐类型';

  @override
  String get loot => '关卡默认掉落';

  @override
  String get victoryModule => '胜利结算方式';

  @override
  String get missingModules => '缺失模块';

  @override
  String get moduleConflict => '模块冲突';

  @override
  String get editableModules => '可用编辑模块';

  @override
  String get parameterModules => '默认参数模块';

  @override
  String get addNewModule => '添加新模块';

  @override
  String get selectStage => '选择地图';

  @override
  String get searchStage => '搜索地图名称或代号';

  @override
  String get noStageFound => '未找到相关地图';

  @override
  String get stageTypeAll => '全部地图';

  @override
  String get stageTypeMain => '主线世界';

  @override
  String get stageTypeExtra => '活动/秘境';

  @override
  String get stageTypeSeasons => '一代/季节';

  @override
  String get stageTypeSpecial => '小游戏';

  @override
  String get search => '搜索';

  @override
  String get disablePeavine => '禁用豆藤共生';

  @override
  String get disableArtifact => '禁用神器';

  @override
  String get selectPlant => '选择植物';

  @override
  String get searchPlant => '搜索植物';

  @override
  String get noPlantFound => '未找到植物';

  @override
  String noResultsFor(Object query) {
    return '没有关于“$query”的结果';
  }

  @override
  String get noModulesInCategory => '该分类下没有模块';

  @override
  String addEventForWave(int wave) {
    return '为第 $wave 波添加事件';
  }

  @override
  String get waveLabel => '波次';

  @override
  String get pointsLabel => '点数';

  @override
  String get noDynamicZombies => '没有动态僵尸';

  @override
  String get moduleTitle_WaveManagerModuleProperties => '波次管理器';

  @override
  String get moduleDesc_WaveManagerModuleProperties => '管理关卡波次事件';

  @override
  String get moduleTitle_CustomLevelModuleProperties => '草坪模块';

  @override
  String get moduleDesc_CustomLevelModuleProperties => '启用自定义草坪框架';

  @override
  String get moduleTitle_StandardLevelIntroProperties => '开场动画';

  @override
  String get moduleDesc_StandardLevelIntroProperties => '关卡开始镜头平移';

  @override
  String get moduleTitle_ZombiesAteYourBrainsProperties => '失败条件';

  @override
  String get moduleDesc_ZombiesAteYourBrainsProperties => '僵尸进房条件';

  @override
  String get moduleTitle_ZombiesDeadWinConProperties => '死亡掉落';

  @override
  String get moduleDesc_ZombiesDeadWinConProperties => '关卡稳定所需';

  @override
  String get moduleTitle_PennyClassroomModuleProperties => '植物阶位';

  @override
  String get moduleDesc_PennyClassroomModuleProperties => '全局植物阶位定义';

  @override
  String get moduleTitle_SeedBankProperties => '种子库';

  @override
  String get moduleDesc_SeedBankProperties => '预设植物与选取方式';

  @override
  String get moduleTitle_ConveyorSeedBankProperties => '传送带';

  @override
  String get moduleDesc_ConveyorSeedBankProperties => '预设传送带植物与权重';

  @override
  String get moduleTitle_SunDropperProperties => '阳光掉落';

  @override
  String get moduleDesc_SunDropperProperties => '控制掉落阳光频率';

  @override
  String get moduleTitle_LevelMutatorMaxSunProps => '最大阳光';

  @override
  String get moduleDesc_LevelMutatorMaxSunProps => '覆盖阳光上限';

  @override
  String get moduleTitle_LevelMutatorStartingPlantfoodProps => '初始植物食品';

  @override
  String get moduleDesc_LevelMutatorStartingPlantfoodProps => '覆盖初始植物食品';

  @override
  String get moduleTitle_StarChallengeModuleProperties => '挑战';

  @override
  String get moduleDesc_StarChallengeModuleProperties => '关卡限制与目标';

  @override
  String get moduleTitle_LevelScoringModuleProperties => '计分';

  @override
  String get moduleDesc_LevelScoringModuleProperties => '击杀获得分数';

  @override
  String get moduleTitle_BowlingMinigameProperties => '保龄球';

  @override
  String get moduleDesc_BowlingMinigameProperties => '设置阵线并禁用铲子';

  @override
  String get moduleTitle_NewBowlingMinigameProperties => '墙果保龄';

  @override
  String get moduleDesc_NewBowlingMinigameProperties => '保龄阵线设置';

  @override
  String get moduleTitle_VaseBreakerPresetProperties => '花瓶布局';

  @override
  String get moduleDesc_VaseBreakerPresetProperties => '配置花瓶内容';

  @override
  String get moduleTitle_VaseBreakerArcadeModuleProperties => '砸罐子模式';

  @override
  String get moduleDesc_VaseBreakerArcadeModuleProperties => '启用砸罐子界面';

  @override
  String get moduleTitle_VaseBreakerFlowModuleProperties => '花瓶动画';

  @override
  String get moduleDesc_VaseBreakerFlowModuleProperties => '控制花瓶掉落动画';

  @override
  String get moduleTitle_EvilDaveProperties => '我是僵尸';

  @override
  String get moduleDesc_EvilDaveProperties => '启用我是僵尸模式';

  @override
  String get moduleTitle_ZombossBattleModuleProperties => '僵王战';

  @override
  String get moduleDesc_ZombossBattleModuleProperties => 'Boss战参数';

  @override
  String get moduleTitle_ZombossBattleIntroProperties => '僵王开场';

  @override
  String get moduleDesc_ZombossBattleIntroProperties => 'Boss开场与血条';

  @override
  String get moduleTitle_SeedRainProperties => '种子雨';

  @override
  String get moduleDesc_SeedRainProperties => '掉落植物/僵尸/物品';

  @override
  String get moduleTitle_LastStandMinigameProperties => '坚不可摧';

  @override
  String get moduleDesc_LastStandMinigameProperties => '初始资源与准备阶段';

  @override
  String get moduleTitle_PVZ1OverwhelmModuleProperties => 'overwhelm';

  @override
  String get moduleDesc_PVZ1OverwhelmModuleProperties => 'overwhelm 小游戏';

  @override
  String get moduleTitle_SunBombChallengeProperties => '阳光炸弹';

  @override
  String get moduleDesc_SunBombChallengeProperties => '掉落阳光炸弹配置';

  @override
  String get moduleTitle_IncreasedCostModuleProperties => '通货膨胀';

  @override
  String get moduleDesc_IncreasedCostModuleProperties => '种植后阳光消耗增加';

  @override
  String get moduleTitle_DeathHoleModuleProperties => '死亡坑洞';

  @override
  String get moduleDesc_DeathHoleModuleProperties => '植物留下不可种植坑洞';

  @override
  String get moduleTitle_ZombieMoveFastModuleProperties => '快速入场';

  @override
  String get moduleDesc_ZombieMoveFastModuleProperties => '僵尸入场加速';

  @override
  String get moduleTitle_InitialPlantEntryProperties => '初始植物';

  @override
  String get moduleDesc_InitialPlantEntryProperties => '开局已有植物';

  @override
  String get moduleTitle_InitialZombieProperties => '初始僵尸';

  @override
  String get moduleDesc_InitialZombieProperties => '开局已有僵尸';

  @override
  String get moduleTitle_InitialGridItemProperties => '初始格点物品';

  @override
  String get moduleDesc_InitialGridItemProperties => '开局已有格点物品';

  @override
  String get moduleTitle_ProtectThePlantChallengeProperties => '保护植物';

  @override
  String get moduleDesc_ProtectThePlantChallengeProperties => '必须保护的植物';

  @override
  String get moduleTitle_ProtectTheGridItemChallengeProperties => '保护物品';

  @override
  String get moduleDesc_ProtectTheGridItemChallengeProperties => '必须保护的物品';

  @override
  String get moduleTitle_ZombiePotionModuleProperties => '僵尸药水';

  @override
  String get moduleDesc_ZombiePotionModuleProperties => '黑暗时代药水生成';

  @override
  String get moduleTitle_PiratePlankProperties => '海盗木板';

  @override
  String get moduleDesc_PiratePlankProperties => '海盗海域木板行';

  @override
  String get moduleTitle_RailcartProperties => '矿车';

  @override
  String get moduleDesc_RailcartProperties => '矿车与轨道布局';

  @override
  String get moduleTitle_PowerTileProperties => '电力格';

  @override
  String get moduleDesc_PowerTileProperties => '未来电力格布局';

  @override
  String get moduleTitle_ManholePipelineModuleProperties => '井盖管道';

  @override
  String get moduleDesc_ManholePipelineModuleProperties => '蒸汽时代管道';

  @override
  String get moduleTitle_RoofProperties => '屋顶花盆';

  @override
  String get moduleDesc_RoofProperties => '屋顶关卡花盆列';

  @override
  String get moduleTitle_TideProperties => '潮汐系统';

  @override
  String get moduleDesc_TideProperties => '启用潮汐系统';

  @override
  String get moduleTitle_WarMistProperties => '战争迷雾';

  @override
  String get moduleDesc_WarMistProperties => '战争迷雾系统';

  @override
  String get moduleTitle_RainDarkProperties => '天气';

  @override
  String get moduleDesc_RainDarkProperties => '雨、雪、风暴效果';

  @override
  String get eventTitle_SpawnZombiesFromGroundSpawnerProps => '地底出怪';

  @override
  String get eventDesc_SpawnZombiesFromGroundSpawnerProps => '从地下生成僵尸';

  @override
  String get eventTitle_SpawnZombiesJitteredWaveActionProps => '标准出怪';

  @override
  String get eventDesc_SpawnZombiesJitteredWaveActionProps => '基本自然出怪';

  @override
  String get eventTitle_FrostWindWaveActionProps => '霜冻风';

  @override
  String get eventDesc_FrostWindWaveActionProps => '行上的冰冻风';

  @override
  String get eventTitle_BeachStageEventZombieSpawnerProps => '低潮';

  @override
  String get eventDesc_BeachStageEventZombieSpawnerProps => '僵尸在低潮时出现';

  @override
  String get eventTitle_TidalChangeWaveActionProps => '潮汐变化';

  @override
  String get eventDesc_TidalChangeWaveActionProps => '改变潮位位置';

  @override
  String get eventTitle_ModifyConveyorWaveActionProps => '传送带修改';

  @override
  String get eventDesc_ModifyConveyorWaveActionProps => '动态添加/移除卡牌';

  @override
  String get eventTitle_DinoWaveActionProps => '恐龙召唤';

  @override
  String get eventDesc_DinoWaveActionProps => '在行上召唤恐龙';

  @override
  String get eventTitle_SpawnModernPortalsWaveActionProps => '时空裂隙';

  @override
  String get eventDesc_SpawnModernPortalsWaveActionProps => '生成时空裂隙';

  @override
  String get eventTitle_StormZombieSpawnerProps => '风暴出怪';

  @override
  String get eventDesc_StormZombieSpawnerProps => '沙尘暴或暴雪出怪';

  @override
  String get eventTitle_RaidingPartyZombieSpawnerProps => '海盗掠夺队';

  @override
  String get eventDesc_RaidingPartyZombieSpawnerProps => '海盗僵尸入侵';

  @override
  String get eventTitle_ZombiePotionActionProps => '药水掉落';

  @override
  String get eventDesc_ZombiePotionActionProps => '在网格上生成药水';

  @override
  String get eventTitle_SpawnGravestonesWaveActionProps => '墓碑生成';

  @override
  String get eventDesc_SpawnGravestonesWaveActionProps => '生成墓碑';

  @override
  String get eventTitle_SpawnZombiesFromGridItemSpawnerProps => '墓碑出怪';

  @override
  String get eventDesc_SpawnZombiesFromGridItemSpawnerProps => '从墓碑生成僵尸';

  @override
  String get eventTitle_FairyTaleFogWaveActionProps => '童话迷雾';

  @override
  String get eventDesc_FairyTaleFogWaveActionProps => '生成迷雾';

  @override
  String get eventTitle_FairyTaleWindWaveActionProps => '童话之风';

  @override
  String get eventDesc_FairyTaleWindWaveActionProps => '吹散迷雾';

  @override
  String get eventTitle_SpiderRainZombieSpawnerProps => '小鬼雨';

  @override
  String get eventDesc_SpiderRainZombieSpawnerProps => '小鬼从天而降';

  @override
  String get eventTitle_ParachuteRainZombieSpawnerProps => '降落伞雨';

  @override
  String get eventDesc_ParachuteRainZombieSpawnerProps => '僵尸带降落伞降落';

  @override
  String get eventTitle_BassRainZombieSpawnerProps => '低音/喷气背包雨';

  @override
  String get eventDesc_BassRainZombieSpawnerProps => '低音/喷气背包僵尸降落';

  @override
  String get eventTitle_BlackHoleWaveActionProps => '黑洞';

  @override
  String get eventDesc_BlackHoleWaveActionProps => '黑洞吸引植物';

  @override
  String get eventTitle_MagicMirrorWaveActionProps => '魔镜';

  @override
  String get eventDesc_MagicMirrorWaveActionProps => '镜子传送门';

  @override
  String get eventTitle_WaveActionMagicMirrorTeleportationArrayProps2 => '魔镜';

  @override
  String get eventDesc_WaveActionMagicMirrorTeleportationArrayProps2 => '镜子传送门';

  @override
  String get weatherOption_DefaultSnow_label => '冰河洞穴 (DefaultSnow)';

  @override
  String get weatherOption_DefaultSnow_desc => '冰河洞穴下雪效果';

  @override
  String get weatherOption_LightningRain_label => '雷暴 (LightningRain)';

  @override
  String get weatherOption_LightningRain_desc => '黑暗时代第8天雨与闪电';

  @override
  String get weatherOption_DefaultRainDark_label => '黑暗时代 (DefaultRainDark)';

  @override
  String get weatherOption_DefaultRainDark_desc => '黑暗时代雨天效果';

  @override
  String get iZombiePlantReserveLabel => '植物预留列（PlantDistance）';

  @override
  String get column => '列';

  @override
  String get iZombieInfoText => '在“我是僵尸”模式下，需在关卡模块（预设植物）和种子库中配置预设植物与僵尸。';

  @override
  String get vaseRangeTitle => '花瓶生成范围与黑名单';

  @override
  String get startColumnLabel => '起始列（最小）';

  @override
  String get endColumnLabel => '结束列（最大）';

  @override
  String get toggleBlacklistHint => '点击切换黑名单';

  @override
  String get vaseCapacityTitle => '花瓶容量';

  @override
  String vaseCapacitySummary(Object current, Object total) {
    return '已分配：$current / 总槽位：$total';
  }

  @override
  String get vaseListTitle => '花瓶列表';

  @override
  String get addVaseTitle => '添加花瓶';

  @override
  String get plantVaseOption => '植物花瓶';

  @override
  String get zombieVaseOption => '僵尸花瓶';

  @override
  String get selectZombie => '选择僵尸';

  @override
  String get searchZombie => '搜索僵尸';

  @override
  String get noZombieFound => '未找到僵尸';

  @override
  String get unknownVaseLabel => '未知花瓶';

  @override
  String get plantLabel => '植物';

  @override
  String get zombieLabel => '僵尸';

  @override
  String get itemLabel => '物品';

  @override
  String get railcartSettings => '矿车轨道设置';

  @override
  String get railcartType => '矿车类型';

  @override
  String get layRails => '铺设轨道';

  @override
  String get placeCarts => '放置矿车';

  @override
  String get railSegments => '轨道段数';

  @override
  String get railcartCount => '矿车数量';

  @override
  String get clearAll => '清空所有配置';

  @override
  String get moduleCategoryBase => '基础';

  @override
  String get moduleCategoryMode => '游戏模式';

  @override
  String get moduleCategoryScene => '场景';
}
