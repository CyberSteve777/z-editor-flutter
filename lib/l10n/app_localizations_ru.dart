// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Моя библиотека уровней';

  @override
  String get about => 'О программе';

  @override
  String get back => 'Назад';

  @override
  String get refresh => 'Обновить';

  @override
  String get toggleTheme => 'Переключить тему';

  @override
  String get switchFolder => 'Сменить папку';

  @override
  String get clearCache => 'Очистить кэш';

  @override
  String get uiSize => 'Размер интерфейса';

  @override
  String get aboutSoftware => 'О программе';

  @override
  String get selectFolder => 'Выбрать папку';

  @override
  String get initSetup => 'Начальная настройка';

  @override
  String get selectFolderPrompt => 'Выберите папку для хранения уровней.';

  @override
  String get selectFolderButton => 'Выбрать папку';

  @override
  String get emptyFolder => 'Папка пуста';

  @override
  String get newFolder => 'Новая папка';

  @override
  String get newLevel => 'Новый уровень';

  @override
  String get rename => 'Переименовать';

  @override
  String get delete => 'Удалить';

  @override
  String get copy => 'Копировать';

  @override
  String get move => 'Переместить';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get create => 'Создать';

  @override
  String get newName => 'Новое имя';

  @override
  String get folderName => 'Имя папки';

  @override
  String get confirmDelete => 'Подтвердить удаление';

  @override
  String confirmDeleteMessage(Object detail, Object name) {
    return 'Вы уверены, что хотите удалить «$name»? $detail';
  }

  @override
  String get folderDeleteDetail => 'Если это папка, её содержимое также будет удалено.';

  @override
  String get levelDeleteDetail => 'Это действие нельзя отменить.';

  @override
  String get confirmDeleteCheckbox => 'Я подтверждаю безвозвратное удаление';

  @override
  String get renameSuccess => 'Переименовано успешно';

  @override
  String get renameFail => 'Ошибка переименования, файл уже существует';

  @override
  String get deleted => 'Удалено';

  @override
  String get copyLevel => 'Копировать уровень';

  @override
  String get newFileName => 'Новое имя файла';

  @override
  String get copySuccess => 'Копирование выполнено';

  @override
  String get copyFail => 'Ошибка копирования';

  @override
  String moving(Object name) {
    return 'Перемещение: $name';
  }

  @override
  String get movePrompt => 'Перейдите в целевую папку и нажмите «Вставить»';

  @override
  String get paste => 'Вставить';

  @override
  String get folderCreated => 'Папка создана';

  @override
  String get createFail => 'Ошибка создания';

  @override
  String get noTemplates => 'Шаблоны не найдены';

  @override
  String get newLevelTemplate => 'Новый уровень — выбор шаблона';

  @override
  String get nameLevel => 'Название уровня';

  @override
  String get levelCreated => 'Уровень создан';

  @override
  String get levelCreateFail => 'Ошибка создания, файл уже существует';

  @override
  String get adjustUiSize => 'Настроить размер интерфейса';

  @override
  String currentScale(Object percent) {
    return 'Текущий масштаб: $percent%';
  }

  @override
  String get small => 'Малый';

  @override
  String get standard => 'Стандартный';

  @override
  String get large => 'Большой';

  @override
  String get done => 'Готово';

  @override
  String get reset => 'Сброс';

  @override
  String cacheCleared(Object count) {
    return 'Очищено файлов в кэше: $count';
  }

  @override
  String get returnUp => 'Назад';

  @override
  String get jsonFile => 'JSON-файл';

  @override
  String get softwareIntro => 'О программе';

  @override
  String get zEditor => 'Z-Editor';

  @override
  String get pvzEditorSubtitle => 'Визуальный редактор уровней PVZ2';

  @override
  String get introSection => 'Введение';

  @override
  String get introText => 'Z-Editor — визуальный редактор уровней для Plants vs. Zombies 2. Упрощает редактирование JSON-файлов уровней с помощью интуитивного интерфейса.';

  @override
  String get featuresSection => 'Основные возможности';

  @override
  String get feature1 => 'Модульное редактирование: управление модулями и событиями уровней.';

  @override
  String get feature2 => 'Режимы: «Я зомби», «Разбей горшки», «Несокрушимый», бой с Зомбоссом.';

  @override
  String get feature3 => 'Пользовательские зомби: добавление и редактирование свойств.';

  @override
  String get feature4 => 'Проверка: обнаружение отсутствующих модулей и неверных ссылок.';

  @override
  String get usageSection => 'Использование';

  @override
  String get usageText => '1. Папка: нажмите на иконку папки, чтобы выбрать каталог с уровнями.\n2. Открыть/Создать: нажмите на уровень для редактирования или «+» для создания из шаблона.\n3. Модули: добавляйте модули в редакторе.\n4. Сохранить: нажмите «Сохранить» для записи в JSON.\nQQ-группа: 562251204';

  @override
  String get creditsSection => 'Благодарности';

  @override
  String get authorLabel => 'Автор:';

  @override
  String get authorName => '降维打击';

  @override
  String get thanksLabel => 'Благодарность:';

  @override
  String get thanksNames => '星寻、metal海枣、超越自我3333、桃酱、凉沈、小小师、顾小言、PhiLia093、咖啡、不留名';

  @override
  String get tagline => 'Создавайте бесконечные возможности';

  @override
  String version(Object version) {
    return 'Версия $version';
  }

  @override
  String get language => 'Язык';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '中文';

  @override
  String get languageRussian => 'Русский';

  @override
  String get templateBlankLevel => 'Пустой уровень';

  @override
  String get templateCardPickExample => 'Пример выбора карт';

  @override
  String get templateConveyorExample => 'Пример конвейера';

  @override
  String get templateLastStandExample => 'Пример «Несокрушимый»';

  @override
  String get templateIZombieExample => 'Пример «Я зомби»';

  @override
  String get templateVaseBreakerExample => 'Пример «Разбей горшки»';

  @override
  String get templateZombossExample => 'Пример боя с Зомбоссом';

  @override
  String get templateCustomZombieExample => 'Пример пользовательского зомби';

  @override
  String get templateIPlantExample => 'Пример «Я растение»';

  @override
  String get unsavedChanges => 'Несохранённые изменения';

  @override
  String get saveBeforeLeaving => 'Сохранить перед выходом?';

  @override
  String get discard => 'Не сохранять';

  @override
  String get saved => 'Сохранено';

  @override
  String get failedToLoadLevel => 'Не удалось загрузить уровень';

  @override
  String get noLevelDefinition => 'Определение уровня не найдено';

  @override
  String get noLevelDefinitionHint => 'Модуль определения уровня (LevelDefinition) не найден. Это базовый узел файла уровня. Попробуйте добавить его вручную.';

  @override
  String get levelBasicInfo => 'Основные данные уровня';

  @override
  String get levelBasicInfoSubtitle => 'Название, номер, описание, стадия';

  @override
  String get removeModule => 'Удалить модуль';

  @override
  String get zombieCategoryMain => 'By World';

  @override
  String get zombieCategorySize => 'By Size';

  @override
  String get zombieCategoryOther => 'Other';

  @override
  String get zombieCategoryCollection => 'My Collection';

  @override
  String get zombieTagAll => 'All Zombies';

  @override
  String get zombieTagEgyptPirate => 'Egypt/Pirate';

  @override
  String get zombieTagWestFuture => 'West/Future';

  @override
  String get zombieTagDarkBeach => 'Dark/Beach';

  @override
  String get zombieTagIceageLostcity => 'Ice Age/Lost City';

  @override
  String get zombieTagKongfuSkycity => 'Kongfu/Sky City';

  @override
  String get zombieTagEightiesDino => '80s/Dino';

  @override
  String get zombieTagModernPvz1 => 'Modern/Pvz1';

  @override
  String get zombieTagSteamRenai => 'Steam/Renaissance';

  @override
  String get zombieTagHenaiAtlantis => 'Heian/Atlantis';

  @override
  String get zombieTagTaleZCorp => 'Fairytale/ZCorp';

  @override
  String get zombieTagParkourSpeed => 'Parkour/Speed';

  @override
  String get zombieTagTothewest => 'Journey to West';

  @override
  String get zombieTagMemory => 'Memory Journey';

  @override
  String get zombieTagUniverse => 'Parallel Universe';

  @override
  String get zombieTagFestival1 => 'Festival 1';

  @override
  String get zombieTagFestival2 => 'Festival 2';

  @override
  String get zombieTagRoman => 'Roman';

  @override
  String get zombieTagPet => 'Pet';

  @override
  String get zombieTagImp => 'Imp';

  @override
  String get zombieTagBasic => 'Basic';

  @override
  String get zombieTagFat => 'Fat';

  @override
  String get zombieTagStrong => 'Strong';

  @override
  String get zombieTagGargantuar => 'Gargantuar';

  @override
  String get zombieTagElite => 'Elite';

  @override
  String get zombieTagEvildave => 'Evil Dave';

  @override
  String get plantCategoryQuality => 'By Quality';

  @override
  String get plantCategoryRole => 'By Role';

  @override
  String get plantCategoryAttribute => 'By Attribute';

  @override
  String get plantCategoryOther => 'Other';

  @override
  String get plantCategoryCollection => 'My Collection';

  @override
  String get plantTagAll => 'All Plants';

  @override
  String get plantTagWhite => 'White Quality';

  @override
  String get plantTagGreen => 'Green Quality';

  @override
  String get plantTagBlue => 'Blue Quality';

  @override
  String get plantTagPurple => 'Purple Quality';

  @override
  String get plantTagOrange => 'Orange Quality';

  @override
  String get plantTagAssist => 'Assist';

  @override
  String get plantTagRemote => 'Remote';

  @override
  String get plantTagProductor => 'Producer';

  @override
  String get plantTagDefence => 'Defense';

  @override
  String get plantTagVanguard => 'Vanguard';

  @override
  String get plantTagTrapper => 'Trapper';

  @override
  String get plantTagFire => 'Fire';

  @override
  String get plantTagIce => 'Ice';

  @override
  String get plantTagMagic => 'Magic';

  @override
  String get plantTagPoison => 'Poison';

  @override
  String get plantTagElectric => 'Electric';

  @override
  String get plantTagPhysics => 'Physics';

  @override
  String get plantTagOriginal => 'Original PvZ1';

  @override
  String get plantTagParallel => 'Parallel World';

  @override
  String get removeModuleConfirm => 'Удалить этот модуль? Локальные модули (@CurrentLevel) и их данные будут удалены безвозвратно.';

  @override
  String get confirmRemove => 'Удалить';

  @override
  String get addModule => 'Добавить модуль';

  @override
  String get settings => 'Настройки';

  @override
  String get timeline => 'Волны';

  @override
  String get iZombie => 'Я зомби';

  @override
  String get vaseBreaker => 'Разбей горшки';

  @override
  String get zomboss => 'Зомбосс';

  @override
  String get moveSourceSameAsDest => 'Исходная и целевая папки совпадают';

  @override
  String get moveSuccess => 'Перемещение выполнено';

  @override
  String get moveFail => 'Ошибка перемещения';

  @override
  String get rootFolder => 'Корень';

  @override
  String get createEmptyWave => 'Создать пустую волну';

  @override
  String get close => 'Закрыть';

  @override
  String get editProperties => 'Редактировать свойства';

  @override
  String get deleteEntity => 'Удалить объект';

  @override
  String get moduleEditorInProgress => 'Редактор модуля в разработке';

  @override
  String get dataEmpty => 'Данные пусты';

  @override
  String get saveSuccess => 'Сохранено успешно';

  @override
  String get saveFail => 'Ошибка сохранения';

  @override
  String get confirmRemoveRef => 'Удалить ссылку';

  @override
  String get confirmRemoveRefMessage => 'Удалить эту ссылку? Данные объекта останутся до удаления всех ссылок.';

  @override
  String get code => 'Код';

  @override
  String get name => 'Название';

  @override
  String get description => 'Описание';

  @override
  String get levelNumber => 'Номер уровня';

  @override
  String get startingSun => 'Начальное солнце';

  @override
  String get stageModule => 'Стадия';

  @override
  String get musicType => 'Тип музыки';

  @override
  String get loot => 'Добыча';

  @override
  String get victoryModule => 'Условие победы';

  @override
  String get missingModules => 'Отсутствующие модули';

  @override
  String get moduleConflict => 'Конфликт модулей';

  @override
  String get editableModules => 'Редактируемые модули';

  @override
  String get parameterModules => 'Модули параметров';

  @override
  String get addNewModule => 'Добавить модуль';

  @override
  String get selectStage => 'Выбрать стадию';

  @override
  String get searchStage => 'Поиск стадии';

  @override
  String get noStageFound => 'Стадия не найдена';

  @override
  String get stageTypeAll => 'Все';

  @override
  String get stageTypeMain => 'Основные';

  @override
  String get stageTypeExtra => 'Дополнительные';

  @override
  String get stageTypeSeasons => 'Сезоны';

  @override
  String get stageTypeSpecial => 'Мини-игры';

  @override
  String get search => 'Поиск';

  @override
  String get disablePeavine => 'Отключить плющ';

  @override
  String get disableArtifact => 'Отключить артефакт';

  @override
  String get selectPlant => 'Выбрать растение';

  @override
  String get searchPlant => 'Поиск растения';

  @override
  String get noPlantFound => 'Растение не найдено';

  @override
  String get moduleTitle_WaveManagerModuleProperties => 'Wave Manager';

  @override
  String get moduleDesc_WaveManagerModuleProperties => 'Manage level wave events';

  @override
  String get moduleTitle_CustomLevelModuleProperties => 'Lawn Module';

  @override
  String get moduleDesc_CustomLevelModuleProperties => 'Enable custom lawn framework';

  @override
  String get moduleTitle_StandardLevelIntroProperties => 'Intro Animation';

  @override
  String get moduleDesc_StandardLevelIntroProperties => 'Camera pan at level start';

  @override
  String get moduleTitle_ZombiesAteYourBrainsProperties => 'Failure Condition';

  @override
  String get moduleDesc_ZombiesAteYourBrainsProperties => 'Zombie enters house condition';

  @override
  String get moduleTitle_ZombiesDeadWinConProperties => 'Death Drop';

  @override
  String get moduleDesc_ZombiesDeadWinConProperties => 'Required for level stability';

  @override
  String get moduleTitle_PennyClassroomModuleProperties => 'Plant Tier';

  @override
  String get moduleDesc_PennyClassroomModuleProperties => 'Global plant tier definition';

  @override
  String get moduleTitle_SeedBankProperties => 'Seed Bank';

  @override
  String get moduleDesc_SeedBankProperties => 'Preset plants and selection method';

  @override
  String get moduleTitle_ConveyorSeedBankProperties => 'Conveyor Belt';

  @override
  String get moduleDesc_ConveyorSeedBankProperties => 'Preset conveyor plants and weights';

  @override
  String get moduleTitle_SunDropperProperties => 'Sun Dropper';

  @override
  String get moduleDesc_SunDropperProperties => 'Control falling sun frequency';

  @override
  String get moduleTitle_LevelMutatorMaxSunProps => 'Max Sun';

  @override
  String get moduleDesc_LevelMutatorMaxSunProps => 'Override maximum sun limit';

  @override
  String get moduleTitle_LevelMutatorStartingPlantfoodProps => 'Starting Plant Food';

  @override
  String get moduleDesc_LevelMutatorStartingPlantfoodProps => 'Override initial plant food';

  @override
  String get moduleTitle_StarChallengeModuleProperties => 'Challenges';

  @override
  String get moduleDesc_StarChallengeModuleProperties => 'Level restrictions and goals';

  @override
  String get moduleTitle_LevelScoringModuleProperties => 'Scoring';

  @override
  String get moduleDesc_LevelScoringModuleProperties => 'Enable score points for kills';

  @override
  String get moduleTitle_BowlingMinigameProperties => 'Bowling Bulb';

  @override
  String get moduleDesc_BowlingMinigameProperties => 'Set line and disable shovel';

  @override
  String get moduleTitle_NewBowlingMinigameProperties => 'Wall-nut Bowling';

  @override
  String get moduleDesc_NewBowlingMinigameProperties => 'Bowling line setup';

  @override
  String get moduleTitle_VaseBreakerPresetProperties => 'Vase Layout';

  @override
  String get moduleDesc_VaseBreakerPresetProperties => 'Configure vase contents';

  @override
  String get moduleTitle_VaseBreakerArcadeModuleProperties => 'Vase Breaker Mode';

  @override
  String get moduleDesc_VaseBreakerArcadeModuleProperties => 'Enable vase breaker UI';

  @override
  String get moduleTitle_VaseBreakerFlowModuleProperties => 'Vase Animation';

  @override
  String get moduleDesc_VaseBreakerFlowModuleProperties => 'Control vase drop animation';

  @override
  String get moduleTitle_EvilDaveProperties => 'I, Zombie';

  @override
  String get moduleDesc_EvilDaveProperties => 'Enable I, Zombie mode';

  @override
  String get moduleTitle_ZombossBattleModuleProperties => 'Zomboss Battle';

  @override
  String get moduleDesc_ZombossBattleModuleProperties => 'Boss battle parameters';

  @override
  String get moduleTitle_ZombossBattleIntroProperties => 'Zomboss Intro';

  @override
  String get moduleDesc_ZombossBattleIntroProperties => 'Boss intro and health bar';

  @override
  String get moduleTitle_SeedRainProperties => 'Seed Rain';

  @override
  String get moduleDesc_SeedRainProperties => 'Falling plants/zombies/items';

  @override
  String get moduleTitle_LastStandMinigameProperties => 'Last Stand';

  @override
  String get moduleDesc_LastStandMinigameProperties => 'Initial resources and setup phase';

  @override
  String get moduleTitle_PVZ1OverwhelmModuleProperties => 'Overwhelm';

  @override
  String get moduleDesc_PVZ1OverwhelmModuleProperties => 'Overwhelm minigame';

  @override
  String get moduleTitle_SunBombChallengeProperties => 'Sun Bombs';

  @override
  String get moduleDesc_SunBombChallengeProperties => 'Falling sun bomb config';

  @override
  String get moduleTitle_IncreasedCostModuleProperties => 'Inflation';

  @override
  String get moduleDesc_IncreasedCostModuleProperties => 'Sun cost increases with planting';

  @override
  String get moduleTitle_DeathHoleModuleProperties => 'Death Holes';

  @override
  String get moduleDesc_DeathHoleModuleProperties => 'Plants leave unplantable holes';

  @override
  String get moduleTitle_ZombieMoveFastModuleProperties => 'Fast Entry';

  @override
  String get moduleDesc_ZombieMoveFastModuleProperties => 'Zombies move fast on entry';

  @override
  String get moduleTitle_InitialPlantEntryProperties => 'Initial Plants';

  @override
  String get moduleDesc_InitialPlantEntryProperties => 'Plants present at start';

  @override
  String get moduleTitle_InitialZombieProperties => 'Initial Zombies';

  @override
  String get moduleDesc_InitialZombieProperties => 'Zombies present at start';

  @override
  String get moduleTitle_InitialGridItemProperties => 'Initial Grid Items';

  @override
  String get moduleDesc_InitialGridItemProperties => 'Grid items present at start';

  @override
  String get moduleTitle_ProtectThePlantChallengeProperties => 'Protect Plants';

  @override
  String get moduleDesc_ProtectThePlantChallengeProperties => 'Plants that must be protected';

  @override
  String get moduleTitle_ProtectTheGridItemChallengeProperties => 'Protect Items';

  @override
  String get moduleDesc_ProtectTheGridItemChallengeProperties => 'Items that must be protected';

  @override
  String get moduleTitle_ZombiePotionModuleProperties => 'Zombie Potions';

  @override
  String get moduleDesc_ZombiePotionModuleProperties => 'Dark Ages potion generation';

  @override
  String get moduleTitle_PiratePlankProperties => 'Pirate Planks';

  @override
  String get moduleDesc_PiratePlankProperties => 'Pirate Seas plank rows';

  @override
  String get moduleTitle_RailcartProperties => 'Railcarts';

  @override
  String get moduleDesc_RailcartProperties => 'Minecart and track layout';

  @override
  String get moduleTitle_PowerTileProperties => 'Power Tiles';

  @override
  String get moduleDesc_PowerTileProperties => 'Future power tile layout';

  @override
  String get moduleTitle_ManholePipelineModuleProperties => 'Manholes';

  @override
  String get moduleDesc_ManholePipelineModuleProperties => 'Steam Age pipelines';

  @override
  String get moduleTitle_RoofProperties => 'Roof Pots';

  @override
  String get moduleDesc_RoofProperties => 'Roof level pot columns';

  @override
  String get moduleTitle_TideProperties => 'Tide System';

  @override
  String get moduleDesc_TideProperties => 'Enable tide system';

  @override
  String get moduleTitle_WarMistProperties => 'War Mist';

  @override
  String get moduleDesc_WarMistProperties => 'Fog of war system';

  @override
  String get moduleTitle_RainDarkProperties => 'Weather';

  @override
  String get moduleDesc_RainDarkProperties => 'Rain, snow, storm effects';

  @override
  String get eventTitle_SpawnZombiesFromGroundSpawnerProps => 'Ground Spawn';

  @override
  String get eventDesc_SpawnZombiesFromGroundSpawnerProps => 'Zombies spawn from ground';

  @override
  String get eventTitle_SpawnZombiesJitteredWaveActionProps => 'Standard Spawn';

  @override
  String get eventDesc_SpawnZombiesJitteredWaveActionProps => 'Basic natural spawn';

  @override
  String get eventTitle_FrostWindWaveActionProps => 'Frost Wind';

  @override
  String get eventDesc_FrostWindWaveActionProps => 'Freezing wind on rows';

  @override
  String get eventTitle_BeachStageEventZombieSpawnerProps => 'Low Tide';

  @override
  String get eventDesc_BeachStageEventZombieSpawnerProps => 'Zombies spawn at low tide';

  @override
  String get eventTitle_TidalChangeWaveActionProps => 'Tide Change';

  @override
  String get eventDesc_TidalChangeWaveActionProps => 'Change tide position';

  @override
  String get eventTitle_ModifyConveyorWaveActionProps => 'Conveyor Modify';

  @override
  String get eventDesc_ModifyConveyorWaveActionProps => 'Add/remove cards dynamically';

  @override
  String get eventTitle_DinoWaveActionProps => 'Dino Summon';

  @override
  String get eventDesc_DinoWaveActionProps => 'Summon dinosaur on row';

  @override
  String get eventTitle_SpawnModernPortalsWaveActionProps => 'Time Rift';

  @override
  String get eventDesc_SpawnModernPortalsWaveActionProps => 'Summon time rift';

  @override
  String get eventTitle_StormZombieSpawnerProps => 'Storm Spawn';

  @override
  String get eventDesc_StormZombieSpawnerProps => 'Sandstorm or blizzard spawn';

  @override
  String get eventTitle_RaidingPartyZombieSpawnerProps => 'Raiding Party';

  @override
  String get eventDesc_RaidingPartyZombieSpawnerProps => 'Swashbuckler invasion';

  @override
  String get eventTitle_ZombiePotionActionProps => 'Potion Drop';

  @override
  String get eventDesc_ZombiePotionActionProps => 'Spawn potions on grid';

  @override
  String get eventTitle_SpawnGravestonesWaveActionProps => 'Gravestone Spawn';

  @override
  String get eventDesc_SpawnGravestonesWaveActionProps => 'Spawn gravestones';

  @override
  String get eventTitle_SpawnZombiesFromGridItemSpawnerProps => 'Grave Spawn';

  @override
  String get eventDesc_SpawnZombiesFromGridItemSpawnerProps => 'Spawn zombies from graves';

  @override
  String get eventTitle_FairyTaleFogWaveActionProps => 'Fairy Fog';

  @override
  String get eventDesc_FairyTaleFogWaveActionProps => 'Spawn fog';

  @override
  String get eventTitle_FairyTaleWindWaveActionProps => 'Fairy Wind';

  @override
  String get eventDesc_FairyTaleWindWaveActionProps => 'Blow away fog';

  @override
  String get eventTitle_SpiderRainZombieSpawnerProps => 'Imp Rain';

  @override
  String get eventDesc_SpiderRainZombieSpawnerProps => 'Imps drop from sky';

  @override
  String get eventTitle_ParachuteRainZombieSpawnerProps => 'Parachute Rain';

  @override
  String get eventDesc_ParachuteRainZombieSpawnerProps => 'Zombies drop with parachutes';

  @override
  String get eventTitle_BassRainZombieSpawnerProps => 'Bass/Jetpack Rain';

  @override
  String get eventDesc_BassRainZombieSpawnerProps => 'Bass/Jetpack zombies drop';

  @override
  String get eventTitle_BlackHoleWaveActionProps => 'Black Hole';

  @override
  String get eventDesc_BlackHoleWaveActionProps => 'Black hole attracts plants';

  @override
  String get eventTitle_WaveActionMagicMirrorTeleportationArrayProps2 => 'Magic Mirror';

  @override
  String get eventDesc_WaveActionMagicMirrorTeleportationArrayProps2 => 'Mirror portals';

  @override
  String get weatherOption_DefaultSnow_label => 'Frostbite Caves (DefaultSnow)';

  @override
  String get weatherOption_DefaultSnow_desc => 'Snowing effect from Frostbite Caves';

  @override
  String get weatherOption_LightningRain_label => 'Thunderstorm (LightningRain)';

  @override
  String get weatherOption_LightningRain_desc => 'Rain and lightning from Dark Ages Day 8';

  @override
  String get weatherOption_DefaultRainDark_label => 'Dark Ages (DefaultRainDark)';

  @override
  String get weatherOption_DefaultRainDark_desc => 'Rain effect from Dark Ages';
}
