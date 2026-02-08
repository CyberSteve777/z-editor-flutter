import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'My Level Library'**
  String get appTitle;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get toggleTheme;

  /// No description provided for @switchFolder.
  ///
  /// In en, this message translates to:
  /// **'Switch folder'**
  String get switchFolder;

  /// No description provided for @clearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get clearCache;

  /// No description provided for @uiSize.
  ///
  /// In en, this message translates to:
  /// **'UI size'**
  String get uiSize;

  /// No description provided for @aboutSoftware.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSoftware;

  /// No description provided for @selectFolder.
  ///
  /// In en, this message translates to:
  /// **'Select folder'**
  String get selectFolder;

  /// No description provided for @initSetup.
  ///
  /// In en, this message translates to:
  /// **'Initial setup'**
  String get initSetup;

  /// No description provided for @selectFolderPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please select a folder as the level storage directory.'**
  String get selectFolderPrompt;

  /// No description provided for @selectFolderButton.
  ///
  /// In en, this message translates to:
  /// **'Select folder'**
  String get selectFolderButton;

  /// No description provided for @emptyFolder.
  ///
  /// In en, this message translates to:
  /// **'Folder is empty'**
  String get emptyFolder;

  /// No description provided for @newFolder.
  ///
  /// In en, this message translates to:
  /// **'New folder'**
  String get newFolder;

  /// No description provided for @newLevel.
  ///
  /// In en, this message translates to:
  /// **'New level'**
  String get newLevel;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @move.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get move;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @newName.
  ///
  /// In en, this message translates to:
  /// **'New name'**
  String get newName;

  /// No description provided for @folderName.
  ///
  /// In en, this message translates to:
  /// **'Folder name'**
  String get folderName;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm delete'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? {detail}'**
  String confirmDeleteMessage(Object detail, Object name);

  /// No description provided for @folderDeleteDetail.
  ///
  /// In en, this message translates to:
  /// **'If it is a folder, its contents will also be deleted.'**
  String get folderDeleteDetail;

  /// No description provided for @levelDeleteDetail.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get levelDeleteDetail;

  /// No description provided for @confirmDeleteCheckbox.
  ///
  /// In en, this message translates to:
  /// **'I confirm permanent deletion'**
  String get confirmDeleteCheckbox;

  /// No description provided for @renameSuccess.
  ///
  /// In en, this message translates to:
  /// **'Renamed successfully'**
  String get renameSuccess;

  /// No description provided for @renameFail.
  ///
  /// In en, this message translates to:
  /// **'Rename failed, file already exists'**
  String get renameFail;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deleted;

  /// No description provided for @copyLevel.
  ///
  /// In en, this message translates to:
  /// **'Copy level'**
  String get copyLevel;

  /// No description provided for @newFileName.
  ///
  /// In en, this message translates to:
  /// **'New file name'**
  String get newFileName;

  /// No description provided for @copySuccess.
  ///
  /// In en, this message translates to:
  /// **'Copy successful'**
  String get copySuccess;

  /// No description provided for @copyFail.
  ///
  /// In en, this message translates to:
  /// **'Copy failed'**
  String get copyFail;

  /// No description provided for @moving.
  ///
  /// In en, this message translates to:
  /// **'Moving: {name}'**
  String moving(Object name);

  /// No description provided for @movePrompt.
  ///
  /// In en, this message translates to:
  /// **'Navigate to target folder, then tap Paste'**
  String get movePrompt;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @folderCreated.
  ///
  /// In en, this message translates to:
  /// **'Folder created'**
  String get folderCreated;

  /// No description provided for @createFail.
  ///
  /// In en, this message translates to:
  /// **'Create failed'**
  String get createFail;

  /// No description provided for @noTemplates.
  ///
  /// In en, this message translates to:
  /// **'No templates found'**
  String get noTemplates;

  /// No description provided for @newLevelTemplate.
  ///
  /// In en, this message translates to:
  /// **'New level - Select template'**
  String get newLevelTemplate;

  /// No description provided for @nameLevel.
  ///
  /// In en, this message translates to:
  /// **'Name level'**
  String get nameLevel;

  /// No description provided for @levelCreated.
  ///
  /// In en, this message translates to:
  /// **'Level created'**
  String get levelCreated;

  /// No description provided for @levelCreateFail.
  ///
  /// In en, this message translates to:
  /// **'Create failed, file already exists'**
  String get levelCreateFail;

  /// No description provided for @adjustUiSize.
  ///
  /// In en, this message translates to:
  /// **'Adjust UI size'**
  String get adjustUiSize;

  /// No description provided for @currentScale.
  ///
  /// In en, this message translates to:
  /// **'Current scale: {percent}%'**
  String currentScale(Object percent);

  /// No description provided for @small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get small;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @cacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cleared {count} cached files'**
  String cacheCleared(Object count);

  /// No description provided for @returnUp.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get returnUp;

  /// No description provided for @jsonFile.
  ///
  /// In en, this message translates to:
  /// **'JSON file'**
  String get jsonFile;

  /// No description provided for @softwareIntro.
  ///
  /// In en, this message translates to:
  /// **'Software intro'**
  String get softwareIntro;

  /// No description provided for @zEditor.
  ///
  /// In en, this message translates to:
  /// **'Z-Editor'**
  String get zEditor;

  /// No description provided for @pvzEditorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'PVZ2 Visual Level Editor'**
  String get pvzEditorSubtitle;

  /// No description provided for @introSection.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get introSection;

  /// No description provided for @introText.
  ///
  /// In en, this message translates to:
  /// **'Z-Editor is a visual level editing tool designed for Plants vs. Zombies 2. It aims to simplify editing level JSON files with an intuitive interface.'**
  String get introText;

  /// No description provided for @featuresSection.
  ///
  /// In en, this message translates to:
  /// **'Core features'**
  String get featuresSection;

  /// No description provided for @feature1.
  ///
  /// In en, this message translates to:
  /// **'Modular editing: Manage level modules and events.'**
  String get feature1;

  /// No description provided for @feature2.
  ///
  /// In en, this message translates to:
  /// **'Multi-mode: I, Zombie, Vase Breaker, Last Stand, Zomboss battle.'**
  String get feature2;

  /// No description provided for @feature3.
  ///
  /// In en, this message translates to:
  /// **'Custom zombies: Inject and edit custom zombie properties.'**
  String get feature3;

  /// No description provided for @feature4.
  ///
  /// In en, this message translates to:
  /// **'Validation: Detect missing modules and broken references.'**
  String get feature4;

  /// No description provided for @usageSection.
  ///
  /// In en, this message translates to:
  /// **'Usage'**
  String get usageSection;

  /// No description provided for @usageText.
  ///
  /// In en, this message translates to:
  /// **'1. Folder: Tap folder icon to choose level JSON directory.\n2. Open/Create: Tap a level to edit or use + to create from template.\n3. Modules: Add modules in the editor.\n4. Save: Tap save to write back to the JSON file.\nQQ group: 562251204'**
  String get usageText;

  /// No description provided for @creditsSection.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get creditsSection;

  /// No description provided for @authorLabel.
  ///
  /// In en, this message translates to:
  /// **'Author:'**
  String get authorLabel;

  /// No description provided for @authorName.
  ///
  /// In en, this message translates to:
  /// **'降维打击'**
  String get authorName;

  /// No description provided for @thanksLabel.
  ///
  /// In en, this message translates to:
  /// **'Thanks:'**
  String get thanksLabel;

  /// No description provided for @thanksNames.
  ///
  /// In en, this message translates to:
  /// **'星寻、metal海枣、超越自我3333、桃酱、凉沈、小小师、顾小言、PhiLia093、咖啡、不留名'**
  String get thanksNames;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Create infinite possibilities'**
  String get tagline;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(Object version);

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Русский'**
  String get languageRussian;

  /// No description provided for @templateBlankLevel.
  ///
  /// In en, this message translates to:
  /// **'Blank level'**
  String get templateBlankLevel;

  /// No description provided for @templateCardPickExample.
  ///
  /// In en, this message translates to:
  /// **'Card pick example'**
  String get templateCardPickExample;

  /// No description provided for @templateConveyorExample.
  ///
  /// In en, this message translates to:
  /// **'Conveyor example'**
  String get templateConveyorExample;

  /// No description provided for @templateLastStandExample.
  ///
  /// In en, this message translates to:
  /// **'Last stand example'**
  String get templateLastStandExample;

  /// No description provided for @templateIZombieExample.
  ///
  /// In en, this message translates to:
  /// **'I, Zombie example'**
  String get templateIZombieExample;

  /// No description provided for @templateVaseBreakerExample.
  ///
  /// In en, this message translates to:
  /// **'Vase breaker example'**
  String get templateVaseBreakerExample;

  /// No description provided for @templateZombossExample.
  ///
  /// In en, this message translates to:
  /// **'Zomboss battle example'**
  String get templateZombossExample;

  /// No description provided for @templateCustomZombieExample.
  ///
  /// In en, this message translates to:
  /// **'Custom zombie example'**
  String get templateCustomZombieExample;

  /// No description provided for @templateIPlantExample.
  ///
  /// In en, this message translates to:
  /// **'I, Plant example'**
  String get templateIPlantExample;

  /// No description provided for @unsavedChanges.
  ///
  /// In en, this message translates to:
  /// **'Unsaved changes'**
  String get unsavedChanges;

  /// No description provided for @saveBeforeLeaving.
  ///
  /// In en, this message translates to:
  /// **'Save before leaving?'**
  String get saveBeforeLeaving;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @failedToLoadLevel.
  ///
  /// In en, this message translates to:
  /// **'Failed to load level'**
  String get failedToLoadLevel;

  /// No description provided for @noLevelDefinition.
  ///
  /// In en, this message translates to:
  /// **'No level definition'**
  String get noLevelDefinition;

  /// No description provided for @noLevelDefinitionHint.
  ///
  /// In en, this message translates to:
  /// **'Level definition module (LevelDefinition) was not found. This is the base node of the level file. Try adding it manually.'**
  String get noLevelDefinitionHint;

  /// No description provided for @levelBasicInfo.
  ///
  /// In en, this message translates to:
  /// **'Level basic info'**
  String get levelBasicInfo;

  /// No description provided for @levelBasicInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, number, description, stage'**
  String get levelBasicInfoSubtitle;

  /// No description provided for @removeModule.
  ///
  /// In en, this message translates to:
  /// **'Remove module'**
  String get removeModule;

  /// No description provided for @zombieCategoryMain.
  ///
  /// In en, this message translates to:
  /// **'By World'**
  String get zombieCategoryMain;

  /// No description provided for @zombieCategorySize.
  ///
  /// In en, this message translates to:
  /// **'By Size'**
  String get zombieCategorySize;

  /// No description provided for @zombieCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get zombieCategoryOther;

  /// No description provided for @zombieCategoryCollection.
  ///
  /// In en, this message translates to:
  /// **'My Collection'**
  String get zombieCategoryCollection;

  /// No description provided for @zombieTagAll.
  ///
  /// In en, this message translates to:
  /// **'All Zombies'**
  String get zombieTagAll;

  /// No description provided for @zombieTagEgyptPirate.
  ///
  /// In en, this message translates to:
  /// **'Egypt/Pirate'**
  String get zombieTagEgyptPirate;

  /// No description provided for @zombieTagWestFuture.
  ///
  /// In en, this message translates to:
  /// **'West/Future'**
  String get zombieTagWestFuture;

  /// No description provided for @zombieTagDarkBeach.
  ///
  /// In en, this message translates to:
  /// **'Dark/Beach'**
  String get zombieTagDarkBeach;

  /// No description provided for @zombieTagIceageLostcity.
  ///
  /// In en, this message translates to:
  /// **'Ice Age/Lost City'**
  String get zombieTagIceageLostcity;

  /// No description provided for @zombieTagKongfuSkycity.
  ///
  /// In en, this message translates to:
  /// **'Kongfu/Sky City'**
  String get zombieTagKongfuSkycity;

  /// No description provided for @zombieTagEightiesDino.
  ///
  /// In en, this message translates to:
  /// **'80s/Dino'**
  String get zombieTagEightiesDino;

  /// No description provided for @zombieTagModernPvz1.
  ///
  /// In en, this message translates to:
  /// **'Modern/Pvz1'**
  String get zombieTagModernPvz1;

  /// No description provided for @zombieTagSteamRenai.
  ///
  /// In en, this message translates to:
  /// **'Steam/Renaissance'**
  String get zombieTagSteamRenai;

  /// No description provided for @zombieTagHenaiAtlantis.
  ///
  /// In en, this message translates to:
  /// **'Heian/Atlantis'**
  String get zombieTagHenaiAtlantis;

  /// No description provided for @zombieTagTaleZCorp.
  ///
  /// In en, this message translates to:
  /// **'Fairytale/ZCorp'**
  String get zombieTagTaleZCorp;

  /// No description provided for @zombieTagParkourSpeed.
  ///
  /// In en, this message translates to:
  /// **'Parkour/Speed'**
  String get zombieTagParkourSpeed;

  /// No description provided for @zombieTagTothewest.
  ///
  /// In en, this message translates to:
  /// **'Journey to West'**
  String get zombieTagTothewest;

  /// No description provided for @zombieTagMemory.
  ///
  /// In en, this message translates to:
  /// **'Memory Journey'**
  String get zombieTagMemory;

  /// No description provided for @zombieTagUniverse.
  ///
  /// In en, this message translates to:
  /// **'Parallel Universe'**
  String get zombieTagUniverse;

  /// No description provided for @zombieTagFestival1.
  ///
  /// In en, this message translates to:
  /// **'Festival 1'**
  String get zombieTagFestival1;

  /// No description provided for @zombieTagFestival2.
  ///
  /// In en, this message translates to:
  /// **'Festival 2'**
  String get zombieTagFestival2;

  /// No description provided for @zombieTagRoman.
  ///
  /// In en, this message translates to:
  /// **'Roman'**
  String get zombieTagRoman;

  /// No description provided for @zombieTagPet.
  ///
  /// In en, this message translates to:
  /// **'Pet'**
  String get zombieTagPet;

  /// No description provided for @zombieTagImp.
  ///
  /// In en, this message translates to:
  /// **'Imp'**
  String get zombieTagImp;

  /// No description provided for @zombieTagBasic.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get zombieTagBasic;

  /// No description provided for @zombieTagFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get zombieTagFat;

  /// No description provided for @zombieTagStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get zombieTagStrong;

  /// No description provided for @zombieTagGargantuar.
  ///
  /// In en, this message translates to:
  /// **'Gargantuar'**
  String get zombieTagGargantuar;

  /// No description provided for @zombieTagElite.
  ///
  /// In en, this message translates to:
  /// **'Elite'**
  String get zombieTagElite;

  /// No description provided for @zombieTagEvildave.
  ///
  /// In en, this message translates to:
  /// **'Evil Dave'**
  String get zombieTagEvildave;

  /// No description provided for @plantCategoryQuality.
  ///
  /// In en, this message translates to:
  /// **'By Quality'**
  String get plantCategoryQuality;

  /// No description provided for @plantCategoryRole.
  ///
  /// In en, this message translates to:
  /// **'By Role'**
  String get plantCategoryRole;

  /// No description provided for @plantCategoryAttribute.
  ///
  /// In en, this message translates to:
  /// **'By Attribute'**
  String get plantCategoryAttribute;

  /// No description provided for @plantCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get plantCategoryOther;

  /// No description provided for @plantCategoryCollection.
  ///
  /// In en, this message translates to:
  /// **'My Collection'**
  String get plantCategoryCollection;

  /// No description provided for @plantTagAll.
  ///
  /// In en, this message translates to:
  /// **'All Plants'**
  String get plantTagAll;

  /// No description provided for @plantTagWhite.
  ///
  /// In en, this message translates to:
  /// **'White Quality'**
  String get plantTagWhite;

  /// No description provided for @plantTagGreen.
  ///
  /// In en, this message translates to:
  /// **'Green Quality'**
  String get plantTagGreen;

  /// No description provided for @plantTagBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue Quality'**
  String get plantTagBlue;

  /// No description provided for @plantTagPurple.
  ///
  /// In en, this message translates to:
  /// **'Purple Quality'**
  String get plantTagPurple;

  /// No description provided for @plantTagOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange Quality'**
  String get plantTagOrange;

  /// No description provided for @plantTagAssist.
  ///
  /// In en, this message translates to:
  /// **'Assist'**
  String get plantTagAssist;

  /// No description provided for @plantTagRemote.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get plantTagRemote;

  /// No description provided for @plantTagProductor.
  ///
  /// In en, this message translates to:
  /// **'Producer'**
  String get plantTagProductor;

  /// No description provided for @plantTagDefence.
  ///
  /// In en, this message translates to:
  /// **'Defense'**
  String get plantTagDefence;

  /// No description provided for @plantTagVanguard.
  ///
  /// In en, this message translates to:
  /// **'Vanguard'**
  String get plantTagVanguard;

  /// No description provided for @plantTagTrapper.
  ///
  /// In en, this message translates to:
  /// **'Trapper'**
  String get plantTagTrapper;

  /// No description provided for @plantTagFire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get plantTagFire;

  /// No description provided for @plantTagIce.
  ///
  /// In en, this message translates to:
  /// **'Ice'**
  String get plantTagIce;

  /// No description provided for @plantTagMagic.
  ///
  /// In en, this message translates to:
  /// **'Magic'**
  String get plantTagMagic;

  /// No description provided for @plantTagPoison.
  ///
  /// In en, this message translates to:
  /// **'Poison'**
  String get plantTagPoison;

  /// No description provided for @plantTagElectric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get plantTagElectric;

  /// No description provided for @plantTagPhysics.
  ///
  /// In en, this message translates to:
  /// **'Physics'**
  String get plantTagPhysics;

  /// No description provided for @plantTagOriginal.
  ///
  /// In en, this message translates to:
  /// **'Original PvZ1'**
  String get plantTagOriginal;

  /// No description provided for @plantTagParallel.
  ///
  /// In en, this message translates to:
  /// **'Parallel World'**
  String get plantTagParallel;

  /// No description provided for @removeModuleConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove this module? Local custom modules (@CurrentLevel) and their data will be deleted permanently.'**
  String get removeModuleConfirm;

  /// No description provided for @confirmRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get confirmRemove;

  /// No description provided for @addModule.
  ///
  /// In en, this message translates to:
  /// **'Add module'**
  String get addModule;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline;

  /// No description provided for @iZombie.
  ///
  /// In en, this message translates to:
  /// **'I, Zombie'**
  String get iZombie;

  /// No description provided for @vaseBreaker.
  ///
  /// In en, this message translates to:
  /// **'Vase breaker'**
  String get vaseBreaker;

  /// No description provided for @zomboss.
  ///
  /// In en, this message translates to:
  /// **'Zomboss'**
  String get zomboss;

  /// No description provided for @moveSourceSameAsDest.
  ///
  /// In en, this message translates to:
  /// **'Source and target folder are the same'**
  String get moveSourceSameAsDest;

  /// No description provided for @moveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Moved successfully'**
  String get moveSuccess;

  /// No description provided for @moveFail.
  ///
  /// In en, this message translates to:
  /// **'Move failed'**
  String get moveFail;

  /// No description provided for @rootFolder.
  ///
  /// In en, this message translates to:
  /// **'Root'**
  String get rootFolder;

  /// No description provided for @createEmptyWave.
  ///
  /// In en, this message translates to:
  /// **'Create empty wave'**
  String get createEmptyWave;

  /// No description provided for @noWaveManager.
  ///
  /// In en, this message translates to:
  /// **'No wave manager found'**
  String get noWaveManager;

  /// No description provided for @noWaveManagerHint.
  ///
  /// In en, this message translates to:
  /// **'This level has wave management but no WaveManagerProperties object.'**
  String get noWaveManagerHint;

  /// No description provided for @waveTimelineHint.
  ///
  /// In en, this message translates to:
  /// **'Tap event to edit. Tap + to add event.'**
  String get waveTimelineHint;

  /// No description provided for @waveTimelineHintDetail.
  ///
  /// In en, this message translates to:
  /// **'Swipe wave left to delete.'**
  String get waveTimelineHintDetail;

  /// No description provided for @waveTimelineGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'Usage guide'**
  String get waveTimelineGuideTitle;

  /// No description provided for @waveTimelineGuideBody.
  ///
  /// In en, this message translates to:
  /// **'Swipe right: manage wave events\nSwipe left: delete wave\nTap points: view expectation'**
  String get waveTimelineGuideBody;

  /// No description provided for @waveDeadLinksTitle.
  ///
  /// In en, this message translates to:
  /// **'Broken references'**
  String get waveDeadLinksTitle;

  /// No description provided for @waveDeadLinksClear.
  ///
  /// In en, this message translates to:
  /// **'Clear dead links'**
  String get waveDeadLinksClear;

  /// No description provided for @customZombieManagerTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom zombie management'**
  String get customZombieManagerTitle;

  /// No description provided for @customZombieEmpty.
  ///
  /// In en, this message translates to:
  /// **'No custom zombie data'**
  String get customZombieEmpty;

  /// No description provided for @switchCustomZombie.
  ///
  /// In en, this message translates to:
  /// **'Switch custom zombie'**
  String get switchCustomZombie;

  /// No description provided for @customZombieAppearanceLocation.
  ///
  /// In en, this message translates to:
  /// **'Appearance location:'**
  String get customZombieAppearanceLocation;

  /// No description provided for @customZombieNotUsed.
  ///
  /// In en, this message translates to:
  /// **'This custom zombie is not used by any wave or module.'**
  String get customZombieNotUsed;

  /// No description provided for @customZombieWaveItem.
  ///
  /// In en, this message translates to:
  /// **'Wave {n}'**
  String customZombieWaveItem(int n);

  /// No description provided for @customZombieDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove this custom zombie entity and its property data.'**
  String get customZombieDeleteConfirm;

  /// No description provided for @editCustomZombieProperties.
  ///
  /// In en, this message translates to:
  /// **'Edit custom zombie properties'**
  String get editCustomZombieProperties;

  /// No description provided for @makeZombieAsCustom.
  ///
  /// In en, this message translates to:
  /// **'Make zombie as custom'**
  String get makeZombieAsCustom;

  /// No description provided for @customLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get customLabel;

  /// No description provided for @waveManagerGlobalParams.
  ///
  /// In en, this message translates to:
  /// **'Wave manager parameters'**
  String get waveManagerGlobalParams;

  /// No description provided for @waveManagerGlobalSummary.
  ///
  /// In en, this message translates to:
  /// **'Flag interval: {interval}, health: {minPercent}% - {maxPercent}%'**
  String waveManagerGlobalSummary(int interval, int minPercent, int maxPercent);

  /// No description provided for @waveEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No waves yet'**
  String get waveEmptyTitle;

  /// No description provided for @waveEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add the first wave, or remove this empty container.'**
  String get waveEmptySubtitle;

  /// No description provided for @waveHeaderPreview.
  ///
  /// In en, this message translates to:
  /// **'Content & points preview'**
  String get waveHeaderPreview;

  /// No description provided for @waveTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total: {total}'**
  String waveTotalLabel(int total);

  /// No description provided for @waveEmptyRowHint.
  ///
  /// In en, this message translates to:
  /// **'Empty wave (swipe left/right)'**
  String get waveEmptyRowHint;

  /// No description provided for @removeFromWave.
  ///
  /// In en, this message translates to:
  /// **'Remove from wave'**
  String get removeFromWave;

  /// No description provided for @deleteEventEntityTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete event entity?'**
  String get deleteEventEntityTitle;

  /// No description provided for @deleteEventEntityBody.
  ///
  /// In en, this message translates to:
  /// **'This will remove the event object from the level.'**
  String get deleteEventEntityBody;

  /// No description provided for @waveEventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Wave {wave} events'**
  String waveEventsTitle(int wave);

  /// No description provided for @waveManagerSettings.
  ///
  /// In en, this message translates to:
  /// **'Wave manager settings'**
  String get waveManagerSettings;

  /// No description provided for @flagInterval.
  ///
  /// In en, this message translates to:
  /// **'Flag interval'**
  String get flagInterval;

  /// No description provided for @waveManagerHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Wave manager'**
  String get waveManagerHelpTitle;

  /// No description provided for @waveManagerHelpOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get waveManagerHelpOverviewTitle;

  /// No description provided for @waveManagerHelpOverviewBody.
  ///
  /// In en, this message translates to:
  /// **'Global parameters for wave events and health thresholds.'**
  String get waveManagerHelpOverviewBody;

  /// No description provided for @waveManagerHelpFlagTitle.
  ///
  /// In en, this message translates to:
  /// **'Flag interval'**
  String get waveManagerHelpFlagTitle;

  /// No description provided for @waveManagerHelpFlagBody.
  ///
  /// In en, this message translates to:
  /// **'Every N waves is a flag wave; the final wave is always flag.'**
  String get waveManagerHelpFlagBody;

  /// No description provided for @waveManagerHelpTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Time control'**
  String get waveManagerHelpTimeTitle;

  /// No description provided for @waveManagerHelpTimeBody.
  ///
  /// In en, this message translates to:
  /// **'First wave delay changes when a conveyor is present.'**
  String get waveManagerHelpTimeBody;

  /// No description provided for @waveManagerHelpMusicTitle.
  ///
  /// In en, this message translates to:
  /// **'Music type'**
  String get waveManagerHelpMusicTitle;

  /// No description provided for @waveManagerHelpMusicBody.
  ///
  /// In en, this message translates to:
  /// **'Modern world only; provides fixed background jam type.'**
  String get waveManagerHelpMusicBody;

  /// No description provided for @waveManagerBasicParams.
  ///
  /// In en, this message translates to:
  /// **'Basic params'**
  String get waveManagerBasicParams;

  /// No description provided for @waveManagerMaxHealthThreshold.
  ///
  /// In en, this message translates to:
  /// **'Max health threshold'**
  String get waveManagerMaxHealthThreshold;

  /// No description provided for @waveManagerMinHealthThreshold.
  ///
  /// In en, this message translates to:
  /// **'Min health threshold'**
  String get waveManagerMinHealthThreshold;

  /// No description provided for @waveManagerThresholdHint.
  ///
  /// In en, this message translates to:
  /// **'Threshold must be between 0 and 1.'**
  String get waveManagerThresholdHint;

  /// No description provided for @waveManagerTimeControl.
  ///
  /// In en, this message translates to:
  /// **'Time control'**
  String get waveManagerTimeControl;

  /// No description provided for @waveManagerFirstWaveDelayConveyor.
  ///
  /// In en, this message translates to:
  /// **'First wave delay (conveyor)'**
  String get waveManagerFirstWaveDelayConveyor;

  /// No description provided for @waveManagerFirstWaveDelayNormal.
  ///
  /// In en, this message translates to:
  /// **'First wave delay (normal)'**
  String get waveManagerFirstWaveDelayNormal;

  /// No description provided for @waveManagerFlagWaveDelay.
  ///
  /// In en, this message translates to:
  /// **'Flag wave delay'**
  String get waveManagerFlagWaveDelay;

  /// No description provided for @waveManagerConveyorDetected.
  ///
  /// In en, this message translates to:
  /// **'Conveyor module detected; conveyor delay applied.'**
  String get waveManagerConveyorDetected;

  /// No description provided for @waveManagerConveyorNotDetected.
  ///
  /// In en, this message translates to:
  /// **'No conveyor module; normal delay applied.'**
  String get waveManagerConveyorNotDetected;

  /// No description provided for @waveManagerSpecial.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get waveManagerSpecial;

  /// No description provided for @waveManagerSuppressFlagZombieTitle.
  ///
  /// In en, this message translates to:
  /// **'Suppress flag zombie'**
  String get waveManagerSuppressFlagZombieTitle;

  /// No description provided for @waveManagerSuppressFlagZombieField.
  ///
  /// In en, this message translates to:
  /// **'SuppressFlagZombie'**
  String get waveManagerSuppressFlagZombieField;

  /// No description provided for @waveManagerSuppressFlagZombieHint.
  ///
  /// In en, this message translates to:
  /// **'When enabled, flag waves won’t spawn a flag zombie.'**
  String get waveManagerSuppressFlagZombieHint;

  /// No description provided for @waveManagerLevelJam.
  ///
  /// In en, this message translates to:
  /// **'Level Jam'**
  String get waveManagerLevelJam;

  /// No description provided for @waveManagerLevelJamHint.
  ///
  /// In en, this message translates to:
  /// **'Only applies to Modern world; provides fixed background music.'**
  String get waveManagerLevelJamHint;

  /// No description provided for @jamNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get jamNone;

  /// No description provided for @jamPop.
  ///
  /// In en, this message translates to:
  /// **'Pop'**
  String get jamPop;

  /// No description provided for @jamRap.
  ///
  /// In en, this message translates to:
  /// **'Rap'**
  String get jamRap;

  /// No description provided for @jamMetal.
  ///
  /// In en, this message translates to:
  /// **'Metal'**
  String get jamMetal;

  /// No description provided for @jamPunk.
  ///
  /// In en, this message translates to:
  /// **'Punk'**
  String get jamPunk;

  /// No description provided for @jam8Bit.
  ///
  /// In en, this message translates to:
  /// **'8-Bit'**
  String get jam8Bit;

  /// No description provided for @noWaves.
  ///
  /// In en, this message translates to:
  /// **'No waves'**
  String get noWaves;

  /// No description provided for @addFirstWave.
  ///
  /// In en, this message translates to:
  /// **'Add the first wave.'**
  String get addFirstWave;

  /// No description provided for @deleteWave.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteWave;

  /// No description provided for @deleteWaveConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will remove this wave and its {count} events.'**
  String deleteWaveConfirm(int count);

  /// No description provided for @addEvent.
  ///
  /// In en, this message translates to:
  /// **'Add event'**
  String get addEvent;

  /// No description provided for @emptyWave.
  ///
  /// In en, this message translates to:
  /// **'Empty wave'**
  String get emptyWave;

  /// No description provided for @addWave.
  ///
  /// In en, this message translates to:
  /// **'Add wave'**
  String get addWave;

  /// No description provided for @expectation.
  ///
  /// In en, this message translates to:
  /// **'Expectation'**
  String get expectation;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @editProperties.
  ///
  /// In en, this message translates to:
  /// **'Edit properties'**
  String get editProperties;

  /// No description provided for @deleteEntity.
  ///
  /// In en, this message translates to:
  /// **'Delete entity'**
  String get deleteEntity;

  /// No description provided for @deleteObjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete object?'**
  String get deleteObjectTitle;

  /// No description provided for @deleteObjectConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove this object from the level file? This action cannot be undone.'**
  String get deleteObjectConfirmMessage;

  /// No description provided for @objectDeleted.
  ///
  /// In en, this message translates to:
  /// **'Object deleted'**
  String get objectDeleted;

  /// No description provided for @moduleEditorInProgress.
  ///
  /// In en, this message translates to:
  /// **'Module editor in development'**
  String get moduleEditorInProgress;

  /// No description provided for @dataEmpty.
  ///
  /// In en, this message translates to:
  /// **'Data is empty'**
  String get dataEmpty;

  /// No description provided for @saveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Save successful'**
  String get saveSuccess;

  /// No description provided for @saveFail.
  ///
  /// In en, this message translates to:
  /// **'Save failed'**
  String get saveFail;

  /// No description provided for @confirmRemoveRef.
  ///
  /// In en, this message translates to:
  /// **'Remove reference'**
  String get confirmRemoveRef;

  /// No description provided for @confirmRemoveRefMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove this reference? The entity data will remain until all references are removed.'**
  String get confirmRemoveRefMessage;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @levelNumber.
  ///
  /// In en, this message translates to:
  /// **'Level number'**
  String get levelNumber;

  /// No description provided for @startingSun.
  ///
  /// In en, this message translates to:
  /// **'Starting sun'**
  String get startingSun;

  /// No description provided for @stageModule.
  ///
  /// In en, this message translates to:
  /// **'Stage module'**
  String get stageModule;

  /// No description provided for @musicType.
  ///
  /// In en, this message translates to:
  /// **'Music type'**
  String get musicType;

  /// No description provided for @loot.
  ///
  /// In en, this message translates to:
  /// **'Loot'**
  String get loot;

  /// No description provided for @victoryModule.
  ///
  /// In en, this message translates to:
  /// **'Victory module'**
  String get victoryModule;

  /// No description provided for @missingModules.
  ///
  /// In en, this message translates to:
  /// **'Missing modules'**
  String get missingModules;

  /// No description provided for @moduleConflict.
  ///
  /// In en, this message translates to:
  /// **'Module conflict'**
  String get moduleConflict;

  /// No description provided for @editableModules.
  ///
  /// In en, this message translates to:
  /// **'Editable modules'**
  String get editableModules;

  /// No description provided for @parameterModules.
  ///
  /// In en, this message translates to:
  /// **'Parameter modules'**
  String get parameterModules;

  /// No description provided for @addNewModule.
  ///
  /// In en, this message translates to:
  /// **'Add new module'**
  String get addNewModule;

  /// No description provided for @selectStage.
  ///
  /// In en, this message translates to:
  /// **'Select stage'**
  String get selectStage;

  /// No description provided for @searchStage.
  ///
  /// In en, this message translates to:
  /// **'Search stage name or alias'**
  String get searchStage;

  /// No description provided for @noStageFound.
  ///
  /// In en, this message translates to:
  /// **'No stage found'**
  String get noStageFound;

  /// No description provided for @stageTypeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get stageTypeAll;

  /// No description provided for @stageTypeMain.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get stageTypeMain;

  /// No description provided for @stageTypeExtra.
  ///
  /// In en, this message translates to:
  /// **'Extra'**
  String get stageTypeExtra;

  /// No description provided for @stageTypeSeasons.
  ///
  /// In en, this message translates to:
  /// **'Seasons'**
  String get stageTypeSeasons;

  /// No description provided for @stageTypeSpecial.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get stageTypeSpecial;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @disablePeavine.
  ///
  /// In en, this message translates to:
  /// **'Disable peavine'**
  String get disablePeavine;

  /// No description provided for @disableArtifact.
  ///
  /// In en, this message translates to:
  /// **'Disable artifact'**
  String get disableArtifact;

  /// No description provided for @selectPlant.
  ///
  /// In en, this message translates to:
  /// **'Select plant'**
  String get selectPlant;

  /// No description provided for @searchPlant.
  ///
  /// In en, this message translates to:
  /// **'Search plant'**
  String get searchPlant;

  /// No description provided for @noPlantFound.
  ///
  /// In en, this message translates to:
  /// **'No plant found'**
  String get noPlantFound;

  /// No description provided for @noResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String noResultsFor(Object query);

  /// No description provided for @noModulesInCategory.
  ///
  /// In en, this message translates to:
  /// **'No modules in this category'**
  String get noModulesInCategory;

  /// No description provided for @addEventForWave.
  ///
  /// In en, this message translates to:
  /// **'Add event for wave {wave}'**
  String addEventForWave(int wave);

  /// No description provided for @waveLabel.
  ///
  /// In en, this message translates to:
  /// **'Wave'**
  String get waveLabel;

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get pointsLabel;

  /// No description provided for @noDynamicZombies.
  ///
  /// In en, this message translates to:
  /// **'No dynamic zombies'**
  String get noDynamicZombies;

  /// No description provided for @moduleTitle_WaveManagerModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Wave Manager'**
  String get moduleTitle_WaveManagerModuleProperties;

  /// No description provided for @moduleDesc_WaveManagerModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Manage level wave events'**
  String get moduleDesc_WaveManagerModuleProperties;

  /// No description provided for @moduleTitle_CustomLevelModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Lawn Module'**
  String get moduleTitle_CustomLevelModuleProperties;

  /// No description provided for @moduleDesc_CustomLevelModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Enable custom lawn framework'**
  String get moduleDesc_CustomLevelModuleProperties;

  /// No description provided for @moduleTitle_StandardLevelIntroProperties.
  ///
  /// In en, this message translates to:
  /// **'Intro Animation'**
  String get moduleTitle_StandardLevelIntroProperties;

  /// No description provided for @moduleDesc_StandardLevelIntroProperties.
  ///
  /// In en, this message translates to:
  /// **'Camera pan at level start'**
  String get moduleDesc_StandardLevelIntroProperties;

  /// No description provided for @moduleTitle_ZombiesAteYourBrainsProperties.
  ///
  /// In en, this message translates to:
  /// **'Failure Condition'**
  String get moduleTitle_ZombiesAteYourBrainsProperties;

  /// No description provided for @moduleDesc_ZombiesAteYourBrainsProperties.
  ///
  /// In en, this message translates to:
  /// **'Zombie enters house condition'**
  String get moduleDesc_ZombiesAteYourBrainsProperties;

  /// No description provided for @moduleTitle_ZombiesDeadWinConProperties.
  ///
  /// In en, this message translates to:
  /// **'Death Drop'**
  String get moduleTitle_ZombiesDeadWinConProperties;

  /// No description provided for @moduleDesc_ZombiesDeadWinConProperties.
  ///
  /// In en, this message translates to:
  /// **'Required for level stability'**
  String get moduleDesc_ZombiesDeadWinConProperties;

  /// No description provided for @moduleTitle_PennyClassroomModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Plant Tier'**
  String get moduleTitle_PennyClassroomModuleProperties;

  /// No description provided for @moduleDesc_PennyClassroomModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Global plant tier definition'**
  String get moduleDesc_PennyClassroomModuleProperties;

  /// No description provided for @moduleTitle_SeedBankProperties.
  ///
  /// In en, this message translates to:
  /// **'Seed Bank'**
  String get moduleTitle_SeedBankProperties;

  /// No description provided for @moduleDesc_SeedBankProperties.
  ///
  /// In en, this message translates to:
  /// **'Preset plants and selection method'**
  String get moduleDesc_SeedBankProperties;

  /// No description provided for @moduleTitle_ConveyorSeedBankProperties.
  ///
  /// In en, this message translates to:
  /// **'Conveyor Belt'**
  String get moduleTitle_ConveyorSeedBankProperties;

  /// No description provided for @moduleDesc_ConveyorSeedBankProperties.
  ///
  /// In en, this message translates to:
  /// **'Preset conveyor plants and weights'**
  String get moduleDesc_ConveyorSeedBankProperties;

  /// No description provided for @moduleTitle_SunDropperProperties.
  ///
  /// In en, this message translates to:
  /// **'Sun Dropper'**
  String get moduleTitle_SunDropperProperties;

  /// No description provided for @moduleDesc_SunDropperProperties.
  ///
  /// In en, this message translates to:
  /// **'Control falling sun frequency'**
  String get moduleDesc_SunDropperProperties;

  /// No description provided for @moduleTitle_LevelMutatorMaxSunProps.
  ///
  /// In en, this message translates to:
  /// **'Max Sun'**
  String get moduleTitle_LevelMutatorMaxSunProps;

  /// No description provided for @moduleDesc_LevelMutatorMaxSunProps.
  ///
  /// In en, this message translates to:
  /// **'Override maximum sun limit'**
  String get moduleDesc_LevelMutatorMaxSunProps;

  /// No description provided for @moduleTitle_LevelMutatorStartingPlantfoodProps.
  ///
  /// In en, this message translates to:
  /// **'Starting Plant Food'**
  String get moduleTitle_LevelMutatorStartingPlantfoodProps;

  /// No description provided for @moduleDesc_LevelMutatorStartingPlantfoodProps.
  ///
  /// In en, this message translates to:
  /// **'Override initial plant food'**
  String get moduleDesc_LevelMutatorStartingPlantfoodProps;

  /// No description provided for @moduleTitle_StarChallengeModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get moduleTitle_StarChallengeModuleProperties;

  /// No description provided for @moduleDesc_StarChallengeModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Level restrictions and goals'**
  String get moduleDesc_StarChallengeModuleProperties;

  /// No description provided for @moduleTitle_LevelScoringModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Scoring'**
  String get moduleTitle_LevelScoringModuleProperties;

  /// No description provided for @moduleDesc_LevelScoringModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Enable score points for kills'**
  String get moduleDesc_LevelScoringModuleProperties;

  /// No description provided for @moduleTitle_BowlingMinigameProperties.
  ///
  /// In en, this message translates to:
  /// **'Bowling Bulb'**
  String get moduleTitle_BowlingMinigameProperties;

  /// No description provided for @moduleDesc_BowlingMinigameProperties.
  ///
  /// In en, this message translates to:
  /// **'Set line and disable shovel'**
  String get moduleDesc_BowlingMinigameProperties;

  /// No description provided for @moduleTitle_NewBowlingMinigameProperties.
  ///
  /// In en, this message translates to:
  /// **'Wall-nut Bowling'**
  String get moduleTitle_NewBowlingMinigameProperties;

  /// No description provided for @moduleDesc_NewBowlingMinigameProperties.
  ///
  /// In en, this message translates to:
  /// **'Bowling line setup'**
  String get moduleDesc_NewBowlingMinigameProperties;

  /// No description provided for @moduleTitle_VaseBreakerPresetProperties.
  ///
  /// In en, this message translates to:
  /// **'Vase Layout'**
  String get moduleTitle_VaseBreakerPresetProperties;

  /// No description provided for @moduleDesc_VaseBreakerPresetProperties.
  ///
  /// In en, this message translates to:
  /// **'Configure vase contents'**
  String get moduleDesc_VaseBreakerPresetProperties;

  /// No description provided for @moduleTitle_VaseBreakerArcadeModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Vase Breaker Mode'**
  String get moduleTitle_VaseBreakerArcadeModuleProperties;

  /// No description provided for @moduleDesc_VaseBreakerArcadeModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Enable vase breaker UI'**
  String get moduleDesc_VaseBreakerArcadeModuleProperties;

  /// No description provided for @moduleTitle_VaseBreakerFlowModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Vase Animation'**
  String get moduleTitle_VaseBreakerFlowModuleProperties;

  /// No description provided for @moduleDesc_VaseBreakerFlowModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Control vase drop animation'**
  String get moduleDesc_VaseBreakerFlowModuleProperties;

  /// No description provided for @moduleTitle_EvilDaveProperties.
  ///
  /// In en, this message translates to:
  /// **'I, Zombie'**
  String get moduleTitle_EvilDaveProperties;

  /// No description provided for @moduleDesc_EvilDaveProperties.
  ///
  /// In en, this message translates to:
  /// **'Enable I, Zombie mode'**
  String get moduleDesc_EvilDaveProperties;

  /// No description provided for @moduleTitle_ZombossBattleModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Zomboss Battle'**
  String get moduleTitle_ZombossBattleModuleProperties;

  /// No description provided for @moduleDesc_ZombossBattleModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Boss battle parameters'**
  String get moduleDesc_ZombossBattleModuleProperties;

  /// No description provided for @moduleTitle_ZombossBattleIntroProperties.
  ///
  /// In en, this message translates to:
  /// **'Zomboss Intro'**
  String get moduleTitle_ZombossBattleIntroProperties;

  /// No description provided for @moduleDesc_ZombossBattleIntroProperties.
  ///
  /// In en, this message translates to:
  /// **'Boss intro and health bar'**
  String get moduleDesc_ZombossBattleIntroProperties;

  /// No description provided for @moduleTitle_SeedRainProperties.
  ///
  /// In en, this message translates to:
  /// **'Seed Rain'**
  String get moduleTitle_SeedRainProperties;

  /// No description provided for @moduleDesc_SeedRainProperties.
  ///
  /// In en, this message translates to:
  /// **'Falling plants/zombies/items'**
  String get moduleDesc_SeedRainProperties;

  /// No description provided for @moduleTitle_LastStandMinigameProperties.
  ///
  /// In en, this message translates to:
  /// **'Last Stand'**
  String get moduleTitle_LastStandMinigameProperties;

  /// No description provided for @moduleDesc_LastStandMinigameProperties.
  ///
  /// In en, this message translates to:
  /// **'Initial resources and setup phase'**
  String get moduleDesc_LastStandMinigameProperties;

  /// No description provided for @moduleTitle_PVZ1OverwhelmModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Overwhelm'**
  String get moduleTitle_PVZ1OverwhelmModuleProperties;

  /// No description provided for @moduleDesc_PVZ1OverwhelmModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Overwhelm minigame'**
  String get moduleDesc_PVZ1OverwhelmModuleProperties;

  /// No description provided for @moduleTitle_SunBombChallengeProperties.
  ///
  /// In en, this message translates to:
  /// **'Sun Bombs'**
  String get moduleTitle_SunBombChallengeProperties;

  /// No description provided for @moduleDesc_SunBombChallengeProperties.
  ///
  /// In en, this message translates to:
  /// **'Falling sun bomb config'**
  String get moduleDesc_SunBombChallengeProperties;

  /// No description provided for @moduleTitle_IncreasedCostModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Inflation'**
  String get moduleTitle_IncreasedCostModuleProperties;

  /// No description provided for @moduleDesc_IncreasedCostModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Sun cost increases with planting'**
  String get moduleDesc_IncreasedCostModuleProperties;

  /// No description provided for @moduleTitle_DeathHoleModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Death Holes'**
  String get moduleTitle_DeathHoleModuleProperties;

  /// No description provided for @moduleDesc_DeathHoleModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Plants leave unplantable holes'**
  String get moduleDesc_DeathHoleModuleProperties;

  /// No description provided for @moduleTitle_ZombieMoveFastModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Fast Entry'**
  String get moduleTitle_ZombieMoveFastModuleProperties;

  /// No description provided for @moduleDesc_ZombieMoveFastModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Zombies move fast on entry'**
  String get moduleDesc_ZombieMoveFastModuleProperties;

  /// No description provided for @moduleTitle_InitialPlantEntryProperties.
  ///
  /// In en, this message translates to:
  /// **'Initial Plants'**
  String get moduleTitle_InitialPlantEntryProperties;

  /// No description provided for @moduleDesc_InitialPlantEntryProperties.
  ///
  /// In en, this message translates to:
  /// **'Plants present at start'**
  String get moduleDesc_InitialPlantEntryProperties;

  /// No description provided for @moduleTitle_InitialZombieProperties.
  ///
  /// In en, this message translates to:
  /// **'Initial Zombies'**
  String get moduleTitle_InitialZombieProperties;

  /// No description provided for @moduleDesc_InitialZombieProperties.
  ///
  /// In en, this message translates to:
  /// **'Zombies present at start'**
  String get moduleDesc_InitialZombieProperties;

  /// No description provided for @moduleTitle_InitialGridItemProperties.
  ///
  /// In en, this message translates to:
  /// **'Initial Grid Items'**
  String get moduleTitle_InitialGridItemProperties;

  /// No description provided for @moduleDesc_InitialGridItemProperties.
  ///
  /// In en, this message translates to:
  /// **'Grid items present at start'**
  String get moduleDesc_InitialGridItemProperties;

  /// No description provided for @moduleTitle_ProtectThePlantChallengeProperties.
  ///
  /// In en, this message translates to:
  /// **'Protect Plants'**
  String get moduleTitle_ProtectThePlantChallengeProperties;

  /// No description provided for @moduleDesc_ProtectThePlantChallengeProperties.
  ///
  /// In en, this message translates to:
  /// **'Plants that must be protected'**
  String get moduleDesc_ProtectThePlantChallengeProperties;

  /// No description provided for @moduleTitle_ProtectTheGridItemChallengeProperties.
  ///
  /// In en, this message translates to:
  /// **'Protect Items'**
  String get moduleTitle_ProtectTheGridItemChallengeProperties;

  /// No description provided for @moduleDesc_ProtectTheGridItemChallengeProperties.
  ///
  /// In en, this message translates to:
  /// **'Items that must be protected'**
  String get moduleDesc_ProtectTheGridItemChallengeProperties;

  /// No description provided for @moduleTitle_ZombiePotionModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Zombie Potions'**
  String get moduleTitle_ZombiePotionModuleProperties;

  /// No description provided for @moduleDesc_ZombiePotionModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Dark Ages potion generation'**
  String get moduleDesc_ZombiePotionModuleProperties;

  /// No description provided for @moduleTitle_PiratePlankProperties.
  ///
  /// In en, this message translates to:
  /// **'Pirate Planks'**
  String get moduleTitle_PiratePlankProperties;

  /// No description provided for @moduleDesc_PiratePlankProperties.
  ///
  /// In en, this message translates to:
  /// **'Pirate Seas plank rows'**
  String get moduleDesc_PiratePlankProperties;

  /// No description provided for @moduleTitle_RailcartProperties.
  ///
  /// In en, this message translates to:
  /// **'Railcarts'**
  String get moduleTitle_RailcartProperties;

  /// No description provided for @moduleDesc_RailcartProperties.
  ///
  /// In en, this message translates to:
  /// **'Minecart and track layout'**
  String get moduleDesc_RailcartProperties;

  /// No description provided for @moduleTitle_PowerTileProperties.
  ///
  /// In en, this message translates to:
  /// **'Power Tiles'**
  String get moduleTitle_PowerTileProperties;

  /// No description provided for @moduleDesc_PowerTileProperties.
  ///
  /// In en, this message translates to:
  /// **'Future power tile layout'**
  String get moduleDesc_PowerTileProperties;

  /// No description provided for @moduleTitle_ManholePipelineModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Manholes'**
  String get moduleTitle_ManholePipelineModuleProperties;

  /// No description provided for @moduleDesc_ManholePipelineModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Steam Age pipelines'**
  String get moduleDesc_ManholePipelineModuleProperties;

  /// No description provided for @moduleTitle_RoofProperties.
  ///
  /// In en, this message translates to:
  /// **'Roof Pots'**
  String get moduleTitle_RoofProperties;

  /// No description provided for @moduleDesc_RoofProperties.
  ///
  /// In en, this message translates to:
  /// **'Roof level pot columns'**
  String get moduleDesc_RoofProperties;

  /// No description provided for @moduleTitle_TideProperties.
  ///
  /// In en, this message translates to:
  /// **'Tide System'**
  String get moduleTitle_TideProperties;

  /// No description provided for @moduleDesc_TideProperties.
  ///
  /// In en, this message translates to:
  /// **'Enable tide system'**
  String get moduleDesc_TideProperties;

  /// No description provided for @moduleTitle_WarMistProperties.
  ///
  /// In en, this message translates to:
  /// **'War Mist'**
  String get moduleTitle_WarMistProperties;

  /// No description provided for @moduleDesc_WarMistProperties.
  ///
  /// In en, this message translates to:
  /// **'Fog of war system'**
  String get moduleDesc_WarMistProperties;

  /// No description provided for @moduleTitle_RainDarkProperties.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get moduleTitle_RainDarkProperties;

  /// No description provided for @moduleDesc_RainDarkProperties.
  ///
  /// In en, this message translates to:
  /// **'Rain, snow, storm effects'**
  String get moduleDesc_RainDarkProperties;

  /// No description provided for @eventTitle_SpawnZombiesFromGroundSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Ground Spawn'**
  String get eventTitle_SpawnZombiesFromGroundSpawnerProps;

  /// No description provided for @eventDesc_SpawnZombiesFromGroundSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Zombies spawn from ground'**
  String get eventDesc_SpawnZombiesFromGroundSpawnerProps;

  /// No description provided for @eventTitle_SpawnZombiesJitteredWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Standard Spawn'**
  String get eventTitle_SpawnZombiesJitteredWaveActionProps;

  /// No description provided for @eventDesc_SpawnZombiesJitteredWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Basic natural spawn'**
  String get eventDesc_SpawnZombiesJitteredWaveActionProps;

  /// No description provided for @eventTitle_FrostWindWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Frost Wind'**
  String get eventTitle_FrostWindWaveActionProps;

  /// No description provided for @eventDesc_FrostWindWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Freezing wind on rows'**
  String get eventDesc_FrostWindWaveActionProps;

  /// No description provided for @eventTitle_BeachStageEventZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Low Tide'**
  String get eventTitle_BeachStageEventZombieSpawnerProps;

  /// No description provided for @eventDesc_BeachStageEventZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Zombies spawn at low tide'**
  String get eventDesc_BeachStageEventZombieSpawnerProps;

  /// No description provided for @eventTitle_TidalChangeWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Tide Change'**
  String get eventTitle_TidalChangeWaveActionProps;

  /// No description provided for @eventDesc_TidalChangeWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Change tide position'**
  String get eventDesc_TidalChangeWaveActionProps;

  /// No description provided for @eventTitle_ModifyConveyorWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Conveyor Modify'**
  String get eventTitle_ModifyConveyorWaveActionProps;

  /// No description provided for @eventDesc_ModifyConveyorWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Add/remove cards dynamically'**
  String get eventDesc_ModifyConveyorWaveActionProps;

  /// No description provided for @eventTitle_DinoWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Dino Summon'**
  String get eventTitle_DinoWaveActionProps;

  /// No description provided for @eventDesc_DinoWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Summon dinosaur on row'**
  String get eventDesc_DinoWaveActionProps;

  /// No description provided for @eventTitle_SpawnModernPortalsWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Time Rift'**
  String get eventTitle_SpawnModernPortalsWaveActionProps;

  /// No description provided for @eventDesc_SpawnModernPortalsWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Summon time rift'**
  String get eventDesc_SpawnModernPortalsWaveActionProps;

  /// No description provided for @eventTitle_StormZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Storm Spawn'**
  String get eventTitle_StormZombieSpawnerProps;

  /// No description provided for @eventDesc_StormZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Sandstorm or blizzard spawn'**
  String get eventDesc_StormZombieSpawnerProps;

  /// No description provided for @eventTitle_RaidingPartyZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Raiding Party'**
  String get eventTitle_RaidingPartyZombieSpawnerProps;

  /// No description provided for @eventDesc_RaidingPartyZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Swashbuckler invasion'**
  String get eventDesc_RaidingPartyZombieSpawnerProps;

  /// No description provided for @eventTitle_ZombiePotionActionProps.
  ///
  /// In en, this message translates to:
  /// **'Potion Drop'**
  String get eventTitle_ZombiePotionActionProps;

  /// No description provided for @eventDesc_ZombiePotionActionProps.
  ///
  /// In en, this message translates to:
  /// **'Spawn potions on grid'**
  String get eventDesc_ZombiePotionActionProps;

  /// No description provided for @eventTitle_SpawnGravestonesWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Gravestone Spawn'**
  String get eventTitle_SpawnGravestonesWaveActionProps;

  /// No description provided for @eventDesc_SpawnGravestonesWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Spawn gravestones'**
  String get eventDesc_SpawnGravestonesWaveActionProps;

  /// No description provided for @eventTitle_SpawnZombiesFromGridItemSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Grave Spawn'**
  String get eventTitle_SpawnZombiesFromGridItemSpawnerProps;

  /// No description provided for @eventDesc_SpawnZombiesFromGridItemSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Spawn zombies from graves'**
  String get eventDesc_SpawnZombiesFromGridItemSpawnerProps;

  /// No description provided for @eventTitle_FairyTaleFogWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Fairy Fog'**
  String get eventTitle_FairyTaleFogWaveActionProps;

  /// No description provided for @eventDesc_FairyTaleFogWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Spawn fog'**
  String get eventDesc_FairyTaleFogWaveActionProps;

  /// No description provided for @eventTitle_FairyTaleWindWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Fairy Wind'**
  String get eventTitle_FairyTaleWindWaveActionProps;

  /// No description provided for @eventDesc_FairyTaleWindWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Blow away fog'**
  String get eventDesc_FairyTaleWindWaveActionProps;

  /// No description provided for @eventTitle_SpiderRainZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Imp Rain'**
  String get eventTitle_SpiderRainZombieSpawnerProps;

  /// No description provided for @eventDesc_SpiderRainZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Imps drop from sky'**
  String get eventDesc_SpiderRainZombieSpawnerProps;

  /// No description provided for @eventTitle_ParachuteRainZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Parachute Rain'**
  String get eventTitle_ParachuteRainZombieSpawnerProps;

  /// No description provided for @eventDesc_ParachuteRainZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Zombies drop with parachutes'**
  String get eventDesc_ParachuteRainZombieSpawnerProps;

  /// No description provided for @eventTitle_BassRainZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Bass/Jetpack Rain'**
  String get eventTitle_BassRainZombieSpawnerProps;

  /// No description provided for @eventDesc_BassRainZombieSpawnerProps.
  ///
  /// In en, this message translates to:
  /// **'Bass/Jetpack zombies drop'**
  String get eventDesc_BassRainZombieSpawnerProps;

  /// No description provided for @eventTitle_BlackHoleWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Black Hole'**
  String get eventTitle_BlackHoleWaveActionProps;

  /// No description provided for @eventDesc_BlackHoleWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Black hole attracts plants'**
  String get eventDesc_BlackHoleWaveActionProps;

  /// No description provided for @eventTitle_MagicMirrorWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Magic Mirror'**
  String get eventTitle_MagicMirrorWaveActionProps;

  /// No description provided for @eventDesc_MagicMirrorWaveActionProps.
  ///
  /// In en, this message translates to:
  /// **'Mirror portals'**
  String get eventDesc_MagicMirrorWaveActionProps;

  /// No description provided for @eventTitle_WaveActionMagicMirrorTeleportationArrayProps2.
  ///
  /// In en, this message translates to:
  /// **'Magic Mirror'**
  String get eventTitle_WaveActionMagicMirrorTeleportationArrayProps2;

  /// No description provided for @eventDesc_WaveActionMagicMirrorTeleportationArrayProps2.
  ///
  /// In en, this message translates to:
  /// **'Mirror portals'**
  String get eventDesc_WaveActionMagicMirrorTeleportationArrayProps2;

  /// No description provided for @weatherOption_DefaultSnow_label.
  ///
  /// In en, this message translates to:
  /// **'Frostbite Caves (DefaultSnow)'**
  String get weatherOption_DefaultSnow_label;

  /// No description provided for @weatherOption_DefaultSnow_desc.
  ///
  /// In en, this message translates to:
  /// **'Snowing effect from Frostbite Caves'**
  String get weatherOption_DefaultSnow_desc;

  /// No description provided for @weatherOption_LightningRain_label.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm (LightningRain)'**
  String get weatherOption_LightningRain_label;

  /// No description provided for @weatherOption_LightningRain_desc.
  ///
  /// In en, this message translates to:
  /// **'Rain and lightning from Dark Ages Day 8'**
  String get weatherOption_LightningRain_desc;

  /// No description provided for @weatherOption_DefaultRainDark_label.
  ///
  /// In en, this message translates to:
  /// **'Dark Ages (DefaultRainDark)'**
  String get weatherOption_DefaultRainDark_label;

  /// No description provided for @weatherOption_DefaultRainDark_desc.
  ///
  /// In en, this message translates to:
  /// **'Rain effect from Dark Ages'**
  String get weatherOption_DefaultRainDark_desc;

  /// No description provided for @iZombiePlantReserveLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant Reserve Column (PlantDistance)'**
  String get iZombiePlantReserveLabel;

  /// No description provided for @column.
  ///
  /// In en, this message translates to:
  /// **'Column'**
  String get column;

  /// No description provided for @iZombieInfoText.
  ///
  /// In en, this message translates to:
  /// **'In I, Zombie mode, preset plants and zombies must be configured in the Level Module (Preset Plants) and Seed Bank respectively.'**
  String get iZombieInfoText;

  /// No description provided for @vaseRangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Vase Generation Range & Blacklist'**
  String get vaseRangeTitle;

  /// No description provided for @startColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Col (Min)'**
  String get startColumnLabel;

  /// No description provided for @endColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'End Col (Max)'**
  String get endColumnLabel;

  /// No description provided for @toggleBlacklistHint.
  ///
  /// In en, this message translates to:
  /// **'Click to toggle blacklist'**
  String get toggleBlacklistHint;

  /// No description provided for @vaseCapacityTitle.
  ///
  /// In en, this message translates to:
  /// **'Vase Capacity'**
  String get vaseCapacityTitle;

  /// No description provided for @vaseCapacitySummary.
  ///
  /// In en, this message translates to:
  /// **'Assigned: {current} / Total Slots: {total}'**
  String vaseCapacitySummary(Object current, Object total);

  /// No description provided for @vaseListTitle.
  ///
  /// In en, this message translates to:
  /// **'Vase List'**
  String get vaseListTitle;

  /// No description provided for @addVaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Vase'**
  String get addVaseTitle;

  /// No description provided for @plantVaseOption.
  ///
  /// In en, this message translates to:
  /// **'Plant Vase'**
  String get plantVaseOption;

  /// No description provided for @zombieVaseOption.
  ///
  /// In en, this message translates to:
  /// **'Zombie Vase'**
  String get zombieVaseOption;

  /// No description provided for @selectZombie.
  ///
  /// In en, this message translates to:
  /// **'Select zombie'**
  String get selectZombie;

  /// No description provided for @searchZombie.
  ///
  /// In en, this message translates to:
  /// **'Search zombie'**
  String get searchZombie;

  /// No description provided for @noZombieFound.
  ///
  /// In en, this message translates to:
  /// **'No zombie found'**
  String get noZombieFound;

  /// No description provided for @unknownVaseLabel.
  ///
  /// In en, this message translates to:
  /// **'Unknown Vase'**
  String get unknownVaseLabel;

  /// No description provided for @plantLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant'**
  String get plantLabel;

  /// No description provided for @zombieLabel.
  ///
  /// In en, this message translates to:
  /// **'Zombie'**
  String get zombieLabel;

  /// No description provided for @itemLabel.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get itemLabel;

  /// No description provided for @railcartSettings.
  ///
  /// In en, this message translates to:
  /// **'Railcart settings'**
  String get railcartSettings;

  /// No description provided for @railcartType.
  ///
  /// In en, this message translates to:
  /// **'Railcart type'**
  String get railcartType;

  /// No description provided for @layRails.
  ///
  /// In en, this message translates to:
  /// **'Lay rails'**
  String get layRails;

  /// No description provided for @placeCarts.
  ///
  /// In en, this message translates to:
  /// **'Place carts'**
  String get placeCarts;

  /// No description provided for @railSegments.
  ///
  /// In en, this message translates to:
  /// **'Rail segments'**
  String get railSegments;

  /// No description provided for @railcartCount.
  ///
  /// In en, this message translates to:
  /// **'Railcart count'**
  String get railcartCount;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @moduleCategoryBase.
  ///
  /// In en, this message translates to:
  /// **'Base'**
  String get moduleCategoryBase;

  /// No description provided for @moduleCategoryMode.
  ///
  /// In en, this message translates to:
  /// **'Game Modes'**
  String get moduleCategoryMode;

  /// No description provided for @moduleCategoryScene.
  ///
  /// In en, this message translates to:
  /// **'Scene'**
  String get moduleCategoryScene;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
