import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pvz_models.dart';

class FileItem {
  FileItem({
    required this.name,
    required this.path,
    required this.isDirectory,
    required this.lastModified,
    required this.size,
  });

  final String name;
  final String path;
  final bool isDirectory;
  final int lastModified;
  final int size;
}

class LevelRepository {
  static const _prefsFolderKey = 'folder_path';

  static Future<String?> getSavedFolderPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsFolderKey);
  }

  static Future<void> setSavedFolderPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsFolderKey, path);
  }

  static Future<String> getCacheDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(p.join(dir.path, 'level_cache'));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir.path;
  }

  static Future<List<FileItem>> getDirectoryContents(String dirPath) async {
    final dir = Directory(dirPath);
    if (!await dir.exists()) return [];

    final list = <FileItem>[];
    await for (final entity in dir.list()) {
      final stat = await entity.stat();
      final name = p.basename(entity.path);
      final isDir = stat.type == FileSystemEntityType.directory;
      final isJson = !isDir && name.toLowerCase().endsWith('.json');
      if (isDir || isJson) {
        list.add(FileItem(
          name: name,
          path: entity.path,
          isDirectory: isDir,
          lastModified: stat.modified.millisecondsSinceEpoch,
          size: stat.size,
        ));
      }
    }

    list.sort((a, b) {
      if (a.isDirectory != b.isDirectory) return a.isDirectory ? -1 : 1;
      return _naturalCompare(a.name, b.name);
    });
    return list;
  }

  static int _naturalCompare(String a, String b) {
    int i = 0, j = 0;
    while (i < a.length && j < b.length) {
      final c1 = a[i];
      final c2 = b[j];
      if (RegExp(r'\d').hasMatch(c1) && RegExp(r'\d').hasMatch(c2)) {
        int num1 = 0;
        while (i < a.length && RegExp(r'\d').hasMatch(a[i])) {
          num1 = num1 * 10 + int.parse(a[i++]);
        }
        int num2 = 0;
        while (j < b.length && RegExp(r'\d').hasMatch(b[j])) {
          num2 = num2 * 10 + int.parse(b[j++]);
        }
        if (num1 != num2) return num1.compareTo(num2);
      } else {
        if (c1 != c2) return c1.compareTo(c2);
        i++;
        j++;
      }
    }
    return a.length.compareTo(b.length);
  }

  static Future<bool> createDirectory(String parentPath, String name) async {
    final dir = Directory(p.join(parentPath, name));
    if (await dir.exists()) return false;
    await dir.create(recursive: true);
    return true;
  }

  static Future<bool> renameItem(
    String currentDirPath,
    String oldName,
    String newName,
    bool isDirectory,
  ) async {
    final oldPath = p.join(currentDirPath, oldName);
    final newPath = p.join(currentDirPath, newName);
    if (await File(newPath).exists() || await Directory(newPath).exists()) return false;
    try {
      await File(oldPath).rename(newPath);
      if (!isDirectory) {
        final cacheDir = await getCacheDir();
        final oldCache = p.join(cacheDir, oldName);
        final newCache = p.join(cacheDir, newName);
        if (await File(oldCache).exists()) {
          await File(oldCache).rename(newCache);
        }
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> deleteItem(
    String currentDirPath,
    String fileName,
    bool isDirectory,
  ) async {
    final targetPath = p.join(currentDirPath, fileName);
    if (isDirectory) {
      await Directory(targetPath).delete(recursive: true);
    } else {
      await File(targetPath).delete();
      final cacheDir = await getCacheDir();
      final cacheFile = File(p.join(cacheDir, fileName));
      if (await cacheFile.exists()) await cacheFile.delete();
    }
  }

  static Future<bool> copyLevelToTarget(
    String srcPath,
    String targetDirPath,
    String targetFileName,
  ) async {
    final destPath = p.join(targetDirPath, targetFileName);
    if (await File(destPath).exists()) return false;
    try {
      await File(srcPath).copy(destPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> moveFile(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    if (srcDirPath == destDirPath) return false;
    final srcPath = p.join(srcDirPath, fileName);
    final destPath = p.join(destDirPath, fileName);
    if (await File(destPath).exists()) return false;
    try {
      await File(srcPath).rename(destPath);
      final cacheDir = await getCacheDir();
      final cacheFile = File(p.join(cacheDir, fileName));
      if (await cacheFile.exists()) await cacheFile.delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<int> clearAllInternalCache() async {
    final cacheDir = await getCacheDir();
    final dir = Directory(cacheDir);
    int count = 0;
    await for (final entity in dir.list()) {
      if (entity is File && entity.path.toLowerCase().endsWith('.json')) {
        await entity.delete();
        count++;
      }
    }
    return count;
  }

  static Future<bool> prepareInternalCache(String sourcePath, String fileName) async {
    try {
      final cacheDir = await getCacheDir();
      final destPath = p.join(cacheDir, fileName);
      await File(sourcePath).copy(destPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<PvzLevelFile?> loadLevel(String fileName) async {
    final cacheDir = await getCacheDir();
    final file = File(p.join(cacheDir, fileName));
    if (!await file.exists()) return null;
    try {
      final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      return PvzLevelFile.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  /// Load level directly from file path. Use when cache-based load fails
  /// (e.g. after switching to another directory).
  static Future<PvzLevelFile?> loadLevelFromPath(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return null;
    try {
      final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      return PvzLevelFile.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  static Future<void> saveAndExport(String filePath, PvzLevelFile levelData) async {
    final file = File(filePath);
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(levelData.toJson()),
    );
    final cacheDir = await getCacheDir();
    final fileName = p.basename(filePath);
    final cachePath = p.join(cacheDir, fileName);
    await file.copy(cachePath);
  }

  /// Default template list (English filenames). UI may override with manifest.
  static const List<String> defaultTemplateList = [
    '1_blank_level.json',
    '2_card_pick_example.json',
    '3_conveyor_example.json',
    '4_last_stand_example.json',
    '5_i_zombie_example.json',
    '6_vase_breaker_example.json',
    '7_zomboss_example.json',
    '8_custom_zombie_example.json',
    '9_i_plant_example.json',
  ];

  static Future<List<String>> getTemplateList() async {
    return List.from(defaultTemplateList);
  }

  /// Parse manifest JSON string to list of template filenames.
  static List<String> parseTemplateManifest(String jsonString) {
    try {
      final list = jsonDecode(jsonString) as List<dynamic>?;
      if (list == null) return [];
      return list.map((e) => e.toString()).where((s) => s.endsWith('.json')).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<bool> createLevelFromTemplate(
    String currentDirPath,
    String templateName,
    String newFileName,
    String assetContent,
  ) async {
    final destPath = p.join(currentDirPath, newFileName);
    if (await File(destPath).exists()) return false;
    try {
      await File(destPath).writeAsString(assetContent);
      return true;
    } catch (_) {
      return false;
    }
  }
}
