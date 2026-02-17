import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_editor/escape_override.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:z_editor/l10n/app_localizations.dart';
import 'package:z_editor/data/repository/level_repository.dart';
import 'package:z_editor/screens/about_screen.dart';
import 'package:z_editor/screens/editor_screen.dart';
import 'package:z_editor/screens/level_list_screen.dart';
import 'package:z_editor/theme/app_theme.dart';

enum AppScreen { levelList, editor, about }

/// Wraps child and handles Escape key on desktop to trigger back/pop.
/// Uses HardwareKeyboard.addHandler for immediate, global Escape handling.
class _DesktopEscapeHandler extends StatefulWidget {
  const _DesktopEscapeHandler({
    required this.child,
    required this.onEscapeNoRouteToPop,
  });

  final Widget child;
  final VoidCallback? onEscapeNoRouteToPop;

  @override
  State<_DesktopEscapeHandler> createState() => _DesktopEscapeHandlerState();
}

class _DesktopEscapeHandlerState extends State<_DesktopEscapeHandler> {
  late final KeyEventCallback _keyHandler;

  @override
  void initState() {
    super.initState();
    _keyHandler = _handleKeyEvent;
    HardwareKeyboard.instance.addHandler(_keyHandler);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_keyHandler);
    super.dispose();
  }

  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyRepeatEvent) return false;
    if (event is! KeyDownEvent) return false;
    if (event.logicalKey != LogicalKeyboardKey.escape) return false;
    if (!mounted) return false;

    final platform = Theme.of(context).platform;
    if (platform != TargetPlatform.windows &&
        platform != TargetPlatform.macOS &&
        platform != TargetPlatform.linux) {
      return false;
    }

    final nav = Navigator.maybeOf(context);
    if (nav != null && nav.canPop()) {
      if (EscapeOverride.tryHandle?.call() == true) return true;
      nav.pop();
      return true;
    }

    widget.onEscapeNoRouteToPop?.call();
    return true;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class ZEditorApp extends StatefulWidget {
  const ZEditorApp({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
    required this.themeMode,
    required this.onCycleTheme,
    required this.uiScale,
    required this.onUiScaleChange,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;
  final ThemeMode themeMode;
  final VoidCallback onCycleTheme;
  final double uiScale;
  final ValueChanged<double> onUiScaleChange;

  @override
  State<ZEditorApp> createState() => _ZEditorAppState();
}

class _ZEditorAppState extends State<ZEditorApp> {
  AppScreen _screen = AppScreen.levelList;
  String _editorFileName = '';
  String _editorFilePath = '';
  Future<bool> Function()? _editorBackHandler;

  void _openLevel(String fileName, String filePath) {
    LevelRepository.setLastOpenedLevelDirectory(p.dirname(filePath));
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
      themeMode: widget.themeMode,
      locale: widget.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final scale = widget.uiScale;
        final mediaQuery = MediaQuery.of(context);
        final viewportSize = mediaQuery.size;
        final scaledSize = Size(
          viewportSize.width / scale,
          viewportSize.height / scale,
        );
        return MediaQuery(
          data: mediaQuery.copyWith(
            size: scaledSize,
            textScaler: TextScaler.linear(1.0),
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: scaledSize.width,
              height: scaledSize.height,
              child: child,
            ),
          ),
        );
      },
      home: _DesktopEscapeHandler(
        onEscapeNoRouteToPop: () {
          if (_screen == AppScreen.levelList) {
            SystemNavigator.pop();
          } else if (_screen == AppScreen.editor && _editorBackHandler != null) {
            _editorBackHandler!().then((leave) {
              if (leave && mounted) _backToLevelList();
            });
          } else if (mounted) {
            _backToLevelList();
          }
        },
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            if (_screen == AppScreen.levelList) {
              SystemNavigator.pop();
            } else if (_screen == AppScreen.editor && _editorBackHandler != null) {
              final shouldLeave = await _editorBackHandler!();
              if (shouldLeave && mounted) _backToLevelList();
            } else if (mounted) {
              _backToLevelList();
            }
          },
          child: _buildCurrentScreen(),
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_screen) {
      case AppScreen.levelList:
        return LevelListScreen(
          themeMode: widget.themeMode,
          onCycleTheme: widget.onCycleTheme,
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
          onRegisterBackHandler: (handler) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(() => _editorBackHandler = handler);
            });
          },
          themeMode: widget.themeMode,
          onCycleTheme: widget.onCycleTheme,
          locale: widget.locale,
          onLocaleChanged: widget.onLocaleChanged,
          uiScale: widget.uiScale,
          onUiScaleChange: widget.onUiScaleChange,
          onLanguageTap: (ctx) => _showLanguageSelector(ctx),
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
