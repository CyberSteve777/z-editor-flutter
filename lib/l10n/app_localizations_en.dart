// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Level Library';

  @override
  String get about => 'About';

  @override
  String get back => 'Back';

  @override
  String get refresh => 'Refresh';

  @override
  String get toggleTheme => 'Toggle theme';

  @override
  String get switchFolder => 'Switch folder';

  @override
  String get clearCache => 'Clear cache';

  @override
  String get uiSize => 'UI size';

  @override
  String get aboutSoftware => 'About';

  @override
  String get selectFolder => 'Select folder';

  @override
  String get storagePermissionHint =>
      'Storage permission required. Enable \"All files access\" in Settings to open level files.';

  @override
  String get storagePermissionDialogTitle => 'Storage Permission Required';

  @override
  String get storagePermissionDialogMessage =>
      'This app requires external storage access to open and save level files. Please grant \"All files access\" permission in Settings.';

  @override
  String get storagePermissionGoToSettings => 'Go to settings';

  @override
  String get storagePermissionDeny => 'Deny';

  @override
  String get initSetup => 'Initial setup';

  @override
  String get selectFolderPrompt =>
      'Please select a folder as the level storage directory.';

  @override
  String get selectFolderButton => 'Select folder';

  @override
  String get emptyFolder => 'Folder is empty';

  @override
  String get newFolder => 'New folder';

  @override
  String get newLevel => 'New level';

  @override
  String get rename => 'Rename';

  @override
  String get delete => 'Delete';

  @override
  String get copy => 'Copy';

  @override
  String get move => 'Move';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get create => 'Create';

  @override
  String get newName => 'New name';

  @override
  String get folderName => 'Folder name';

  @override
  String get confirmDelete => 'Confirm delete';

  @override
  String confirmDeleteMessage(Object detail, Object name) {
    return 'Are you sure you want to delete \"$name\"? $detail';
  }

  @override
  String get folderDeleteDetail =>
      'If it is a folder, its contents will also be deleted.';

  @override
  String get levelDeleteDetail => 'This action cannot be undone.';

  @override
  String get confirmDeleteCheckbox => 'I confirm permanent deletion';

  @override
  String get renameSuccess => 'Successfully renamed';

  @override
  String get renameFail => 'Rename failed, file already exists';

  @override
  String get copyReferenceOrDeep => 'Copy reference or make a deep copy?';

  @override
  String get copyReference => 'Copy reference';

  @override
  String get deepCopy => 'Deep copy';

  @override
  String get copyEventTarget => 'Target wave';

  @override
  String get targetWaveIndex => 'Target wave index';

  @override
  String get moveToWaveIndex => 'Move to wave index';

  @override
  String get invalidWaveIndex => 'Invalid wave index';

  @override
  String get renamingFailed => 'Renaming failed';

  @override
  String get deleted => 'Deleted';

  @override
  String get copyLevel => 'Copy level';

  @override
  String get newFileName => 'New file name';

  @override
  String get copySuccess => 'Copy successful';

  @override
  String get copyFail => 'Copy failed';

  @override
  String moving(Object name) {
    return 'Moving: $name';
  }

  @override
  String get movePrompt => 'Navigate to target folder, then tap Paste';

  @override
  String get paste => 'Paste';

  @override
  String get movingSuccess => 'Moved successfully';

  @override
  String get movingFail => 'Move failed';

  @override
  String get moveSameFolder => 'Source and target are the same';

  @override
  String get moveFileExistsTitle => 'File already exists';

  @override
  String get moveFileExistsMessage =>
      'A file with this name already exists in the destination folder.';

  @override
  String get moveOverwrite => 'Overwrite';

  @override
  String fileOverwritten(Object name) {
    return 'File was overwritten: $name';
  }

  @override
  String get moveSaveAsCopy => 'Save as copy';

  @override
  String get moveCancelled => 'Operation cancelled';

  @override
  String movedAs(Object name) {
    return 'Moved and saved as $name';
  }

  @override
  String get folderCreated => 'Folder created';

  @override
  String get createFail => 'Create failed';

  @override
  String get noTemplates => 'No templates found';

  @override
  String get newLevelTemplate => 'New level - Select template';

  @override
  String get nameLevel => 'Name level';

  @override
  String get levelCreated => 'Level created';

  @override
  String get levelCreateFail => 'Create failed, file already exists';

  @override
  String get adjustUiSize => 'Adjust UI size';

  @override
  String currentScale(Object percent) {
    return 'Current scale: $percent%';
  }

  @override
  String get small => 'Small';

  @override
  String get standard => 'Standard';

  @override
  String get large => 'Large';

  @override
  String get done => 'Done';

  @override
  String get reset => 'Reset';

  @override
  String cacheCleared(Object count) {
    return 'Cleared $count cached files';
  }

  @override
  String get returnUp => 'Back';

  @override
  String get jsonFile => 'JSON file';

  @override
  String get softwareIntro => 'Software intro';

  @override
  String get zEditor => 'Z-Editor';

  @override
  String get pvzEditorSubtitle => 'PVZ2 Visual Level Editor';

  @override
  String get introSection => 'Introduction';

  @override
  String get introText =>
      'Z-Editor is a visual level editing tool designed for Plants vs. Zombies 2. It aims to simplify editing level JSON files with an intuitive interface.';

  @override
  String get featuresSection => 'Core features';

  @override
  String get feature1 => 'Modular editing: Manage level modules and events.';

  @override
  String get feature2 =>
      'Multi-mode: I, Zombie, Vase Breaker, Last Stand, Zomboss battle.';

  @override
  String get feature3 =>
      'Custom zombies: Inject and edit custom zombie properties.';

  @override
  String get feature4 =>
      'Validation: Detect missing modules and broken references.';

  @override
  String get usageSection => 'Usage';

  @override
  String get usageText =>
      '1. Folder: Tap folder icon to choose level JSON directory.\n2. Open/Create: Tap a level to edit or use + to create from template.\n3. Modules: Add modules in the editor.\n4. Save: Tap save to write back to the JSON file.\nQQ group: 562251204';

  @override
  String get creditsSection => 'Credits';

  @override
  String get authorLabel => 'Author:';

  @override
  String get authorName => '降维打击';

  @override
  String get thanksLabel => 'Thanks:';

  @override
  String get thanksNames =>
      '星寻、metal海枣、超越自我3333、桃酱、凉沈、小小师、顾小言、PhiLia093、咖啡、不留名';

  @override
  String get tagline => 'Create infinite possibilities';

  @override
  String version(Object version) {
    return 'Version $version';
  }

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => '中文';

  @override
  String get languageRussian => 'Русский';

  @override
  String get templateBlankLevel => 'Blank level';

  @override
  String get templateCardPickExample => 'Card pick example';

  @override
  String get templateConveyorExample => 'Conveyor example';

  @override
  String get templateLastStandExample => 'Last stand example';

  @override
  String get templateIZombieExample => 'I, Zombie example';

  @override
  String get templateVaseBreakerExample => 'Vase breaker example';

  @override
  String get templateZombossExample => 'Zomboss battle example';

  @override
  String get templateCustomZombieExample => 'Custom zombie example';

  @override
  String get templateIPlantExample => 'I, Plant example';

  @override
  String get unsavedChanges => 'Unsaved changes';

  @override
  String get saveBeforeLeaving => 'Save before leaving?';

  @override
  String get discard => 'Discard';

  @override
  String get stayInEditor => 'Stay';

  @override
  String get saved => 'Saved';

  @override
  String get failedToLoadLevel => 'Failed to load level';

  @override
  String get noLevelDefinition => 'No level definition';

  @override
  String get noLevelDefinitionHint =>
      'Level definition module (LevelDefinition) was not found. This is the base node of the level file. Try adding it manually.';

  @override
  String get levelBasicInfo => 'Level basic info';

  @override
  String get levelBasicInfoSubtitle => 'Name, number, description, stage';

  @override
  String get removeModule => 'Remove module';

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
  String get removeModuleConfirm =>
      'Remove this module? Local custom modules (@CurrentLevel) and their data will be deleted permanently.';

  @override
  String get confirmRemove => 'Remove';

  @override
  String get addModule => 'Add module';

  @override
  String get settings => 'Settings';

  @override
  String get timeline => 'Timeline';

  @override
  String get iZombie => 'I, Zombie';

  @override
  String get vaseBreaker => 'Vase breaker';

  @override
  String get zomboss => 'Zomboss';

  @override
  String get moveSourceSameAsDest => 'Source and target folder are the same';

  @override
  String get moveSuccess => 'Moved successfully';

  @override
  String get moveFail => 'Move failed';

  @override
  String get rootFolder => 'Root';

  @override
  String get createEmptyWave => 'Create empty wave';

  @override
  String get createEmptyWaveContainer => 'Create empty wave container';

  @override
  String get deleteEmptyContainer => 'Delete empty container';

  @override
  String get deleteWaveContainerTitle => 'Delete wave container?';

  @override
  String get deleteWaveContainerConfirm =>
      'Are you sure you want to delete the empty wave container? You can create a new one later.';

  @override
  String get noWaveManager => 'No wave manager found';

  @override
  String get noWaveManagerHint =>
      'This level has wave management but no WaveManagerProperties object.';

  @override
  String get waveTimelineHint => 'Tap event to edit. Tap + to add event.';

  @override
  String get waveTimelineHintDetail => 'Swipe wave left to delete.';

  @override
  String get waveTimelineGuideTitle => 'Usage guide';

  @override
  String get waveTimelineGuideBody =>
      'Swipe right: manage wave events\nSwipe left: delete wave\nTap points: view expectation';

  @override
  String get waveDeadLinksTitle => 'Broken references';

  @override
  String get waveDeadLinksClear => 'Clear dead links';

  @override
  String get customZombieManagerTitle => 'Custom zombie management';

  @override
  String get customZombieEmpty => 'No custom zombie data';

  @override
  String get switchCustomZombie => 'Switch custom zombie';

  @override
  String get customZombieAppearanceLocation => 'Appearance location:';

  @override
  String get customZombieNotUsed =>
      'This custom zombie is not used by any wave or module.';

  @override
  String customZombieWaveItem(int n) {
    return 'Wave $n';
  }

  @override
  String get customZombieDeleteConfirm =>
      'Remove this custom zombie entity and its property data.';

  @override
  String get editCustomZombieProperties => 'Edit custom zombie properties';

  @override
  String get makeZombieAsCustom => 'Make zombie as custom';

  @override
  String get customLabel => 'Custom';

  @override
  String get waveManagerGlobalParams => 'Wave manager parameters';

  @override
  String waveManagerGlobalSummary(
    int interval,
    int minPercent,
    int maxPercent,
  ) {
    return 'Flag interval: $interval, health: $minPercent% - $maxPercent%';
  }

  @override
  String get waveEmptyTitle => 'No waves yet';

  @override
  String get waveEmptySubtitle =>
      'Add the first wave, or remove this empty container.';

  @override
  String get waveHeaderPreview => 'Content & points preview';

  @override
  String waveTotalLabel(int total) {
    return 'Total: $total';
  }

  @override
  String get waveEmptyRowHint => 'Empty wave (swipe left/right)';

  @override
  String get removeFromWave => 'Remove from wave';

  @override
  String get deleteEventEntityTitle => 'Delete event entity?';

  @override
  String get deleteEventEntityBody =>
      'This will remove the event object from the level.';

  @override
  String waveEventsTitle(int wave) {
    return 'Wave $wave events';
  }

  @override
  String get waveManagerSettings => 'Wave manager settings';

  @override
  String get flagInterval => 'Flag interval';

  @override
  String get waveManagerHelpTitle => 'Wave manager';

  @override
  String get waveManagerHelpOverviewTitle => 'Overview';

  @override
  String get waveManagerHelpOverviewBody =>
      'Global parameters for wave events and health thresholds.';

  @override
  String get waveManagerHelpFlagTitle => 'Flag interval';

  @override
  String get waveManagerHelpFlagBody =>
      'Every N waves is a flag wave; the final wave is always flag.';

  @override
  String get waveManagerHelpTimeTitle => 'Time control';

  @override
  String get waveManagerHelpTimeBody =>
      'First wave delay changes when a conveyor is present.';

  @override
  String get waveManagerHelpMusicTitle => 'Music type';

  @override
  String get waveManagerHelpMusicBody =>
      'Modern world only; provides fixed background jam type.';

  @override
  String get waveManagerBasicParams => 'Basic params';

  @override
  String get waveManagerMaxHealthThreshold => 'Max health threshold';

  @override
  String get waveManagerMinHealthThreshold => 'Min health threshold';

  @override
  String get waveManagerThresholdHint => 'Threshold must be between 0 and 1.';

  @override
  String get waveManagerTimeControl => 'Time control';

  @override
  String get waveManagerFirstWaveDelayConveyor => 'First wave delay (conveyor)';

  @override
  String get waveManagerFirstWaveDelayNormal => 'First wave delay (normal)';

  @override
  String get waveManagerFlagWaveDelay => 'Flag wave delay';

  @override
  String get waveManagerConveyorDetected =>
      'Conveyor module detected; conveyor delay applied.';

  @override
  String get waveManagerConveyorNotDetected =>
      'No conveyor module; normal delay applied.';

  @override
  String get waveManagerSpecial => 'Special';

  @override
  String get waveManagerSuppressFlagZombieTitle => 'Suppress flag zombie';

  @override
  String get waveManagerSuppressFlagZombieField => 'SuppressFlagZombie';

  @override
  String get waveManagerSuppressFlagZombieHint =>
      'When enabled, flag waves won’t spawn a flag zombie.';

  @override
  String get waveManagerLevelJam => 'Level Jam';

  @override
  String get waveManagerLevelJamHint =>
      'Only applies to Modern world; provides fixed background music.';

  @override
  String get jamNone => 'None';

  @override
  String get jamPop => 'Pop';

  @override
  String get jamRap => 'Rap';

  @override
  String get jamMetal => 'Metal';

  @override
  String get jamPunk => 'Punk';

  @override
  String get jam8Bit => '8-Bit';

  @override
  String get noWaves => 'No waves';

  @override
  String get addFirstWave => 'Add the first wave.';

  @override
  String get deleteWave => 'Delete';

  @override
  String deleteWaveConfirm(int count) {
    return 'This will remove this wave and its $count events.';
  }

  @override
  String get addEvent => 'Add event';

  @override
  String get emptyWave => 'Empty wave';

  @override
  String get addWave => 'Add wave';

  @override
  String get expectation => 'Expectation';

  @override
  String get close => 'Close';

  @override
  String get editProperties => 'Edit properties';

  @override
  String get deleteEntity => 'Delete entity';

  @override
  String get deleteObjectTitle => 'Delete object?';

  @override
  String get deleteObjectConfirmMessage =>
      'Remove this object from the level file? This action cannot be undone.';

  @override
  String get objectDeleted => 'Object deleted';

  @override
  String get moduleEditorInProgress => 'Module editor in development';

  @override
  String get dataEmpty => 'Data is empty';

  @override
  String get saveSuccess => 'Save successful';

  @override
  String get saveFail => 'Save failed';

  @override
  String get confirmRemoveRef => 'Remove reference';

  @override
  String get confirmRemoveRefMessage =>
      'Remove this reference? The entity data will remain until all references are removed.';

  @override
  String get noZombiesInLane => 'No zombies in this lane';

  @override
  String get code => 'Code';

  @override
  String get name => 'Name';

  @override
  String get description => 'Description';

  @override
  String get levelNumber => 'Level number';

  @override
  String get startingSun => 'Starting sun';

  @override
  String get stageModule => 'Stage module';

  @override
  String get musicType => 'Music type';

  @override
  String get loot => 'Loot';

  @override
  String get victoryModule => 'Victory module';

  @override
  String get basicInfoSection => 'Basic info';

  @override
  String get sceneSettingsSection => 'Scene settings';

  @override
  String get restrictionsSection => 'Restrictions';

  @override
  String get victoryModuleWarning =>
      'Using non-default victory modules may cause level crashes due to module conflicts. Use with caution.';

  @override
  String get hintTextDisplay => 'Text display (Description)';

  @override
  String get beatTheLevelDialogIntro =>
      'Display hint text in a pop-up at the beginning of the level.';

  @override
  String get beatTheLevelDialogHint =>
      'Supports Chinese; for multi-line text enter newlines directly, no need for \\n. Note: hints cannot be viewed in iOS courtyard.';

  @override
  String get levelHintText => 'Level hint text';

  @override
  String get missingModules => 'Missing modules';

  @override
  String get moduleConflict => 'Module conflict';

  @override
  String get editableModules => 'Editable modules';

  @override
  String get parameterModules => 'Parameter modules';

  @override
  String get addNewModule => 'Add new module';

  @override
  String get selectStage => 'Select stage';

  @override
  String get searchStage => 'Search stage name or alias';

  @override
  String get noStageFound => 'No stage found';

  @override
  String get stageTypeAll => 'All';

  @override
  String get stageTypeMain => 'Main';

  @override
  String get stageTypeExtra => 'Extra';

  @override
  String get stageTypeSeasons => 'Seasons';

  @override
  String get stageTypeSpecial => 'Special';

  @override
  String get search => 'Search';

  @override
  String get disablePeavine => 'Disable peavine';

  @override
  String get disableArtifact => 'Disable artifact';

  @override
  String get selectPlant => 'Select plant';

  @override
  String get searchPlant => 'Search plant';

  @override
  String get noPlantFound => 'No plant found';

  @override
  String noResultsFor(Object query) {
    return 'No results for \"$query\"';
  }

  @override
  String get noModulesInCategory => 'No modules in this category';

  @override
  String addEventForWave(int wave) {
    return 'Add event for wave $wave';
  }

  @override
  String get waveLabel => 'Wave';

  @override
  String get pointsLabel => 'Points';

  @override
  String get noDynamicZombies => 'No dynamic zombies';

  @override
  String get moduleTitle_WaveManagerModuleProperties => 'Wave Manager';

  @override
  String get moduleDesc_WaveManagerModuleProperties =>
      'Manage level wave events';

  @override
  String get moduleTitle_CustomLevelModuleProperties => 'Lawn Module';

  @override
  String get moduleDesc_CustomLevelModuleProperties =>
      'Enable custom lawn framework';

  @override
  String get moduleTitle_StandardLevelIntroProperties => 'Intro Animation';

  @override
  String get moduleDesc_StandardLevelIntroProperties =>
      'Camera pan at level start';

  @override
  String get moduleTitle_ZombiesAteYourBrainsProperties => 'Failure Condition';

  @override
  String get moduleDesc_ZombiesAteYourBrainsProperties =>
      'Zombie enters house condition';

  @override
  String get moduleTitle_ZombiesDeadWinConProperties => 'Death Drop';

  @override
  String get moduleDesc_ZombiesDeadWinConProperties =>
      'Required for level stability';

  @override
  String get moduleTitle_PennyClassroomModuleProperties => 'Plant Tier';

  @override
  String get moduleDesc_PennyClassroomModuleProperties =>
      'Global plant tier definition';

  @override
  String get moduleTitle_SeedBankProperties => 'Seed Bank';

  @override
  String get moduleDesc_SeedBankProperties =>
      'Preset plants and selection method';

  @override
  String get moduleTitle_ConveyorSeedBankProperties => 'Conveyor Belt';

  @override
  String get moduleDesc_ConveyorSeedBankProperties =>
      'Preset conveyor plants and weights';

  @override
  String get moduleTitle_SunDropperProperties => 'Sun Dropper';

  @override
  String get moduleDesc_SunDropperProperties => 'Control falling sun frequency';

  @override
  String get moduleTitle_LevelMutatorMaxSunProps => 'Max Sun';

  @override
  String get moduleDesc_LevelMutatorMaxSunProps => 'Override maximum sun limit';

  @override
  String get moduleTitle_LevelMutatorStartingPlantfoodProps =>
      'Starting Plant Food';

  @override
  String get moduleDesc_LevelMutatorStartingPlantfoodProps =>
      'Override initial plant food';

  @override
  String get moduleTitle_StarChallengeModuleProperties => 'Challenges';

  @override
  String get moduleDesc_StarChallengeModuleProperties =>
      'Level restrictions and goals';

  @override
  String get starChallengeNoConfigTitle => 'Challenge';

  @override
  String get starChallengeNoConfigMessage =>
      'This challenge has no configurable parameters.';

  @override
  String get starChallengeSaveMowersTitle => 'Don\'t lose mowers';

  @override
  String get starChallengeSaveMowersNoConfigMessage =>
      'This challenge has no configurable parameters.\n\nAll lawn mowers must remain intact at level end. Note: Yard module has no mowers by default.';

  @override
  String get starChallengePlantFoodNonuseTitle => 'Don\'t use plant food';

  @override
  String get starChallengePlantFoodNonuseNoConfigMessage =>
      'This challenge has no configurable parameters.\n\nPlant food use is prohibited.';

  @override
  String get moduleTitle_LevelScoringModuleProperties => 'Scoring';

  @override
  String get moduleDesc_LevelScoringModuleProperties =>
      'Enable score points for kills';

  @override
  String get moduleTitle_BowlingMinigameProperties => 'Bowling Bulb';

  @override
  String get moduleDesc_BowlingMinigameProperties =>
      'Set line and disable shovel';

  @override
  String get moduleTitle_NewBowlingMinigameProperties => 'Wall-nut Bowling';

  @override
  String get moduleDesc_NewBowlingMinigameProperties => 'Bowling line setup';

  @override
  String get moduleTitle_VaseBreakerPresetProperties => 'Vase Layout';

  @override
  String get moduleDesc_VaseBreakerPresetProperties =>
      'Configure vase contents';

  @override
  String get moduleTitle_VaseBreakerArcadeModuleProperties =>
      'Vase Breaker Mode';

  @override
  String get moduleDesc_VaseBreakerArcadeModuleProperties =>
      'Enable vase breaker UI';

  @override
  String get moduleTitle_VaseBreakerFlowModuleProperties => 'Vase Animation';

  @override
  String get moduleDesc_VaseBreakerFlowModuleProperties =>
      'Control vase drop animation';

  @override
  String get moduleTitle_EvilDaveProperties => 'I, Zombie';

  @override
  String get moduleDesc_EvilDaveProperties => 'Enable I, Zombie mode';

  @override
  String get moduleTitle_ZombossBattleModuleProperties => 'Zomboss Battle';

  @override
  String get moduleDesc_ZombossBattleModuleProperties =>
      'Boss battle parameters';

  @override
  String get moduleTitle_ZombossBattleIntroProperties => 'Zomboss Intro';

  @override
  String get moduleDesc_ZombossBattleIntroProperties =>
      'Boss intro and health bar';

  @override
  String get moduleTitle_SeedRainProperties => 'Seed Rain';

  @override
  String get moduleDesc_SeedRainProperties => 'Falling plants/zombies/items';

  @override
  String get moduleTitle_LastStandMinigameProperties => 'Last Stand';

  @override
  String get moduleDesc_LastStandMinigameProperties =>
      'Initial resources and setup phase';

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
  String get moduleDesc_IncreasedCostModuleProperties =>
      'Sun cost increases with planting';

  @override
  String get moduleTitle_DeathHoleModuleProperties => 'Death Holes';

  @override
  String get moduleDesc_DeathHoleModuleProperties =>
      'Plants leave unplantable holes';

  @override
  String get moduleTitle_ZombieMoveFastModuleProperties => 'Fast Entry';

  @override
  String get moduleDesc_ZombieMoveFastModuleProperties =>
      'Zombies move fast on entry';

  @override
  String get moduleTitle_InitialPlantProperties => 'Legacy Preset Plants';

  @override
  String get moduleDesc_InitialPlantProperties =>
      'Legacy preset plants with frozen plant support';

  @override
  String get moduleTitle_InitialPlantEntryProperties => 'Initial Plants';

  @override
  String get moduleDesc_InitialPlantEntryProperties =>
      'Plants present at start';

  @override
  String get frozenPlantPlacementTitle => 'Legacy Preset Plants';

  @override
  String get frozenPlantPlacementLastStand => 'Last Stand mode';

  @override
  String get frozenPlantPlacementSelectedPosition => 'Selected position';

  @override
  String get frozenPlantPlacementPlaceHere => 'Add plant';

  @override
  String get frozenPlantPlacementPlantList => 'Plant list (row-first)';

  @override
  String frozenPlantPlacementEditPlant(Object name) {
    return 'Edit $name';
  }

  @override
  String get frozenPlantPlacementLevel => 'Level';

  @override
  String get frozenPlantPlacementCondition => 'Condition';

  @override
  String get frozenPlantPlacementConditionNull => 'None (null)';

  @override
  String get noConditions => 'No conditions';

  @override
  String get frozenPlantPlacementHelpTitle => 'Legacy Preset Plants - Help';

  @override
  String get frozenPlantPlacementHelpOverviewTitle => 'Overview';

  @override
  String get frozenPlantPlacementHelpOverviewBody =>
      'This module configures plant layout before the level starts. Similar to preset plant layout but with a different structure and special state support.';

  @override
  String get frozenPlantPlacementHelpConditionTitle => 'Special State';

  @override
  String get frozenPlantPlacementHelpConditionBody =>
      'Plants can be set to frozen state, commonly used in Ice Age levels.';

  @override
  String get frozenPlantPlacementHelpLastStandTitle => 'Last Stand Mode';

  @override
  String get frozenPlantPlacementHelpLastStandBody =>
      'When Last Stand mode is enabled, initial plants will be destroyed after the game starts. Note: Chinese version does not show the plant destruction fire effect.';

  @override
  String get save => 'Save';

  @override
  String get moduleTitle_InitialZombieProperties => 'Initial Zombies';

  @override
  String get moduleDesc_InitialZombieProperties => 'Zombies present at start';

  @override
  String get moduleTitle_InitialGridItemProperties => 'Initial Grid Items';

  @override
  String get moduleDesc_InitialGridItemProperties =>
      'Grid items present at start';

  @override
  String get moduleTitle_ProtectThePlantChallengeProperties => 'Protect Plants';

  @override
  String get moduleDesc_ProtectThePlantChallengeProperties =>
      'Plants that must be protected';

  @override
  String get moduleTitle_ProtectTheGridItemChallengeProperties =>
      'Protect Items';

  @override
  String get moduleDesc_ProtectTheGridItemChallengeProperties =>
      'Items that must be protected';

  @override
  String get moduleTitle_ZombiePotionModuleProperties => 'Zombie Potions';

  @override
  String get moduleDesc_ZombiePotionModuleProperties =>
      'Dark Ages potion generation';

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
  String get moduleDesc_ManholePipelineModuleProperties =>
      'Steam Age pipelines';

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
  String get eventDesc_SpawnZombiesFromGroundSpawnerProps =>
      'Zombies spawn from ground';

  @override
  String get eventTitle_SpawnZombiesJitteredWaveActionProps => 'Standard Spawn';

  @override
  String get eventDesc_SpawnZombiesJitteredWaveActionProps =>
      'Basic natural spawn';

  @override
  String get eventTitle_FrostWindWaveActionProps => 'Frost Wind';

  @override
  String get eventDesc_FrostWindWaveActionProps => 'Freezing wind on rows';

  @override
  String get eventTitle_BeachStageEventZombieSpawnerProps => 'Low Tide';

  @override
  String get eventDesc_BeachStageEventZombieSpawnerProps =>
      'Zombies spawn at low tide';

  @override
  String get eventTitle_TidalChangeWaveActionProps => 'Tide Change';

  @override
  String get eventDesc_TidalChangeWaveActionProps => 'Change tide position';

  @override
  String get eventTitle_ModifyConveyorWaveActionProps => 'Conveyor Modify';

  @override
  String get eventDesc_ModifyConveyorWaveActionProps =>
      'Add/remove cards dynamically';

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
  String get eventDesc_RaidingPartyZombieSpawnerProps =>
      'Swashbuckler invasion';

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
  String get eventDesc_SpawnZombiesFromGridItemSpawnerProps =>
      'Spawn zombies from graves';

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
  String get eventDesc_ParachuteRainZombieSpawnerProps =>
      'Zombies drop with parachutes';

  @override
  String get eventTitle_BassRainZombieSpawnerProps => 'Bass/Jetpack Rain';

  @override
  String get eventDesc_BassRainZombieSpawnerProps =>
      'Bass/Jetpack zombies drop';

  @override
  String get eventTitle_BlackHoleWaveActionProps => 'Black Hole';

  @override
  String get eventDesc_BlackHoleWaveActionProps => 'Black hole attracts plants';

  @override
  String get eventTitle_MagicMirrorWaveActionProps => 'Magic Mirror';

  @override
  String get eventDesc_MagicMirrorWaveActionProps => 'Mirror portals';

  @override
  String get eventTitle_WaveActionMagicMirrorTeleportationArrayProps2 =>
      'Magic Mirror';

  @override
  String get eventDesc_WaveActionMagicMirrorTeleportationArrayProps2 =>
      'Mirror portals';

  @override
  String get weatherOption_DefaultSnow_label => 'Frostbite Caves (DefaultSnow)';

  @override
  String get weatherOption_DefaultSnow_desc =>
      'Snowing effect from Frostbite Caves';

  @override
  String get weatherOption_LightningRain_label =>
      'Thunderstorm (LightningRain)';

  @override
  String get weatherOption_LightningRain_desc =>
      'Rain and lightning from Dark Ages Day 8';

  @override
  String get weatherOption_DefaultRainDark_label =>
      'Dark Ages (DefaultRainDark)';

  @override
  String get weatherOption_DefaultRainDark_desc => 'Rain effect from Dark Ages';

  @override
  String get iZombiePlantReserveLabel => 'Plant Reserve Column (PlantDistance)';

  @override
  String get column => 'Column';

  @override
  String get iZombieInfoText =>
      'In I, Zombie mode, preset plants and zombies must be configured in the Level Module (Preset Plants) and Seed Bank respectively.';

  @override
  String get vaseRangeTitle => 'Vase Generation Range & Blacklist';

  @override
  String get startColumnLabel => 'Start Col (Min)';

  @override
  String get endColumnLabel => 'End Col (Max)';

  @override
  String get toggleBlacklistHint => 'Click to toggle blacklist';

  @override
  String get vaseCapacityTitle => 'Vase Capacity';

  @override
  String vaseCapacitySummary(Object current, Object total) {
    return 'Assigned: $current / Total Slots: $total';
  }

  @override
  String get vaseListTitle => 'Vase List';

  @override
  String get addVaseTitle => 'Add Vase';

  @override
  String get plantVaseOption => 'Plant Vase';

  @override
  String get zombieVaseOption => 'Zombie Vase';

  @override
  String get selectZombie => 'Select zombie';

  @override
  String get searchZombie => 'Search zombie';

  @override
  String get noZombieFound => 'No zombie found';

  @override
  String get unknownVaseLabel => 'Unknown Vase';

  @override
  String get plantLabel => 'Plant';

  @override
  String get zombieLabel => 'Zombie';

  @override
  String get itemLabel => 'Item';

  @override
  String get railcartSettings => 'Railcart settings';

  @override
  String get railcartType => 'Railcart type';

  @override
  String get layRails => 'Lay rails';

  @override
  String get placeCarts => 'Place carts';

  @override
  String get railSegments => 'Rail segments';

  @override
  String get railcartCount => 'Railcart count';

  @override
  String get clearAll => 'Clear all';

  @override
  String get moduleCategoryBase => 'Base';

  @override
  String get moduleCategoryMode => 'Game Modes';

  @override
  String get moduleCategoryScene => 'Scene';

  @override
  String get customZombie => 'Custom zombie';

  @override
  String get customZombieProperties => 'Custom zombie properties';

  @override
  String get zombieTypeNotFound => 'Zombie type object not found.';

  @override
  String get propertyObjectNotFound => 'Property object not found';

  @override
  String propertyObjectNotFoundHint(Object alias) {
    return 'The custom zombie\'s property object ($alias) was not found in the level. The property definition does not point to level internals, so it cannot be edited here.';
  }

  @override
  String get baseStats => 'Base stats';

  @override
  String get hitpoints => 'Hitpoints';

  @override
  String get speed => 'Speed';

  @override
  String get speedVariance => 'Speed variance';

  @override
  String get eatDPS => 'EatDPS';

  @override
  String get hitPosition => 'Hit / position';

  @override
  String get hitRect => 'HitRect';

  @override
  String get editHitRect => 'Edit HitRect';

  @override
  String get attackRect => 'AttackRect';

  @override
  String get editAttackRect => 'Edit AttackRect';

  @override
  String get artCenter => 'ArtCenter';

  @override
  String get editArtCenter => 'Edit ArtCenter';

  @override
  String get shadowOffset => 'ShadowOffset';

  @override
  String get editShadowOffset => 'Edit ShadowOffset';

  @override
  String get groundTrackName => 'GroundTrackName (行进轨迹)';

  @override
  String get groundTrackNormal => 'Normal ground (ground_swatch)';

  @override
  String get groundTrackNone => 'None (null)';

  @override
  String get appearanceBehavior => 'Appearance & behavior';

  @override
  String get sizeType => 'SizeType';

  @override
  String get selectSize => 'Select size';

  @override
  String get disableDropFractions => 'Disable drop fractions';

  @override
  String get immuneToKnockback => 'Immune to knockback';

  @override
  String get showHealthBarOnDamage => 'Show health bar on damage';

  @override
  String get drawHealthBarTime => 'DrawHealthBarTime';

  @override
  String get enableEliteScale => 'Enable elite scale';

  @override
  String get eliteScale => 'EliteScale';

  @override
  String get enableEliteImmunities => 'Enable elite immunities';

  @override
  String get canSpawnPlantFood => 'Can spawn plant food';

  @override
  String get canSurrender => 'Can surrender';

  @override
  String get canTriggerZombieWin => 'Can trigger zombie win';

  @override
  String get resilience => 'Resilience';

  @override
  String get instantKillResistance => 'Instant kill resistance';

  @override
  String get resiliencePhysics => 'Physics';

  @override
  String get resiliencePoison => 'Poison';

  @override
  String get resilienceElectric => 'Electric';

  @override
  String get resilienceMagic => 'Magic';

  @override
  String get resilienceIce => 'Ice';

  @override
  String get resilienceFire => 'Fire';

  @override
  String get resilienceHint => '0.0 = none, 1.0 = full immunity';

  @override
  String zombieTypeLabel(Object type) {
    return 'Zombie type: $type';
  }

  @override
  String propertyAliasLabel(Object alias) {
    return 'Property alias: $alias';
  }

  @override
  String get ok => 'OK';

  @override
  String get width => 'Width';

  @override
  String get height => 'Height';

  @override
  String get customZombieHelpIntro => 'Brief introduction';

  @override
  String get customZombieHelpIntroBody =>
      'This screen edits custom zombie parameters injected into the level. Only common properties are supported; many special attributes require manual JSON editing.';

  @override
  String get customZombieHelpBase => 'Base properties';

  @override
  String get customZombieHelpBaseBody =>
      'Custom zombies can modify base stats (HP, speed, eat damage). Custom zombies do not appear in the level preview pool.';

  @override
  String get customZombieHelpHit => 'Hit/position';

  @override
  String get customZombieHelpHitBody =>
      'X and Y are offsets; W and H are width and height. Offsetting ArtCenter can hide the zombie sprite. Leaving ground track empty lets the zombie walk in place.';

  @override
  String get customZombieHelpManual => 'Manual editing';

  @override
  String get customZombieHelpManualBody =>
      'Custom injection auto-fills all properties from game files. You can further edit the JSON file manually if needed.';

  @override
  String editAlias(Object alias) {
    return 'Edit $alias';
  }

  @override
  String get add => 'Add';

  @override
  String get overview => 'Overview';

  @override
  String get left => 'Left';

  @override
  String get right => 'Right';

  @override
  String get weight => 'Weight';

  @override
  String get maxCount => 'Max count';

  @override
  String get startColumn => 'Start column';

  @override
  String get endColumn => 'End column';

  @override
  String get removeItem => 'Remove item';

  @override
  String removeItemConfirm(Object name) {
    return 'Remove $name?';
  }

  @override
  String groupN(int n) {
    return 'Group $n';
  }

  @override
  String rowN(int n) {
    return 'Row $n';
  }

  @override
  String get addItem => 'Add item';

  @override
  String get addWind => 'Add wind';

  @override
  String get addDropItem => 'Add drop item';

  @override
  String get addMirrorGroup => 'Add a mirror group above';

  @override
  String pipeN(int n) {
    return 'Pipe $n';
  }

  @override
  String get setStart => 'Set start';

  @override
  String get setEnd => 'Set end';

  @override
  String get collectable => 'Collectable (Plant Food)';

  @override
  String get selectGridItem => 'Select grid item';

  @override
  String get addItemTitle => 'Add item';

  @override
  String get initialPlantLayout => 'Initial plant layout';

  @override
  String get gridItemLayout => 'Grid item layout';

  @override
  String get zombieCount => 'Zombie count';

  @override
  String get groupSize => 'Group size';

  @override
  String get timeBetweenGroups => 'Time between groups';

  @override
  String get timeBeforeSpawn => 'Time before spawn (s)';

  @override
  String get waterBoundaryColumn => 'Water boundary column';

  @override
  String get columnsDragged => 'Columns dragged (ColNumPlantIsDragged)';

  @override
  String get typeIndex => 'Type index';

  @override
  String styleN(int n) {
    return 'Style $n';
  }

  @override
  String get existDurationSec => 'Exist duration (sec)';

  @override
  String get mirror1 => 'Mirror 1';

  @override
  String get mirror2 => 'Mirror 2';

  @override
  String get ignoreGravestone => 'Ignore gravestone (IgnoreGraveStone)';

  @override
  String zombiePreview(Object name) {
    return '$name - Zombie preview';
  }

  @override
  String get weatherSettings => 'Weather settings';

  @override
  String get holeLifetimeSeconds => 'Hole lifetime (seconds)';

  @override
  String get startingWaveLocation => 'Starting wave location';

  @override
  String get rainIntervalSeconds => 'Rain interval (seconds)';

  @override
  String get startingPlantFood => 'Starting plant food';

  @override
  String get bowlingFoulLine => 'Bowling foul line (BowlingFoulLine)';

  @override
  String get stopColumn => 'Stop column (StopColumn)';

  @override
  String get speedUp => 'Speed up (SpeedUp)';

  @override
  String get baseCostIncreased => 'Base cost increase (BaseCostIncreased)';

  @override
  String get maxIncreasedCount => 'Max increase count (MaxIncreasedCount)';

  @override
  String get initialMistPositionX => 'Initial mist position X';

  @override
  String get normalValueX => 'Normal value X';

  @override
  String get bloverEffectInterval => 'Blover effect interval (seconds)';

  @override
  String get dinoType => 'Dino type';

  @override
  String dinoRow(int n) {
    return 'Row (DinoRow): $n';
  }

  @override
  String get dinoWaveDuration => 'Duration (DinoWaveDuration)';

  @override
  String get unknownModuleTitle => 'Module editor in development';

  @override
  String get unknownModuleHelpTitle => 'Unknown module';

  @override
  String get unknownModuleHelpBody =>
      'This module is not registered in the level interpreter. It may be manually modified objclass.';

  @override
  String get noEditorForModule => 'No editor available for this module';

  @override
  String get noEditorForModuleBody =>
      'This module is not registered in the level parser. It may have been added manually or the objclass was changed.';

  @override
  String get invalidEventTitle => 'Invalid event';

  @override
  String get invalidEventBody => 'This event object could not be parsed.';

  @override
  String get invalidReference => 'Invalid reference';

  @override
  String aliasNotFound(Object alias) {
    return 'Alias \"$alias\" not found';
  }

  @override
  String invalidRefBody(int wave) {
    return 'Wave $wave references this event, but no matching entity exists. Keeping it will cause a crash.';
  }

  @override
  String get removeInvalidRef => 'Remove this invalid reference from wave';

  @override
  String get spawnCount => 'Spawn count';

  @override
  String get columnRangeTiming => 'Column range & timing';

  @override
  String get waveStartMessage => 'Wave start message';

  @override
  String get zombieTypeZombieName => 'Zombie type (ZombieName)';

  @override
  String get optional => 'Optional';

  @override
  String get eventHelpBeachStageBody =>
      'Zombies spawn at low tide. Used for Pirate Seas.';

  @override
  String get eventHelpTidalChangeBody =>
      'This event changes the tide position during a wave.';

  @override
  String get eventHelpTidalChangePosition =>
      'Column 0 is rightmost, 9 is leftmost. ChangeAmount sets the water boundary.';

  @override
  String get eventHelpBlackHoleBody =>
      'Kongfu world event. Black hole attracts plants to the right.';

  @override
  String get eventHelpBlackHoleColumns =>
      'Number of columns plants are dragged by the black hole.';

  @override
  String get eventHelpMagicMirrorBody =>
      'Magic mirrors create paired portals on the field.';

  @override
  String get eventHelpMagicMirrorType =>
      'Type index changes mirror appearance. Three styles available.';

  @override
  String get eventHelpParachuteRainBody =>
      'Zombies drop from the sky during a wave.';

  @override
  String get eventHelpParachuteRainLogic =>
      'Zombies spawn in batches. Control total count, batch size, column range, and timing.';

  @override
  String get eventHelpModernPortalsBody =>
      'Spawns time rift portals on the field, common in Modern world.';

  @override
  String get eventHelpModernPortalsType =>
      'Many portal types exist; choose the specific type.';

  @override
  String get eventHelpModernPortalsIgnore =>
      'When enabled, portals spawn even if blocked by gravestones.';

  @override
  String get eventHelpFrostWindBody =>
      'Ice Age event. Freezing wind freezes plants on specified rows.';

  @override
  String get eventHelpFrostWindDirection =>
      'Set wind direction: left or right.';

  @override
  String get eventHelpModifyConveyorBody =>
      'Change conveyor belt configuration during a wave. Add or remove plants.';

  @override
  String get eventHelpModifyConveyorAdd => 'Add plants to the conveyor belt.';

  @override
  String get eventHelpModifyConveyorRemove =>
      'Remove plants from the conveyor belt.';

  @override
  String get eventHelpDinoBody =>
      'Dino Crisis event. Summon a dinosaur on the specified row to assist zombies.';

  @override
  String get eventHelpDinoDuration => 'How long the dinosaur stays, in waves.';

  @override
  String get eventHelpZombiePotionBody =>
      'Spawns potions on the grid, can overlap plants.';

  @override
  String get eventHelpZombiePotionUsage =>
      'Select grid position, tap add item, choose potion type.';

  @override
  String get eventHelpFairyFogBody =>
      'Spawns fog that gives zombies shields. Only fairy wind can clear it.';

  @override
  String get eventHelpFairyFogRange =>
      'mX, mY are center; mWidth, mHeight extend right and down.';

  @override
  String get eventHelpFairyWindBody => 'Creates wind to blow away fairy fog.';

  @override
  String get eventHelpFairyWindVelocity =>
      'Changes projectile speed. 1.0 = original, higher = faster.';

  @override
  String get eventHelpRaidingPartyBody =>
      'Pirate event. Swashbuckler zombies spawn in batches.';

  @override
  String get eventHelpRaidingPartyGroup => 'Zombies per group.';

  @override
  String get eventHelpRaidingPartyCount => 'Total swashbuckler count.';

  @override
  String get eventHelpGravestoneBody =>
      'Randomly spawns obstacles during a wave (e.g. gravestones).';

  @override
  String get eventHelpGravestoneLogic =>
      'Picks random cells from position pool. Total items must not exceed positions.';

  @override
  String get eventHelpGravestoneMissingAssets =>
      'Some maps without gravestone spawn effects may show sun textures instead.';

  @override
  String get eventHelpGraveSpawnBody =>
      'This event spawns zombies from specific grid item types, commonly used in Dark Ages levels.';

  @override
  String get eventHelpGraveSpawnWait =>
      'Delay from wave start to zombie spawn.';

  @override
  String get eventHelpStormBody =>
      'Sandstorm or blizzard teleports zombies to the front.';

  @override
  String get eventHelpStormColumns =>
      'Column 0 = left, 9 = right. Start < end.';

  @override
  String get eventHelpStormLevels => 'Storm zombies support level 1-10.';

  @override
  String get eventHelpGroundSpawnBody =>
      'Configure zombies that spawn in this wave.';

  @override
  String get moduleHelpTideBody =>
      'Enables tide system and sets initial tide position.';

  @override
  String get moduleHelpTidePosition =>
      'Right edge is 0, left edge is 9. Negative values allowed.';

  @override
  String get initialTidePosition => 'Initial tide position';

  @override
  String get moduleHelpManholeBody =>
      'Defines underground pipeline links used in Steam Age.';

  @override
  String get moduleHelpManholeEdit =>
      'Toggle start/end mode, then tap grid to place.';

  @override
  String get moduleHelpWeatherBody =>
      'Controls global weather effects (rain, snow, darkness).';

  @override
  String get moduleHelpWeatherRef => 'These options reference LevelModules.';

  @override
  String get moduleHelpZombiePotionBody =>
      'Potions spawn over time until reaching max count.';

  @override
  String get moduleHelpZombiePotionTypes =>
      'Potions are chosen randomly from the list.';

  @override
  String get moduleHelpUnknownBody =>
      'Level files consist of root nodes and modules. Each object has aliases, objclass, objdata.';

  @override
  String get moduleHelpUnknownEvents =>
      'The app parses modules by objclass. This module is not registered.';

  @override
  String get eventHelpInvalidBody =>
      'This event is referenced but the parser cannot find its entity. RTID points to nothing.';

  @override
  String get eventHelpInvalidImpact =>
      'Keeping this reference will cause the game to crash. Remove it manually.';

  @override
  String get position => 'Position';

  @override
  String get editing => 'Editing';

  @override
  String get logic => 'Logic';

  @override
  String get impact => 'Impact';

  @override
  String get events => 'Events';

  @override
  String get referenceModules => 'Reference modules';

  @override
  String get portalType => 'Portal type';

  @override
  String get direction => 'Direction';

  @override
  String get velocityScale => 'Velocity scale';

  @override
  String get range => 'Range';

  @override
  String get columnRange => 'Column range';

  @override
  String get zombieLevels => 'Zombie levels';

  @override
  String get missingAssets => 'Missing assets';

  @override
  String get usage => 'Usage';

  @override
  String get types => 'Types';

  @override
  String get eventBlackHole => 'Black hole event';

  @override
  String get attractionConfig => 'Attraction config';

  @override
  String get selectedPosition => 'Selected position';

  @override
  String get placePlant => 'Place plant';

  @override
  String get plantList => 'Plant list (row-first)';

  @override
  String get firstCostume => 'First costume (Avatar)';

  @override
  String get eventMagicMirror => 'Magic mirror event';

  @override
  String get eventParachuteRain => 'Parachute/Bass/Spider rain event';

  @override
  String get manholePipeline => 'Manhole pipeline';

  @override
  String get manholePipelines => 'Manhole pipelines';

  @override
  String get manholePipelineHelpOverview =>
      'Defines underground pipeline links used in Steam Age.';

  @override
  String get manholePipelineHelpEditing =>
      'Toggle start/end mode, then tap grid to place.';

  @override
  String manholePipelineStartEndFormat(int sx, int sy, int ex, int ey) {
    return 'Start: ($sx, $sy)  End: ($ex, $ey)';
  }

  @override
  String get piratePlank => 'Pirate plank';

  @override
  String get weatherModule => 'Weather module';

  @override
  String get zombiePotion => 'Zombie potion';

  @override
  String get eventTimeRift => 'Time rift event';

  @override
  String get deathHole => 'Death Hole';

  @override
  String get seedRain => 'Seed rain';

  @override
  String get eventFrostWind => 'Frost wind event';

  @override
  String get lastStandSettings => 'Last stand settings';

  @override
  String get roofFlowerPot => 'Roof flower pot';

  @override
  String get eventConveyorModify => 'Conveyor modify event';

  @override
  String get bowlingMinigame => 'Bowling Minigame';

  @override
  String get zombieMoveFast => 'Zombie Move Fast';

  @override
  String get eventPotionDrop => 'Potion drop event';

  @override
  String get warMist => 'War mist';

  @override
  String get eventDino => 'Dino event';

  @override
  String get duration => 'Duration';

  @override
  String get sunDropper => 'Sun dropper';

  @override
  String get eventFairyWind => 'Fairy wind event';

  @override
  String get eventFairyFog => 'Fairy fog event';

  @override
  String get eventRaidingParty => 'Raiding party event';

  @override
  String get swashbucklerCount => 'Swashbuckler count';

  @override
  String get sunBomb => 'Sun bomb';

  @override
  String get eventSpawnGravestones => 'Spawn gravestones event';

  @override
  String get eventGraveSpawn => 'Grave spawn event';

  @override
  String get zombieSpawnWait => 'Zombie spawn wait';

  @override
  String get selectCustomZombie => 'Select custom zombie';

  @override
  String get change => 'Change';

  @override
  String get autoLevel => 'Auto level';

  @override
  String get apply => 'Apply';

  @override
  String get applyBatchLevel => 'Apply batch level?';

  @override
  String get conveyorBelt => 'Conveyor belt';

  @override
  String get starChallenges => 'Star Challenges';

  @override
  String get addChallenge => 'Add Challenge';

  @override
  String get unknownChallengeType => 'Unknown challenge type';

  @override
  String get protectedPlants => 'Protected Plants';

  @override
  String get addPlant => 'Add Plant';

  @override
  String get protectedGridItems => 'Protected Grid Items';

  @override
  String get addGridItem => 'Add Grid Item';

  @override
  String get spawnTimer => 'Spawn timer';

  @override
  String get plantLevels => 'Plant levels';

  @override
  String get globalPlantLevels => 'Global plant levels';

  @override
  String get scope => 'Scope';

  @override
  String get applyBatch => 'Apply batch';

  @override
  String get addPlants => 'Add plants';

  @override
  String get noPlantsConfigured => 'No plants configured';

  @override
  String batchLevelFormat(int level) {
    return 'Batch level: $level';
  }

  @override
  String get protectPlants => 'Protect plants';

  @override
  String get protectItems => 'Protect items';

  @override
  String get autoCount => 'Auto count';

  @override
  String get overrideStartingPlantfood => 'Override Starting Plantfood';

  @override
  String get startingPlantfoodOverride => 'Starting Plantfood Override';

  @override
  String get iconText => 'Icon Text';

  @override
  String get iconImage => 'Icon Image';

  @override
  String get overrideMaxSun => 'Override Max Sun';

  @override
  String get maxSunOverride => 'Max Sun Override';

  @override
  String get maxSunHelpTitle => 'Max Sun Module';

  @override
  String get maxSunHelpOverview =>
      'This module was originally used to control different difficulty levels in Panchase. Use it to override the maximum sun that can be stored in the level.';

  @override
  String get startingPlantfoodHelpTitle => 'Starting Plantfood Module';

  @override
  String get startingPlantfoodHelpOverview =>
      'This module was originally used to control different difficulty levels in Panchase. Use it to override the initial plant food carried at level start.';

  @override
  String get starChallengeHelpTitle => 'Star Challenge Module';

  @override
  String get starChallengeHelpOverview =>
      'Select challenge modules used in the level here. You can set multiple challenge goals and use the same challenge type multiple times.';

  @override
  String get starChallengeHelpSuggestionTitle => 'Optimization suggestion';

  @override
  String get starChallengeHelpSuggestion =>
      'Some challenges have in-game progress stat boxes. When there are too many challenge modules, stat boxes may overlap.';

  @override
  String get remove => 'Remove';

  @override
  String get plant => 'Plant';

  @override
  String get zombie => 'Zombie';

  @override
  String get initialZombieLayout => 'Initial zombie layout';

  @override
  String get placeZombie => 'Place zombie';

  @override
  String get manualInput => 'Manual input';

  @override
  String get waveManagerModule => 'Wave manager module';

  @override
  String get points => 'Points';

  @override
  String get eventStorm => 'Storm event';

  @override
  String get row => 'Row';

  @override
  String get addType => 'Add type';

  @override
  String get plantFunExperimental => 'Plant (Fun/Experimental)';

  @override
  String get availableZombies => 'Available zombies';

  @override
  String get presetPlants => 'Preset plants (PresetPlantList)';

  @override
  String get whiteList => 'White list (WhiteList)';

  @override
  String get blackList => 'Black list (BlackList)';

  @override
  String get chooser => 'Chooser';

  @override
  String get preset => 'Preset';

  @override
  String get seedBankHelp => 'Seed bank help';

  @override
  String get conveyorBeltHelp => 'Conveyor belt help';

  @override
  String get dropDelayConditions => 'Drop delay (DropDelayConditions)';

  @override
  String get unitSeconds => 'Unit: seconds';

  @override
  String get speedConditions => 'Speed (SpeedConditions)';

  @override
  String get speedConditionsSubtitle => 'Standard value 100, higher = faster';

  @override
  String get addPlantConveyor => 'Add plant';

  @override
  String get addTool => 'Add tool';

  @override
  String get increasedCost => 'Increased Cost';

  @override
  String get powerTile => 'Power tile';

  @override
  String get eventStandardSpawn => 'Event: Standard spawn';

  @override
  String get eventGroundSpawn => 'Event: Ground spawn';

  @override
  String get eventEditorInDevelopment => 'Event editor in development';

  @override
  String get level => 'Level';

  @override
  String get missingTideModule => 'Missing tide module';

  @override
  String get levelHasNoTideProperties =>
      'Level has no TideProperties. This event may not work.';

  @override
  String get changePosition => 'Change position';

  @override
  String get changePositionChangeAmount => 'Change position (ChangeAmount)';

  @override
  String get preview => 'Preview';

  @override
  String get water => 'Water';

  @override
  String get land => 'Land';

  @override
  String groupConfigN(int n) {
    return 'Group $n config';
  }

  @override
  String get globalParameters => 'Global parameters';

  @override
  String get timePerGrid => 'Time per grid';

  @override
  String get damagePerSecond => 'Damage per second';

  @override
  String get pipe => 'Pipe';

  @override
  String get stageMismatch => 'Stage mismatch';

  @override
  String get currentStageNotPirate =>
      'Current stage is not Pirate. This module may not work correctly.';

  @override
  String get plankRows => 'Plank rows (0–4)';

  @override
  String get selectedRows => 'Selected rows';

  @override
  String get selectedRowsLabel => 'Selected rows:';

  @override
  String get indexLabel => 'Index';

  @override
  String get selectWeatherType => 'Select weather type';

  @override
  String get counts => 'Counts';

  @override
  String get initial => 'Initial';

  @override
  String get max => 'Max';

  @override
  String get spawnTimerShort => 'Spawn timer';

  @override
  String get minSec => 'Min (sec)';

  @override
  String get maxSec => 'Max (sec)';

  @override
  String get potionTypes => 'Potion types';

  @override
  String get noPotionTypes => 'No potion types';

  @override
  String get ignoreGravestoneSubtitle =>
      'Enable to spawn regardless of obstacles';

  @override
  String get thisPortalSpawns => 'This portal spawns:';

  @override
  String startEndFormat(int sx, int sy, int ex, int ey) {
    return 'Start: ($sx, $sy)  End: ($ex, $ey)';
  }

  @override
  String indexN(int n) {
    return 'Index: $n';
  }

  @override
  String get noItemsAddHint =>
      'No items. Add plants, zombies, or collectables.';

  @override
  String get zombieTypeSpiderZombieName => 'Zombie type (SpiderZombieName)';

  @override
  String get noneSelected => 'None selected';

  @override
  String get totalSpiderCount => 'Total (SpiderCount)';

  @override
  String get perBatchGroupSize => 'Per batch (GroupSize)';

  @override
  String get fallTime => 'Fall time (s)';

  @override
  String get waveStartMessageLabel => 'Red subtitle (WaveStartMessage)';

  @override
  String get optionalWarningText => 'Optional warning text before spawn';

  @override
  String rowNShort(int n) {
    return 'Row $n';
  }

  @override
  String weightMaxFormat(int weight, int max) {
    return 'Weight: $weight, Max: $max';
  }

  @override
  String get random => 'Random';

  @override
  String get noChallengesConfigured => 'No challenges configured';

  @override
  String get whiteListBlackListHint =>
      'White list: empty = no limit. Black list overrides white list.';

  @override
  String get conveyorBeltHelpIntro =>
      'Conveyor mode randomly generates cards by weight. Configure plant pool and refresh delay.';

  @override
  String get conveyorBeltHelpPool =>
      'Plant pool & weight: Probability = weight / total weight. Use thresholds to adjust dynamically.';

  @override
  String get conveyorBeltHelpDropDelay =>
      'Drop delay: Controls card spawn interval. More plants = slower.';

  @override
  String get conveyorBeltHelpSpeed =>
      'Speed: Physical belt speed. Standard = 100.';

  @override
  String get cannotAddEliteZombies => 'Cannot add elite zombies';

  @override
  String get eliteZombiesNotAllowed => 'Elite zombies are not allowed here';

  @override
  String fixToAlias(Object alias) {
    return 'Fix to $alias';
  }

  @override
  String editPresetZombie(Object name) {
    return 'Edit preset zombie: $name';
  }

  @override
  String get missingZombossModule => 'Missing ZombossBattleModuleProperties';

  @override
  String get challengeNoConfig =>
      'This challenge doesn\'t support configuration.';

  @override
  String get maxPotionCount => 'Max Potion Count';

  @override
  String potionTypesConfigured(int count) {
    return 'Potion types: $count configured';
  }

  @override
  String pipelinesCount(int count) {
    return 'Pipelines: $count';
  }

  @override
  String windN(int n) {
    return 'Wind #$n';
  }

  @override
  String get zombieList => 'Zombie list (row-first)';

  @override
  String get positionPoolSpawnPositions => 'Position pool (SpawnPositionsPool)';

  @override
  String get tapCellsSelectDeselect =>
      'Tap cells to select/deselect spawn positions';

  @override
  String get gravestonePool => 'Gravestone pool (GravestonePool)';

  @override
  String get removePlants => 'Remove plants';

  @override
  String get current => 'Current';

  @override
  String get eliteZombiesUseDefaultLevel => 'Elite zombies use default level.';

  @override
  String get basicParameters => 'Basic parameters';

  @override
  String get zombieSpawnWaitSec => 'Zombie spawn wait (sec)';

  @override
  String get gridTypes => 'Grid types';

  @override
  String zombiesCount(int count) {
    return 'Zombies ($count)';
  }

  @override
  String get eventGraveSpawnSubtitle => 'Event: Grave spawn';

  @override
  String get eventStormSpawnSubtitle => 'Event: Storm spawn';

  @override
  String get eventHelpGraveSpawnZombieWait =>
      'Delay from wave start until zombies spawn. Zombies won\'t spawn if the next wave has already begun.';

  @override
  String get eventHelpStormOverview =>
      'Sandstorm or snowstorm quickly delivers zombies to the front. Excold storm can freeze plants.';

  @override
  String get eventHelpStormColumnRange =>
      'Columns 0–9. Left edge is 0, right is 9. Start column must be less than end column.';

  @override
  String get eventHelpStormZombieLevels =>
      'Storm zombies support levels 1–10. Elite zombies use default level.';

  @override
  String get spawnParameters => 'Spawn parameters';

  @override
  String get sandstorm => 'Sandstorm';

  @override
  String get snowstorm => 'Snowstorm';

  @override
  String get excoldStorm => 'Excold storm';

  @override
  String get columnStart => 'Column start';

  @override
  String get columnEnd => 'Column end';

  @override
  String applyBatchLevelContent(int level) {
    return 'Set all zombies in this wave to level $level (elite unchanged).';
  }

  @override
  String get randomRow => 'Random row';

  @override
  String levelFormat(int level) {
    return 'Level: $level';
  }

  @override
  String get levelAccount => 'Level: account';

  @override
  String levelDisplay(Object value) {
    return 'Level: $value';
  }

  @override
  String get eventStandardSpawnTitle => 'Standard spawn event';

  @override
  String get eventGroundSpawnTitle => 'Ground spawn event';

  @override
  String get eventHelpStandardOverview =>
      'Configure zombies that spawn in this wave. Level 0 follows map tier.';

  @override
  String get eventHelpStandardRow => 'Rows 0–4. Leave unset for random row.';

  @override
  String get izombieModeTitle => 'I, Zombie mode';

  @override
  String get izombieModeSubtitle =>
      'Enable to place zombies. Locks selection method.';

  @override
  String get reverseZombieFactionTitle => 'Reverse zombie faction';

  @override
  String get reverseZombieFactionSubtitle =>
      'Enable to make zombies plant faction. For ZvZ.';

  @override
  String get initialWeight => 'Initial weight';

  @override
  String get plantLevelLabel => 'Plant level';

  @override
  String get missingIntroModule => 'Missing Intro Module';

  @override
  String get missingIntroModuleHint =>
      'Level is missing ZombossBattleIntroProperties. Please add it.';

  @override
  String get zombossType => 'Zomboss Type';

  @override
  String get unknownZomboss => 'Unknown Zomboss';

  @override
  String get parameters => 'Parameters';

  @override
  String get reservedColumnCount => 'Reserved Column Count';

  @override
  String get reservedColumnCountHint =>
      'Columns reserved from the right where plants cannot be planted.';

  @override
  String get protectedList => 'Protected list';

  @override
  String get plantLevelsFollowGlobal =>
      'Plant levels follow global level definitions. Seed bank levels are overridden.';

  @override
  String get protectPlantsOverview =>
      'Plants listed here must survive; losing them fails the level.';

  @override
  String get protectPlantsAutoCount =>
      'The required count follows the number of listed plants.';

  @override
  String get protectItemsOverview =>
      'Grid items listed here must survive; losing them fails the level.';

  @override
  String get protectItemsAutoCount =>
      'The required count follows the number of listed items.';

  @override
  String positionsCount(int count) {
    return 'Positions: $count';
  }

  @override
  String totalItemsCount(int count) {
    return 'Total items: $count';
  }

  @override
  String get itemCountExceedsPositionsWarning =>
      'Warning: item count exceeds positions. Some will not spawn.';

  @override
  String get gravestoneBlockedInfo =>
      'Gravestones and similar obstacles blocked by plants cannot spawn. Use other methods to force spawn.';

  @override
  String get enterConditionValue => 'Enter condition value';

  @override
  String get customInputHint => 'Custom input must be accurate';

  @override
  String get presetConditions => 'Preset conditions';

  @override
  String get selectFromPresetHint => 'Select from preset condition list';

  @override
  String get conveyorCardPool => 'Conveyor card pool';

  @override
  String get toolCardsUseFixedLevel => 'Tool cards use fixed level';

  @override
  String get maxLimits => 'Max limits';

  @override
  String get maxCountThreshold => 'Max count threshold';

  @override
  String get weightFactor => 'Weight factor';

  @override
  String get minLimits => 'Min limits';

  @override
  String get minCountThreshold => 'Min count threshold';

  @override
  String get followAccountLevel => '0 = follow account level';

  @override
  String get enablePointSpawning => 'Enable point spawning';

  @override
  String get pointSpawningEnabledDesc =>
      'Enabled (uses extra points for spawning)';

  @override
  String get pointSpawningDisabledDesc => 'Disabled (wave events only)';

  @override
  String get pointSettings => 'Point settings';

  @override
  String get startingWave => 'Starting wave';

  @override
  String get startingPoints => 'Starting points';

  @override
  String get pointIncrement => 'Point increment';

  @override
  String get zombiePool => 'Zombie pool';

  @override
  String plantLevelsCount(int count) {
    return 'Plant levels: $count';
  }

  @override
  String lvN(int n) {
    return 'Lv $n';
  }

  @override
  String get pennyClassroom => 'Penny classroom';

  @override
  String get protectGridItems => 'Protect grid items';

  @override
  String get waveManagerHelpOverview =>
      'Enables wave manager. Without this module, wave editing is disabled.';

  @override
  String get waveManagerHelpPoints =>
      'Point-based spawning uses this pool. Avoid elite and custom zombies.';

  @override
  String get pointsSection => 'Points';

  @override
  String get globalPlantLevelsOverview =>
      'Defines global levels for specified plants.';

  @override
  String get globalPlantLevelsScope =>
      'Applies to protect plants, seed rain, and other modules.';

  @override
  String mustProtectCountFormat(int count) {
    return 'Must protect count: $count';
  }

  @override
  String get noWaveManagerPropsFound =>
      'No WaveManagerProperties object found.';

  @override
  String get itemsSortedByRow => 'Items (sorted by row)';

  @override
  String get eventStormSpawn => 'Event: Storm spawn';

  @override
  String get stormEvent => 'Storm event';

  @override
  String get makeCustom => 'Make custom';

  @override
  String get zombieLevelsBody =>
      'Storm zombies support level 1-10. Elite zombies use default level.';

  @override
  String get batchLevel => 'Batch level';

  @override
  String get start => 'Start';

  @override
  String get end => 'End';

  @override
  String get backgroundMusicLevelJam => 'Background music (LevelJam)';

  @override
  String get onlyAppliesRockEra => 'Only applies to Rock era maps.';

  @override
  String get appliesToAllNonElite =>
      'Applies to all non-elite zombies in this wave.';

  @override
  String get dropConfigPlants => 'Drop config (Plants)';

  @override
  String get dropConfigPlantFood => 'Drop config (Plant Food)';

  @override
  String get zombiesCarryingPlants => 'Zombies carrying plants';

  @override
  String get zombiesCarryingPlantFood => 'Zombies carrying plant food';

  @override
  String get descriptiveName => 'Descriptive Name';

  @override
  String get count => 'Count';

  @override
  String get targetDistance => 'Target Distance';

  @override
  String get targetSun => 'Target Sun';

  @override
  String get maximumSun => 'Maximum Sun';

  @override
  String get holdoutSeconds => 'Holdout Seconds';

  @override
  String get zombiesToKill => 'Zombies To Kill';

  @override
  String get timeSeconds => 'Time (Seconds)';

  @override
  String get speedModifier => 'Speed Modifier';

  @override
  String get sunModifier => 'Sun Modifier';

  @override
  String get maximumPlantsLost => 'Maximum Plants Lost';

  @override
  String get maximumPlants => 'Maximum Plants';

  @override
  String get targetScore => 'Target Score';

  @override
  String get plantBombRadius => 'Plant Bomb Radius';

  @override
  String get plantType => 'Plant Type';

  @override
  String get gridX => 'Grid X';

  @override
  String get gridY => 'Grid Y';

  @override
  String get noCardsYetAddPlants => 'No cards yet. Add plants or tools.';

  @override
  String get mustProtectCountAll => 'Must Protect Count (0 = All)';

  @override
  String get mustProtectCount => 'Must Protect Count';

  @override
  String get gridItemType => 'Grid Item Type';

  @override
  String get zombieBombRadius => 'Zombie Bomb Radius';

  @override
  String get plantDamage => 'Plant Damage';

  @override
  String get zombieDamage => 'Zombie Damage';

  @override
  String get initialPotionCount => 'Initial Potion Count';

  @override
  String get operationTimePerGrid => 'Operation Time Per Grid';

  @override
  String get levelLabel => 'Level: ';

  @override
  String get mistParameters => 'Mist parameters';

  @override
  String get sunDropParameters => 'Sun drop parameters';

  @override
  String get initialDropDelay => 'Initial drop delay';

  @override
  String get baseCountdown => 'Base countdown';

  @override
  String get maxCountdown => 'Max countdown';

  @override
  String get countdownRange => 'Countdown range';

  @override
  String get increasePerSun => 'Increase per sun';

  @override
  String get inflationParams => 'Inflation params';

  @override
  String get baseCostIncreaseLabel => 'Base cost increase (BaseCostIncreased)';

  @override
  String get maxIncreaseCountLabel => 'Max increase count (MaxIncreasedCount)';

  @override
  String get selectGroup => 'Select group';

  @override
  String get gridTapAddRemove =>
      'Grid (tap to add/change, long-press to remove)';

  @override
  String get sunBombHelpOverview => 'Overview';

  @override
  String get sunBombHelpBody =>
      'Turns falling sun into explosive sun bombs. Configure radius and damage.';

  @override
  String get damage => 'Damage';

  @override
  String get explosionRadius => 'Explosion radius';

  @override
  String get plantRadius => 'Plant radius';

  @override
  String get zombieRadius => 'Zombie radius';

  @override
  String get radiusPixelsHint => 'Radius is in pixels. One tile is about 60px.';

  @override
  String get enterMaxSunHint => 'Enter max sun (e.g., 9900)';

  @override
  String get optionalLabelHint => 'Optional label';

  @override
  String get imageResourceIdHint => 'IMAGE_... resource id';

  @override
  String get enterStartingPlantfoodHint => 'Enter starting plantfood (0+)';

  @override
  String get threshold => 'Threshold';

  @override
  String get delay => 'Delay';

  @override
  String get seedBankLetsPlayersChoose =>
      'Seed bank lets players choose plants. In courtyard mode you can set global level and all plants.';

  @override
  String get iZombieModePresetHint =>
      'I, Zombie mode: preset zombies for player. Selection locked to preset.';

  @override
  String get invalidIdsHint =>
      'Invalid IDs leave empty slots. Zombie IDs in plant mode and vice versa. Put zombie slots first.';

  @override
  String get seedBankIZombie => 'Seed bank (I, Zombie)';

  @override
  String get basicRules => 'Basic rules';

  @override
  String get selectionMethod => 'Selection method';

  @override
  String get emptyList => 'Empty list';

  @override
  String get plantsAvailableAtStart => 'Plants available at start';

  @override
  String get whiteListDescription =>
      'Only these plants allowed (empty = no limit)';

  @override
  String get blackListDescription => 'These plants are forbidden';

  @override
  String get availableZombiesDescription =>
      'Zombies available for I, Zombie mode';

  @override
  String get izombieCardSlotsHint =>
      'Only some zombies have IZ card slots. Check Other category in zombie selection.';

  @override
  String get selectToolCard => 'Select tool card';

  @override
  String get searchGridItems => 'Search grid items';

  @override
  String get noItems => 'No items';

  @override
  String get addedToFavorites => 'Added to favorites';

  @override
  String get removedFromFavorites => 'Removed from favorites';

  @override
  String selectedCountTapToSearch(int count) {
    return 'Selected $count, tap to search';
  }

  @override
  String get noFavoritesLongPress => 'No favorites. Long-press to favorite.';

  @override
  String get gridItemCategoryAll => 'All';

  @override
  String get gridItemCategoryScene => 'Scene';

  @override
  String get gridItemCategoryTrap => 'Trap';

  @override
  String get gridItemCategoryPlants => 'Plants';

  @override
  String get sunDropperConfigTitle => 'Sun drop config';

  @override
  String get customLocalParams => 'Custom local params';

  @override
  String get currentModeLocal => 'Current: local (@CurrentLevel)';

  @override
  String get currentModeSystem => 'Current: system default (@LevelModules)';

  @override
  String get paramAdjust => 'Parameter adjust';

  @override
  String get firstDropDelay => 'First drop delay';

  @override
  String get initialDropInterval => 'Initial drop interval';

  @override
  String get maxDropInterval => 'Max drop interval';

  @override
  String get intervalFloatRange => 'Interval float range';

  @override
  String get sunDropperHelpTitle => 'Sun dropper module';

  @override
  String get sunDropperHelpIntro =>
      'This module configures falling sun parameters. Consider not adding it for night levels.';

  @override
  String get sunDropperHelpParams => 'Parameter config';

  @override
  String get sunDropperHelpParamsBody =>
      'By default the module uses game definitions. You can enable custom mode to edit parameters locally.';

  @override
  String get noZombossFound => 'No zomboss found';

  @override
  String get searchChallengeNameOrCode => 'Search challenge name or code';

  @override
  String get deleteChallengeTitle => 'Delete challenge?';

  @override
  String deleteChallengeConfirmLocal(String name) {
    return 'Remove \"$name\"? Local challenge data will be deleted permanently.';
  }

  @override
  String deleteChallengeConfirmRef(String name) {
    return 'Remove \"$name\"? Reference will be removed. Challenge stays in LevelModules.';
  }

  @override
  String get missingModulesRecommended =>
      'The level might not function correctly. Recommended to add:';

  @override
  String get itemListRowFirst => 'Item list (row-first)';

  @override
  String get railcartCowboy => 'Cowboy';

  @override
  String get railcartFuture => 'Future';

  @override
  String get railcartEgypt => 'Egypt';

  @override
  String get railcartPirate => 'Pirate';

  @override
  String get railcartWorldcup => 'World Cup';

  @override
  String get clearUnusedTitle => 'Clear unused objects?';

  @override
  String get clearUnusedMessage =>
      'This will permanently delete all unused objects from the level file, including custom zombies, their properties, and any other unreferenced data. This action cannot be undone. Continue?';

  @override
  String get clearUnusedNone => 'No unused objects found.';

  @override
  String clearUnusedDone(int count) {
    return 'Removed $count unused object(s).';
  }

  @override
  String get lawnMowerTitle => 'Lawn mower style';

  @override
  String get lawnMowerNotes => 'Notes';

  @override
  String get lawnMowerHelpOverview =>
      'Controls lawn mower appearance. Lawn mowers are ineffective in Yard module.';

  @override
  String get lawnMowerHelpNotes =>
      'Lawn mower module typically references LevelModules directly.';

  @override
  String get lawnMowerSelectType => 'Select mower type';

  @override
  String get zombieRushTitle => 'Level timer';

  @override
  String get zombieRushHelpOverview =>
      'Countdown timer for Zombie Rush. Level ends when time runs out.';

  @override
  String get zombieRushHelpNotes => 'Notes';

  @override
  String get zombieRushHelpIncompat =>
      'Timer module is incompatible with Yard mode and may crash. Use Zombie Rush timer instead.';

  @override
  String get zombieRushTimeSettings => 'Time settings';

  @override
  String get levelCountdown => 'Level countdown';

  @override
  String get tunnelDefendTitle => 'Tunnel defend';

  @override
  String get tunnelDefendHelpOverview =>
      'Add mausoleum tunnel paths. Some zombies and plants interact with tunnels.';

  @override
  String get tunnelDefendHelpUsage => 'Usage';

  @override
  String get tunnelDefendHelpUsageBody =>
      'Select a tunnel piece below, then tap the grid to place. Tap the same piece again to remove. Tap a different piece to replace.';

  @override
  String get tunnelDefendSelectComponent => 'Select component';

  @override
  String get tunnelDefendPlacedCount => 'Placed';

  @override
  String get tunnelDefendClearAll => 'Clear all';

  @override
  String get tunnelDefendClearConfirmTitle => 'Clear all tunnel components?';

  @override
  String get tunnelDefendClearConfirmMessage =>
      'Remove all placed tunnel components from the grid. This cannot be undone.';

  @override
  String get tunnelDefendPathOutsideLawn =>
      'Path elements outside of the lawn: ';

  @override
  String get tunnelDefendDeleteOutside => 'Delete path elements outside lawn';

  @override
  String get tunnelDefendDeleteOutsideConfirmTitle =>
      'Delete path elements outside lawn?';

  @override
  String get tunnelDefendDeleteOutsideConfirmMessage =>
      'Remove path elements that are outside the 5×9 lawn grid. This cannot be undone.';

  @override
  String get moduleTitle_LawnMowerProperties => 'Lawn mower';

  @override
  String get moduleDesc_LawnMowerProperties => 'Mower style for the level';

  @override
  String get moduleTitle_TunnelDefendModuleProperties => 'Tunnel defend';

  @override
  String get moduleDesc_TunnelDefendModuleProperties =>
      'Mausoleum tunnel placement';

  @override
  String get moduleTitle_ZombieRushModuleProperties => 'Zombie Rush timer';

  @override
  String get moduleDesc_ZombieRushModuleProperties => 'Level countdown timer';

  @override
  String get jsonViewerModeReading => '(reading mode)';

  @override
  String get jsonViewerModeObjectReading => '(object reading mode)';

  @override
  String get jsonViewerModeEdit => '(edit mode)';

  @override
  String get tooltipAboutModule => 'About this module';

  @override
  String get tooltipAboutEvent => 'About this event';

  @override
  String get tooltipSave => 'Save';

  @override
  String get tooltipEdit => 'Edit';

  @override
  String get tooltipClose => 'Close';

  @override
  String get tooltipToggleObjectView => 'Toggle object/raw view';

  @override
  String get tooltipClearUnused => 'Clear unused objects';

  @override
  String get tooltipJsonViewer => 'View/edit JSON';

  @override
  String get tooltipAdd => 'Add';

  @override
  String get tooltipDecrease => 'Decrease';

  @override
  String get tooltipIncrease => 'Increase';
}
