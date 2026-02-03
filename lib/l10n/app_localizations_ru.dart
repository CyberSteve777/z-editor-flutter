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
  String get folderDeleteDetail =>
      'Если это папка, её содержимое также будет удалено.';

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
  String get introText =>
      'Z-Editor — визуальный редактор уровней для Plants vs. Zombies 2. Упрощает редактирование JSON-файлов уровней с помощью интуитивного интерфейса.';

  @override
  String get featuresSection => 'Основные возможности';

  @override
  String get feature1 =>
      'Модульное редактирование: управление модулями и событиями уровней.';

  @override
  String get feature2 =>
      'Режимы: «Я зомби», «Разбей горшки», «Несокрушимый», бой с Зомбоссом.';

  @override
  String get feature3 =>
      'Пользовательские зомби: добавление и редактирование свойств.';

  @override
  String get feature4 =>
      'Проверка: обнаружение отсутствующих модулей и неверных ссылок.';

  @override
  String get usageSection => 'Использование';

  @override
  String get usageText =>
      '1. Папка: нажмите на иконку папки, чтобы выбрать каталог с уровнями.\n2. Открыть/Создать: нажмите на уровень для редактирования или «+» для создания из шаблона.\n3. Модули: добавляйте модули в редакторе.\n4. Сохранить: нажмите «Сохранить» для записи в JSON.\nQQ-группа: 562251204';

  @override
  String get creditsSection => 'Благодарности';

  @override
  String get authorLabel => 'Автор:';

  @override
  String get authorName => '降维打击';

  @override
  String get thanksLabel => 'Благодарность:';

  @override
  String get thanksNames =>
      '星寻、metal海枣、超越自我3333、桃酱、凉沈、小小师、顾小言、PhiLia093、咖啡、不留名';

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
  String get noLevelDefinitionHint =>
      'Модуль определения уровня (LevelDefinition) не найден. Это базовый узел файла уровня. Попробуйте добавить его вручную.';

  @override
  String get levelBasicInfo => 'Основные данные уровня';

  @override
  String get levelBasicInfoSubtitle => 'Название, номер, описание, стадия';

  @override
  String get removeModule => 'Удалить модуль';

  @override
  String get zombieCategoryMain => 'По миру';

  @override
  String get zombieCategorySize => 'По размеру';

  @override
  String get zombieCategoryOther => 'Прочее';

  @override
  String get zombieCategoryCollection => 'Моя коллекция';

  @override
  String get zombieTagAll => 'Все зомби';

  @override
  String get zombieTagEgyptPirate => 'Египет/Пираты';

  @override
  String get zombieTagWestFuture => 'Запад/Будущее';

  @override
  String get zombieTagDarkBeach => 'Тёмные/Пляж';

  @override
  String get zombieTagIceageLostcity => 'Ледниковый/Затерянный город';

  @override
  String get zombieTagKongfuSkycity => 'Кунг-фу/Небесный город';

  @override
  String get zombieTagEightiesDino => '80-е/Динозавры';

  @override
  String get zombieTagModernPvz1 => 'Современный/PvZ1';

  @override
  String get zombieTagSteamRenai => 'Пар/Ренессанс';

  @override
  String get zombieTagHenaiAtlantis => 'Хэйан/Атлантида';

  @override
  String get zombieTagTaleZCorp => 'Сказка/ZCorp';

  @override
  String get zombieTagParkourSpeed => 'Паркур/Скорость';

  @override
  String get zombieTagTothewest => 'Путь на Запад';

  @override
  String get zombieTagMemory => 'Путь воспоминаний';

  @override
  String get zombieTagUniverse => 'Параллельный мир';

  @override
  String get zombieTagFestival1 => 'Фестиваль 1';

  @override
  String get zombieTagFestival2 => 'Фестиваль 2';

  @override
  String get zombieTagRoman => 'Рим';

  @override
  String get zombieTagPet => 'Питомец';

  @override
  String get zombieTagImp => 'Имп';

  @override
  String get zombieTagBasic => 'Базовый';

  @override
  String get zombieTagFat => 'Толстый';

  @override
  String get zombieTagStrong => 'Сильный';

  @override
  String get zombieTagGargantuar => 'Гаргантюар';

  @override
  String get zombieTagElite => 'Элита';

  @override
  String get zombieTagEvildave => 'Злой Дейв';

  @override
  String get plantCategoryQuality => 'По качеству';

  @override
  String get plantCategoryRole => 'По роли';

  @override
  String get plantCategoryAttribute => 'По атрибуту';

  @override
  String get plantCategoryOther => 'Прочее';

  @override
  String get plantCategoryCollection => 'Моя коллекция';

  @override
  String get plantTagAll => 'Все растения';

  @override
  String get plantTagWhite => 'Белое качество';

  @override
  String get plantTagGreen => 'Зелёное качество';

  @override
  String get plantTagBlue => 'Синее качество';

  @override
  String get plantTagPurple => 'Фиолетовое качество';

  @override
  String get plantTagOrange => 'Оранжевое качество';

  @override
  String get plantTagAssist => 'Помощник';

  @override
  String get plantTagRemote => 'Дальний бой';

  @override
  String get plantTagProductor => 'Производитель';

  @override
  String get plantTagDefence => 'Защита';

  @override
  String get plantTagVanguard => 'Авангард';

  @override
  String get plantTagTrapper => 'Ловушка';

  @override
  String get plantTagFire => 'Огонь';

  @override
  String get plantTagIce => 'Лёд';

  @override
  String get plantTagMagic => 'Магия';

  @override
  String get plantTagPoison => 'Яд';

  @override
  String get plantTagElectric => 'Электричество';

  @override
  String get plantTagPhysics => 'Физика';

  @override
  String get plantTagOriginal => 'Оригинал PvZ1';

  @override
  String get plantTagParallel => 'Параллельный мир';

  @override
  String get removeModuleConfirm =>
      'Удалить этот модуль? Локальные модули (@CurrentLevel) и их данные будут удалены безвозвратно.';

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
  String get noWaveManager => 'Менеджер волн не найден';

  @override
  String get noWaveManagerHint =>
      'У уровня есть модуль волн, но отсутствует объект WaveManagerProperties.';

  @override
  String get waveTimelineHint =>
      'Нажмите на событие для редактирования. Нажмите + для добавления.';

  @override
  String get waveTimelineHintDetail => 'Смахните влево для удаления волны.';

  @override
  String get waveTimelineGuideTitle => 'Инструкция';

  @override
  String get waveTimelineGuideBody =>
      'Свайп вправо: управление событиями волны\nСвайп влево: удалить волну\nНажмите на очки: ожидание';

  @override
  String get waveDeadLinksTitle => 'Неверные ссылки';

  @override
  String get waveDeadLinksClear => 'Очистить неверные ссылки';

  @override
  String get customZombieManagerTitle => 'Управление пользовательскими зомби';

  @override
  String get customZombieEmpty => 'Нет данных о пользовательских зомби';

  @override
  String get waveManagerGlobalParams => 'Глобальные параметры волн';

  @override
  String waveManagerGlobalSummary(
    int interval,
    int minPercent,
    int maxPercent,
  ) {
    return 'Интервал флага: $interval, порог здоровья: $minPercent% - $maxPercent%';
  }

  @override
  String get waveEmptyTitle => 'Список волн пуст';

  @override
  String get waveEmptySubtitle =>
      'Добавьте первую волну или удалите этот пустой контейнер.';

  @override
  String get waveHeaderPreview => 'Содержимое и очки';

  @override
  String waveTotalLabel(int total) {
    return 'Всего: $total';
  }

  @override
  String get waveEmptyRowHint => 'Пустая волна (свайп влево/вправо)';

  @override
  String get removeFromWave => 'Удалить из волны';

  @override
  String get deleteEventEntityTitle => 'Удалить объект события?';

  @override
  String get deleteEventEntityBody => 'Это удалит объект события из уровня.';

  @override
  String waveEventsTitle(int wave) {
    return 'События волны $wave';
  }

  @override
  String get waveManagerSettings => 'Настройки менеджера волн';

  @override
  String get flagInterval => 'Интервал флага';

  @override
  String get waveManagerHelpTitle => 'Менеджер волн';

  @override
  String get waveManagerHelpOverviewTitle => 'Обзор';

  @override
  String get waveManagerHelpOverviewBody =>
      'Глобальные параметры волн и пороги здоровья.';

  @override
  String get waveManagerHelpFlagTitle => 'Интервал флага';

  @override
  String get waveManagerHelpFlagBody =>
      'Каждые N волн — флаговая; последняя волна всегда флаговая.';

  @override
  String get waveManagerHelpTimeTitle => 'Контроль времени';

  @override
  String get waveManagerHelpTimeBody =>
      'Задержка первой волны зависит от наличия конвейера.';

  @override
  String get waveManagerHelpMusicTitle => 'Тип музыки';

  @override
  String get waveManagerHelpMusicBody =>
      'Только Modern; задает фиксированный фон.';

  @override
  String get waveManagerBasicParams => 'Базовые параметры';

  @override
  String get waveManagerMaxHealthThreshold => 'Макс. порог здоровья';

  @override
  String get waveManagerMinHealthThreshold => 'Мин. порог здоровья';

  @override
  String get waveManagerThresholdHint => 'Порог должен быть от 0 до 1.';

  @override
  String get waveManagerTimeControl => 'Контроль времени';

  @override
  String get waveManagerFirstWaveDelayConveyor =>
      'Задержка первой волны (конвейер)';

  @override
  String get waveManagerFirstWaveDelayNormal =>
      'Задержка первой волны (обычно)';

  @override
  String get waveManagerFlagWaveDelay => 'Задержка флаговой волны';

  @override
  String get waveManagerConveyorDetected =>
      'Обнаружен конвейер; применена задержка конвейера.';

  @override
  String get waveManagerConveyorNotDetected =>
      'Конвейер не найден; применена обычная задержка.';

  @override
  String get waveManagerSpecial => 'Особое';

  @override
  String get waveManagerSuppressFlagZombieTitle => 'Отключить флаг-зомби';

  @override
  String get waveManagerSuppressFlagZombieField => 'SuppressFlagZombie';

  @override
  String get waveManagerSuppressFlagZombieHint =>
      'При включении флаговые волны не спавнят флаг-зомби.';

  @override
  String get waveManagerLevelJam => 'Level Jam';

  @override
  String get waveManagerLevelJamHint =>
      'Только Modern; фиксированная фоновая музыка.';

  @override
  String get jamNone => 'Нет';

  @override
  String get jamPop => 'Поп';

  @override
  String get jamRap => 'Рэп';

  @override
  String get jamMetal => 'Метал';

  @override
  String get jamPunk => 'Панк';

  @override
  String get jam8Bit => '8-бит';

  @override
  String get noWaves => 'Нет волн';

  @override
  String get addFirstWave => 'Добавьте первую волну.';

  @override
  String get deleteWave => 'Удалить';

  @override
  String deleteWaveConfirm(int count) {
    return 'Будет удалена эта волна и её $count событий.';
  }

  @override
  String get addEvent => 'Добавить событие';

  @override
  String get emptyWave => 'Пустая волна';

  @override
  String get addWave => 'Добавить волну';

  @override
  String get expectation => 'Ожидание';

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
  String get confirmRemoveRefMessage =>
      'Удалить эту ссылку? Данные объекта останутся до удаления всех ссылок.';

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
  String noResultsFor(Object query) {
    return 'Нет результатов для «$query»';
  }

  @override
  String get noModulesInCategory => 'Нет модулей в этой категории';

  @override
  String addEventForWave(int wave) {
    return 'Добавить событие для волны $wave';
  }

  @override
  String get waveLabel => 'Волна';

  @override
  String get pointsLabel => 'Очки';

  @override
  String get noDynamicZombies => 'Нет динамических зомби';

  @override
  String get moduleTitle_WaveManagerModuleProperties => 'Менеджер волн';

  @override
  String get moduleDesc_WaveManagerModuleProperties =>
      'Управление волнами уровня';

  @override
  String get moduleTitle_CustomLevelModuleProperties => 'Модуль лужайки';

  @override
  String get moduleDesc_CustomLevelModuleProperties =>
      'Включить свою схему лужайки';

  @override
  String get moduleTitle_StandardLevelIntroProperties => 'Заставка';

  @override
  String get moduleDesc_StandardLevelIntroProperties =>
      'Прокрутка камеры в начале уровня';

  @override
  String get moduleTitle_ZombiesAteYourBrainsProperties => 'Условие поражения';

  @override
  String get moduleDesc_ZombiesAteYourBrainsProperties => 'Зомби дошёл до дома';

  @override
  String get moduleTitle_ZombiesDeadWinConProperties => 'Смертельная капля';

  @override
  String get moduleDesc_ZombiesDeadWinConProperties =>
      'Нужно для стабильности уровня';

  @override
  String get moduleTitle_PennyClassroomModuleProperties => 'Уровень растений';

  @override
  String get moduleDesc_PennyClassroomModuleProperties =>
      'Глобальные уровни растений';

  @override
  String get moduleTitle_SeedBankProperties => 'Банк семян';

  @override
  String get moduleDesc_SeedBankProperties => 'Набор растений и способ выбора';

  @override
  String get moduleTitle_ConveyorSeedBankProperties => 'Конвейер';

  @override
  String get moduleDesc_ConveyorSeedBankProperties =>
      'Растения на конвейере и веса';

  @override
  String get moduleTitle_SunDropperProperties => 'Падающее солнце';

  @override
  String get moduleDesc_SunDropperProperties => 'Частота падения солнца';

  @override
  String get moduleTitle_LevelMutatorMaxSunProps => 'Макс. солнце';

  @override
  String get moduleDesc_LevelMutatorMaxSunProps => 'Лимит солнца';

  @override
  String get moduleTitle_LevelMutatorStartingPlantfoodProps =>
      'Стартовый растительный корм';

  @override
  String get moduleDesc_LevelMutatorStartingPlantfoodProps =>
      'Начальный растительный корм';

  @override
  String get moduleTitle_StarChallengeModuleProperties => 'Испытания';

  @override
  String get moduleDesc_StarChallengeModuleProperties =>
      'Ограничения и цели уровня';

  @override
  String get moduleTitle_LevelScoringModuleProperties => 'Очки';

  @override
  String get moduleDesc_LevelScoringModuleProperties => 'Очки за убийства';

  @override
  String get moduleTitle_BowlingMinigameProperties => 'Боулинг';

  @override
  String get moduleDesc_BowlingMinigameProperties =>
      'Линия и отключение лопаты';

  @override
  String get moduleTitle_NewBowlingMinigameProperties => 'Боулинг с орехами';

  @override
  String get moduleDesc_NewBowlingMinigameProperties =>
      'Настройка линии боулинга';

  @override
  String get moduleTitle_VaseBreakerPresetProperties => 'Расклад ваз';

  @override
  String get moduleDesc_VaseBreakerPresetProperties => 'Содержимое ваз';

  @override
  String get moduleTitle_VaseBreakerArcadeModuleProperties =>
      'Режим «Разбей горшки»';

  @override
  String get moduleDesc_VaseBreakerArcadeModuleProperties =>
      'Включить интерфейс режима';

  @override
  String get moduleTitle_VaseBreakerFlowModuleProperties => 'Анимация ваз';

  @override
  String get moduleDesc_VaseBreakerFlowModuleProperties =>
      'Анимация падения ваз';

  @override
  String get moduleTitle_EvilDaveProperties => 'Я зомби';

  @override
  String get moduleDesc_EvilDaveProperties => 'Включить режим «Я зомби»';

  @override
  String get moduleTitle_ZombossBattleModuleProperties => 'Бой с Зомбоссом';

  @override
  String get moduleDesc_ZombossBattleModuleProperties => 'Параметры босса';

  @override
  String get moduleTitle_ZombossBattleIntroProperties => 'Заставка Зомбосса';

  @override
  String get moduleDesc_ZombossBattleIntroProperties =>
      'Заставка и полоска здоровья босса';

  @override
  String get moduleTitle_SeedRainProperties => 'Семенной дождь';

  @override
  String get moduleDesc_SeedRainProperties =>
      'Падающие растения/зомби/предметы';

  @override
  String get moduleTitle_LastStandMinigameProperties => 'Несокрушимый';

  @override
  String get moduleDesc_LastStandMinigameProperties =>
      'Стартовые ресурсы и фаза подготовки';

  @override
  String get moduleTitle_PVZ1OverwhelmModuleProperties => 'Overwhelm';

  @override
  String get moduleDesc_PVZ1OverwhelmModuleProperties => 'Мини-игра Overwhelm';

  @override
  String get moduleTitle_SunBombChallengeProperties => 'Солнечные бомбы';

  @override
  String get moduleDesc_SunBombChallengeProperties =>
      'Настройка падающих солнечных бомб';

  @override
  String get moduleTitle_IncreasedCostModuleProperties => 'Инфляция';

  @override
  String get moduleDesc_IncreasedCostModuleProperties =>
      'Рост стоимости солнца при посадке';

  @override
  String get moduleTitle_DeathHoleModuleProperties => 'Смертельные ямы';

  @override
  String get moduleDesc_DeathHoleModuleProperties =>
      'Растения оставляют непосадочные ямы';

  @override
  String get moduleTitle_ZombieMoveFastModuleProperties => 'Быстрый вход';

  @override
  String get moduleDesc_ZombieMoveFastModuleProperties =>
      'Зомби быстрее входят';

  @override
  String get moduleTitle_InitialPlantEntryProperties => 'Начальные растения';

  @override
  String get moduleDesc_InitialPlantEntryProperties =>
      'Растения в начале уровня';

  @override
  String get moduleTitle_InitialZombieProperties => 'Начальные зомби';

  @override
  String get moduleDesc_InitialZombieProperties => 'Зомби в начале уровня';

  @override
  String get moduleTitle_InitialGridItemProperties => 'Начальные объекты сетки';

  @override
  String get moduleDesc_InitialGridItemProperties =>
      'Объекты сетки в начале уровня';

  @override
  String get moduleTitle_ProtectThePlantChallengeProperties =>
      'Защитить растения';

  @override
  String get moduleDesc_ProtectThePlantChallengeProperties =>
      'Растения, которые нужно защитить';

  @override
  String get moduleTitle_ProtectTheGridItemChallengeProperties =>
      'Защитить предметы';

  @override
  String get moduleDesc_ProtectTheGridItemChallengeProperties =>
      'Предметы, которые нужно защитить';

  @override
  String get moduleTitle_ZombiePotionModuleProperties => 'Зелья зомби';

  @override
  String get moduleDesc_ZombiePotionModuleProperties =>
      'Генерация зелий в Тёмных веках';

  @override
  String get moduleTitle_PiratePlankProperties => 'Пиратские доски';

  @override
  String get moduleDesc_PiratePlankProperties => 'Ряды досок в Пиратском море';

  @override
  String get moduleTitle_RailcartProperties => 'Вагонетки';

  @override
  String get moduleDesc_RailcartProperties => 'Вагонетки и рельсы';

  @override
  String get moduleTitle_PowerTileProperties => 'Силовые плитки';

  @override
  String get moduleDesc_PowerTileProperties =>
      'Расклад силовых плиток в Будущем';

  @override
  String get moduleTitle_ManholePipelineModuleProperties => 'Люки';

  @override
  String get moduleDesc_ManholePipelineModuleProperties =>
      'Трубы в Паровом веке';

  @override
  String get moduleTitle_RoofProperties => 'Крышные горшки';

  @override
  String get moduleDesc_RoofProperties => 'Колонки горшков на крыше';

  @override
  String get moduleTitle_TideProperties => 'Система прилива';

  @override
  String get moduleDesc_TideProperties => 'Включить прилив';

  @override
  String get moduleTitle_WarMistProperties => 'Туман войны';

  @override
  String get moduleDesc_WarMistProperties => 'Система тумана войны';

  @override
  String get moduleTitle_RainDarkProperties => 'Погода';

  @override
  String get moduleDesc_RainDarkProperties => 'Дождь, снег, буря';

  @override
  String get eventTitle_SpawnZombiesFromGroundSpawnerProps => 'Земляной спавн';

  @override
  String get eventDesc_SpawnZombiesFromGroundSpawnerProps =>
      'Зомби появляются из-под земли';

  @override
  String get eventTitle_SpawnZombiesJitteredWaveActionProps =>
      'Стандартный спавн';

  @override
  String get eventDesc_SpawnZombiesJitteredWaveActionProps =>
      'Основной естественный спавн';

  @override
  String get eventTitle_FrostWindWaveActionProps => 'Морозный ветер';

  @override
  String get eventDesc_FrostWindWaveActionProps => 'Холодный ветер по рядам';

  @override
  String get eventTitle_BeachStageEventZombieSpawnerProps => 'Низкая вода';

  @override
  String get eventDesc_BeachStageEventZombieSpawnerProps =>
      'Зомби появляются при низкой воде';

  @override
  String get eventTitle_TidalChangeWaveActionProps => 'Смена прилива';

  @override
  String get eventDesc_TidalChangeWaveActionProps => 'Изменение уровня прилива';

  @override
  String get eventTitle_ModifyConveyorWaveActionProps => 'Изменение конвейера';

  @override
  String get eventDesc_ModifyConveyorWaveActionProps =>
      'Динамическое добавление/удаление карт';

  @override
  String get eventTitle_DinoWaveActionProps => 'Призыв динозавра';

  @override
  String get eventDesc_DinoWaveActionProps => 'Призвать динозавра на ряд';

  @override
  String get eventTitle_SpawnModernPortalsWaveActionProps => 'Разлом времени';

  @override
  String get eventDesc_SpawnModernPortalsWaveActionProps =>
      'Создать порталы времени';

  @override
  String get eventTitle_StormZombieSpawnerProps => 'Штормовой спавн';

  @override
  String get eventDesc_StormZombieSpawnerProps => 'Песчаная буря или метель';

  @override
  String get eventTitle_RaidingPartyZombieSpawnerProps => 'Налет пиратов';

  @override
  String get eventDesc_RaidingPartyZombieSpawnerProps =>
      'Разбойники/пиратские зомби вторгаются';

  @override
  String get eventTitle_ZombiePotionActionProps => 'Бросок зелий';

  @override
  String get eventDesc_ZombiePotionActionProps => 'Появление зелий на сетке';

  @override
  String get eventTitle_SpawnGravestonesWaveActionProps => 'Спавн надгробий';

  @override
  String get eventDesc_SpawnGravestonesWaveActionProps => 'Создать надгробия';

  @override
  String get eventTitle_SpawnZombiesFromGridItemSpawnerProps =>
      'Спавн из надгробий';

  @override
  String get eventDesc_SpawnZombiesFromGridItemSpawnerProps =>
      'Появление зомби из могил';

  @override
  String get eventTitle_FairyTaleFogWaveActionProps => 'Сказочный туман';

  @override
  String get eventDesc_FairyTaleFogWaveActionProps => 'Породить туман';

  @override
  String get eventTitle_FairyTaleWindWaveActionProps => 'Сказочный ветер';

  @override
  String get eventDesc_FairyTaleWindWaveActionProps => 'Сдувать туман';

  @override
  String get eventTitle_SpiderRainZombieSpawnerProps => 'Дождь импов';

  @override
  String get eventDesc_SpiderRainZombieSpawnerProps => 'Импы падают с неба';

  @override
  String get eventTitle_ParachuteRainZombieSpawnerProps => 'Парашютный дождь';

  @override
  String get eventDesc_ParachuteRainZombieSpawnerProps =>
      'Зомби падают с парашютами';

  @override
  String get eventTitle_BassRainZombieSpawnerProps =>
      'Дождь басистов/джетпаков';

  @override
  String get eventDesc_BassRainZombieSpawnerProps =>
      'Падают басисты/джетпак-зомби';

  @override
  String get eventTitle_BlackHoleWaveActionProps => 'Чёрная дыра';

  @override
  String get eventDesc_BlackHoleWaveActionProps =>
      'Чёрная дыра притягивает растения';

  @override
  String get eventTitle_MagicMirrorWaveActionProps => 'Волшебное зеркало';

  @override
  String get eventDesc_MagicMirrorWaveActionProps => 'Зеркальные порталы';

  @override
  String get eventTitle_WaveActionMagicMirrorTeleportationArrayProps2 =>
      'Волшебное зеркало';

  @override
  String get eventDesc_WaveActionMagicMirrorTeleportationArrayProps2 =>
      'Зеркальные порталы';

  @override
  String get weatherOption_DefaultSnow_label => 'Ледяные пещеры (DefaultSnow)';

  @override
  String get weatherOption_DefaultSnow_desc => 'Эффект снега из Ледяных пещер';

  @override
  String get weatherOption_LightningRain_label => 'Гроза (LightningRain)';

  @override
  String get weatherOption_LightningRain_desc =>
      'Дождь и молнии, Тёмные века день 8';

  @override
  String get weatherOption_DefaultRainDark_label =>
      'Тёмные века (DefaultRainDark)';

  @override
  String get weatherOption_DefaultRainDark_desc =>
      'Эффект дождя в Тёмных веках';

  @override
  String get iZombiePlantReserveLabel =>
      'Колонна резерва растений (PlantDistance)';

  @override
  String get column => 'Колонна';

  @override
  String get iZombieInfoText =>
      'В режиме «Я, Зомби» предварительные растения и зомби необходимо настроить в модуле уровня (Preset Plants) и в банке семян.';

  @override
  String get vaseRangeTitle => 'Диапазон генерации ваз и черный список';

  @override
  String get startColumnLabel => 'Начальная колонна (мин.)';

  @override
  String get endColumnLabel => 'Конечная колонна (макс.)';

  @override
  String get toggleBlacklistHint => 'Нажмите, чтобы переключить черный список';

  @override
  String get vaseCapacityTitle => 'Вместимость ваз';

  @override
  String vaseCapacitySummary(Object current, Object total) {
    return 'Назначено: $current / Всего ячеек: $total';
  }

  @override
  String get vaseListTitle => 'Список ваз';

  @override
  String get addVaseTitle => 'Добавить вазу';

  @override
  String get plantVaseOption => 'Ваза с растением';

  @override
  String get zombieVaseOption => 'Ваза с зомби';

  @override
  String get selectZombie => 'Выбрать зомби';

  @override
  String get searchZombie => 'Поиск зомби';

  @override
  String get noZombieFound => 'Зомби не найден';

  @override
  String get unknownVaseLabel => 'Неизвестная ваза';

  @override
  String get plantLabel => 'Растение';

  @override
  String get zombieLabel => 'Зомби';

  @override
  String get itemLabel => 'Предмет';

  @override
  String get railcartSettings => 'Настройки рельсов';

  @override
  String get railcartType => 'Тип вагонетки';

  @override
  String get layRails => 'Уложить рельсы';

  @override
  String get placeCarts => 'Разместить вагонетки';

  @override
  String get railSegments => 'Сегменты рельсов';

  @override
  String get railcartCount => 'Количество вагонеток';

  @override
  String get clearAll => 'Очистить всё';

  @override
  String get moduleCategoryBase => 'Базовые';

  @override
  String get moduleCategoryMode => 'Режимы';

  @override
  String get moduleCategoryScene => 'Сцена';
}
