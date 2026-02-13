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

  /// No description provided for @storagePermissionHint.
  ///
  /// In en, this message translates to:
  /// **'Storage permission required. Enable \"All files access\" in Settings to open level files.'**
  String get storagePermissionHint;

  /// No description provided for @storagePermissionDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Storage Permission Required'**
  String get storagePermissionDialogTitle;

  /// No description provided for @storagePermissionDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This app requires external storage access to open and save level files. Please grant \"All files access\" permission in Settings.'**
  String get storagePermissionDialogMessage;

  /// No description provided for @storagePermissionGoToSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to settings'**
  String get storagePermissionGoToSettings;

  /// No description provided for @storagePermissionDeny.
  ///
  /// In en, this message translates to:
  /// **'Deny'**
  String get storagePermissionDeny;

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
  /// **'Successfully renamed'**
  String get renameSuccess;

  /// No description provided for @renameFail.
  ///
  /// In en, this message translates to:
  /// **'Rename failed, file already exists'**
  String get renameFail;

  /// No description provided for @copyReferenceOrDeep.
  ///
  /// In en, this message translates to:
  /// **'Copy reference or make a deep copy?'**
  String get copyReferenceOrDeep;

  /// No description provided for @copyReference.
  ///
  /// In en, this message translates to:
  /// **'Copy reference'**
  String get copyReference;

  /// No description provided for @deepCopy.
  ///
  /// In en, this message translates to:
  /// **'Deep copy'**
  String get deepCopy;

  /// No description provided for @copyEventTarget.
  ///
  /// In en, this message translates to:
  /// **'Target wave'**
  String get copyEventTarget;

  /// No description provided for @targetWaveIndex.
  ///
  /// In en, this message translates to:
  /// **'Target wave index'**
  String get targetWaveIndex;

  /// No description provided for @moveToWaveIndex.
  ///
  /// In en, this message translates to:
  /// **'Move to wave index'**
  String get moveToWaveIndex;

  /// No description provided for @invalidWaveIndex.
  ///
  /// In en, this message translates to:
  /// **'Invalid wave index'**
  String get invalidWaveIndex;

  /// No description provided for @renamingFailed.
  ///
  /// In en, this message translates to:
  /// **'Renaming failed'**
  String get renamingFailed;

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

  /// No description provided for @movingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Moved successfully'**
  String get movingSuccess;

  /// No description provided for @movingFail.
  ///
  /// In en, this message translates to:
  /// **'Move failed'**
  String get movingFail;

  /// No description provided for @moveSameFolder.
  ///
  /// In en, this message translates to:
  /// **'Source and target are the same'**
  String get moveSameFolder;

  /// No description provided for @moveFileExistsTitle.
  ///
  /// In en, this message translates to:
  /// **'File already exists'**
  String get moveFileExistsTitle;

  /// No description provided for @moveFileExistsMessage.
  ///
  /// In en, this message translates to:
  /// **'A file with this name already exists in the destination folder.'**
  String get moveFileExistsMessage;

  /// No description provided for @moveOverwrite.
  ///
  /// In en, this message translates to:
  /// **'Overwrite'**
  String get moveOverwrite;

  /// No description provided for @fileOverwritten.
  ///
  /// In en, this message translates to:
  /// **'File was overwritten: {name}'**
  String fileOverwritten(Object name);

  /// No description provided for @moveSaveAsCopy.
  ///
  /// In en, this message translates to:
  /// **'Save as copy'**
  String get moveSaveAsCopy;

  /// No description provided for @moveCancelled.
  ///
  /// In en, this message translates to:
  /// **'Operation cancelled'**
  String get moveCancelled;

  /// No description provided for @movedAs.
  ///
  /// In en, this message translates to:
  /// **'Moved and saved as {name}'**
  String movedAs(Object name);

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

  /// No description provided for @stayInEditor.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stayInEditor;

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

  /// No description provided for @createEmptyWaveContainer.
  ///
  /// In en, this message translates to:
  /// **'Create empty wave container'**
  String get createEmptyWaveContainer;

  /// No description provided for @deleteEmptyContainer.
  ///
  /// In en, this message translates to:
  /// **'Delete empty container'**
  String get deleteEmptyContainer;

  /// No description provided for @deleteWaveContainerTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete wave container?'**
  String get deleteWaveContainerTitle;

  /// No description provided for @deleteWaveContainerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the empty wave container? You can create a new one later.'**
  String get deleteWaveContainerConfirm;

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

  /// No description provided for @noZombiesInLane.
  ///
  /// In en, this message translates to:
  /// **'No zombies in this lane'**
  String get noZombiesInLane;

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

  /// No description provided for @basicInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Basic info'**
  String get basicInfoSection;

  /// No description provided for @sceneSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'Scene settings'**
  String get sceneSettingsSection;

  /// No description provided for @restrictionsSection.
  ///
  /// In en, this message translates to:
  /// **'Restrictions'**
  String get restrictionsSection;

  /// No description provided for @victoryModuleWarning.
  ///
  /// In en, this message translates to:
  /// **'Using non-default victory modules may cause level crashes due to module conflicts. Use with caution.'**
  String get victoryModuleWarning;

  /// No description provided for @hintTextDisplay.
  ///
  /// In en, this message translates to:
  /// **'Text display (Description)'**
  String get hintTextDisplay;

  /// No description provided for @beatTheLevelDialogIntro.
  ///
  /// In en, this message translates to:
  /// **'Display hint text in a pop-up at the beginning of the level.'**
  String get beatTheLevelDialogIntro;

  /// No description provided for @beatTheLevelDialogHint.
  ///
  /// In en, this message translates to:
  /// **'Supports Chinese; for multi-line text enter newlines directly, no need for \\n. Note: hints cannot be viewed in iOS courtyard.'**
  String get beatTheLevelDialogHint;

  /// No description provided for @levelHintText.
  ///
  /// In en, this message translates to:
  /// **'Level hint text'**
  String get levelHintText;

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

  /// No description provided for @starChallengeNoConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Challenge'**
  String get starChallengeNoConfigTitle;

  /// No description provided for @starChallengeNoConfigMessage.
  ///
  /// In en, this message translates to:
  /// **'This challenge has no configurable parameters.'**
  String get starChallengeNoConfigMessage;

  /// No description provided for @starChallengeSaveMowersTitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t lose mowers'**
  String get starChallengeSaveMowersTitle;

  /// No description provided for @starChallengeSaveMowersNoConfigMessage.
  ///
  /// In en, this message translates to:
  /// **'This challenge has no configurable parameters.\n\nAll lawn mowers must remain intact at level end. Note: Yard module has no mowers by default.'**
  String get starChallengeSaveMowersNoConfigMessage;

  /// No description provided for @starChallengePlantFoodNonuseTitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t use plant food'**
  String get starChallengePlantFoodNonuseTitle;

  /// No description provided for @starChallengePlantFoodNonuseNoConfigMessage.
  ///
  /// In en, this message translates to:
  /// **'This challenge has no configurable parameters.\n\nPlant food use is prohibited.'**
  String get starChallengePlantFoodNonuseNoConfigMessage;

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

  /// No description provided for @moduleTitle_InitialPlantProperties.
  ///
  /// In en, this message translates to:
  /// **'Legacy Preset Plants'**
  String get moduleTitle_InitialPlantProperties;

  /// No description provided for @moduleDesc_InitialPlantProperties.
  ///
  /// In en, this message translates to:
  /// **'Legacy preset plants with frozen plant support'**
  String get moduleDesc_InitialPlantProperties;

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

  /// No description provided for @frozenPlantPlacementTitle.
  ///
  /// In en, this message translates to:
  /// **'Legacy Preset Plants'**
  String get frozenPlantPlacementTitle;

  /// No description provided for @frozenPlantPlacementLastStand.
  ///
  /// In en, this message translates to:
  /// **'Last Stand mode'**
  String get frozenPlantPlacementLastStand;

  /// No description provided for @frozenPlantPlacementSelectedPosition.
  ///
  /// In en, this message translates to:
  /// **'Selected position'**
  String get frozenPlantPlacementSelectedPosition;

  /// No description provided for @frozenPlantPlacementPlaceHere.
  ///
  /// In en, this message translates to:
  /// **'Add plant'**
  String get frozenPlantPlacementPlaceHere;

  /// No description provided for @frozenPlantPlacementPlantList.
  ///
  /// In en, this message translates to:
  /// **'Plant list (row-first)'**
  String get frozenPlantPlacementPlantList;

  /// No description provided for @frozenPlantPlacementEditPlant.
  ///
  /// In en, this message translates to:
  /// **'Edit {name}'**
  String frozenPlantPlacementEditPlant(Object name);

  /// No description provided for @frozenPlantPlacementLevel.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get frozenPlantPlacementLevel;

  /// No description provided for @frozenPlantPlacementCondition.
  ///
  /// In en, this message translates to:
  /// **'Condition'**
  String get frozenPlantPlacementCondition;

  /// No description provided for @frozenPlantPlacementConditionNull.
  ///
  /// In en, this message translates to:
  /// **'None (null)'**
  String get frozenPlantPlacementConditionNull;

  /// No description provided for @noConditions.
  ///
  /// In en, this message translates to:
  /// **'No conditions'**
  String get noConditions;

  /// No description provided for @frozenPlantPlacementHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Legacy Preset Plants - Help'**
  String get frozenPlantPlacementHelpTitle;

  /// No description provided for @frozenPlantPlacementHelpOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get frozenPlantPlacementHelpOverviewTitle;

  /// No description provided for @frozenPlantPlacementHelpOverviewBody.
  ///
  /// In en, this message translates to:
  /// **'This module configures plant layout before the level starts. Similar to preset plant layout but with a different structure and special state support.'**
  String get frozenPlantPlacementHelpOverviewBody;

  /// No description provided for @frozenPlantPlacementHelpConditionTitle.
  ///
  /// In en, this message translates to:
  /// **'Special State'**
  String get frozenPlantPlacementHelpConditionTitle;

  /// No description provided for @frozenPlantPlacementHelpConditionBody.
  ///
  /// In en, this message translates to:
  /// **'Plants can be set to frozen state, commonly used in Ice Age levels.'**
  String get frozenPlantPlacementHelpConditionBody;

  /// No description provided for @frozenPlantPlacementHelpLastStandTitle.
  ///
  /// In en, this message translates to:
  /// **'Last Stand Mode'**
  String get frozenPlantPlacementHelpLastStandTitle;

  /// No description provided for @frozenPlantPlacementHelpLastStandBody.
  ///
  /// In en, this message translates to:
  /// **'When Last Stand mode is enabled, initial plants will be destroyed after the game starts. Note: Chinese version does not show the plant destruction fire effect.'**
  String get frozenPlantPlacementHelpLastStandBody;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

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

  /// No description provided for @customZombie.
  ///
  /// In en, this message translates to:
  /// **'Custom zombie'**
  String get customZombie;

  /// No description provided for @customZombieProperties.
  ///
  /// In en, this message translates to:
  /// **'Custom zombie properties'**
  String get customZombieProperties;

  /// No description provided for @zombieTypeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Zombie type object not found.'**
  String get zombieTypeNotFound;

  /// No description provided for @propertyObjectNotFound.
  ///
  /// In en, this message translates to:
  /// **'Property object not found'**
  String get propertyObjectNotFound;

  /// No description provided for @propertyObjectNotFoundHint.
  ///
  /// In en, this message translates to:
  /// **'The custom zombie\'s property object ({alias}) was not found in the level. The property definition does not point to level internals, so it cannot be edited here.'**
  String propertyObjectNotFoundHint(Object alias);

  /// No description provided for @baseStats.
  ///
  /// In en, this message translates to:
  /// **'Base stats'**
  String get baseStats;

  /// No description provided for @hitpoints.
  ///
  /// In en, this message translates to:
  /// **'Hitpoints'**
  String get hitpoints;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// No description provided for @speedVariance.
  ///
  /// In en, this message translates to:
  /// **'Speed variance'**
  String get speedVariance;

  /// No description provided for @eatDPS.
  ///
  /// In en, this message translates to:
  /// **'EatDPS'**
  String get eatDPS;

  /// No description provided for @hitPosition.
  ///
  /// In en, this message translates to:
  /// **'Hit / position'**
  String get hitPosition;

  /// No description provided for @hitRect.
  ///
  /// In en, this message translates to:
  /// **'HitRect'**
  String get hitRect;

  /// No description provided for @editHitRect.
  ///
  /// In en, this message translates to:
  /// **'Edit HitRect'**
  String get editHitRect;

  /// No description provided for @attackRect.
  ///
  /// In en, this message translates to:
  /// **'AttackRect'**
  String get attackRect;

  /// No description provided for @editAttackRect.
  ///
  /// In en, this message translates to:
  /// **'Edit AttackRect'**
  String get editAttackRect;

  /// No description provided for @artCenter.
  ///
  /// In en, this message translates to:
  /// **'ArtCenter'**
  String get artCenter;

  /// No description provided for @editArtCenter.
  ///
  /// In en, this message translates to:
  /// **'Edit ArtCenter'**
  String get editArtCenter;

  /// No description provided for @shadowOffset.
  ///
  /// In en, this message translates to:
  /// **'ShadowOffset'**
  String get shadowOffset;

  /// No description provided for @editShadowOffset.
  ///
  /// In en, this message translates to:
  /// **'Edit ShadowOffset'**
  String get editShadowOffset;

  /// No description provided for @groundTrackName.
  ///
  /// In en, this message translates to:
  /// **'GroundTrackName (行进轨迹)'**
  String get groundTrackName;

  /// No description provided for @groundTrackNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal ground (ground_swatch)'**
  String get groundTrackNormal;

  /// No description provided for @groundTrackNone.
  ///
  /// In en, this message translates to:
  /// **'None (null)'**
  String get groundTrackNone;

  /// No description provided for @appearanceBehavior.
  ///
  /// In en, this message translates to:
  /// **'Appearance & behavior'**
  String get appearanceBehavior;

  /// No description provided for @sizeType.
  ///
  /// In en, this message translates to:
  /// **'SizeType'**
  String get sizeType;

  /// No description provided for @selectSize.
  ///
  /// In en, this message translates to:
  /// **'Select size'**
  String get selectSize;

  /// No description provided for @disableDropFractions.
  ///
  /// In en, this message translates to:
  /// **'Disable drop fractions'**
  String get disableDropFractions;

  /// No description provided for @immuneToKnockback.
  ///
  /// In en, this message translates to:
  /// **'Immune to knockback'**
  String get immuneToKnockback;

  /// No description provided for @showHealthBarOnDamage.
  ///
  /// In en, this message translates to:
  /// **'Show health bar on damage'**
  String get showHealthBarOnDamage;

  /// No description provided for @drawHealthBarTime.
  ///
  /// In en, this message translates to:
  /// **'DrawHealthBarTime'**
  String get drawHealthBarTime;

  /// No description provided for @enableEliteScale.
  ///
  /// In en, this message translates to:
  /// **'Enable elite scale'**
  String get enableEliteScale;

  /// No description provided for @eliteScale.
  ///
  /// In en, this message translates to:
  /// **'EliteScale'**
  String get eliteScale;

  /// No description provided for @enableEliteImmunities.
  ///
  /// In en, this message translates to:
  /// **'Enable elite immunities'**
  String get enableEliteImmunities;

  /// No description provided for @canSpawnPlantFood.
  ///
  /// In en, this message translates to:
  /// **'Can spawn plant food'**
  String get canSpawnPlantFood;

  /// No description provided for @canSurrender.
  ///
  /// In en, this message translates to:
  /// **'Can surrender'**
  String get canSurrender;

  /// No description provided for @canTriggerZombieWin.
  ///
  /// In en, this message translates to:
  /// **'Can trigger zombie win'**
  String get canTriggerZombieWin;

  /// No description provided for @resilience.
  ///
  /// In en, this message translates to:
  /// **'Resilience'**
  String get resilience;

  /// No description provided for @instantKillResistance.
  ///
  /// In en, this message translates to:
  /// **'Instant kill resistance'**
  String get instantKillResistance;

  /// No description provided for @resiliencePhysics.
  ///
  /// In en, this message translates to:
  /// **'Physics'**
  String get resiliencePhysics;

  /// No description provided for @resiliencePoison.
  ///
  /// In en, this message translates to:
  /// **'Poison'**
  String get resiliencePoison;

  /// No description provided for @resilienceElectric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get resilienceElectric;

  /// No description provided for @resilienceMagic.
  ///
  /// In en, this message translates to:
  /// **'Magic'**
  String get resilienceMagic;

  /// No description provided for @resilienceIce.
  ///
  /// In en, this message translates to:
  /// **'Ice'**
  String get resilienceIce;

  /// No description provided for @resilienceFire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get resilienceFire;

  /// No description provided for @resilienceHint.
  ///
  /// In en, this message translates to:
  /// **'0.0 = none, 1.0 = full immunity'**
  String get resilienceHint;

  /// No description provided for @zombieTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Zombie type: {type}'**
  String zombieTypeLabel(Object type);

  /// No description provided for @propertyAliasLabel.
  ///
  /// In en, this message translates to:
  /// **'Property alias: {alias}'**
  String propertyAliasLabel(Object alias);

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @width.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get width;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @customZombieHelpIntro.
  ///
  /// In en, this message translates to:
  /// **'Brief introduction'**
  String get customZombieHelpIntro;

  /// No description provided for @customZombieHelpIntroBody.
  ///
  /// In en, this message translates to:
  /// **'This screen edits custom zombie parameters injected into the level. Only common properties are supported; many special attributes require manual JSON editing.'**
  String get customZombieHelpIntroBody;

  /// No description provided for @customZombieHelpBase.
  ///
  /// In en, this message translates to:
  /// **'Base properties'**
  String get customZombieHelpBase;

  /// No description provided for @customZombieHelpBaseBody.
  ///
  /// In en, this message translates to:
  /// **'Custom zombies can modify base stats (HP, speed, eat damage). Custom zombies do not appear in the level preview pool.'**
  String get customZombieHelpBaseBody;

  /// No description provided for @customZombieHelpHit.
  ///
  /// In en, this message translates to:
  /// **'Hit/position'**
  String get customZombieHelpHit;

  /// No description provided for @customZombieHelpHitBody.
  ///
  /// In en, this message translates to:
  /// **'X and Y are offsets; W and H are width and height. Offsetting ArtCenter can hide the zombie sprite. Leaving ground track empty lets the zombie walk in place.'**
  String get customZombieHelpHitBody;

  /// No description provided for @customZombieHelpManual.
  ///
  /// In en, this message translates to:
  /// **'Manual editing'**
  String get customZombieHelpManual;

  /// No description provided for @customZombieHelpManualBody.
  ///
  /// In en, this message translates to:
  /// **'Custom injection auto-fills all properties from game files. You can further edit the JSON file manually if needed.'**
  String get customZombieHelpManualBody;

  /// No description provided for @editAlias.
  ///
  /// In en, this message translates to:
  /// **'Edit {alias}'**
  String editAlias(Object alias);

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// No description provided for @right.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get right;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @maxCount.
  ///
  /// In en, this message translates to:
  /// **'Max count'**
  String get maxCount;

  /// No description provided for @startColumn.
  ///
  /// In en, this message translates to:
  /// **'Start column'**
  String get startColumn;

  /// No description provided for @endColumn.
  ///
  /// In en, this message translates to:
  /// **'End column'**
  String get endColumn;

  /// No description provided for @removeItem.
  ///
  /// In en, this message translates to:
  /// **'Remove item'**
  String get removeItem;

  /// No description provided for @removeItemConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove {name}?'**
  String removeItemConfirm(Object name);

  /// No description provided for @groupN.
  ///
  /// In en, this message translates to:
  /// **'Group {n}'**
  String groupN(int n);

  /// No description provided for @rowN.
  ///
  /// In en, this message translates to:
  /// **'Row {n}'**
  String rowN(int n);

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get addItem;

  /// No description provided for @addWind.
  ///
  /// In en, this message translates to:
  /// **'Add wind'**
  String get addWind;

  /// No description provided for @addDropItem.
  ///
  /// In en, this message translates to:
  /// **'Add drop item'**
  String get addDropItem;

  /// No description provided for @addMirrorGroup.
  ///
  /// In en, this message translates to:
  /// **'Add a mirror group above'**
  String get addMirrorGroup;

  /// No description provided for @pipeN.
  ///
  /// In en, this message translates to:
  /// **'Pipe {n}'**
  String pipeN(int n);

  /// No description provided for @setStart.
  ///
  /// In en, this message translates to:
  /// **'Set start'**
  String get setStart;

  /// No description provided for @setEnd.
  ///
  /// In en, this message translates to:
  /// **'Set end'**
  String get setEnd;

  /// No description provided for @collectable.
  ///
  /// In en, this message translates to:
  /// **'Collectable (Plant Food)'**
  String get collectable;

  /// No description provided for @selectGridItem.
  ///
  /// In en, this message translates to:
  /// **'Select grid item'**
  String get selectGridItem;

  /// No description provided for @addItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get addItemTitle;

  /// No description provided for @initialPlantLayout.
  ///
  /// In en, this message translates to:
  /// **'Initial plant layout'**
  String get initialPlantLayout;

  /// No description provided for @gridItemLayout.
  ///
  /// In en, this message translates to:
  /// **'Grid item layout'**
  String get gridItemLayout;

  /// No description provided for @zombieCount.
  ///
  /// In en, this message translates to:
  /// **'Zombie count'**
  String get zombieCount;

  /// No description provided for @groupSize.
  ///
  /// In en, this message translates to:
  /// **'Group size'**
  String get groupSize;

  /// No description provided for @timeBetweenGroups.
  ///
  /// In en, this message translates to:
  /// **'Time between groups'**
  String get timeBetweenGroups;

  /// No description provided for @timeBeforeSpawn.
  ///
  /// In en, this message translates to:
  /// **'Time before spawn (s)'**
  String get timeBeforeSpawn;

  /// No description provided for @waterBoundaryColumn.
  ///
  /// In en, this message translates to:
  /// **'Water boundary column'**
  String get waterBoundaryColumn;

  /// No description provided for @columnsDragged.
  ///
  /// In en, this message translates to:
  /// **'Columns dragged (ColNumPlantIsDragged)'**
  String get columnsDragged;

  /// No description provided for @typeIndex.
  ///
  /// In en, this message translates to:
  /// **'Type index'**
  String get typeIndex;

  /// No description provided for @styleN.
  ///
  /// In en, this message translates to:
  /// **'Style {n}'**
  String styleN(int n);

  /// No description provided for @existDurationSec.
  ///
  /// In en, this message translates to:
  /// **'Exist duration (sec)'**
  String get existDurationSec;

  /// No description provided for @mirror1.
  ///
  /// In en, this message translates to:
  /// **'Mirror 1'**
  String get mirror1;

  /// No description provided for @mirror2.
  ///
  /// In en, this message translates to:
  /// **'Mirror 2'**
  String get mirror2;

  /// No description provided for @ignoreGravestone.
  ///
  /// In en, this message translates to:
  /// **'Ignore gravestone (IgnoreGraveStone)'**
  String get ignoreGravestone;

  /// No description provided for @zombiePreview.
  ///
  /// In en, this message translates to:
  /// **'{name} - Zombie preview'**
  String zombiePreview(Object name);

  /// No description provided for @weatherSettings.
  ///
  /// In en, this message translates to:
  /// **'Weather settings'**
  String get weatherSettings;

  /// No description provided for @holeLifetimeSeconds.
  ///
  /// In en, this message translates to:
  /// **'Hole lifetime (seconds)'**
  String get holeLifetimeSeconds;

  /// No description provided for @startingWaveLocation.
  ///
  /// In en, this message translates to:
  /// **'Starting wave location'**
  String get startingWaveLocation;

  /// No description provided for @rainIntervalSeconds.
  ///
  /// In en, this message translates to:
  /// **'Rain interval (seconds)'**
  String get rainIntervalSeconds;

  /// No description provided for @startingPlantFood.
  ///
  /// In en, this message translates to:
  /// **'Starting plant food'**
  String get startingPlantFood;

  /// No description provided for @bowlingFoulLine.
  ///
  /// In en, this message translates to:
  /// **'Bowling foul line (BowlingFoulLine)'**
  String get bowlingFoulLine;

  /// No description provided for @stopColumn.
  ///
  /// In en, this message translates to:
  /// **'Stop column (StopColumn)'**
  String get stopColumn;

  /// No description provided for @speedUp.
  ///
  /// In en, this message translates to:
  /// **'Speed up (SpeedUp)'**
  String get speedUp;

  /// No description provided for @baseCostIncreased.
  ///
  /// In en, this message translates to:
  /// **'Base cost increase (BaseCostIncreased)'**
  String get baseCostIncreased;

  /// No description provided for @maxIncreasedCount.
  ///
  /// In en, this message translates to:
  /// **'Max increase count (MaxIncreasedCount)'**
  String get maxIncreasedCount;

  /// No description provided for @initialMistPositionX.
  ///
  /// In en, this message translates to:
  /// **'Initial mist position X'**
  String get initialMistPositionX;

  /// No description provided for @normalValueX.
  ///
  /// In en, this message translates to:
  /// **'Normal value X'**
  String get normalValueX;

  /// No description provided for @bloverEffectInterval.
  ///
  /// In en, this message translates to:
  /// **'Blover effect interval (seconds)'**
  String get bloverEffectInterval;

  /// No description provided for @dinoType.
  ///
  /// In en, this message translates to:
  /// **'Dino type'**
  String get dinoType;

  /// No description provided for @dinoRow.
  ///
  /// In en, this message translates to:
  /// **'Row (DinoRow): {n}'**
  String dinoRow(int n);

  /// No description provided for @dinoWaveDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration (DinoWaveDuration)'**
  String get dinoWaveDuration;

  /// No description provided for @unknownModuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Module editor in development'**
  String get unknownModuleTitle;

  /// No description provided for @unknownModuleHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Unknown module'**
  String get unknownModuleHelpTitle;

  /// No description provided for @unknownModuleHelpBody.
  ///
  /// In en, this message translates to:
  /// **'This module is not registered in the level interpreter. It may be manually modified objclass.'**
  String get unknownModuleHelpBody;

  /// No description provided for @noEditorForModule.
  ///
  /// In en, this message translates to:
  /// **'No editor available for this module'**
  String get noEditorForModule;

  /// No description provided for @noEditorForModuleBody.
  ///
  /// In en, this message translates to:
  /// **'This module is not registered in the level parser. It may have been added manually or the objclass was changed.'**
  String get noEditorForModuleBody;

  /// No description provided for @invalidEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid event'**
  String get invalidEventTitle;

  /// No description provided for @invalidEventBody.
  ///
  /// In en, this message translates to:
  /// **'This event object could not be parsed.'**
  String get invalidEventBody;

  /// No description provided for @invalidReference.
  ///
  /// In en, this message translates to:
  /// **'Invalid reference'**
  String get invalidReference;

  /// No description provided for @aliasNotFound.
  ///
  /// In en, this message translates to:
  /// **'Alias \"{alias}\" not found'**
  String aliasNotFound(Object alias);

  /// No description provided for @invalidRefBody.
  ///
  /// In en, this message translates to:
  /// **'Wave {wave} references this event, but no matching entity exists. Keeping it will cause a crash.'**
  String invalidRefBody(int wave);

  /// No description provided for @removeInvalidRef.
  ///
  /// In en, this message translates to:
  /// **'Remove this invalid reference from wave'**
  String get removeInvalidRef;

  /// No description provided for @spawnCount.
  ///
  /// In en, this message translates to:
  /// **'Spawn count'**
  String get spawnCount;

  /// No description provided for @columnRangeTiming.
  ///
  /// In en, this message translates to:
  /// **'Column range & timing'**
  String get columnRangeTiming;

  /// No description provided for @waveStartMessage.
  ///
  /// In en, this message translates to:
  /// **'Wave start message'**
  String get waveStartMessage;

  /// No description provided for @zombieTypeZombieName.
  ///
  /// In en, this message translates to:
  /// **'Zombie type (ZombieName)'**
  String get zombieTypeZombieName;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @eventHelpBeachStageBody.
  ///
  /// In en, this message translates to:
  /// **'Zombies spawn at low tide. Used for Pirate Seas.'**
  String get eventHelpBeachStageBody;

  /// No description provided for @eventHelpTidalChangeBody.
  ///
  /// In en, this message translates to:
  /// **'This event changes the tide position during a wave.'**
  String get eventHelpTidalChangeBody;

  /// No description provided for @eventHelpTidalChangePosition.
  ///
  /// In en, this message translates to:
  /// **'Column 0 is rightmost, 9 is leftmost. ChangeAmount sets the water boundary.'**
  String get eventHelpTidalChangePosition;

  /// No description provided for @eventHelpBlackHoleBody.
  ///
  /// In en, this message translates to:
  /// **'Kongfu world event. Black hole attracts plants to the right.'**
  String get eventHelpBlackHoleBody;

  /// No description provided for @eventHelpBlackHoleColumns.
  ///
  /// In en, this message translates to:
  /// **'Number of columns plants are dragged by the black hole.'**
  String get eventHelpBlackHoleColumns;

  /// No description provided for @eventHelpMagicMirrorBody.
  ///
  /// In en, this message translates to:
  /// **'Magic mirrors create paired portals on the field.'**
  String get eventHelpMagicMirrorBody;

  /// No description provided for @eventHelpMagicMirrorType.
  ///
  /// In en, this message translates to:
  /// **'Type index changes mirror appearance. Three styles available.'**
  String get eventHelpMagicMirrorType;

  /// No description provided for @eventHelpParachuteRainBody.
  ///
  /// In en, this message translates to:
  /// **'Zombies drop from the sky during a wave.'**
  String get eventHelpParachuteRainBody;

  /// No description provided for @eventHelpParachuteRainLogic.
  ///
  /// In en, this message translates to:
  /// **'Zombies spawn in batches. Control total count, batch size, column range, and timing.'**
  String get eventHelpParachuteRainLogic;

  /// No description provided for @eventHelpModernPortalsBody.
  ///
  /// In en, this message translates to:
  /// **'Spawns time rift portals on the field, common in Modern world.'**
  String get eventHelpModernPortalsBody;

  /// No description provided for @eventHelpModernPortalsType.
  ///
  /// In en, this message translates to:
  /// **'Many portal types exist; choose the specific type.'**
  String get eventHelpModernPortalsType;

  /// No description provided for @eventHelpModernPortalsIgnore.
  ///
  /// In en, this message translates to:
  /// **'When enabled, portals spawn even if blocked by gravestones.'**
  String get eventHelpModernPortalsIgnore;

  /// No description provided for @eventHelpFrostWindBody.
  ///
  /// In en, this message translates to:
  /// **'Ice Age event. Freezing wind freezes plants on specified rows.'**
  String get eventHelpFrostWindBody;

  /// No description provided for @eventHelpFrostWindDirection.
  ///
  /// In en, this message translates to:
  /// **'Set wind direction: left or right.'**
  String get eventHelpFrostWindDirection;

  /// No description provided for @eventHelpModifyConveyorBody.
  ///
  /// In en, this message translates to:
  /// **'Change conveyor belt configuration during a wave. Add or remove plants.'**
  String get eventHelpModifyConveyorBody;

  /// No description provided for @eventHelpModifyConveyorAdd.
  ///
  /// In en, this message translates to:
  /// **'Add plants to the conveyor belt.'**
  String get eventHelpModifyConveyorAdd;

  /// No description provided for @eventHelpModifyConveyorRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove plants from the conveyor belt.'**
  String get eventHelpModifyConveyorRemove;

  /// No description provided for @eventHelpDinoBody.
  ///
  /// In en, this message translates to:
  /// **'Dino Crisis event. Summon a dinosaur on the specified row to assist zombies.'**
  String get eventHelpDinoBody;

  /// No description provided for @eventHelpDinoDuration.
  ///
  /// In en, this message translates to:
  /// **'How long the dinosaur stays, in waves.'**
  String get eventHelpDinoDuration;

  /// No description provided for @eventHelpZombiePotionBody.
  ///
  /// In en, this message translates to:
  /// **'Spawns potions on the grid, can overlap plants.'**
  String get eventHelpZombiePotionBody;

  /// No description provided for @eventHelpZombiePotionUsage.
  ///
  /// In en, this message translates to:
  /// **'Select grid position, tap add item, choose potion type.'**
  String get eventHelpZombiePotionUsage;

  /// No description provided for @eventHelpFairyFogBody.
  ///
  /// In en, this message translates to:
  /// **'Spawns fog that gives zombies shields. Only fairy wind can clear it.'**
  String get eventHelpFairyFogBody;

  /// No description provided for @eventHelpFairyFogRange.
  ///
  /// In en, this message translates to:
  /// **'mX, mY are center; mWidth, mHeight extend right and down.'**
  String get eventHelpFairyFogRange;

  /// No description provided for @eventHelpFairyWindBody.
  ///
  /// In en, this message translates to:
  /// **'Creates wind to blow away fairy fog.'**
  String get eventHelpFairyWindBody;

  /// No description provided for @eventHelpFairyWindVelocity.
  ///
  /// In en, this message translates to:
  /// **'Changes projectile speed. 1.0 = original, higher = faster.'**
  String get eventHelpFairyWindVelocity;

  /// No description provided for @eventHelpRaidingPartyBody.
  ///
  /// In en, this message translates to:
  /// **'Pirate event. Swashbuckler zombies spawn in batches.'**
  String get eventHelpRaidingPartyBody;

  /// No description provided for @eventHelpRaidingPartyGroup.
  ///
  /// In en, this message translates to:
  /// **'Zombies per group.'**
  String get eventHelpRaidingPartyGroup;

  /// No description provided for @eventHelpRaidingPartyCount.
  ///
  /// In en, this message translates to:
  /// **'Total swashbuckler count.'**
  String get eventHelpRaidingPartyCount;

  /// No description provided for @eventHelpGravestoneBody.
  ///
  /// In en, this message translates to:
  /// **'Randomly spawns obstacles during a wave (e.g. gravestones).'**
  String get eventHelpGravestoneBody;

  /// No description provided for @eventHelpGravestoneLogic.
  ///
  /// In en, this message translates to:
  /// **'Picks random cells from position pool. Total items must not exceed positions.'**
  String get eventHelpGravestoneLogic;

  /// No description provided for @eventHelpGravestoneMissingAssets.
  ///
  /// In en, this message translates to:
  /// **'Some maps without gravestone spawn effects may show sun textures instead.'**
  String get eventHelpGravestoneMissingAssets;

  /// No description provided for @eventHelpGraveSpawnBody.
  ///
  /// In en, this message translates to:
  /// **'This event spawns zombies from specific grid item types, commonly used in Dark Ages levels.'**
  String get eventHelpGraveSpawnBody;

  /// No description provided for @eventHelpGraveSpawnWait.
  ///
  /// In en, this message translates to:
  /// **'Delay from wave start to zombie spawn.'**
  String get eventHelpGraveSpawnWait;

  /// No description provided for @eventHelpStormBody.
  ///
  /// In en, this message translates to:
  /// **'Sandstorm or blizzard teleports zombies to the front.'**
  String get eventHelpStormBody;

  /// No description provided for @eventHelpStormColumns.
  ///
  /// In en, this message translates to:
  /// **'Column 0 = left, 9 = right. Start < end.'**
  String get eventHelpStormColumns;

  /// No description provided for @eventHelpStormLevels.
  ///
  /// In en, this message translates to:
  /// **'Storm zombies support level 1-10.'**
  String get eventHelpStormLevels;

  /// No description provided for @eventHelpGroundSpawnBody.
  ///
  /// In en, this message translates to:
  /// **'Configure zombies that spawn in this wave.'**
  String get eventHelpGroundSpawnBody;

  /// No description provided for @moduleHelpTideBody.
  ///
  /// In en, this message translates to:
  /// **'Enables tide system and sets initial tide position.'**
  String get moduleHelpTideBody;

  /// No description provided for @moduleHelpTidePosition.
  ///
  /// In en, this message translates to:
  /// **'Right edge is 0, left edge is 9. Negative values allowed.'**
  String get moduleHelpTidePosition;

  /// No description provided for @initialTidePosition.
  ///
  /// In en, this message translates to:
  /// **'Initial tide position'**
  String get initialTidePosition;

  /// No description provided for @moduleHelpManholeBody.
  ///
  /// In en, this message translates to:
  /// **'Defines underground pipeline links used in Steam Age.'**
  String get moduleHelpManholeBody;

  /// No description provided for @moduleHelpManholeEdit.
  ///
  /// In en, this message translates to:
  /// **'Toggle start/end mode, then tap grid to place.'**
  String get moduleHelpManholeEdit;

  /// No description provided for @moduleHelpWeatherBody.
  ///
  /// In en, this message translates to:
  /// **'Controls global weather effects (rain, snow, darkness).'**
  String get moduleHelpWeatherBody;

  /// No description provided for @moduleHelpWeatherRef.
  ///
  /// In en, this message translates to:
  /// **'These options reference LevelModules.'**
  String get moduleHelpWeatherRef;

  /// No description provided for @moduleHelpZombiePotionBody.
  ///
  /// In en, this message translates to:
  /// **'Potions spawn over time until reaching max count.'**
  String get moduleHelpZombiePotionBody;

  /// No description provided for @moduleHelpZombiePotionTypes.
  ///
  /// In en, this message translates to:
  /// **'Potions are chosen randomly from the list.'**
  String get moduleHelpZombiePotionTypes;

  /// No description provided for @moduleHelpUnknownBody.
  ///
  /// In en, this message translates to:
  /// **'Level files consist of root nodes and modules. Each object has aliases, objclass, objdata.'**
  String get moduleHelpUnknownBody;

  /// No description provided for @moduleHelpUnknownEvents.
  ///
  /// In en, this message translates to:
  /// **'The app parses modules by objclass. This module is not registered.'**
  String get moduleHelpUnknownEvents;

  /// No description provided for @eventHelpInvalidBody.
  ///
  /// In en, this message translates to:
  /// **'This event is referenced but the parser cannot find its entity. RTID points to nothing.'**
  String get eventHelpInvalidBody;

  /// No description provided for @eventHelpInvalidImpact.
  ///
  /// In en, this message translates to:
  /// **'Keeping this reference will cause the game to crash. Remove it manually.'**
  String get eventHelpInvalidImpact;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @editing.
  ///
  /// In en, this message translates to:
  /// **'Editing'**
  String get editing;

  /// No description provided for @logic.
  ///
  /// In en, this message translates to:
  /// **'Logic'**
  String get logic;

  /// No description provided for @impact.
  ///
  /// In en, this message translates to:
  /// **'Impact'**
  String get impact;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @referenceModules.
  ///
  /// In en, this message translates to:
  /// **'Reference modules'**
  String get referenceModules;

  /// No description provided for @portalType.
  ///
  /// In en, this message translates to:
  /// **'Portal type'**
  String get portalType;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get direction;

  /// No description provided for @velocityScale.
  ///
  /// In en, this message translates to:
  /// **'Velocity scale'**
  String get velocityScale;

  /// No description provided for @range.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get range;

  /// No description provided for @columnRange.
  ///
  /// In en, this message translates to:
  /// **'Column range'**
  String get columnRange;

  /// No description provided for @zombieLevels.
  ///
  /// In en, this message translates to:
  /// **'Zombie levels'**
  String get zombieLevels;

  /// No description provided for @missingAssets.
  ///
  /// In en, this message translates to:
  /// **'Missing assets'**
  String get missingAssets;

  /// No description provided for @usage.
  ///
  /// In en, this message translates to:
  /// **'Usage'**
  String get usage;

  /// No description provided for @types.
  ///
  /// In en, this message translates to:
  /// **'Types'**
  String get types;

  /// No description provided for @eventBlackHole.
  ///
  /// In en, this message translates to:
  /// **'Black hole event'**
  String get eventBlackHole;

  /// No description provided for @attractionConfig.
  ///
  /// In en, this message translates to:
  /// **'Attraction config'**
  String get attractionConfig;

  /// No description provided for @selectedPosition.
  ///
  /// In en, this message translates to:
  /// **'Selected position'**
  String get selectedPosition;

  /// No description provided for @placePlant.
  ///
  /// In en, this message translates to:
  /// **'Place plant'**
  String get placePlant;

  /// No description provided for @plantList.
  ///
  /// In en, this message translates to:
  /// **'Plant list (row-first)'**
  String get plantList;

  /// No description provided for @firstCostume.
  ///
  /// In en, this message translates to:
  /// **'First costume (Avatar)'**
  String get firstCostume;

  /// No description provided for @eventMagicMirror.
  ///
  /// In en, this message translates to:
  /// **'Magic mirror event'**
  String get eventMagicMirror;

  /// No description provided for @eventParachuteRain.
  ///
  /// In en, this message translates to:
  /// **'Parachute/Bass/Spider rain event'**
  String get eventParachuteRain;

  /// No description provided for @manholePipeline.
  ///
  /// In en, this message translates to:
  /// **'Manhole pipeline'**
  String get manholePipeline;

  /// No description provided for @manholePipelines.
  ///
  /// In en, this message translates to:
  /// **'Manhole pipelines'**
  String get manholePipelines;

  /// No description provided for @manholePipelineHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'Defines underground pipeline links used in Steam Age.'**
  String get manholePipelineHelpOverview;

  /// No description provided for @manholePipelineHelpEditing.
  ///
  /// In en, this message translates to:
  /// **'Toggle start/end mode, then tap grid to place.'**
  String get manholePipelineHelpEditing;

  /// No description provided for @manholePipelineStartEndFormat.
  ///
  /// In en, this message translates to:
  /// **'Start: ({sx}, {sy})  End: ({ex}, {ey})'**
  String manholePipelineStartEndFormat(int sx, int sy, int ex, int ey);

  /// No description provided for @piratePlank.
  ///
  /// In en, this message translates to:
  /// **'Pirate plank'**
  String get piratePlank;

  /// No description provided for @weatherModule.
  ///
  /// In en, this message translates to:
  /// **'Weather module'**
  String get weatherModule;

  /// No description provided for @zombiePotion.
  ///
  /// In en, this message translates to:
  /// **'Zombie potion'**
  String get zombiePotion;

  /// No description provided for @eventTimeRift.
  ///
  /// In en, this message translates to:
  /// **'Time rift event'**
  String get eventTimeRift;

  /// No description provided for @deathHole.
  ///
  /// In en, this message translates to:
  /// **'Death Hole'**
  String get deathHole;

  /// No description provided for @seedRain.
  ///
  /// In en, this message translates to:
  /// **'Seed rain'**
  String get seedRain;

  /// No description provided for @eventFrostWind.
  ///
  /// In en, this message translates to:
  /// **'Frost wind event'**
  String get eventFrostWind;

  /// No description provided for @lastStandSettings.
  ///
  /// In en, this message translates to:
  /// **'Last stand settings'**
  String get lastStandSettings;

  /// No description provided for @roofFlowerPot.
  ///
  /// In en, this message translates to:
  /// **'Roof flower pot'**
  String get roofFlowerPot;

  /// No description provided for @eventConveyorModify.
  ///
  /// In en, this message translates to:
  /// **'Conveyor modify event'**
  String get eventConveyorModify;

  /// No description provided for @bowlingMinigame.
  ///
  /// In en, this message translates to:
  /// **'Bowling Minigame'**
  String get bowlingMinigame;

  /// No description provided for @zombieMoveFast.
  ///
  /// In en, this message translates to:
  /// **'Zombie Move Fast'**
  String get zombieMoveFast;

  /// No description provided for @eventPotionDrop.
  ///
  /// In en, this message translates to:
  /// **'Potion drop event'**
  String get eventPotionDrop;

  /// No description provided for @warMist.
  ///
  /// In en, this message translates to:
  /// **'War mist'**
  String get warMist;

  /// No description provided for @eventDino.
  ///
  /// In en, this message translates to:
  /// **'Dino event'**
  String get eventDino;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @sunDropper.
  ///
  /// In en, this message translates to:
  /// **'Sun dropper'**
  String get sunDropper;

  /// No description provided for @eventFairyWind.
  ///
  /// In en, this message translates to:
  /// **'Fairy wind event'**
  String get eventFairyWind;

  /// No description provided for @eventFairyFog.
  ///
  /// In en, this message translates to:
  /// **'Fairy fog event'**
  String get eventFairyFog;

  /// No description provided for @eventRaidingParty.
  ///
  /// In en, this message translates to:
  /// **'Raiding party event'**
  String get eventRaidingParty;

  /// No description provided for @swashbucklerCount.
  ///
  /// In en, this message translates to:
  /// **'Swashbuckler count'**
  String get swashbucklerCount;

  /// No description provided for @sunBomb.
  ///
  /// In en, this message translates to:
  /// **'Sun bomb'**
  String get sunBomb;

  /// No description provided for @eventSpawnGravestones.
  ///
  /// In en, this message translates to:
  /// **'Spawn gravestones event'**
  String get eventSpawnGravestones;

  /// No description provided for @eventGraveSpawn.
  ///
  /// In en, this message translates to:
  /// **'Grave spawn event'**
  String get eventGraveSpawn;

  /// No description provided for @zombieSpawnWait.
  ///
  /// In en, this message translates to:
  /// **'Zombie spawn wait'**
  String get zombieSpawnWait;

  /// No description provided for @selectCustomZombie.
  ///
  /// In en, this message translates to:
  /// **'Select custom zombie'**
  String get selectCustomZombie;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @autoLevel.
  ///
  /// In en, this message translates to:
  /// **'Auto level'**
  String get autoLevel;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @applyBatchLevel.
  ///
  /// In en, this message translates to:
  /// **'Apply batch level?'**
  String get applyBatchLevel;

  /// No description provided for @conveyorBelt.
  ///
  /// In en, this message translates to:
  /// **'Conveyor belt'**
  String get conveyorBelt;

  /// No description provided for @starChallenges.
  ///
  /// In en, this message translates to:
  /// **'Star Challenges'**
  String get starChallenges;

  /// No description provided for @addChallenge.
  ///
  /// In en, this message translates to:
  /// **'Add Challenge'**
  String get addChallenge;

  /// No description provided for @unknownChallengeType.
  ///
  /// In en, this message translates to:
  /// **'Unknown challenge type'**
  String get unknownChallengeType;

  /// No description provided for @protectedPlants.
  ///
  /// In en, this message translates to:
  /// **'Protected Plants'**
  String get protectedPlants;

  /// No description provided for @addPlant.
  ///
  /// In en, this message translates to:
  /// **'Add Plant'**
  String get addPlant;

  /// No description provided for @protectedGridItems.
  ///
  /// In en, this message translates to:
  /// **'Protected Grid Items'**
  String get protectedGridItems;

  /// No description provided for @addGridItem.
  ///
  /// In en, this message translates to:
  /// **'Add Grid Item'**
  String get addGridItem;

  /// No description provided for @spawnTimer.
  ///
  /// In en, this message translates to:
  /// **'Spawn timer'**
  String get spawnTimer;

  /// No description provided for @plantLevels.
  ///
  /// In en, this message translates to:
  /// **'Plant levels'**
  String get plantLevels;

  /// No description provided for @globalPlantLevels.
  ///
  /// In en, this message translates to:
  /// **'Global plant levels'**
  String get globalPlantLevels;

  /// No description provided for @scope.
  ///
  /// In en, this message translates to:
  /// **'Scope'**
  String get scope;

  /// No description provided for @applyBatch.
  ///
  /// In en, this message translates to:
  /// **'Apply batch'**
  String get applyBatch;

  /// No description provided for @addPlants.
  ///
  /// In en, this message translates to:
  /// **'Add plants'**
  String get addPlants;

  /// No description provided for @noPlantsConfigured.
  ///
  /// In en, this message translates to:
  /// **'No plants configured'**
  String get noPlantsConfigured;

  /// No description provided for @batchLevelFormat.
  ///
  /// In en, this message translates to:
  /// **'Batch level: {level}'**
  String batchLevelFormat(int level);

  /// No description provided for @protectPlants.
  ///
  /// In en, this message translates to:
  /// **'Protect plants'**
  String get protectPlants;

  /// No description provided for @protectItems.
  ///
  /// In en, this message translates to:
  /// **'Protect items'**
  String get protectItems;

  /// No description provided for @autoCount.
  ///
  /// In en, this message translates to:
  /// **'Auto count'**
  String get autoCount;

  /// No description provided for @overrideStartingPlantfood.
  ///
  /// In en, this message translates to:
  /// **'Override Starting Plantfood'**
  String get overrideStartingPlantfood;

  /// No description provided for @startingPlantfoodOverride.
  ///
  /// In en, this message translates to:
  /// **'Starting Plantfood Override'**
  String get startingPlantfoodOverride;

  /// No description provided for @iconText.
  ///
  /// In en, this message translates to:
  /// **'Icon Text'**
  String get iconText;

  /// No description provided for @iconImage.
  ///
  /// In en, this message translates to:
  /// **'Icon Image'**
  String get iconImage;

  /// No description provided for @overrideMaxSun.
  ///
  /// In en, this message translates to:
  /// **'Override Max Sun'**
  String get overrideMaxSun;

  /// No description provided for @maxSunOverride.
  ///
  /// In en, this message translates to:
  /// **'Max Sun Override'**
  String get maxSunOverride;

  /// No description provided for @maxSunHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Max Sun Module'**
  String get maxSunHelpTitle;

  /// No description provided for @maxSunHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'This module was originally used to control different difficulty levels in Panchase. Use it to override the maximum sun that can be stored in the level.'**
  String get maxSunHelpOverview;

  /// No description provided for @startingPlantfoodHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Starting Plantfood Module'**
  String get startingPlantfoodHelpTitle;

  /// No description provided for @startingPlantfoodHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'This module was originally used to control different difficulty levels in Panchase. Use it to override the initial plant food carried at level start.'**
  String get startingPlantfoodHelpOverview;

  /// No description provided for @starChallengeHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Star Challenge Module'**
  String get starChallengeHelpTitle;

  /// No description provided for @starChallengeHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'Select challenge modules used in the level here. You can set multiple challenge goals and use the same challenge type multiple times.'**
  String get starChallengeHelpOverview;

  /// No description provided for @starChallengeHelpSuggestionTitle.
  ///
  /// In en, this message translates to:
  /// **'Optimization suggestion'**
  String get starChallengeHelpSuggestionTitle;

  /// No description provided for @starChallengeHelpSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Some challenges have in-game progress stat boxes. When there are too many challenge modules, stat boxes may overlap.'**
  String get starChallengeHelpSuggestion;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @plant.
  ///
  /// In en, this message translates to:
  /// **'Plant'**
  String get plant;

  /// No description provided for @zombie.
  ///
  /// In en, this message translates to:
  /// **'Zombie'**
  String get zombie;

  /// No description provided for @initialZombieLayout.
  ///
  /// In en, this message translates to:
  /// **'Initial zombie layout'**
  String get initialZombieLayout;

  /// No description provided for @placeZombie.
  ///
  /// In en, this message translates to:
  /// **'Place zombie'**
  String get placeZombie;

  /// No description provided for @manualInput.
  ///
  /// In en, this message translates to:
  /// **'Manual input'**
  String get manualInput;

  /// No description provided for @waveManagerModule.
  ///
  /// In en, this message translates to:
  /// **'Wave manager module'**
  String get waveManagerModule;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @eventStorm.
  ///
  /// In en, this message translates to:
  /// **'Storm event'**
  String get eventStorm;

  /// No description provided for @row.
  ///
  /// In en, this message translates to:
  /// **'Row'**
  String get row;

  /// No description provided for @addType.
  ///
  /// In en, this message translates to:
  /// **'Add type'**
  String get addType;

  /// No description provided for @plantFunExperimental.
  ///
  /// In en, this message translates to:
  /// **'Plant (Fun/Experimental)'**
  String get plantFunExperimental;

  /// No description provided for @availableZombies.
  ///
  /// In en, this message translates to:
  /// **'Available zombies'**
  String get availableZombies;

  /// No description provided for @presetPlants.
  ///
  /// In en, this message translates to:
  /// **'Preset plants (PresetPlantList)'**
  String get presetPlants;

  /// No description provided for @whiteList.
  ///
  /// In en, this message translates to:
  /// **'White list (WhiteList)'**
  String get whiteList;

  /// No description provided for @blackList.
  ///
  /// In en, this message translates to:
  /// **'Black list (BlackList)'**
  String get blackList;

  /// No description provided for @chooser.
  ///
  /// In en, this message translates to:
  /// **'Chooser'**
  String get chooser;

  /// No description provided for @preset.
  ///
  /// In en, this message translates to:
  /// **'Preset'**
  String get preset;

  /// No description provided for @seedBankHelp.
  ///
  /// In en, this message translates to:
  /// **'Seed bank help'**
  String get seedBankHelp;

  /// No description provided for @conveyorBeltHelp.
  ///
  /// In en, this message translates to:
  /// **'Conveyor belt help'**
  String get conveyorBeltHelp;

  /// No description provided for @dropDelayConditions.
  ///
  /// In en, this message translates to:
  /// **'Drop delay (DropDelayConditions)'**
  String get dropDelayConditions;

  /// No description provided for @unitSeconds.
  ///
  /// In en, this message translates to:
  /// **'Unit: seconds'**
  String get unitSeconds;

  /// No description provided for @speedConditions.
  ///
  /// In en, this message translates to:
  /// **'Speed (SpeedConditions)'**
  String get speedConditions;

  /// No description provided for @speedConditionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Standard value 100, higher = faster'**
  String get speedConditionsSubtitle;

  /// No description provided for @addPlantConveyor.
  ///
  /// In en, this message translates to:
  /// **'Add plant'**
  String get addPlantConveyor;

  /// No description provided for @addTool.
  ///
  /// In en, this message translates to:
  /// **'Add tool'**
  String get addTool;

  /// No description provided for @increasedCost.
  ///
  /// In en, this message translates to:
  /// **'Increased Cost'**
  String get increasedCost;

  /// No description provided for @powerTile.
  ///
  /// In en, this message translates to:
  /// **'Power tile'**
  String get powerTile;

  /// No description provided for @eventStandardSpawn.
  ///
  /// In en, this message translates to:
  /// **'Event: Standard spawn'**
  String get eventStandardSpawn;

  /// No description provided for @eventGroundSpawn.
  ///
  /// In en, this message translates to:
  /// **'Event: Ground spawn'**
  String get eventGroundSpawn;

  /// No description provided for @eventEditorInDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Event editor in development'**
  String get eventEditorInDevelopment;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @missingTideModule.
  ///
  /// In en, this message translates to:
  /// **'Missing tide module'**
  String get missingTideModule;

  /// No description provided for @levelHasNoTideProperties.
  ///
  /// In en, this message translates to:
  /// **'Level has no TideProperties. This event may not work.'**
  String get levelHasNoTideProperties;

  /// No description provided for @changePosition.
  ///
  /// In en, this message translates to:
  /// **'Change position'**
  String get changePosition;

  /// No description provided for @changePositionChangeAmount.
  ///
  /// In en, this message translates to:
  /// **'Change position (ChangeAmount)'**
  String get changePositionChangeAmount;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get land;

  /// No description provided for @groupConfigN.
  ///
  /// In en, this message translates to:
  /// **'Group {n} config'**
  String groupConfigN(int n);

  /// No description provided for @globalParameters.
  ///
  /// In en, this message translates to:
  /// **'Global parameters'**
  String get globalParameters;

  /// No description provided for @timePerGrid.
  ///
  /// In en, this message translates to:
  /// **'Time per grid'**
  String get timePerGrid;

  /// No description provided for @damagePerSecond.
  ///
  /// In en, this message translates to:
  /// **'Damage per second'**
  String get damagePerSecond;

  /// No description provided for @pipe.
  ///
  /// In en, this message translates to:
  /// **'Pipe'**
  String get pipe;

  /// No description provided for @stageMismatch.
  ///
  /// In en, this message translates to:
  /// **'Stage mismatch'**
  String get stageMismatch;

  /// No description provided for @currentStageNotPirate.
  ///
  /// In en, this message translates to:
  /// **'Current stage is not Pirate. This module may not work correctly.'**
  String get currentStageNotPirate;

  /// No description provided for @plankRows.
  ///
  /// In en, this message translates to:
  /// **'Plank rows (0–4)'**
  String get plankRows;

  /// No description provided for @selectedRows.
  ///
  /// In en, this message translates to:
  /// **'Selected rows'**
  String get selectedRows;

  /// No description provided for @selectedRowsLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected rows:'**
  String get selectedRowsLabel;

  /// No description provided for @indexLabel.
  ///
  /// In en, this message translates to:
  /// **'Index'**
  String get indexLabel;

  /// No description provided for @selectWeatherType.
  ///
  /// In en, this message translates to:
  /// **'Select weather type'**
  String get selectWeatherType;

  /// No description provided for @counts.
  ///
  /// In en, this message translates to:
  /// **'Counts'**
  String get counts;

  /// No description provided for @initial.
  ///
  /// In en, this message translates to:
  /// **'Initial'**
  String get initial;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @spawnTimerShort.
  ///
  /// In en, this message translates to:
  /// **'Spawn timer'**
  String get spawnTimerShort;

  /// No description provided for @minSec.
  ///
  /// In en, this message translates to:
  /// **'Min (sec)'**
  String get minSec;

  /// No description provided for @maxSec.
  ///
  /// In en, this message translates to:
  /// **'Max (sec)'**
  String get maxSec;

  /// No description provided for @potionTypes.
  ///
  /// In en, this message translates to:
  /// **'Potion types'**
  String get potionTypes;

  /// No description provided for @noPotionTypes.
  ///
  /// In en, this message translates to:
  /// **'No potion types'**
  String get noPotionTypes;

  /// No description provided for @ignoreGravestoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable to spawn regardless of obstacles'**
  String get ignoreGravestoneSubtitle;

  /// No description provided for @thisPortalSpawns.
  ///
  /// In en, this message translates to:
  /// **'This portal spawns:'**
  String get thisPortalSpawns;

  /// No description provided for @startEndFormat.
  ///
  /// In en, this message translates to:
  /// **'Start: ({sx}, {sy})  End: ({ex}, {ey})'**
  String startEndFormat(int sx, int sy, int ex, int ey);

  /// No description provided for @indexN.
  ///
  /// In en, this message translates to:
  /// **'Index: {n}'**
  String indexN(int n);

  /// No description provided for @noItemsAddHint.
  ///
  /// In en, this message translates to:
  /// **'No items. Add plants, zombies, or collectables.'**
  String get noItemsAddHint;

  /// No description provided for @zombieTypeSpiderZombieName.
  ///
  /// In en, this message translates to:
  /// **'Zombie type (SpiderZombieName)'**
  String get zombieTypeSpiderZombieName;

  /// No description provided for @noneSelected.
  ///
  /// In en, this message translates to:
  /// **'None selected'**
  String get noneSelected;

  /// No description provided for @totalSpiderCount.
  ///
  /// In en, this message translates to:
  /// **'Total (SpiderCount)'**
  String get totalSpiderCount;

  /// No description provided for @perBatchGroupSize.
  ///
  /// In en, this message translates to:
  /// **'Per batch (GroupSize)'**
  String get perBatchGroupSize;

  /// No description provided for @fallTime.
  ///
  /// In en, this message translates to:
  /// **'Fall time (s)'**
  String get fallTime;

  /// No description provided for @waveStartMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Red subtitle (WaveStartMessage)'**
  String get waveStartMessageLabel;

  /// No description provided for @optionalWarningText.
  ///
  /// In en, this message translates to:
  /// **'Optional warning text before spawn'**
  String get optionalWarningText;

  /// No description provided for @rowNShort.
  ///
  /// In en, this message translates to:
  /// **'Row {n}'**
  String rowNShort(int n);

  /// No description provided for @weightMaxFormat.
  ///
  /// In en, this message translates to:
  /// **'Weight: {weight}, Max: {max}'**
  String weightMaxFormat(int weight, int max);

  /// No description provided for @random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get random;

  /// No description provided for @noChallengesConfigured.
  ///
  /// In en, this message translates to:
  /// **'No challenges configured'**
  String get noChallengesConfigured;

  /// No description provided for @whiteListBlackListHint.
  ///
  /// In en, this message translates to:
  /// **'White list: empty = no limit. Black list overrides white list.'**
  String get whiteListBlackListHint;

  /// No description provided for @conveyorBeltHelpIntro.
  ///
  /// In en, this message translates to:
  /// **'Conveyor mode randomly generates cards by weight. Configure plant pool and refresh delay.'**
  String get conveyorBeltHelpIntro;

  /// No description provided for @conveyorBeltHelpPool.
  ///
  /// In en, this message translates to:
  /// **'Plant pool & weight: Probability = weight / total weight. Use thresholds to adjust dynamically.'**
  String get conveyorBeltHelpPool;

  /// No description provided for @conveyorBeltHelpDropDelay.
  ///
  /// In en, this message translates to:
  /// **'Drop delay: Controls card spawn interval. More plants = slower.'**
  String get conveyorBeltHelpDropDelay;

  /// No description provided for @conveyorBeltHelpSpeed.
  ///
  /// In en, this message translates to:
  /// **'Speed: Physical belt speed. Standard = 100.'**
  String get conveyorBeltHelpSpeed;

  /// No description provided for @cannotAddEliteZombies.
  ///
  /// In en, this message translates to:
  /// **'Cannot add elite zombies'**
  String get cannotAddEliteZombies;

  /// No description provided for @eliteZombiesNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Elite zombies are not allowed here'**
  String get eliteZombiesNotAllowed;

  /// No description provided for @fixToAlias.
  ///
  /// In en, this message translates to:
  /// **'Fix to {alias}'**
  String fixToAlias(Object alias);

  /// No description provided for @editPresetZombie.
  ///
  /// In en, this message translates to:
  /// **'Edit preset zombie: {name}'**
  String editPresetZombie(Object name);

  /// No description provided for @missingZombossModule.
  ///
  /// In en, this message translates to:
  /// **'Missing ZombossBattleModuleProperties'**
  String get missingZombossModule;

  /// No description provided for @challengeNoConfig.
  ///
  /// In en, this message translates to:
  /// **'This challenge doesn\'t support configuration.'**
  String get challengeNoConfig;

  /// No description provided for @maxPotionCount.
  ///
  /// In en, this message translates to:
  /// **'Max Potion Count'**
  String get maxPotionCount;

  /// No description provided for @potionTypesConfigured.
  ///
  /// In en, this message translates to:
  /// **'Potion types: {count} configured'**
  String potionTypesConfigured(int count);

  /// No description provided for @pipelinesCount.
  ///
  /// In en, this message translates to:
  /// **'Pipelines: {count}'**
  String pipelinesCount(int count);

  /// No description provided for @windN.
  ///
  /// In en, this message translates to:
  /// **'Wind #{n}'**
  String windN(int n);

  /// No description provided for @zombieList.
  ///
  /// In en, this message translates to:
  /// **'Zombie list (row-first)'**
  String get zombieList;

  /// No description provided for @positionPoolSpawnPositions.
  ///
  /// In en, this message translates to:
  /// **'Position pool (SpawnPositionsPool)'**
  String get positionPoolSpawnPositions;

  /// No description provided for @tapCellsSelectDeselect.
  ///
  /// In en, this message translates to:
  /// **'Tap cells to select/deselect spawn positions'**
  String get tapCellsSelectDeselect;

  /// No description provided for @gravestonePool.
  ///
  /// In en, this message translates to:
  /// **'Gravestone pool (GravestonePool)'**
  String get gravestonePool;

  /// No description provided for @removePlants.
  ///
  /// In en, this message translates to:
  /// **'Remove plants'**
  String get removePlants;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @eliteZombiesUseDefaultLevel.
  ///
  /// In en, this message translates to:
  /// **'Elite zombies use default level.'**
  String get eliteZombiesUseDefaultLevel;

  /// No description provided for @basicParameters.
  ///
  /// In en, this message translates to:
  /// **'Basic parameters'**
  String get basicParameters;

  /// No description provided for @zombieSpawnWaitSec.
  ///
  /// In en, this message translates to:
  /// **'Zombie spawn wait (sec)'**
  String get zombieSpawnWaitSec;

  /// No description provided for @gridTypes.
  ///
  /// In en, this message translates to:
  /// **'Grid types'**
  String get gridTypes;

  /// No description provided for @zombiesCount.
  ///
  /// In en, this message translates to:
  /// **'Zombies ({count})'**
  String zombiesCount(int count);

  /// No description provided for @eventGraveSpawnSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Event: Grave spawn'**
  String get eventGraveSpawnSubtitle;

  /// No description provided for @eventStormSpawnSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Event: Storm spawn'**
  String get eventStormSpawnSubtitle;

  /// No description provided for @eventHelpGraveSpawnZombieWait.
  ///
  /// In en, this message translates to:
  /// **'Delay from wave start until zombies spawn. Zombies won\'t spawn if the next wave has already begun.'**
  String get eventHelpGraveSpawnZombieWait;

  /// No description provided for @eventHelpStormOverview.
  ///
  /// In en, this message translates to:
  /// **'Sandstorm or snowstorm quickly delivers zombies to the front. Excold storm can freeze plants.'**
  String get eventHelpStormOverview;

  /// No description provided for @eventHelpStormColumnRange.
  ///
  /// In en, this message translates to:
  /// **'Columns 0–9. Left edge is 0, right is 9. Start column must be less than end column.'**
  String get eventHelpStormColumnRange;

  /// No description provided for @eventHelpStormZombieLevels.
  ///
  /// In en, this message translates to:
  /// **'Storm zombies support levels 1–10. Elite zombies use default level.'**
  String get eventHelpStormZombieLevels;

  /// No description provided for @spawnParameters.
  ///
  /// In en, this message translates to:
  /// **'Spawn parameters'**
  String get spawnParameters;

  /// No description provided for @sandstorm.
  ///
  /// In en, this message translates to:
  /// **'Sandstorm'**
  String get sandstorm;

  /// No description provided for @snowstorm.
  ///
  /// In en, this message translates to:
  /// **'Snowstorm'**
  String get snowstorm;

  /// No description provided for @excoldStorm.
  ///
  /// In en, this message translates to:
  /// **'Excold storm'**
  String get excoldStorm;

  /// No description provided for @columnStart.
  ///
  /// In en, this message translates to:
  /// **'Column start'**
  String get columnStart;

  /// No description provided for @columnEnd.
  ///
  /// In en, this message translates to:
  /// **'Column end'**
  String get columnEnd;

  /// No description provided for @applyBatchLevelContent.
  ///
  /// In en, this message translates to:
  /// **'Set all zombies in this wave to level {level} (elite unchanged).'**
  String applyBatchLevelContent(int level);

  /// No description provided for @randomRow.
  ///
  /// In en, this message translates to:
  /// **'Random row'**
  String get randomRow;

  /// No description provided for @levelFormat.
  ///
  /// In en, this message translates to:
  /// **'Level: {level}'**
  String levelFormat(int level);

  /// No description provided for @levelAccount.
  ///
  /// In en, this message translates to:
  /// **'Level: account'**
  String get levelAccount;

  /// No description provided for @levelDisplay.
  ///
  /// In en, this message translates to:
  /// **'Level: {value}'**
  String levelDisplay(Object value);

  /// No description provided for @eventStandardSpawnTitle.
  ///
  /// In en, this message translates to:
  /// **'Standard spawn event'**
  String get eventStandardSpawnTitle;

  /// No description provided for @eventGroundSpawnTitle.
  ///
  /// In en, this message translates to:
  /// **'Ground spawn event'**
  String get eventGroundSpawnTitle;

  /// No description provided for @eventHelpStandardOverview.
  ///
  /// In en, this message translates to:
  /// **'Configure zombies that spawn in this wave. Level 0 follows map tier.'**
  String get eventHelpStandardOverview;

  /// No description provided for @eventHelpStandardRow.
  ///
  /// In en, this message translates to:
  /// **'Rows 0–4. Leave unset for random row.'**
  String get eventHelpStandardRow;

  /// No description provided for @izombieModeTitle.
  ///
  /// In en, this message translates to:
  /// **'I, Zombie mode'**
  String get izombieModeTitle;

  /// No description provided for @izombieModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable to place zombies. Locks selection method.'**
  String get izombieModeSubtitle;

  /// No description provided for @reverseZombieFactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Reverse zombie faction'**
  String get reverseZombieFactionTitle;

  /// No description provided for @reverseZombieFactionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable to make zombies plant faction. For ZvZ.'**
  String get reverseZombieFactionSubtitle;

  /// No description provided for @initialWeight.
  ///
  /// In en, this message translates to:
  /// **'Initial weight'**
  String get initialWeight;

  /// No description provided for @plantLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Plant level'**
  String get plantLevelLabel;

  /// No description provided for @missingIntroModule.
  ///
  /// In en, this message translates to:
  /// **'Missing Intro Module'**
  String get missingIntroModule;

  /// No description provided for @missingIntroModuleHint.
  ///
  /// In en, this message translates to:
  /// **'Level is missing ZombossBattleIntroProperties. Please add it.'**
  String get missingIntroModuleHint;

  /// No description provided for @zombossType.
  ///
  /// In en, this message translates to:
  /// **'Zomboss Type'**
  String get zombossType;

  /// No description provided for @unknownZomboss.
  ///
  /// In en, this message translates to:
  /// **'Unknown Zomboss'**
  String get unknownZomboss;

  /// No description provided for @parameters.
  ///
  /// In en, this message translates to:
  /// **'Parameters'**
  String get parameters;

  /// No description provided for @reservedColumnCount.
  ///
  /// In en, this message translates to:
  /// **'Reserved Column Count'**
  String get reservedColumnCount;

  /// No description provided for @reservedColumnCountHint.
  ///
  /// In en, this message translates to:
  /// **'Columns reserved from the right where plants cannot be planted.'**
  String get reservedColumnCountHint;

  /// No description provided for @protectedList.
  ///
  /// In en, this message translates to:
  /// **'Protected list'**
  String get protectedList;

  /// No description provided for @plantLevelsFollowGlobal.
  ///
  /// In en, this message translates to:
  /// **'Plant levels follow global level definitions. Seed bank levels are overridden.'**
  String get plantLevelsFollowGlobal;

  /// No description provided for @protectPlantsOverview.
  ///
  /// In en, this message translates to:
  /// **'Plants listed here must survive; losing them fails the level.'**
  String get protectPlantsOverview;

  /// No description provided for @protectPlantsAutoCount.
  ///
  /// In en, this message translates to:
  /// **'The required count follows the number of listed plants.'**
  String get protectPlantsAutoCount;

  /// No description provided for @protectItemsOverview.
  ///
  /// In en, this message translates to:
  /// **'Grid items listed here must survive; losing them fails the level.'**
  String get protectItemsOverview;

  /// No description provided for @protectItemsAutoCount.
  ///
  /// In en, this message translates to:
  /// **'The required count follows the number of listed items.'**
  String get protectItemsAutoCount;

  /// No description provided for @positionsCount.
  ///
  /// In en, this message translates to:
  /// **'Positions: {count}'**
  String positionsCount(int count);

  /// No description provided for @totalItemsCount.
  ///
  /// In en, this message translates to:
  /// **'Total items: {count}'**
  String totalItemsCount(int count);

  /// No description provided for @itemCountExceedsPositionsWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning: item count exceeds positions. Some will not spawn.'**
  String get itemCountExceedsPositionsWarning;

  /// No description provided for @gravestoneBlockedInfo.
  ///
  /// In en, this message translates to:
  /// **'Gravestones and similar obstacles blocked by plants cannot spawn. Use other methods to force spawn.'**
  String get gravestoneBlockedInfo;

  /// No description provided for @enterConditionValue.
  ///
  /// In en, this message translates to:
  /// **'Enter condition value'**
  String get enterConditionValue;

  /// No description provided for @customInputHint.
  ///
  /// In en, this message translates to:
  /// **'Custom input must be accurate'**
  String get customInputHint;

  /// No description provided for @presetConditions.
  ///
  /// In en, this message translates to:
  /// **'Preset conditions'**
  String get presetConditions;

  /// No description provided for @selectFromPresetHint.
  ///
  /// In en, this message translates to:
  /// **'Select from preset condition list'**
  String get selectFromPresetHint;

  /// No description provided for @conveyorCardPool.
  ///
  /// In en, this message translates to:
  /// **'Conveyor card pool'**
  String get conveyorCardPool;

  /// No description provided for @toolCardsUseFixedLevel.
  ///
  /// In en, this message translates to:
  /// **'Tool cards use fixed level'**
  String get toolCardsUseFixedLevel;

  /// No description provided for @maxLimits.
  ///
  /// In en, this message translates to:
  /// **'Max limits'**
  String get maxLimits;

  /// No description provided for @maxCountThreshold.
  ///
  /// In en, this message translates to:
  /// **'Max count threshold'**
  String get maxCountThreshold;

  /// No description provided for @weightFactor.
  ///
  /// In en, this message translates to:
  /// **'Weight factor'**
  String get weightFactor;

  /// No description provided for @minLimits.
  ///
  /// In en, this message translates to:
  /// **'Min limits'**
  String get minLimits;

  /// No description provided for @minCountThreshold.
  ///
  /// In en, this message translates to:
  /// **'Min count threshold'**
  String get minCountThreshold;

  /// No description provided for @followAccountLevel.
  ///
  /// In en, this message translates to:
  /// **'0 = follow account level'**
  String get followAccountLevel;

  /// No description provided for @enablePointSpawning.
  ///
  /// In en, this message translates to:
  /// **'Enable point spawning'**
  String get enablePointSpawning;

  /// No description provided for @pointSpawningEnabledDesc.
  ///
  /// In en, this message translates to:
  /// **'Enabled (uses extra points for spawning)'**
  String get pointSpawningEnabledDesc;

  /// No description provided for @pointSpawningDisabledDesc.
  ///
  /// In en, this message translates to:
  /// **'Disabled (wave events only)'**
  String get pointSpawningDisabledDesc;

  /// No description provided for @pointSettings.
  ///
  /// In en, this message translates to:
  /// **'Point settings'**
  String get pointSettings;

  /// No description provided for @startingWave.
  ///
  /// In en, this message translates to:
  /// **'Starting wave'**
  String get startingWave;

  /// No description provided for @startingPoints.
  ///
  /// In en, this message translates to:
  /// **'Starting points'**
  String get startingPoints;

  /// No description provided for @pointIncrement.
  ///
  /// In en, this message translates to:
  /// **'Point increment'**
  String get pointIncrement;

  /// No description provided for @zombiePool.
  ///
  /// In en, this message translates to:
  /// **'Zombie pool'**
  String get zombiePool;

  /// No description provided for @plantLevelsCount.
  ///
  /// In en, this message translates to:
  /// **'Plant levels: {count}'**
  String plantLevelsCount(int count);

  /// No description provided for @lvN.
  ///
  /// In en, this message translates to:
  /// **'Lv {n}'**
  String lvN(int n);

  /// No description provided for @pennyClassroom.
  ///
  /// In en, this message translates to:
  /// **'Penny classroom'**
  String get pennyClassroom;

  /// No description provided for @protectGridItems.
  ///
  /// In en, this message translates to:
  /// **'Protect grid items'**
  String get protectGridItems;

  /// No description provided for @waveManagerHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'Enables wave manager. Without this module, wave editing is disabled.'**
  String get waveManagerHelpOverview;

  /// No description provided for @waveManagerHelpPoints.
  ///
  /// In en, this message translates to:
  /// **'Point-based spawning uses this pool. Avoid elite and custom zombies.'**
  String get waveManagerHelpPoints;

  /// No description provided for @pointsSection.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get pointsSection;

  /// No description provided for @globalPlantLevelsOverview.
  ///
  /// In en, this message translates to:
  /// **'Defines global levels for specified plants.'**
  String get globalPlantLevelsOverview;

  /// No description provided for @globalPlantLevelsScope.
  ///
  /// In en, this message translates to:
  /// **'Applies to protect plants, seed rain, and other modules.'**
  String get globalPlantLevelsScope;

  /// No description provided for @mustProtectCountFormat.
  ///
  /// In en, this message translates to:
  /// **'Must protect count: {count}'**
  String mustProtectCountFormat(int count);

  /// No description provided for @noWaveManagerPropsFound.
  ///
  /// In en, this message translates to:
  /// **'No WaveManagerProperties object found.'**
  String get noWaveManagerPropsFound;

  /// No description provided for @itemsSortedByRow.
  ///
  /// In en, this message translates to:
  /// **'Items (sorted by row)'**
  String get itemsSortedByRow;

  /// No description provided for @eventStormSpawn.
  ///
  /// In en, this message translates to:
  /// **'Event: Storm spawn'**
  String get eventStormSpawn;

  /// No description provided for @stormEvent.
  ///
  /// In en, this message translates to:
  /// **'Storm event'**
  String get stormEvent;

  /// No description provided for @makeCustom.
  ///
  /// In en, this message translates to:
  /// **'Make custom'**
  String get makeCustom;

  /// No description provided for @zombieLevelsBody.
  ///
  /// In en, this message translates to:
  /// **'Storm zombies support level 1-10. Elite zombies use default level.'**
  String get zombieLevelsBody;

  /// No description provided for @batchLevel.
  ///
  /// In en, this message translates to:
  /// **'Batch level'**
  String get batchLevel;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get end;

  /// No description provided for @backgroundMusicLevelJam.
  ///
  /// In en, this message translates to:
  /// **'Background music (LevelJam)'**
  String get backgroundMusicLevelJam;

  /// No description provided for @onlyAppliesRockEra.
  ///
  /// In en, this message translates to:
  /// **'Only applies to Rock era maps.'**
  String get onlyAppliesRockEra;

  /// No description provided for @appliesToAllNonElite.
  ///
  /// In en, this message translates to:
  /// **'Applies to all non-elite zombies in this wave.'**
  String get appliesToAllNonElite;

  /// No description provided for @dropConfigPlants.
  ///
  /// In en, this message translates to:
  /// **'Drop config (Plants)'**
  String get dropConfigPlants;

  /// No description provided for @dropConfigPlantFood.
  ///
  /// In en, this message translates to:
  /// **'Drop config (Plant Food)'**
  String get dropConfigPlantFood;

  /// No description provided for @zombiesCarryingPlants.
  ///
  /// In en, this message translates to:
  /// **'Zombies carrying plants'**
  String get zombiesCarryingPlants;

  /// No description provided for @zombiesCarryingPlantFood.
  ///
  /// In en, this message translates to:
  /// **'Zombies carrying plant food'**
  String get zombiesCarryingPlantFood;

  /// No description provided for @descriptiveName.
  ///
  /// In en, this message translates to:
  /// **'Descriptive Name'**
  String get descriptiveName;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @targetDistance.
  ///
  /// In en, this message translates to:
  /// **'Target Distance'**
  String get targetDistance;

  /// No description provided for @targetSun.
  ///
  /// In en, this message translates to:
  /// **'Target Sun'**
  String get targetSun;

  /// No description provided for @maximumSun.
  ///
  /// In en, this message translates to:
  /// **'Maximum Sun'**
  String get maximumSun;

  /// No description provided for @holdoutSeconds.
  ///
  /// In en, this message translates to:
  /// **'Holdout Seconds'**
  String get holdoutSeconds;

  /// No description provided for @zombiesToKill.
  ///
  /// In en, this message translates to:
  /// **'Zombies To Kill'**
  String get zombiesToKill;

  /// No description provided for @timeSeconds.
  ///
  /// In en, this message translates to:
  /// **'Time (Seconds)'**
  String get timeSeconds;

  /// No description provided for @speedModifier.
  ///
  /// In en, this message translates to:
  /// **'Speed Modifier'**
  String get speedModifier;

  /// No description provided for @sunModifier.
  ///
  /// In en, this message translates to:
  /// **'Sun Modifier'**
  String get sunModifier;

  /// No description provided for @maximumPlantsLost.
  ///
  /// In en, this message translates to:
  /// **'Maximum Plants Lost'**
  String get maximumPlantsLost;

  /// No description provided for @maximumPlants.
  ///
  /// In en, this message translates to:
  /// **'Maximum Plants'**
  String get maximumPlants;

  /// No description provided for @targetScore.
  ///
  /// In en, this message translates to:
  /// **'Target Score'**
  String get targetScore;

  /// No description provided for @plantBombRadius.
  ///
  /// In en, this message translates to:
  /// **'Plant Bomb Radius'**
  String get plantBombRadius;

  /// No description provided for @plantType.
  ///
  /// In en, this message translates to:
  /// **'Plant Type'**
  String get plantType;

  /// No description provided for @gridX.
  ///
  /// In en, this message translates to:
  /// **'Grid X'**
  String get gridX;

  /// No description provided for @gridY.
  ///
  /// In en, this message translates to:
  /// **'Grid Y'**
  String get gridY;

  /// No description provided for @noCardsYetAddPlants.
  ///
  /// In en, this message translates to:
  /// **'No cards yet. Add plants or tools.'**
  String get noCardsYetAddPlants;

  /// No description provided for @mustProtectCountAll.
  ///
  /// In en, this message translates to:
  /// **'Must Protect Count (0 = All)'**
  String get mustProtectCountAll;

  /// No description provided for @mustProtectCount.
  ///
  /// In en, this message translates to:
  /// **'Must Protect Count'**
  String get mustProtectCount;

  /// No description provided for @gridItemType.
  ///
  /// In en, this message translates to:
  /// **'Grid Item Type'**
  String get gridItemType;

  /// No description provided for @zombieBombRadius.
  ///
  /// In en, this message translates to:
  /// **'Zombie Bomb Radius'**
  String get zombieBombRadius;

  /// No description provided for @plantDamage.
  ///
  /// In en, this message translates to:
  /// **'Plant Damage'**
  String get plantDamage;

  /// No description provided for @zombieDamage.
  ///
  /// In en, this message translates to:
  /// **'Zombie Damage'**
  String get zombieDamage;

  /// No description provided for @initialPotionCount.
  ///
  /// In en, this message translates to:
  /// **'Initial Potion Count'**
  String get initialPotionCount;

  /// No description provided for @operationTimePerGrid.
  ///
  /// In en, this message translates to:
  /// **'Operation Time Per Grid'**
  String get operationTimePerGrid;

  /// No description provided for @levelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level: '**
  String get levelLabel;

  /// No description provided for @mistParameters.
  ///
  /// In en, this message translates to:
  /// **'Mist parameters'**
  String get mistParameters;

  /// No description provided for @sunDropParameters.
  ///
  /// In en, this message translates to:
  /// **'Sun drop parameters'**
  String get sunDropParameters;

  /// No description provided for @initialDropDelay.
  ///
  /// In en, this message translates to:
  /// **'Initial drop delay'**
  String get initialDropDelay;

  /// No description provided for @baseCountdown.
  ///
  /// In en, this message translates to:
  /// **'Base countdown'**
  String get baseCountdown;

  /// No description provided for @maxCountdown.
  ///
  /// In en, this message translates to:
  /// **'Max countdown'**
  String get maxCountdown;

  /// No description provided for @countdownRange.
  ///
  /// In en, this message translates to:
  /// **'Countdown range'**
  String get countdownRange;

  /// No description provided for @increasePerSun.
  ///
  /// In en, this message translates to:
  /// **'Increase per sun'**
  String get increasePerSun;

  /// No description provided for @inflationParams.
  ///
  /// In en, this message translates to:
  /// **'Inflation params'**
  String get inflationParams;

  /// No description provided for @baseCostIncreaseLabel.
  ///
  /// In en, this message translates to:
  /// **'Base cost increase (BaseCostIncreased)'**
  String get baseCostIncreaseLabel;

  /// No description provided for @maxIncreaseCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Max increase count (MaxIncreasedCount)'**
  String get maxIncreaseCountLabel;

  /// No description provided for @selectGroup.
  ///
  /// In en, this message translates to:
  /// **'Select group'**
  String get selectGroup;

  /// No description provided for @gridTapAddRemove.
  ///
  /// In en, this message translates to:
  /// **'Grid (tap to add/change, long-press to remove)'**
  String get gridTapAddRemove;

  /// No description provided for @sunBombHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get sunBombHelpOverview;

  /// No description provided for @sunBombHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Turns falling sun into explosive sun bombs. Configure radius and damage.'**
  String get sunBombHelpBody;

  /// No description provided for @damage.
  ///
  /// In en, this message translates to:
  /// **'Damage'**
  String get damage;

  /// No description provided for @explosionRadius.
  ///
  /// In en, this message translates to:
  /// **'Explosion radius'**
  String get explosionRadius;

  /// No description provided for @plantRadius.
  ///
  /// In en, this message translates to:
  /// **'Plant radius'**
  String get plantRadius;

  /// No description provided for @zombieRadius.
  ///
  /// In en, this message translates to:
  /// **'Zombie radius'**
  String get zombieRadius;

  /// No description provided for @radiusPixelsHint.
  ///
  /// In en, this message translates to:
  /// **'Radius is in pixels. One tile is about 60px.'**
  String get radiusPixelsHint;

  /// No description provided for @enterMaxSunHint.
  ///
  /// In en, this message translates to:
  /// **'Enter max sun (e.g., 9900)'**
  String get enterMaxSunHint;

  /// No description provided for @optionalLabelHint.
  ///
  /// In en, this message translates to:
  /// **'Optional label'**
  String get optionalLabelHint;

  /// No description provided for @imageResourceIdHint.
  ///
  /// In en, this message translates to:
  /// **'IMAGE_... resource id'**
  String get imageResourceIdHint;

  /// No description provided for @enterStartingPlantfoodHint.
  ///
  /// In en, this message translates to:
  /// **'Enter starting plantfood (0+)'**
  String get enterStartingPlantfoodHint;

  /// No description provided for @threshold.
  ///
  /// In en, this message translates to:
  /// **'Threshold'**
  String get threshold;

  /// No description provided for @delay.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get delay;

  /// No description provided for @seedBankLetsPlayersChoose.
  ///
  /// In en, this message translates to:
  /// **'Seed bank lets players choose plants. In courtyard mode you can set global level and all plants.'**
  String get seedBankLetsPlayersChoose;

  /// No description provided for @iZombieModePresetHint.
  ///
  /// In en, this message translates to:
  /// **'I, Zombie mode: preset zombies for player. Selection locked to preset.'**
  String get iZombieModePresetHint;

  /// No description provided for @invalidIdsHint.
  ///
  /// In en, this message translates to:
  /// **'Invalid IDs leave empty slots. Zombie IDs in plant mode and vice versa. Put zombie slots first.'**
  String get invalidIdsHint;

  /// No description provided for @seedBankIZombie.
  ///
  /// In en, this message translates to:
  /// **'Seed bank (I, Zombie)'**
  String get seedBankIZombie;

  /// No description provided for @basicRules.
  ///
  /// In en, this message translates to:
  /// **'Basic rules'**
  String get basicRules;

  /// No description provided for @selectionMethod.
  ///
  /// In en, this message translates to:
  /// **'Selection method'**
  String get selectionMethod;

  /// No description provided for @emptyList.
  ///
  /// In en, this message translates to:
  /// **'Empty list'**
  String get emptyList;

  /// No description provided for @plantsAvailableAtStart.
  ///
  /// In en, this message translates to:
  /// **'Plants available at start'**
  String get plantsAvailableAtStart;

  /// No description provided for @whiteListDescription.
  ///
  /// In en, this message translates to:
  /// **'Only these plants allowed (empty = no limit)'**
  String get whiteListDescription;

  /// No description provided for @blackListDescription.
  ///
  /// In en, this message translates to:
  /// **'These plants are forbidden'**
  String get blackListDescription;

  /// No description provided for @availableZombiesDescription.
  ///
  /// In en, this message translates to:
  /// **'Zombies available for I, Zombie mode'**
  String get availableZombiesDescription;

  /// No description provided for @izombieCardSlotsHint.
  ///
  /// In en, this message translates to:
  /// **'Only some zombies have IZ card slots. Check Other category in zombie selection.'**
  String get izombieCardSlotsHint;

  /// No description provided for @selectToolCard.
  ///
  /// In en, this message translates to:
  /// **'Select tool card'**
  String get selectToolCard;

  /// No description provided for @searchGridItems.
  ///
  /// In en, this message translates to:
  /// **'Search grid items'**
  String get searchGridItems;

  /// No description provided for @noItems.
  ///
  /// In en, this message translates to:
  /// **'No items'**
  String get noItems;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get addedToFavorites;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get removedFromFavorites;

  /// No description provided for @selectedCountTapToSearch.
  ///
  /// In en, this message translates to:
  /// **'Selected {count}, tap to search'**
  String selectedCountTapToSearch(int count);

  /// No description provided for @noFavoritesLongPress.
  ///
  /// In en, this message translates to:
  /// **'No favorites. Long-press to favorite.'**
  String get noFavoritesLongPress;

  /// No description provided for @gridItemCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get gridItemCategoryAll;

  /// No description provided for @gridItemCategoryScene.
  ///
  /// In en, this message translates to:
  /// **'Scene'**
  String get gridItemCategoryScene;

  /// No description provided for @gridItemCategoryTrap.
  ///
  /// In en, this message translates to:
  /// **'Trap'**
  String get gridItemCategoryTrap;

  /// No description provided for @gridItemCategoryPlants.
  ///
  /// In en, this message translates to:
  /// **'Plants'**
  String get gridItemCategoryPlants;

  /// No description provided for @sunDropperConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Sun drop config'**
  String get sunDropperConfigTitle;

  /// No description provided for @customLocalParams.
  ///
  /// In en, this message translates to:
  /// **'Custom local params'**
  String get customLocalParams;

  /// No description provided for @currentModeLocal.
  ///
  /// In en, this message translates to:
  /// **'Current: local (@CurrentLevel)'**
  String get currentModeLocal;

  /// No description provided for @currentModeSystem.
  ///
  /// In en, this message translates to:
  /// **'Current: system default (@LevelModules)'**
  String get currentModeSystem;

  /// No description provided for @paramAdjust.
  ///
  /// In en, this message translates to:
  /// **'Parameter adjust'**
  String get paramAdjust;

  /// No description provided for @firstDropDelay.
  ///
  /// In en, this message translates to:
  /// **'First drop delay'**
  String get firstDropDelay;

  /// No description provided for @initialDropInterval.
  ///
  /// In en, this message translates to:
  /// **'Initial drop interval'**
  String get initialDropInterval;

  /// No description provided for @maxDropInterval.
  ///
  /// In en, this message translates to:
  /// **'Max drop interval'**
  String get maxDropInterval;

  /// No description provided for @intervalFloatRange.
  ///
  /// In en, this message translates to:
  /// **'Interval float range'**
  String get intervalFloatRange;

  /// No description provided for @sunDropperHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sun dropper module'**
  String get sunDropperHelpTitle;

  /// No description provided for @sunDropperHelpIntro.
  ///
  /// In en, this message translates to:
  /// **'This module configures falling sun parameters. Consider not adding it for night levels.'**
  String get sunDropperHelpIntro;

  /// No description provided for @sunDropperHelpParams.
  ///
  /// In en, this message translates to:
  /// **'Parameter config'**
  String get sunDropperHelpParams;

  /// No description provided for @sunDropperHelpParamsBody.
  ///
  /// In en, this message translates to:
  /// **'By default the module uses game definitions. You can enable custom mode to edit parameters locally.'**
  String get sunDropperHelpParamsBody;

  /// No description provided for @noZombossFound.
  ///
  /// In en, this message translates to:
  /// **'No zomboss found'**
  String get noZombossFound;

  /// No description provided for @searchChallengeNameOrCode.
  ///
  /// In en, this message translates to:
  /// **'Search challenge name or code'**
  String get searchChallengeNameOrCode;

  /// No description provided for @deleteChallengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete challenge?'**
  String get deleteChallengeTitle;

  /// No description provided for @deleteChallengeConfirmLocal.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\"? Local challenge data will be deleted permanently.'**
  String deleteChallengeConfirmLocal(String name);

  /// No description provided for @deleteChallengeConfirmRef.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\"? Reference will be removed. Challenge stays in LevelModules.'**
  String deleteChallengeConfirmRef(String name);

  /// No description provided for @missingModulesRecommended.
  ///
  /// In en, this message translates to:
  /// **'The level might not function correctly. Recommended to add:'**
  String get missingModulesRecommended;

  /// No description provided for @itemListRowFirst.
  ///
  /// In en, this message translates to:
  /// **'Item list (row-first)'**
  String get itemListRowFirst;

  /// No description provided for @railcartCowboy.
  ///
  /// In en, this message translates to:
  /// **'Cowboy'**
  String get railcartCowboy;

  /// No description provided for @railcartFuture.
  ///
  /// In en, this message translates to:
  /// **'Future'**
  String get railcartFuture;

  /// No description provided for @railcartEgypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get railcartEgypt;

  /// No description provided for @railcartPirate.
  ///
  /// In en, this message translates to:
  /// **'Pirate'**
  String get railcartPirate;

  /// No description provided for @railcartWorldcup.
  ///
  /// In en, this message translates to:
  /// **'World Cup'**
  String get railcartWorldcup;

  /// No description provided for @clearUnusedTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear unused objects?'**
  String get clearUnusedTitle;

  /// No description provided for @clearUnusedMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete all unused objects from the level file, including custom zombies, their properties, and any other unreferenced data. This action cannot be undone. Continue?'**
  String get clearUnusedMessage;

  /// No description provided for @clearUnusedNone.
  ///
  /// In en, this message translates to:
  /// **'No unused objects found.'**
  String get clearUnusedNone;

  /// No description provided for @clearUnusedDone.
  ///
  /// In en, this message translates to:
  /// **'Removed {count} unused object(s).'**
  String clearUnusedDone(int count);

  /// No description provided for @lawnMowerTitle.
  ///
  /// In en, this message translates to:
  /// **'Lawn mower style'**
  String get lawnMowerTitle;

  /// No description provided for @lawnMowerNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get lawnMowerNotes;

  /// No description provided for @lawnMowerHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'Controls lawn mower appearance. Lawn mowers are ineffective in Yard module.'**
  String get lawnMowerHelpOverview;

  /// No description provided for @lawnMowerHelpNotes.
  ///
  /// In en, this message translates to:
  /// **'Lawn mower module typically references LevelModules directly.'**
  String get lawnMowerHelpNotes;

  /// No description provided for @lawnMowerSelectType.
  ///
  /// In en, this message translates to:
  /// **'Select mower type'**
  String get lawnMowerSelectType;

  /// No description provided for @zombieRushTitle.
  ///
  /// In en, this message translates to:
  /// **'Level timer'**
  String get zombieRushTitle;

  /// No description provided for @zombieRushHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'Countdown timer for Zombie Rush. Level ends when time runs out.'**
  String get zombieRushHelpOverview;

  /// No description provided for @zombieRushHelpNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get zombieRushHelpNotes;

  /// No description provided for @zombieRushHelpIncompat.
  ///
  /// In en, this message translates to:
  /// **'Timer module is incompatible with Yard mode and may crash. Use Zombie Rush timer instead.'**
  String get zombieRushHelpIncompat;

  /// No description provided for @zombieRushTimeSettings.
  ///
  /// In en, this message translates to:
  /// **'Time settings'**
  String get zombieRushTimeSettings;

  /// No description provided for @levelCountdown.
  ///
  /// In en, this message translates to:
  /// **'Level countdown'**
  String get levelCountdown;

  /// No description provided for @tunnelDefendTitle.
  ///
  /// In en, this message translates to:
  /// **'Tunnel defend'**
  String get tunnelDefendTitle;

  /// No description provided for @tunnelDefendHelpOverview.
  ///
  /// In en, this message translates to:
  /// **'Add mausoleum tunnel paths. Some zombies and plants interact with tunnels.'**
  String get tunnelDefendHelpOverview;

  /// No description provided for @tunnelDefendHelpUsage.
  ///
  /// In en, this message translates to:
  /// **'Usage'**
  String get tunnelDefendHelpUsage;

  /// No description provided for @tunnelDefendHelpUsageBody.
  ///
  /// In en, this message translates to:
  /// **'Select a tunnel piece below, then tap the grid to place. Tap the same piece again to remove. Tap a different piece to replace.'**
  String get tunnelDefendHelpUsageBody;

  /// No description provided for @tunnelDefendSelectComponent.
  ///
  /// In en, this message translates to:
  /// **'Select component'**
  String get tunnelDefendSelectComponent;

  /// No description provided for @tunnelDefendPlacedCount.
  ///
  /// In en, this message translates to:
  /// **'Placed'**
  String get tunnelDefendPlacedCount;

  /// No description provided for @tunnelDefendClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get tunnelDefendClearAll;

  /// No description provided for @tunnelDefendClearConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all tunnel components?'**
  String get tunnelDefendClearConfirmTitle;

  /// No description provided for @tunnelDefendClearConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove all placed tunnel components from the grid. This cannot be undone.'**
  String get tunnelDefendClearConfirmMessage;

  /// No description provided for @tunnelDefendPathOutsideLawn.
  ///
  /// In en, this message translates to:
  /// **'Path elements outside of the lawn: '**
  String get tunnelDefendPathOutsideLawn;

  /// No description provided for @tunnelDefendDeleteOutside.
  ///
  /// In en, this message translates to:
  /// **'Delete path elements outside lawn'**
  String get tunnelDefendDeleteOutside;

  /// No description provided for @tunnelDefendDeleteOutsideConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete path elements outside lawn?'**
  String get tunnelDefendDeleteOutsideConfirmTitle;

  /// No description provided for @tunnelDefendDeleteOutsideConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove path elements that are outside the 5×9 lawn grid. This cannot be undone.'**
  String get tunnelDefendDeleteOutsideConfirmMessage;

  /// No description provided for @moduleTitle_LawnMowerProperties.
  ///
  /// In en, this message translates to:
  /// **'Lawn mower'**
  String get moduleTitle_LawnMowerProperties;

  /// No description provided for @moduleDesc_LawnMowerProperties.
  ///
  /// In en, this message translates to:
  /// **'Mower style for the level'**
  String get moduleDesc_LawnMowerProperties;

  /// No description provided for @moduleTitle_TunnelDefendModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Tunnel defend'**
  String get moduleTitle_TunnelDefendModuleProperties;

  /// No description provided for @moduleDesc_TunnelDefendModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Mausoleum tunnel placement'**
  String get moduleDesc_TunnelDefendModuleProperties;

  /// No description provided for @moduleTitle_ZombieRushModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Zombie Rush timer'**
  String get moduleTitle_ZombieRushModuleProperties;

  /// No description provided for @moduleDesc_ZombieRushModuleProperties.
  ///
  /// In en, this message translates to:
  /// **'Level countdown timer'**
  String get moduleDesc_ZombieRushModuleProperties;

  /// No description provided for @jsonViewerModeReading.
  ///
  /// In en, this message translates to:
  /// **'(reading mode)'**
  String get jsonViewerModeReading;

  /// No description provided for @jsonViewerModeObjectReading.
  ///
  /// In en, this message translates to:
  /// **'(object reading mode)'**
  String get jsonViewerModeObjectReading;

  /// No description provided for @jsonViewerModeEdit.
  ///
  /// In en, this message translates to:
  /// **'(edit mode)'**
  String get jsonViewerModeEdit;

  /// No description provided for @tooltipAboutModule.
  ///
  /// In en, this message translates to:
  /// **'About this module'**
  String get tooltipAboutModule;

  /// No description provided for @tooltipAboutEvent.
  ///
  /// In en, this message translates to:
  /// **'About this event'**
  String get tooltipAboutEvent;

  /// No description provided for @tooltipSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get tooltipSave;

  /// No description provided for @tooltipEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get tooltipEdit;

  /// No description provided for @tooltipClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get tooltipClose;

  /// No description provided for @tooltipToggleObjectView.
  ///
  /// In en, this message translates to:
  /// **'Toggle object/raw view'**
  String get tooltipToggleObjectView;

  /// No description provided for @tooltipClearUnused.
  ///
  /// In en, this message translates to:
  /// **'Clear unused objects'**
  String get tooltipClearUnused;

  /// No description provided for @tooltipJsonViewer.
  ///
  /// In en, this message translates to:
  /// **'View/edit JSON'**
  String get tooltipJsonViewer;

  /// No description provided for @tooltipAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get tooltipAdd;

  /// No description provided for @tooltipDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get tooltipDecrease;

  /// No description provided for @tooltipIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get tooltipIncrease;
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
