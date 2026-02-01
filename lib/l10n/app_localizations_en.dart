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
  String get initSetup => 'Initial setup';

  @override
  String get selectFolderPrompt => 'Please select a folder as the level storage directory.';

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
  String get folderDeleteDetail => 'If it is a folder, its contents will also be deleted.';

  @override
  String get levelDeleteDetail => 'This action cannot be undone.';

  @override
  String get confirmDeleteCheckbox => 'I confirm permanent deletion';

  @override
  String get renameSuccess => 'Renamed successfully';

  @override
  String get renameFail => 'Rename failed, file already exists';

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
  String get introText => 'Z-Editor is a visual level editing tool designed for Plants vs. Zombies 2. It aims to simplify editing level JSON files with an intuitive interface.';

  @override
  String get featuresSection => 'Core features';

  @override
  String get feature1 => 'Modular editing: Manage level modules and events.';

  @override
  String get feature2 => 'Multi-mode: I, Zombie, Vase Breaker, Last Stand, Zomboss battle.';

  @override
  String get feature3 => 'Custom zombies: Inject and edit custom zombie properties.';

  @override
  String get feature4 => 'Validation: Detect missing modules and broken references.';

  @override
  String get usageSection => 'Usage';

  @override
  String get usageText => '1. Folder: Tap folder icon to choose level JSON directory.\n2. Open/Create: Tap a level to edit or use + to create from template.\n3. Modules: Add modules in the editor.\n4. Save: Tap save to write back to the JSON file.\nQQ group: 562251204';

  @override
  String get creditsSection => 'Credits';

  @override
  String get authorLabel => 'Author:';

  @override
  String get authorName => '降维打击';

  @override
  String get thanksLabel => 'Thanks:';

  @override
  String get thanksNames => '星寻、metal海枣、超越自我3333、桃酱、凉沈、小小师、顾小言、PhiLia093、咖啡、不留名';

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
  String get saved => 'Saved';

  @override
  String get failedToLoadLevel => 'Failed to load level';

  @override
  String get noLevelDefinition => 'No level definition';

  @override
  String get noLevelDefinitionHint => 'Level definition module (LevelDefinition) was not found. This is the base node of the level file. Try adding it manually.';

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
  String get removeModuleConfirm => 'Remove this module? Local custom modules (@CurrentLevel) and their data will be deleted permanently.';

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
  String get close => 'Close';

  @override
  String get editProperties => 'Edit properties';

  @override
  String get deleteEntity => 'Delete entity';

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
  String get confirmRemoveRefMessage => 'Remove this reference? The entity data will remain until all references are removed.';

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
