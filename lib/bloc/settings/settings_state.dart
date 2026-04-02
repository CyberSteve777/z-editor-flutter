part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    required this.locale,
    required this.themeMode,
    required this.uiScale,
  });

  final Locale locale;
  final ThemeMode themeMode;
  final double uiScale;

  SettingsState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    double? uiScale,
  }) {
    return SettingsState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      uiScale: uiScale ?? this.uiScale,
    );
  }

  @override
  List<Object?> get props => [locale, themeMode, uiScale];
}
