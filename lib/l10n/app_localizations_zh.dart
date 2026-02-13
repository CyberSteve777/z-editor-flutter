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
  String get storagePermissionDialogTitle => '需要存储权限';

  @override
  String get storagePermissionDialogMessage =>
      '本应用需要访问外部存储以打开和保存关卡文件。请在设置中授予「允许管理所有文件」权限。';

  @override
  String get storagePermissionGoToSettings => '前往设置';

  @override
  String get storagePermissionDeny => '拒绝';

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
  String get copyReferenceOrDeep => '复制引用还是深拷贝？';

  @override
  String get copyReference => '复制引用';

  @override
  String get deepCopy => '深拷贝';

  @override
  String get copyEventTarget => '目标波次';

  @override
  String get targetWaveIndex => '目标波次序号';

  @override
  String get moveToWaveIndex => '移动至波次序号';

  @override
  String get invalidWaveIndex => '无效波次序号';

  @override
  String get renamingFailed => '重命名失败';

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
  String get movingSuccess => '移动成功';

  @override
  String get movingFail => '移动失败';

  @override
  String get moveSameFolder => '源目录和目标目录相同';

  @override
  String get moveFileExistsTitle => '文件已存在';

  @override
  String get moveFileExistsMessage => '目标文件夹中已存在同名文件。';

  @override
  String get moveOverwrite => '覆盖';

  @override
  String fileOverwritten(Object name) {
    return '文件已覆盖: $name';
  }

  @override
  String get moveSaveAsCopy => '另存为副本';

  @override
  String get moveCancelled => '操作已取消';

  @override
  String movedAs(Object name) {
    return '已移动并另存为 $name';
  }

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
  String get stayInEditor => '留下';

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
  String get createEmptyWave => '添加空波次';

  @override
  String get createEmptyWaveContainer => '创建空波次容器';

  @override
  String get deleteEmptyContainer => '删除空容器';

  @override
  String get deleteWaveContainerTitle => '删除波次容器？';

  @override
  String get deleteWaveContainerConfirm => '确定要删除空的波次容器吗？删除后您可以重新创建一个新的容器。';

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
  String get noZombiesInLane => '此车道没有僵尸';

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
  String get basicInfoSection => '基础信息';

  @override
  String get sceneSettingsSection => '场景设置';

  @override
  String get restrictionsSection => '限制选项';

  @override
  String get victoryModuleWarning => '使用默认结算方式以外的结算方式可能会因为模块冲突导致关卡闪退，请谨慎使用。';

  @override
  String get hintTextDisplay => '文字显示 (Description)';

  @override
  String get beatTheLevelDialogIntro => '在关卡开头用弹窗显示提示文字。';

  @override
  String get beatTheLevelDialogHint =>
      '支持显示中文，多行文字需直接输入回车，无需使用转义序列\\n，注意iOS端庭院内无法查看提示内容。';

  @override
  String get levelHintText => '关卡提示文字';

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
  String get starChallengeNoConfigTitle => '挑战';

  @override
  String get starChallengeNoConfigMessage => '该挑战没有可配置的参数。';

  @override
  String get starChallengeSaveMowersTitle => '不丢车挑战';

  @override
  String get starChallengeSaveMowersNoConfigMessage =>
      '该挑战没有可配置的参数。\n\n通关时所有小推车必须完好无损，注意庭院模块下默认没有小推车。';

  @override
  String get starChallengePlantFoodNonuseTitle => '禁用能量豆挑战';

  @override
  String get starChallengePlantFoodNonuseNoConfigMessage =>
      '该挑战没有可配置的参数。\n\n禁止玩家使用能量豆。';

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
  String get moduleTitle_InitialPlantProperties => '旧版预置植物';

  @override
  String get moduleDesc_InitialPlantProperties => '预置植物传统写法，可放置冰封植物';

  @override
  String get moduleTitle_InitialPlantEntryProperties => '初始植物';

  @override
  String get moduleDesc_InitialPlantEntryProperties => '开局已有植物';

  @override
  String get frozenPlantPlacementTitle => '旧版预置植物';

  @override
  String get frozenPlantPlacementLastStand => '复活之战模式';

  @override
  String get frozenPlantPlacementSelectedPosition => '选中位置';

  @override
  String get frozenPlantPlacementPlaceHere => '地方植物';

  @override
  String get frozenPlantPlacementPlantList => '植物分布列表（行优先）';

  @override
  String frozenPlantPlacementEditPlant(Object name) {
    return '编辑 $name';
  }

  @override
  String get frozenPlantPlacementLevel => '等级';

  @override
  String get frozenPlantPlacementCondition => '初始状态';

  @override
  String get frozenPlantPlacementConditionNull => '无状态 (null)';

  @override
  String get noConditions => '无条件';

  @override
  String get frozenPlantPlacementHelpTitle => '初始植物配置模块说明';

  @override
  String get frozenPlantPlacementHelpOverviewTitle => '简要介绍';

  @override
  String get frozenPlantPlacementHelpOverviewBody =>
      '此模块用于在关卡开始前配置植物布局，与预置植物布局类似，但结构不同且支持特殊状态。';

  @override
  String get frozenPlantPlacementHelpConditionTitle => '特殊状态';

  @override
  String get frozenPlantPlacementHelpConditionBody => '可以为植物设置冰封状态，常见于冰河世界关卡。';

  @override
  String get frozenPlantPlacementHelpLastStandTitle => '复活之战模式';

  @override
  String get frozenPlantPlacementHelpLastStandBody =>
      '开启复活之战模式后，初始植物将于开始游戏后被销毁。注意中文版没有销毁植物的火焰效果。';

  @override
  String get save => '保存';

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

  @override
  String get customZombie => '自定义僵尸';

  @override
  String get customZombieProperties => '自定义僵尸属性';

  @override
  String get zombieTypeNotFound => '未找到僵尸类型对象。';

  @override
  String get propertyObjectNotFound => '未找到属性对象';

  @override
  String propertyObjectNotFoundHint(Object alias) {
    return '自定义僵尸的属性对象（$alias）在关卡中未找到。属性定义未指向关卡内部，因此无法在此编辑。';
  }

  @override
  String get baseStats => '基础属性';

  @override
  String get hitpoints => '生命值';

  @override
  String get speed => '速度';

  @override
  String get speedVariance => '速度方差';

  @override
  String get eatDPS => '啃食伤害';

  @override
  String get hitPosition => '命中 / 位置';

  @override
  String get hitRect => '命中矩形';

  @override
  String get editHitRect => '编辑命中矩形';

  @override
  String get attackRect => '攻击矩形';

  @override
  String get editAttackRect => '编辑攻击矩形';

  @override
  String get artCenter => '美术中心';

  @override
  String get editArtCenter => '编辑美术中心';

  @override
  String get shadowOffset => '阴影偏移';

  @override
  String get editShadowOffset => '编辑阴影偏移';

  @override
  String get groundTrackName => '行进轨迹';

  @override
  String get groundTrackNormal => '普通地面 (ground_swatch)';

  @override
  String get groundTrackNone => '无 (null)';

  @override
  String get appearanceBehavior => '外观与行为';

  @override
  String get sizeType => '体型';

  @override
  String get selectSize => '选择体型';

  @override
  String get disableDropFractions => '禁用掉落分数';

  @override
  String get immuneToKnockback => '免疫击退';

  @override
  String get showHealthBarOnDamage => '受伤时显示血条';

  @override
  String get drawHealthBarTime => '血条显示时长';

  @override
  String get enableEliteScale => '启用精英缩放';

  @override
  String get eliteScale => '精英缩放';

  @override
  String get enableEliteImmunities => '启用精英免疫';

  @override
  String get canSpawnPlantFood => '可掉落能量豆';

  @override
  String get canSurrender => '可投降';

  @override
  String get canTriggerZombieWin => '可触发僵尸胜利';

  @override
  String get resilience => '韧性';

  @override
  String get instantKillResistance => '秒杀抗性';

  @override
  String get resiliencePhysics => '物理';

  @override
  String get resiliencePoison => '毒系';

  @override
  String get resilienceElectric => '电能';

  @override
  String get resilienceMagic => '魔法';

  @override
  String get resilienceIce => '寒冰';

  @override
  String get resilienceFire => '火焰';

  @override
  String get resilienceHint => '0.0 = 无抗性，1.0 = 完全免疫';

  @override
  String zombieTypeLabel(Object type) {
    return '僵尸类型：$type';
  }

  @override
  String propertyAliasLabel(Object alias) {
    return '属性别名：$alias';
  }

  @override
  String get ok => '确定';

  @override
  String get width => '宽度';

  @override
  String get height => '高度';

  @override
  String get customZombieHelpIntro => '简要介绍';

  @override
  String get customZombieHelpIntroBody =>
      '本界面编辑注入关卡的自定义僵尸参数。仅支持常用属性；许多特殊属性需手动编辑 JSON。';

  @override
  String get customZombieHelpBase => '基础属性';

  @override
  String get customZombieHelpBaseBody =>
      '自定义僵尸可修改基础属性（生命、速度、啃食伤害）。自定义僵尸不会出现在关卡预览池中。';

  @override
  String get customZombieHelpHit => '命中/位置';

  @override
  String get customZombieHelpHitBody =>
      'X、Y 为偏移；W、H 为宽高。偏移 ArtCenter 可隐藏僵尸精灵。留空行进轨迹会让僵尸原地行走。';

  @override
  String get customZombieHelpManual => '手动编辑';

  @override
  String get customZombieHelpManualBody =>
      '自定义注入会从游戏文件自动填充所有属性。如需进一步编辑可手动修改 JSON 文件。';

  @override
  String editAlias(Object alias) {
    return '编辑 $alias';
  }

  @override
  String get add => '添加';

  @override
  String get overview => '简要介绍';

  @override
  String get left => '左';

  @override
  String get right => '右';

  @override
  String get weight => '权重';

  @override
  String get maxCount => '最大数量';

  @override
  String get startColumn => '起始列';

  @override
  String get endColumn => '结束列';

  @override
  String get removeItem => '移除物品';

  @override
  String removeItemConfirm(Object name) {
    return '移除 $name？';
  }

  @override
  String groupN(int n) {
    return '组 $n';
  }

  @override
  String rowN(int n) {
    return '行 $n';
  }

  @override
  String get addItem => '添加物品';

  @override
  String get addWind => '添加风';

  @override
  String get addDropItem => '添加掉落物品';

  @override
  String get addMirrorGroup => '在上方添加镜子组';

  @override
  String pipeN(int n) {
    return '管道 $n';
  }

  @override
  String get setStart => '设起点';

  @override
  String get setEnd => '设终点';

  @override
  String get collectable => '收集物（能量豆）';

  @override
  String get selectGridItem => '选择物品';

  @override
  String get addItemTitle => '添加物品';

  @override
  String get initialPlantLayout => '初始植物布局';

  @override
  String get gridItemLayout => '物品布局';

  @override
  String get zombieCount => '僵尸数量';

  @override
  String get groupSize => '每组数量';

  @override
  String get timeBetweenGroups => '组间间隔';

  @override
  String get timeBeforeSpawn => '生成前时间（秒）';

  @override
  String get waterBoundaryColumn => '水位边界列';

  @override
  String get columnsDragged => '拖拽列数 (ColNumPlantIsDragged)';

  @override
  String get typeIndex => '类型索引';

  @override
  String styleN(int n) {
    return '样式 $n';
  }

  @override
  String get existDurationSec => '存在时长（秒）';

  @override
  String get mirror1 => '镜子 1';

  @override
  String get mirror2 => '镜子 2';

  @override
  String get ignoreGravestone => '忽略墓碑 (IgnoreGraveStone)';

  @override
  String zombiePreview(Object name) {
    return '$name - 僵尸预览';
  }

  @override
  String get weatherSettings => '天气设置';

  @override
  String get holeLifetimeSeconds => '坑洞持续时间（秒）';

  @override
  String get startingWaveLocation => '起始波位置';

  @override
  String get rainIntervalSeconds => '掉落间隔（秒）';

  @override
  String get startingPlantFood => '初始能量豆';

  @override
  String get bowlingFoulLine => '保龄球犯规线 (BowlingFoulLine)';

  @override
  String get stopColumn => '停止列 (StopColumn)';

  @override
  String get speedUp => '加速 (SpeedUp)';

  @override
  String get baseCostIncreased => '基础花费增加 (BaseCostIncreased)';

  @override
  String get maxIncreasedCount => '最大增加次数 (MaxIncreasedCount)';

  @override
  String get initialMistPositionX => '迷雾初始位置 X';

  @override
  String get normalValueX => '正常值 X';

  @override
  String get bloverEffectInterval => '三叶草效果间隔（秒）';

  @override
  String get dinoType => '恐龙种类';

  @override
  String dinoRow(int n) {
    return '行 (DinoRow)：$n';
  }

  @override
  String get dinoWaveDuration => '持续时间 (DinoWaveDuration)';

  @override
  String get unknownModuleTitle => '模块编辑器开发中';

  @override
  String get unknownModuleHelpTitle => '未解析模块';

  @override
  String get unknownModuleHelpBody => '该模块暂时未注册到关卡解释器，暂无可用编辑器。';

  @override
  String get noEditorForModule => '该模块暂无可用编辑器';

  @override
  String get noEditorForModuleBody => '该模块未注册到关卡解析器。可能是手动添加或 objclass 被修改。';

  @override
  String get invalidEventTitle => '无效事件';

  @override
  String get invalidEventBody => '此事件对象无法解析。';

  @override
  String get invalidReference => '无效引用';

  @override
  String aliasNotFound(Object alias) {
    return '未找到别名 \"$alias\"';
  }

  @override
  String invalidRefBody(int wave) {
    return '波次 $wave 引用了此事件，但找不到对应实体。保留会导致崩溃。';
  }

  @override
  String get removeInvalidRef => '从波次中移除此无效引用';

  @override
  String get spawnCount => '生成数量';

  @override
  String get columnRangeTiming => '列范围与时间';

  @override
  String get waveStartMessage => '波次开始消息';

  @override
  String get zombieTypeZombieName => '僵尸类型 (ZombieName)';

  @override
  String get optional => '可选';

  @override
  String get eventHelpBeachStageBody => '僵尸会从水下浮现。通常用于巨浪沙滩的潜水僵尸。';

  @override
  String get eventHelpTidalChangeBody => '此事件在波次中改变潮汐位置。';

  @override
  String get eventHelpTidalChangePosition => '列0为最右，9为最左。ChangeAmount 设置水位边界。';

  @override
  String get eventHelpBlackHoleBody => '功夫世界特有事件。时空黑洞会随事件生成，将所有植物向右吸动。';

  @override
  String get eventHelpBlackHoleColumns => '植物被吸引拖拽的列数。';

  @override
  String get eventHelpMagicMirrorBody => '魔镜事件会在场地上生成成对的传送门。';

  @override
  String get eventHelpMagicMirrorType => '类型索引可更改镜子外观，共3种形态。';

  @override
  String get eventHelpParachuteRainBody => '僵尸在波次中从空中降落。';

  @override
  String get eventHelpParachuteRainLogic => '僵尸分批生成。可控制总数、批大小、列范围和间隔。';

  @override
  String get eventHelpModernPortalsBody => '在场地上刷新时空裂缝，常见于摩登世界。';

  @override
  String get eventHelpModernPortalsType => '游戏内有多种裂缝类型，可在此选择。';

  @override
  String get eventHelpModernPortalsIgnore => '开启后裂缝不会因被墓碑等挡住而不生成。';

  @override
  String get eventHelpFrostWindBody => '冰河世界专属事件。在指定行生成寒风，将植物冻结。';

  @override
  String get eventHelpFrostWindDirection => '可设置寒风方向：左或右。';

  @override
  String get eventHelpModifyConveyorBody => '在波次中变更传送带配置。添加或移除植物。';

  @override
  String get eventHelpModifyConveyorAdd => '向传送带添加植物。';

  @override
  String get eventHelpModifyConveyorRemove => '从传送带移除植物。';

  @override
  String get eventHelpDinoBody => '恐龙危机专属事件。在指定行召唤恐龙协助僵尸进攻。';

  @override
  String get eventHelpDinoDuration => '恐龙在场上停留的时间，单位为波次。';

  @override
  String get eventHelpZombiePotionBody => '在场地上强行生成药水，可无视植物。';

  @override
  String get eventHelpZombiePotionUsage => '选择网格位置，点击添加物品，选择药水类型。';

  @override
  String get eventHelpFairyFogBody => '生成覆盖场地的迷雾，给僵尸护盾。只有微风事件能吹散。';

  @override
  String get eventHelpFairyFogRange =>
      'mX、mY 为计算中心点，mWidth、mHeight 为向右和向下延伸距离。';

  @override
  String get eventHelpFairyWindBody => '产生持续微风，用于吹散童话迷雾。';

  @override
  String get eventHelpFairyWindVelocity => '可改变抛射物速度。1.0 表示原速，数值越大越快。';

  @override
  String get eventHelpRaidingPartyBody => '海盗港湾事件，分批依次生成飞索僵尸进攻。';

  @override
  String get eventHelpRaidingPartyGroup => '每组所包含的僵尸数量。';

  @override
  String get eventHelpRaidingPartyCount => '该事件总共生成的僵尸数量。';

  @override
  String get eventHelpGravestoneBody => '在波次中随机生成障碍物（如墓碑）。';

  @override
  String get eventHelpGravestoneLogic => '从位置池随机选取单元格。总物品数不得超过位置数。';

  @override
  String get eventHelpGravestoneMissingAssets => '部分地图无墓碑生成效果时可能显示阳光纹理。';

  @override
  String get eventHelpGraveSpawnBody => '此事件在特定障碍物类型上出怪，常用于黑暗时代。';

  @override
  String get eventHelpGraveSpawnWait => '从波次开始到僵尸生成的时间间隔。';

  @override
  String get eventHelpStormBody => '沙尘暴或暴风雪将僵尸快速传送到前线。';

  @override
  String get eventHelpStormColumns => '列0为左，9为右。起始列需小于结束列。';

  @override
  String get eventHelpStormLevels => '风暴僵尸支持 1-10 级。';

  @override
  String get eventHelpGroundSpawnBody => '配置此波次生成的僵尸。';

  @override
  String get moduleHelpTideBody => '启用潮汐系统并设置初始潮汐位置。';

  @override
  String get moduleHelpTidePosition => '右边界为0，左边界为9。允许负值。';

  @override
  String get initialTidePosition => '初始潮汐位置';

  @override
  String get moduleHelpManholeBody => '定义蒸汽时代地下管道链接。';

  @override
  String get moduleHelpManholeEdit => '切换起点/终点模式，然后点击网格放置。';

  @override
  String get moduleHelpWeatherBody => '控制全局天气效果（雨、雪、黑暗）。';

  @override
  String get moduleHelpWeatherRef => '这些选项引用 LevelModules。';

  @override
  String get moduleHelpZombiePotionBody => '药水随时间生成直至达到最大数量。';

  @override
  String get moduleHelpZombiePotionTypes => '药水从列表中随机选择。';

  @override
  String get moduleHelpUnknownBody => '关卡文件由根节点和模块构成。每个对象有代号、objclass、objdata。';

  @override
  String get moduleHelpUnknownEvents => '本软件通过 objclass 解析模块。此模块未注册。';

  @override
  String get eventHelpInvalidBody => '此事件被引用但解析器找不到其实体定义。';

  @override
  String get eventHelpInvalidImpact => '保留此引用会导致游戏崩溃。请手动移除。';

  @override
  String get position => '位置';

  @override
  String get editing => '编辑';

  @override
  String get logic => '逻辑';

  @override
  String get impact => '影响';

  @override
  String get events => '事件';

  @override
  String get referenceModules => '参考模块';

  @override
  String get portalType => '裂缝类型';

  @override
  String get direction => '方向';

  @override
  String get velocityScale => '速度缩放';

  @override
  String get range => '范围';

  @override
  String get columnRange => '列范围';

  @override
  String get zombieLevels => '僵尸等级';

  @override
  String get missingAssets => '缺失资源';

  @override
  String get usage => '用法';

  @override
  String get types => '类型';

  @override
  String get eventBlackHole => '黑洞事件';

  @override
  String get attractionConfig => '吸引配置';

  @override
  String get selectedPosition => '已选位置';

  @override
  String get placePlant => '地方植物';

  @override
  String get plantList => '植物列表（先行后列）';

  @override
  String get firstCostume => '首次装扮 (Avatar)';

  @override
  String get eventMagicMirror => '魔镜事件';

  @override
  String get eventParachuteRain => '降落伞/低音炮/蜘蛛雨事件';

  @override
  String get manholePipeline => '井盖管道';

  @override
  String get manholePipelines => '井盖管道';

  @override
  String get manholePipelineHelpOverview => '定义蒸汽时代使用的地下管道连接。';

  @override
  String get manholePipelineHelpEditing => '切换起点/终点模式，然后点击网格放置。';

  @override
  String manholePipelineStartEndFormat(int sx, int sy, int ex, int ey) {
    return '起点: ($sx, $sy)  终点: ($ex, $ey)';
  }

  @override
  String get piratePlank => '海盗木板';

  @override
  String get weatherModule => '天气模块';

  @override
  String get zombiePotion => '僵尸药水';

  @override
  String get eventTimeRift => '时空裂缝事件';

  @override
  String get deathHole => '死亡之洞';

  @override
  String get seedRain => '种子雨';

  @override
  String get eventFrostWind => '寒风事件';

  @override
  String get lastStandSettings => '坚不可摧设置';

  @override
  String get roofFlowerPot => '屋顶花盆';

  @override
  String get eventConveyorModify => '传送带修改事件';

  @override
  String get bowlingMinigame => '保龄球小游戏';

  @override
  String get zombieMoveFast => '僵尸快跑';

  @override
  String get eventPotionDrop => '药水掉落事件';

  @override
  String get warMist => '战争迷雾';

  @override
  String get eventDino => '恐龙事件';

  @override
  String get duration => '持续时间';

  @override
  String get sunDropper => '阳光掉落';

  @override
  String get eventFairyWind => '童话微风事件';

  @override
  String get eventFairyFog => '童话迷雾事件';

  @override
  String get eventRaidingParty => '突袭派对事件';

  @override
  String get swashbucklerCount => '飞索僵尸数量';

  @override
  String get sunBomb => '阳光炸弹';

  @override
  String get eventSpawnGravestones => '生成墓碑事件';

  @override
  String get eventGraveSpawn => '墓穴出怪事件';

  @override
  String get zombieSpawnWait => '僵尸生成等待';

  @override
  String get selectCustomZombie => '选择自定义僵尸';

  @override
  String get change => '更换';

  @override
  String get autoLevel => '自动等级';

  @override
  String get apply => '应用';

  @override
  String get applyBatchLevel => '应用批量等级？';

  @override
  String get conveyorBelt => '传送带';

  @override
  String get starChallenges => '星级挑战';

  @override
  String get addChallenge => '添加挑战';

  @override
  String get unknownChallengeType => '未知挑战类型';

  @override
  String get protectedPlants => '保护植物';

  @override
  String get addPlant => '添加植物';

  @override
  String get protectedGridItems => '保护物品';

  @override
  String get addGridItem => '添加物品';

  @override
  String get spawnTimer => '生成计时器';

  @override
  String get plantLevels => '植物等级';

  @override
  String get globalPlantLevels => '全局植物等级';

  @override
  String get scope => '范围';

  @override
  String get applyBatch => '批量应用';

  @override
  String get addPlants => '添加植物';

  @override
  String get noPlantsConfigured => '未配置植物';

  @override
  String batchLevelFormat(int level) {
    return '批量等级：$level';
  }

  @override
  String get protectPlants => '保护植物';

  @override
  String get protectItems => '保护物品';

  @override
  String get autoCount => '自动计数';

  @override
  String get overrideStartingPlantfood => '覆盖初始能量豆';

  @override
  String get startingPlantfoodOverride => '初始能量豆覆盖';

  @override
  String get iconText => '图标文字';

  @override
  String get iconImage => '图标图片';

  @override
  String get overrideMaxSun => '覆盖最大阳光';

  @override
  String get maxSunOverride => '最大阳光覆盖';

  @override
  String get maxSunHelpTitle => '阳光上限模块说明';

  @override
  String get maxSunHelpOverview => '该模块原本用于控制潘追关卡不同难度级别，可以用此模块覆盖关卡内能够储存的阳光最大值。';

  @override
  String get startingPlantfoodHelpTitle => '初始能量豆模块说明';

  @override
  String get startingPlantfoodHelpOverview =>
      '该模块原本用于控制潘追关卡不同难度级别，可以用此模块覆盖关卡内携带的初始能量豆数量。';

  @override
  String get starChallengeHelpTitle => '挑战模块说明';

  @override
  String get starChallengeHelpOverview =>
      '这里可用选择关卡使用的各项挑战模块。可以同时设置多项挑战目标以及使用多次同种挑战。';

  @override
  String get starChallengeHelpSuggestionTitle => '优化建议';

  @override
  String get starChallengeHelpSuggestion =>
      '部分挑战在游戏内有统计框记录进度，当挑战模块过多时统计数据框可能会被遮挡。';

  @override
  String get remove => '移除';

  @override
  String get plant => '植物';

  @override
  String get zombie => '僵尸';

  @override
  String get initialZombieLayout => '初始僵尸布局';

  @override
  String get placeZombie => '放置僵尸';

  @override
  String get manualInput => '手动输入';

  @override
  String get waveManagerModule => '波次管理模块';

  @override
  String get points => '积分';

  @override
  String get eventStorm => '风暴事件';

  @override
  String get row => '行';

  @override
  String get addType => '添加类型';

  @override
  String get plantFunExperimental => '植物（趣味/实验）';

  @override
  String get availableZombies => '可用僵尸';

  @override
  String get presetPlants => '预设植物 (PresetPlantList)';

  @override
  String get whiteList => '白名单 (WhiteList)';

  @override
  String get blackList => '黑名单 (BlackList)';

  @override
  String get chooser => '选择器';

  @override
  String get preset => '预设';

  @override
  String get seedBankHelp => '种子库说明';

  @override
  String get conveyorBeltHelp => '传送带说明';

  @override
  String get dropDelayConditions => '掉落延迟 (DropDelayConditions)';

  @override
  String get unitSeconds => '单位：秒';

  @override
  String get speedConditions => '速度 (SpeedConditions)';

  @override
  String get speedConditionsSubtitle => '标准值 100，越大越快';

  @override
  String get addPlantConveyor => '添加植物';

  @override
  String get addTool => '添加工具';

  @override
  String get increasedCost => '增加花费';

  @override
  String get powerTile => '能量砖';

  @override
  String get eventStandardSpawn => '事件：标准生成';

  @override
  String get eventGroundSpawn => '事件：地面生成';

  @override
  String get eventEditorInDevelopment => '事件编辑器开发中';

  @override
  String get level => '等级';

  @override
  String get missingTideModule => '缺少潮汐模块';

  @override
  String get levelHasNoTideProperties => '关卡没有 TideProperties 模块，此事件可能无法工作。';

  @override
  String get changePosition => '更改位置';

  @override
  String get changePositionChangeAmount => '更改位置 (ChangeAmount)';

  @override
  String get preview => '预览';

  @override
  String get water => '水域';

  @override
  String get land => '陆地';

  @override
  String groupConfigN(int n) {
    return '组 $n 配置';
  }

  @override
  String get globalParameters => '全局参数';

  @override
  String get timePerGrid => '每格耗时';

  @override
  String get damagePerSecond => '每秒伤害';

  @override
  String get pipe => '管道';

  @override
  String get stageMismatch => '关卡类型不匹配';

  @override
  String get currentStageNotPirate => '当前关卡不是海盗港湾，此模块可能无法正常工作。';

  @override
  String get plankRows => '木板行 (0–4)';

  @override
  String get selectedRows => '已选行';

  @override
  String get selectedRowsLabel => '已选行：';

  @override
  String get indexLabel => '索引';

  @override
  String get selectWeatherType => '选择天气类型';

  @override
  String get counts => '数量';

  @override
  String get initial => '初始';

  @override
  String get max => '最大';

  @override
  String get spawnTimerShort => '生成计时';

  @override
  String get minSec => '最小（秒）';

  @override
  String get maxSec => '最大（秒）';

  @override
  String get potionTypes => '药水类型';

  @override
  String get noPotionTypes => '无药水类型';

  @override
  String get ignoreGravestoneSubtitle => '开启后不受障碍物阻挡即可生成';

  @override
  String get thisPortalSpawns => '此裂缝生成：';

  @override
  String startEndFormat(int sx, int sy, int ex, int ey) {
    return '起点：($sx, $sy)  终点：($ex, $ey)';
  }

  @override
  String indexN(int n) {
    return '索引：$n';
  }

  @override
  String get noItemsAddHint => '暂无物品。可添加植物、僵尸或收集物。';

  @override
  String get zombieTypeSpiderZombieName => '僵尸类型 (SpiderZombieName)';

  @override
  String get noneSelected => '未选择';

  @override
  String get totalSpiderCount => '总数 (SpiderCount)';

  @override
  String get perBatchGroupSize => '每批 (GroupSize)';

  @override
  String get fallTime => '下落时间（秒）';

  @override
  String get waveStartMessageLabel => '红色副标题 (WaveStartMessage)';

  @override
  String get optionalWarningText => '可选警告文本';

  @override
  String rowNShort(int n) {
    return '行 $n';
  }

  @override
  String weightMaxFormat(int weight, int max) {
    return '权重：$weight，最大：$max';
  }

  @override
  String get random => '随机';

  @override
  String get noChallengesConfigured => '未配置挑战';

  @override
  String get whiteListBlackListHint => '白名单：空=无限制。黑名单优先于白名单。';

  @override
  String get conveyorBeltHelpIntro => '传送带模式按权重随机生成卡牌。配置植物池和刷新延迟。';

  @override
  String get conveyorBeltHelpPool => '植物池与权重：概率 = 权重/总权重。使用阈值动态调整。';

  @override
  String get conveyorBeltHelpDropDelay => '掉落延迟：控制卡牌生成间隔。植物越多越慢。';

  @override
  String get conveyorBeltHelpSpeed => '速度：物理传送带速度。标准=100。';

  @override
  String get cannotAddEliteZombies => '无法添加精英僵尸';

  @override
  String get eliteZombiesNotAllowed => '此处不允许精英僵尸';

  @override
  String fixToAlias(Object alias) {
    return '修复至 $alias';
  }

  @override
  String editPresetZombie(Object name) {
    return '编辑预设僵尸：$name';
  }

  @override
  String get missingZombossModule => '缺少 ZombossBattleModuleProperties';

  @override
  String get challengeNoConfig => '此挑战不支持配置。';

  @override
  String get maxPotionCount => '最大药水数量';

  @override
  String potionTypesConfigured(int count) {
    return '药水类型：已配置 $count 个';
  }

  @override
  String pipelinesCount(int count) {
    return '管道：$count';
  }

  @override
  String windN(int n) {
    return '寒风 #$n';
  }

  @override
  String get zombieList => '僵尸列表（先行后列）';

  @override
  String get positionPoolSpawnPositions => '位置池 (SpawnPositionsPool)';

  @override
  String get tapCellsSelectDeselect => '点击格子选择/取消生成位置';

  @override
  String get gravestonePool => '墓碑池 (GravestonePool)';

  @override
  String get removePlants => '移除植物';

  @override
  String get current => '当前';

  @override
  String get eliteZombiesUseDefaultLevel => '精英僵尸使用默认等级。';

  @override
  String get basicParameters => '基本参数';

  @override
  String get zombieSpawnWaitSec => '僵尸生成等待（秒）';

  @override
  String get gridTypes => '障碍物类型';

  @override
  String zombiesCount(int count) {
    return '僵尸（$count）';
  }

  @override
  String get eventGraveSpawnSubtitle => '事件：障碍物出怪';

  @override
  String get eventStormSpawnSubtitle => '事件：风暴出怪';

  @override
  String get eventHelpGraveSpawnZombieWait => '从波次开始到僵尸生成的时间间隔，若已进入下一波将不生成僵尸。';

  @override
  String get eventHelpStormOverview => '沙尘暴或暴风雪将僵尸快速传送到前线。极寒风暴可冻结植物。';

  @override
  String get eventHelpStormColumnRange => '场地左边界为0列，右边界为9列，起始列要小于结束列。';

  @override
  String get eventHelpStormZombieLevels => '风暴僵尸支持等级1–10。精英僵尸使用默认等级。';

  @override
  String get spawnParameters => '生成参数';

  @override
  String get sandstorm => '沙尘暴';

  @override
  String get snowstorm => '暴风雪';

  @override
  String get excoldStorm => '极寒风暴';

  @override
  String get columnStart => '起始列';

  @override
  String get columnEnd => '结束列';

  @override
  String applyBatchLevelContent(int level) {
    return '将此波次所有僵尸设为等级 $level（精英不变）。';
  }

  @override
  String get randomRow => '随机行';

  @override
  String levelFormat(int level) {
    return '等级：$level';
  }

  @override
  String get levelAccount => '等级：账户';

  @override
  String levelDisplay(Object value) {
    return '等级：$value';
  }

  @override
  String get eventStandardSpawnTitle => '标准出怪事件';

  @override
  String get eventGroundSpawnTitle => '地面出怪事件';

  @override
  String get eventHelpStandardOverview => '配置此波次出怪的僵尸。等级0跟随地图层级。';

  @override
  String get eventHelpStandardRow => '行0–4。未设置则为随机行。';

  @override
  String get izombieModeTitle => '我是僵尸模式';

  @override
  String get izombieModeSubtitle => '启用后放置僵尸。锁定选择方式。';

  @override
  String get reverseZombieFactionTitle => '反转僵尸阵营';

  @override
  String get reverseZombieFactionSubtitle => '启用后僵尸为植物阵营。用于僵尸对僵尸。';

  @override
  String get initialWeight => '初始权重';

  @override
  String get plantLevelLabel => '植物等级';

  @override
  String get missingIntroModule => '缺少开场模块';

  @override
  String get missingIntroModuleHint => '关卡缺少 ZombossBattleIntroProperties，请添加。';

  @override
  String get zombossType => '僵尸博士类型';

  @override
  String get unknownZomboss => '未知僵尸博士';

  @override
  String get parameters => '参数';

  @override
  String get reservedColumnCount => '保留列数';

  @override
  String get reservedColumnCountHint => '从右侧保留的列，植物无法种植。';

  @override
  String get protectedList => '保护列表';

  @override
  String get plantLevelsFollowGlobal => '植物等级遵循全局定义，种子包等级将被覆盖。';

  @override
  String get protectPlantsOverview => '此处列出的植物必须存活，失去即失败。';

  @override
  String get protectPlantsAutoCount => '所需数量与列出的植物数量一致。';

  @override
  String get protectItemsOverview => '此处列出的障碍物必须存活，失去即失败。';

  @override
  String get protectItemsAutoCount => '所需数量与列出的障碍物数量一致。';

  @override
  String positionsCount(int count) {
    return '位置数：$count';
  }

  @override
  String totalItemsCount(int count) {
    return '物品总数：$count';
  }

  @override
  String get itemCountExceedsPositionsWarning => '警告：物品数超过位置数，部分将不会生成。';

  @override
  String get gravestoneBlockedInfo => '被植物阻挡的墓碑等障碍物无法生成。请用其他方式强制生成。';

  @override
  String get enterConditionValue => '输入条件值';

  @override
  String get customInputHint => '自定义输入需准确无误';

  @override
  String get presetConditions => '预设条件';

  @override
  String get selectFromPresetHint => '从预设条件列表中选择';

  @override
  String get conveyorCardPool => '传送带卡池';

  @override
  String get toolCardsUseFixedLevel => '工具卡使用固定等级';

  @override
  String get maxLimits => '上限';

  @override
  String get maxCountThreshold => '最大数量阈值';

  @override
  String get weightFactor => '权重系数';

  @override
  String get minLimits => '下限';

  @override
  String get minCountThreshold => '最小数量阈值';

  @override
  String get followAccountLevel => '0 = follow account level';

  @override
  String get enablePointSpawning => '启用点数出怪';

  @override
  String get pointSpawningEnabledDesc => '已启用 (使用额外点数出怪)';

  @override
  String get pointSpawningDisabledDesc => '未启用 (仅使用波次事件)';

  @override
  String get pointSettings => '分数设置';

  @override
  String get startingWave => '起始波';

  @override
  String get startingPoints => '起始分数';

  @override
  String get pointIncrement => '分数增量';

  @override
  String get zombiePool => '僵尸池';

  @override
  String plantLevelsCount(int count) {
    return '植物等级：$count';
  }

  @override
  String lvN(int n) {
    return '等级 $n';
  }

  @override
  String get pennyClassroom => '潘妮课堂';

  @override
  String get protectGridItems => '保护格子物品';

  @override
  String get waveManagerHelpOverview => '启用波次管理器。无此模块时无法编辑波次。';

  @override
  String get waveManagerHelpPoints => '按分数生成使用此池。避免精英和自定义僵尸。';

  @override
  String get pointsSection => '分数';

  @override
  String get globalPlantLevelsOverview => '为指定植物定义全局等级。';

  @override
  String get globalPlantLevelsScope => '适用于保护植物、种子雨等模块。';

  @override
  String mustProtectCountFormat(int count) {
    return '需保护数量：$count';
  }

  @override
  String get noWaveManagerPropsFound => '未找到 WaveManagerProperties 对象。';

  @override
  String get itemsSortedByRow => '物品（按行排序）';

  @override
  String get eventStormSpawn => '事件：风暴生成';

  @override
  String get stormEvent => '风暴事件';

  @override
  String get makeCustom => '设为自定义';

  @override
  String get zombieLevelsBody => '风暴僵尸支持 1–10 级。精英僵尸使用默认等级。';

  @override
  String get batchLevel => '批量等级';

  @override
  String get start => '起始';

  @override
  String get end => '结束';

  @override
  String get backgroundMusicLevelJam => '背景音乐 (LevelJam)';

  @override
  String get onlyAppliesRockEra => '仅适用于摇滚时代地图。';

  @override
  String get appliesToAllNonElite => '适用于本波所有非精英僵尸。';

  @override
  String get dropConfigPlants => '掉落配置（植物）';

  @override
  String get dropConfigPlantFood => '掉落配置（植物能量）';

  @override
  String get zombiesCarryingPlants => '携带植物的僵尸';

  @override
  String get zombiesCarryingPlantFood => '携带植物能量的僵尸';

  @override
  String get descriptiveName => '描述名称';

  @override
  String get count => '数量';

  @override
  String get targetDistance => '目标距离';

  @override
  String get targetSun => '目标阳光';

  @override
  String get maximumSun => '最大阳光';

  @override
  String get holdoutSeconds => '坚守秒数';

  @override
  String get zombiesToKill => '需击杀僵尸数';

  @override
  String get timeSeconds => '时间（秒）';

  @override
  String get speedModifier => '速度修正';

  @override
  String get sunModifier => '阳光修正';

  @override
  String get maximumPlantsLost => '最大损失植物数';

  @override
  String get maximumPlants => '最大植物数';

  @override
  String get targetScore => '目标分数';

  @override
  String get plantBombRadius => '植物炸弹半径';

  @override
  String get plantType => '植物类型';

  @override
  String get gridX => '格子 X';

  @override
  String get gridY => '格子 Y';

  @override
  String get noCardsYetAddPlants => '尚无卡片。添加植物或工具。';

  @override
  String get mustProtectCountAll => '必须保护数量（0=全部）';

  @override
  String get mustProtectCount => '必须保护数量';

  @override
  String get gridItemType => '格子物品类型';

  @override
  String get zombieBombRadius => '僵尸炸弹半径';

  @override
  String get plantDamage => '植物伤害';

  @override
  String get zombieDamage => '僵尸伤害';

  @override
  String get initialPotionCount => '初始药水数量';

  @override
  String get operationTimePerGrid => '每格操作时间';

  @override
  String get levelLabel => '等级：';

  @override
  String get mistParameters => '迷雾参数';

  @override
  String get sunDropParameters => '阳光掉落参数';

  @override
  String get initialDropDelay => '初始掉落延迟';

  @override
  String get baseCountdown => '基础倒计时';

  @override
  String get maxCountdown => '最大倒计时';

  @override
  String get countdownRange => '倒计时范围';

  @override
  String get increasePerSun => '每阳光增加';

  @override
  String get inflationParams => '通货膨胀参数';

  @override
  String get baseCostIncreaseLabel => '基础成本增加 (BaseCostIncreased)';

  @override
  String get maxIncreaseCountLabel => '最大增加次数 (MaxIncreasedCount)';

  @override
  String get selectGroup => '选择组';

  @override
  String get gridTapAddRemove => '网格（点击添加/更改，长按移除）';

  @override
  String get sunBombHelpOverview => '概述';

  @override
  String get sunBombHelpBody => '将掉落阳光变为爆炸阳光炸弹。可配置半径和伤害。';

  @override
  String get damage => '伤害';

  @override
  String get explosionRadius => '爆炸半径';

  @override
  String get plantRadius => '植物半径';

  @override
  String get zombieRadius => '僵尸半径';

  @override
  String get radiusPixelsHint => '半径单位为像素。一个格子约 60 像素。';

  @override
  String get enterMaxSunHint => '输入最大阳光（如 9900）';

  @override
  String get optionalLabelHint => '可选标签';

  @override
  String get imageResourceIdHint => 'IMAGE_... 资源 ID';

  @override
  String get enterStartingPlantfoodHint => '输入初始植物能量（0+）';

  @override
  String get threshold => '阈值';

  @override
  String get delay => '延迟';

  @override
  String get seedBankLetsPlayersChoose => '种子库让玩家选择植物。庭院模式下可设置全局等级和所有植物。';

  @override
  String get iZombieModePresetHint => '我是僵尸模式：为玩家预设僵尸。选择锁定为预设。';

  @override
  String get invalidIdsHint => '无效 ID 会留空槽位。植物模式中的僵尸 ID 反之亦然。僵尸槽位请放前面。';

  @override
  String get seedBankIZombie => '种子库（我是僵尸）';

  @override
  String get basicRules => '基本规则';

  @override
  String get selectionMethod => '选择方式';

  @override
  String get emptyList => '空列表';

  @override
  String get plantsAvailableAtStart => '开局可用植物';

  @override
  String get whiteListDescription => '仅允许这些植物（空=无限制）';

  @override
  String get blackListDescription => '这些植物被禁止';

  @override
  String get availableZombiesDescription => '我是僵尸模式可用僵尸';

  @override
  String get izombieCardSlotsHint => '仅部分僵尸有 IZ 卡槽。请在僵尸选择中查看「其他」类别。';

  @override
  String get selectToolCard => '选择工具卡牌';

  @override
  String get searchGridItems => '搜索格子物品';

  @override
  String get noItems => '无物品';

  @override
  String get addedToFavorites => '已添加至收藏';

  @override
  String get removedFromFavorites => '已从收藏移除';

  @override
  String selectedCountTapToSearch(int count) {
    return '已选 $count，点击搜索';
  }

  @override
  String get noFavoritesLongPress => '暂无收藏。长按可添加收藏。';

  @override
  String get gridItemCategoryAll => '全部';

  @override
  String get gridItemCategoryScene => '场景';

  @override
  String get gridItemCategoryTrap => '陷阱';

  @override
  String get gridItemCategoryPlants => '植物';

  @override
  String get sunDropperConfigTitle => '阳光掉落配置';

  @override
  String get customLocalParams => '自定义本地参数';

  @override
  String get currentModeLocal => '当前: 本地编辑 (@CurrentLevel)';

  @override
  String get currentModeSystem => '当前: 系统默认 (@LevelModules)';

  @override
  String get paramAdjust => '参数调节';

  @override
  String get firstDropDelay => '首次掉落延迟';

  @override
  String get initialDropInterval => '初始掉落间隔';

  @override
  String get maxDropInterval => '最大掉落间隔';

  @override
  String get intervalFloatRange => '间隔浮动范围';

  @override
  String get sunDropperHelpTitle => '阳光掉落模块说明';

  @override
  String get sunDropperHelpIntro => '本模块用于配置关卡中的天降阳光参数，若是黑夜地图可考虑不添加此模块。';

  @override
  String get sunDropperHelpParams => '参数配置';

  @override
  String get sunDropperHelpParamsBody =>
      '常规情况下，本模块使用在游戏文件里的定义，也可以选择打开自定义开关对详细参数进行编辑。';

  @override
  String get noZombossFound => '未找到僵尸博士';

  @override
  String get searchChallengeNameOrCode => '搜索挑战名称或代码';

  @override
  String get deleteChallengeTitle => '删除挑战？';

  @override
  String deleteChallengeConfirmLocal(String name) {
    return '移除「$name」？本地挑战数据将永久删除。';
  }

  @override
  String deleteChallengeConfirmRef(String name) {
    return '移除「$name」引用？挑战仍保留在 LevelModules 中。';
  }

  @override
  String get missingModulesRecommended => '关卡可能无法正常运行。建议添加：';

  @override
  String get itemListRowFirst => '物品列表（行优先）';

  @override
  String get railcartCowboy => '牛仔';

  @override
  String get railcartFuture => '未来';

  @override
  String get railcartEgypt => '埃及';

  @override
  String get railcartPirate => '海盗';

  @override
  String get railcartWorldcup => '世界杯';

  @override
  String get clearUnusedTitle => '清除未使用对象？';

  @override
  String get clearUnusedMessage =>
      '将永久删除关卡文件中所有未使用的对象，包括自定义僵尸、其属性及任何其他未被引用的数据。此操作不可撤销。确定继续？';

  @override
  String get clearUnusedNone => '未找到未使用的对象。';

  @override
  String clearUnusedDone(int count) {
    return '已移除 $count 个未使用对象。';
  }

  @override
  String get lawnMowerTitle => '小推车样式设置';

  @override
  String get lawnMowerNotes => '注意事项';

  @override
  String get lawnMowerHelpOverview => '本模块用于控制关卡中小推车的样式外观，注意在庭院框架下小推车模块无效。';

  @override
  String get lawnMowerHelpNotes => '小推车模块通常直接引用自 LevelModules，无需在关卡内自定义参数。';

  @override
  String get lawnMowerSelectType => '选择小推车类型';

  @override
  String get zombieRushTitle => '关卡计时设置';

  @override
  String get zombieRushHelpOverview => '僵尸清除计划里的倒计时模块，在倒计时结束后关卡会结束进行结算。';

  @override
  String get zombieRushHelpNotes => '注意事项';

  @override
  String get zombieRushHelpIncompat =>
      '潘追的计时器模块和庭院不兼容会闪退，所以软件推荐使用僵尸清除计划里的计时模块。';

  @override
  String get zombieRushTimeSettings => '时间设置';

  @override
  String get levelCountdown => '关卡倒计时';

  @override
  String get tunnelDefendTitle => '地宫坑道设置';

  @override
  String get tunnelDefendHelpOverview => '使用本模块在关卡里添加地宫秘境的地道，部分僵尸和植物的交互会被地道影响。';

  @override
  String get tunnelDefendHelpUsage => '使用说明';

  @override
  String get tunnelDefendHelpUsageBody =>
      '先在下方列表中选择一个地道组件，在上方网格中点击即可放置。点击已有的相同组件可将其移除，点击不同的组件可直接替换。';

  @override
  String get tunnelDefendSelectComponent => '选择组件';

  @override
  String get tunnelDefendPlacedCount => '已放置组件';

  @override
  String get tunnelDefendClearAll => '清空全部';

  @override
  String get tunnelDefendClearConfirmTitle => '清空全部地道组件？';

  @override
  String get tunnelDefendClearConfirmMessage => '将移除网格上所有已放置的地道组件，此操作不可撤销。';

  @override
  String get tunnelDefendPathOutsideLawn => '场地外的路径组件：';

  @override
  String get tunnelDefendDeleteOutside => '删除场地外的路径组件';

  @override
  String get tunnelDefendDeleteOutsideConfirmTitle => '删除场地外的路径组件？';

  @override
  String get tunnelDefendDeleteOutsideConfirmMessage =>
      '将移除 5×9 场地网格之外的路径组件，此操作不可撤销。';

  @override
  String get moduleTitle_LawnMowerProperties => '小推车';

  @override
  String get moduleDesc_LawnMowerProperties => '关卡小推车样式';

  @override
  String get moduleTitle_TunnelDefendModuleProperties => '地宫坑道';

  @override
  String get moduleDesc_TunnelDefendModuleProperties => '地宫地道放置';

  @override
  String get moduleTitle_ZombieRushModuleProperties => '僵尸清除计时';

  @override
  String get moduleDesc_ZombieRushModuleProperties => '关卡倒计时';

  @override
  String get jsonViewerModeReading => '（只读模式）';

  @override
  String get jsonViewerModeObjectReading => '（对象只读模式）';

  @override
  String get jsonViewerModeEdit => '（编辑模式）';

  @override
  String get tooltipAboutModule => '关于此模块';

  @override
  String get tooltipAboutEvent => '关于此事件';

  @override
  String get tooltipSave => '保存';

  @override
  String get tooltipEdit => '编辑';

  @override
  String get tooltipClose => '关闭';

  @override
  String get tooltipToggleObjectView => '切换对象/原始视图';

  @override
  String get tooltipClearUnused => '清除未使用对象';

  @override
  String get tooltipJsonViewer => '查看/编辑 JSON';

  @override
  String get tooltipAdd => '添加';

  @override
  String get tooltipDecrease => '减少';

  @override
  String get tooltipIncrease => '增加';
}
