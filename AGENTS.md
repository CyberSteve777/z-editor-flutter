# AGENTS.md

## Cursor Cloud specific instructions

### Project overview

Z-Editor is a cross-platform **Flutter** desktop/mobile/web app — a Level Editor for Plants vs. Zombies 2 Chinese. It is a purely client-side application with no backend services, databases, or Docker containers.

### SDK requirements

- **Flutter SDK ≥ 3.41** (ships with Dart ≥ 3.11, which satisfies the `^3.9.2` constraint in `pubspec.yaml`).
- Flutter is installed at `/home/ubuntu/flutter` and added to PATH via `~/.bashrc`.

### Linux desktop build dependencies

The following system packages are required for `flutter build linux` / `flutter run -d linux`:

- `cmake`, `clang`, `ninja-build`, `lld`, `llvm-18`, `libgtk-3-dev`, `pkg-config`, `liblzma-dev`, `libstdc++-14-dev`

A `libstdc++.so` symlink must exist at `/usr/lib/x86_64-linux-gnu/libstdc++.so` (pointing to `libstdc++.so.6`). If missing, create it: `sudo ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so`.

### Common commands

| Task | Command |
|------|---------|
| Install deps | `flutter pub get` |
| Lint / analyze | `flutter analyze` |
| Run tests | `flutter test` |
| Build Linux | `flutter build linux` |
| Run (debug, Linux) | `flutter run -d linux` |
| Run (debug, Chrome) | `flutter run -d chrome` |

### Gotchas

- The app requires a writable folder configured as its "level library" on first launch. On Linux, set or create a directory and point the app to it from the initial setup screen.
- `flutter analyze` reports ~21 pre-existing info/warning-level lint issues. No errors.
- EGL/DRI3 warnings at app launch (`libEGL warning: DRI3 error`) are expected in headless/container environments and do not affect functionality.
- Localization files under `lib/l10n/` are auto-generated (`generate: true` in `pubspec.yaml`). Do not edit them directly; edit `assets/l10n/*.arb` instead.
