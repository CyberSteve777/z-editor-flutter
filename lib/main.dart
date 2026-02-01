import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_editor/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final localeCode = prefs.getString('locale') ?? 'en';
  final locale = localeCode == 'zh'
      ? const Locale('zh')
      : localeCode == 'ru'
          ? const Locale('ru')
          : const Locale('en');

  final isDark = prefs.getBool('dark_theme') ?? false;
  final uiScale = prefs.getDouble('ui_scale') ?? 1.0;

  runApp(ZEditorRoot(
    initialLocale: locale,
    initialDarkTheme: isDark,
    initialUiScale: uiScale.toDouble(),
    prefs: prefs,
  ));
}

class ZEditorRoot extends StatefulWidget {
  const ZEditorRoot({
    super.key,
    required this.initialLocale,
    required this.initialDarkTheme,
    required this.initialUiScale,
    required this.prefs,
  });

  final Locale initialLocale;
  final bool initialDarkTheme;
  final double initialUiScale;
  final SharedPreferences prefs;

  @override
  State<ZEditorRoot> createState() => _ZEditorRootState();
}

class _ZEditorRootState extends State<ZEditorRoot> {
  late Locale _locale;
  late bool _isDarkTheme;
  late double _uiScale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
    _isDarkTheme = widget.initialDarkTheme;
    _uiScale = widget.initialUiScale;
  }

  void _onLocaleChanged(Locale locale) {
    setState(() => _locale = locale);
    widget.prefs.setString('locale', locale.languageCode);
  }

  void _onToggleTheme() {
    setState(() => _isDarkTheme = !_isDarkTheme);
    widget.prefs.setBool('dark_theme', _isDarkTheme);
  }

  void _onUiScaleChange(double scale) {
    setState(() => _uiScale = scale);
    widget.prefs.setDouble('ui_scale', scale);
  }

  @override
  Widget build(BuildContext context) {
    return ZEditorApp(
      locale: _locale,
      onLocaleChanged: _onLocaleChanged,
      isDarkTheme: _isDarkTheme,
      onToggleTheme: _onToggleTheme,
      uiScale: _uiScale,
      onUiScaleChange: _onUiScaleChange,
    );
  }
}
