import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_editor/util/3rdParty/sen_buffer.dart';
import 'package:z_editor/util/3rdParty/sen_rton_codec.dart';
import 'package:z_editor/util/hujson_codec.dart';
import 'package:z_editor/util/pvz2c_crypto.dart';

import '../pvz_models.dart';
export '../pvz_models.dart' show PvzLevelFile;

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

/// Native (IO) implementation of LevelRepository. Uses path_provider and dart:io.
class LevelRepository {
  static const _prefsFolderKey = 'folder_path';
  static const _prefsLastLevelDirKey = 'last_level_directory';
  static const Set<String> _levelExtensions = {'.json', '.hujson', '.rton'};

  static Future<String?> getSavedFolderPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsFolderKey);
  }

  static Future<void> setSavedFolderPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsFolderKey, path);
  }

  static Future<void> setLastOpenedLevelDirectory(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsLastLevelDirKey, path);
  }

  static Future<String?> getLastOpenedLevelDirectory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsLastLevelDirKey);
  }

  static Future<String> getCacheDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(p.join(dir.path, 'level_cache'));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir.path;
  }

  static Future<bool> fileExistsInDirectory(String dirPath, String fileName) async {
    final path = p.join(dirPath, fileName);
    return File(path).exists();
  }

  static Future<List<FileItem>> getDirectoryContents(String dirPath) async {
    final dir = Directory(dirPath);
    if (!await dir.exists()) return [];

    final list = <FileItem>[];
    await for (final entity in dir.list()) {
      final stat = await entity.stat();
      final name = p.basename(entity.path);
      final isDir = stat.type == FileSystemEntityType.directory;
      final isLevel = !isDir && isSupportedLevelFileName(name);
      if (isDir || isLevel) {
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

  static bool isSupportedLevelFileName(String name) {
    final lower = name.toLowerCase();
    return _levelExtensions.any(lower.endsWith);
  }

  static String baseNameWithoutLevelExtension(String name) {
    final lower = name.toLowerCase();
    for (final ext in _levelExtensions) {
      if (lower.endsWith(ext)) {
        return name.substring(0, name.length - ext.length);
      }
    }
    return p.basenameWithoutExtension(name);
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
      if (isDirectory) {
        await Directory(oldPath).rename(newPath);
      } else {
        await File(oldPath).rename(newPath);
      }
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

  static Future<String> getNextAvailableNameForTemplate(
    String dirPath,
    String defaultBaseName,
  ) async {
    final items = await getDirectoryContents(dirPath);
    final existing = items.map((f) => baseNameWithoutLevelExtension(f.name).toLowerCase()).toSet();
    final base = defaultBaseName;
    if (!existing.contains(base.toLowerCase())) return base;
    var candidate = '${base}_copy';
    if (!existing.contains(candidate.toLowerCase())) return candidate;
    var n = 1;
    while (existing.contains('${base}_copy$n'.toLowerCase())) n++;
    return '${base}_copy$n';
  }

  static Future<String> getNextAvailableCopyName(String dirPath, String baseNameWithoutExt) async {
    final items = await getDirectoryContents(dirPath);
    final existing = items.map((f) => baseNameWithoutLevelExtension(f.name).toLowerCase()).toSet();
    var candidate = '${baseNameWithoutExt}_copy';
    if (!existing.contains(candidate.toLowerCase())) return candidate;
    var n = 2;
    while (existing.contains('${candidate}$n'.toLowerCase())) n++;
    return '$candidate$n';
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

  static Future<bool> moveFileOverwriting(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    if (srcDirPath == destDirPath) return false;
    final srcPath = p.join(srcDirPath, fileName);
    final destPath = p.join(destDirPath, fileName);
    try {
      if (await File(destPath).exists()) await File(destPath).delete();
      await File(srcPath).rename(destPath);
      final cacheDir = await getCacheDir();
      final cacheFile = File(p.join(cacheDir, fileName));
      if (await cacheFile.exists()) await cacheFile.delete();
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<String?> moveFileAsCopy(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    final baseName = baseNameWithoutLevelExtension(fileName);
    final suggested = await getNextAvailableCopyName(destDirPath, baseName);
    final newFileName = '$suggested.json';
    return moveFileWithName(srcDirPath, fileName, destDirPath, newFileName);
  }

  static Future<String?> moveFileWithName(
    String srcDirPath,
    String fileName,
    String destDirPath,
    String newFileName,
  ) async {
    if (srcDirPath == destDirPath) return null;
    final srcPath = p.join(srcDirPath, fileName);
    try {
      final copied = await copyLevelToTarget(srcPath, destDirPath, newFileName);
      if (!copied) return null;
      await deleteItem(srcDirPath, fileName, false);
      return newFileName;
    } catch (_) {
      return null;
    }
  }

  static Future<int> clearAllInternalCache() async {
    final cacheDir = await getCacheDir();
    final dir = Directory(cacheDir);
    int count = 0;
    await for (final entity in dir.list()) {
      if (entity is File && isSupportedLevelFileName(p.basename(entity.path))) {
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

  /// Web-only; no-op on native.
  static Future<bool> prepareInternalCacheFromBytes(String fileName, List<int> bytes) async {
    return false;
  }

  static Future<PvzLevelFile?> loadLevel(String fileName) async {
    final cacheDir = await getCacheDir();
    final file = File(p.join(cacheDir, fileName));
    if (!await file.exists()) return null;
    try {
      final bytes = await file.readAsBytes();
      return _decodeLevelBytes(fileName, bytes);
    } catch (_) {
      return null;
    }
  }

  static Future<PvzLevelFile?> loadLevelFromPath(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return null;
    try {
      final bytes = await file.readAsBytes();
      return _decodeLevelBytes(p.basename(filePath), bytes);
    } catch (_) {
      return null;
    }
  }

  /// No-op on IO; used on web to trigger single-level download.
  static Future<void> downloadLevel(String fileName) async {}

  /// No-op on IO; used on web to trigger zip download of all cached levels.
  static Future<void> downloadAllLevelsAsZip() async {}

  static Future<void> saveAndExport(String filePath, PvzLevelFile levelData) async {
    final fileName = p.basename(filePath);
    final bytes = _encodeLevelBytes(fileName, levelData);
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    final cacheDir = await getCacheDir();
    final cachePath = p.join(cacheDir, fileName);
    await File(cachePath).writeAsBytes(bytes, flush: true);
  }

  static Future<String?> convertLevelFile({
    required String sourcePath,
    required String sourceName,
    required String targetExtension,
    String? targetName,
  }) async {
    final srcFile = File(sourcePath);
    if (!await srcFile.exists()) return null;
    final parent = p.dirname(sourcePath);
    final base = baseNameWithoutLevelExtension(sourceName);
    final target = targetName ?? '$base$targetExtension';
    final targetPath = p.join(parent, target);
    if (await File(targetPath).exists()) return null;
    final level = _decodeLevelBytes(sourceName, await srcFile.readAsBytes());
    if (level == null) return null;
    final outBytes = _encodeLevelBytes(target, level);
    await File(targetPath).writeAsBytes(outBytes, flush: true);
    return target;
  }

  static Future<String> getFirstAvailableIndexedName(
    String dirPath,
    String baseName,
    String extension,
  ) async {
    var i = 1;
    while (true) {
      final candidate = '${baseName}_$i$extension';
      if (!await fileExistsInDirectory(dirPath, candidate)) return candidate;
      i++;
    }
  }

  static PvzLevelFile? _decodeLevelBytes(String fileName, Uint8List bytes) {
    final lower = fileName.toLowerCase();
    try {
      if (lower.endsWith('.json')) {
        return PvzLevelFile.fromJson(jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>);
      }
      if (lower.endsWith('.hujson')) {
        final plain = HuJsonCodec.decode(bytes);
        return PvzLevelFile.fromJson(jsonDecode(utf8.decode(plain)) as Map<String, dynamic>);
      }
      if (lower.endsWith('.rton')) {
        final plainRton = HuJsonCodec.decode(bytes);
        final buf = SenBuffer.fromBytes(plainRton);
        final rton = ReflectionObjectNotation();
        final encrypted =
            plainRton.length >= 2 && plainRton[0] == 0x10 && plainRton[1] == 0x00;
        final jsonMap = rton.decodeRTON(
          buf,
          encrypted,
          encrypted ? RijndaelC.defaultValue() : null,
          null,
        );
        return PvzLevelFile.fromJson(Map<String, dynamic>.from(jsonMap as Map));
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  static Uint8List _encodeLevelBytes(String fileName, PvzLevelFile data) {
    final lower = fileName.toLowerCase();
    final jsonText = const JsonEncoder.withIndent('  ').convert(data.toJson());
    final jsonBytes = Uint8List.fromList(utf8.encode(jsonText));
    if (lower.endsWith('.json')) return jsonBytes;
    if (lower.endsWith('.hujson')) return HuJsonCodec.encode(jsonBytes);
    if (lower.endsWith('.rton')) {
      final rton = ReflectionObjectNotation();
      final senOut = rton.encodeRTON(data.toJson(), false, null, null);
      return HuJsonCodec.encode(senOut.toBytes());
    }
    return jsonBytes;
  }

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
