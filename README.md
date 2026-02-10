# z_editor

Level Editor for Plants vs. Zombies 2 Chinese

## Windows keyboard fix

On Windows, you may hit a Flutter bug where pressing any key causes:
`KeyDownEvent is dispatched, but the physical key is already pressed` and typing stops.

**Fix**: Run the patch script (modifies Flutter SDK):
```powershell
powershell -ExecutionPolicy Bypass -File tool\patch_flutter_keyboard.ps1
```
Then restart the app. Re-run the script after `flutter upgrade`.

**Alternative**: Run in release mode (assertions disabled):
```bash
flutter run -d windows --release
```

See [Flutter issue #125975](https://github.com/flutter/flutter/issues/125975).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
