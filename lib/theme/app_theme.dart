import 'package:flutter/material.dart';

// PVZ2-style colors from Z-Editor-master Color.kt
const Color _pvzGreenPrimary = Color(0xFF4CAF50);
const Color _pvzGreenDark = Color(0xFF2E7D32);
const Color _pvzGreenContainer = Color(0xFFC8E6C9);
const Color _pvzBluePrimary = Color(0xFF2196F3);

/// Orange accent for Custom Zombie Properties (matches Kotlin PvzOrangeLight/Dark)
const Color pvzOrangeLight = Color(0xFFE8A000);
const Color pvzOrangeDark = Color(0xFFD5925E);

/// Purple for Custom Zombie card in Wave Timeline (matches Kotlin PvzPurpleLight/Dark)
const Color pvzPurpleLight = Color(0xFF673AB7);
const Color pvzPurpleDark = Color(0xFF8F76BB);

/// Usage guide card: dark blue in dark mode, light blue in light mode
const Color usageGuideDarkBg = Color(0xFF1C4D7C);
const Color usageGuideLightBg = Color(0xFFB3E5FC);
const Color usageGuideLightOnBg = Color(0xFF01579B);

const Color _darkSurface = Color(0xFF1E1E1E);
const Color _darkSurfaceVariant = Color(0xFF2C2C2C);
const Color _darkOnSurface = Color(0xFFE0E0E0);
const Color _darkOnSurfaceVariant = Color(0xFFB0B0B0);

const Color _lightSurface = Colors.white;
const Color _lightSurfaceVariant = Color(0xFFE8E8E8);
const Color _lightOnSurface = Color(0xFF212121);
const Color _lightOnSurfaceVariant = Color(0xFF616161);

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: _pvzGreenPrimary,
      onPrimary: Colors.white,
      primaryContainer: _pvzGreenContainer,
      onPrimaryContainer: _pvzGreenDark,
      secondary: _pvzBluePrimary,
      onSecondary: Colors.white,
      surface: _lightSurface,
      onSurface: _lightOnSurface,
      surfaceContainerHighest: _lightSurfaceVariant,
      onSurfaceVariant: _lightOnSurfaceVariant,
      error: Colors.red.shade700,
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 2,
    ),
  );
}

ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: _pvzGreenPrimary,
      onPrimary: Colors.black87,
      primaryContainer: _pvzGreenDark,
      onPrimaryContainer: Colors.white,
      secondary: _pvzBluePrimary,
      onSecondary: Colors.black87,
      surface: _darkSurface,
      onSurface: _darkOnSurface,
      surfaceContainerHighest: _darkSurfaceVariant,
      onSurfaceVariant: _darkOnSurfaceVariant,
      error: Colors.red.shade400,
      onError: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 2,
    ),
  );
}
