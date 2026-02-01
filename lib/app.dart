import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/screens/about_screen.dart';
import 'package:z_editor/screens/editor_screen.dart';
import 'package:z_editor/screens/level_list_screen.dart';
import 'package:z_editor/theme/app_theme.dart';

enum AppScreen { levelList, editor, about }

class ZEditorApp extends StatefulWidget {
  const ZEditorApp({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    required this.isDarkTheme,
    required this.onToggleTheme,
    required this.uiScale,
    required this.onUiScaleChange,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final bool isDarkTheme;
  final VoidCallback onToggleTheme;
  final double uiScale;
  final ValueChanged<double> onUiScaleChange;

  @override
  State<ZEditorApp> createState() => _ZEditorAppState();
}

class _ZEditorAppState extends State<ZEditorApp> {
  AppScreen _screen = AppScreen.levelList;
  String _editorFileName = '';
  String _editorFilePath = '';

  void _openLevel(String fileName, String filePath) {
    setState(() {
      _editorFileName = fileName;
      _editorFilePath = filePath;
      _screen = AppScreen.editor;
    });
  }

  void _openAbout() {
    setState(() => _screen = AppScreen.about);
  }

  void _backToLevelList() {
    setState(() => _screen = AppScreen.levelList);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Z-Editor',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: widget.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      locale: widget.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(widget.uiScale),
        ),
        child: _buildCurrentScreen(),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_screen) {
      case AppScreen.levelList:
        return LevelListScreen(
          isDarkTheme: widget.isDarkTheme,
          onToggleTheme: widget.onToggleTheme,
          uiScale: widget.uiScale,
          onUiScaleChange: widget.onUiScaleChange,
          onLevelClick: _openLevel,
          onAboutClick: _openAbout,
          onLanguageTap: (ctx) => _showLanguageSelector(ctx),
        );
      case AppScreen.editor:
        return EditorScreen(
          fileName: _editorFileName,
          filePath: _editorFilePath,
          onBack: _backToLevelList,
          isDarkTheme: widget.isDarkTheme,
          onToggleTheme: widget.onToggleTheme,
        );
      case AppScreen.about:
        return AboutScreen(onBack: _backToLevelList);
    }
  }

  void _showLanguageSelector(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageTitle = l10n?.language ?? 'Language';
    final languageEnglish = l10n?.languageEnglish ?? 'English';
    final languageChinese = l10n?.languageChinese ?? '中文';
    final languageRussian = l10n?.languageRussian ?? 'Русский';
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(languageTitle, style: Theme.of(ctx).textTheme.titleLarge),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(languageEnglish),
              onTap: () {
                widget.onLocaleChanged(const Locale('en'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.translate),
              title: Text(languageChinese),
              onTap: () {
                widget.onLocaleChanged(const Locale('zh'));
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.translate),
              title: Text(languageRussian),
              onTap: () {
                widget.onLocaleChanged(const Locale('ru'));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }
}
