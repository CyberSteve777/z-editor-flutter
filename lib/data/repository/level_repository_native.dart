import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_editor/util/3rdParty/sen_popcap_zlib.dart';
import 'package:z_editor/util/3rdParty/sen_buffer.dart';

import '../pvz_models.dart';
import 'level_repository_base.dart';

LevelRepositoryBase createLevelRepository() => LevelRepositoryNativeImpl();

class LevelRepositoryNativeImpl extends LevelRepositoryBase {
  static const _prefsFolderKey = 'folder_path';
  static const _prefsLastLevelDirKey = 'last_level_directory';

  @override
  Future<String?> getSavedFolderPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsFolderKey);
  }

  @override
  Future<void> setSavedFolderPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsFolderKey, path);
  }

  @override
  Future<void> setLastOpenedLevelDirectory(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsLastLevelDirKey, path);
  }

  @override
  Future<String?> getLastOpenedLevelDirectory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_prefsLastLevelDirKey);
  }

  @override
  Future<String> getCacheDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(p.join(dir.path, 'level_cache'));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir.path;
  }

  @override
  Future<bool> fileExistsInDirectory(String dirPath, String fileName) async {
    final path = p.join(dirPath, fileName);
    return File(path).exists();
  }

  @override
  Future<List<FileItem>> getDirectoryContents(String dirPath) async {
    final dir = Directory(dirPath);
    if (!await dir.exists()) return [];

    final list = <FileItem>[];
    await for (final entity in dir.list()) {
      final stat = await entity.stat();
      final name = p.basename(entity.path);
      final isDir = stat.type == FileSystemEntityType.directory;
      final isLevel = !isDir && isSupportedLevelFileName(name);
      if (isDir || isLevel) {
        list.add(
          FileItem(
            name: name,
            path: entity.path,
            isDirectory: isDir,
            lastModified: stat.modified.millisecondsSinceEpoch,
            size: stat.size,
          ),
        );
      }
    }

    list.sort((a, b) {
      if (a.isDirectory != b.isDirectory) return a.isDirectory ? -1 : 1;
      return naturalCompare(a.name, b.name);
    });
    return list;
  }

  @override
  Future<bool> createDirectory(String parentPath, String name) async {
    final dir = Directory(p.join(parentPath, name));
    if (await dir.exists()) return false;
    await dir.create(recursive: true);
    return true;
  }

  @override
  Future<bool> renameItem(
    String currentDirPath,
    String oldName,
    String newName,
    bool isDirectory,
  ) async {
    final oldPath = p.join(currentDirPath, oldName);
    final newPath = p.join(currentDirPath, newName);
    if (await File(newPath).exists() || await Directory(newPath).exists()) {
      return false;
    }
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

  @override
  Future<void> deleteItem(
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
      if (await cacheFile.exists()) {
        await cacheFile.delete();
      }
    }
  }

  @override
  Future<bool> copyLevelToTarget(
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

  @override
  Future<bool> moveFile(
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
      if (await cacheFile.exists()) {
        await cacheFile.delete();
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> moveFileOverwriting(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    if (srcDirPath == destDirPath) return false;
    final srcPath = p.join(srcDirPath, fileName);
    final destPath = p.join(destDirPath, fileName);
    try {
      if (await File(destPath).exists()) {
        await File(destPath).delete();
      }
      await File(srcPath).rename(destPath);
      final cacheDir = await getCacheDir();
      final cacheFile = File(p.join(cacheDir, fileName));
      if (await cacheFile.exists()) {
        await cacheFile.delete();
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<String?> moveFileWithName(
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

  @override
  Future<int> clearAllInternalCache() async {
    final cacheDir = await getCacheDir();
    final dir = Directory(cacheDir);
    var count = 0;
    await for (final entity in dir.list()) {
      if (entity is File && isSupportedLevelFileName(p.basename(entity.path))) {
        await entity.delete();
        count++;
      }
    }
    return count;
  }

  @override
  Future<bool> prepareInternalCache(String sourcePath, String fileName) async {
    try {
      final cacheDir = await getCacheDir();
      final destPath = p.join(cacheDir, fileName);
      await File(sourcePath).copy(destPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> prepareInternalCacheFromBytes(
    String fileName,
    List<int> bytes,
  ) async {
    return false;
  }

  @override
  Future<bool> prepareInternalCacheFromString(
    String fileName,
    String content,
  ) async {
    return false;
  }

  @override
  Future<PvzLevelFile?> loadLevel(String fileName) async {
    final cacheDir = await getCacheDir();
    final file = File(p.join(cacheDir, fileName));
    if (!await file.exists()) return null;
    try {
      final bytes = await file.readAsBytes();
      return decodeLevelBytes(fileName, bytes);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<PvzLevelFile?> loadLevelFromPath(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return null;
    try {
      final bytes = await file.readAsBytes();
      return decodeLevelBytes(p.basename(filePath), bytes);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> downloadLevel(String fileName) async {}

  @override
  Future<void> downloadAllLevelsAsZip() async {}

  @override
  Future<void> saveAndExport(String filePath, PvzLevelFile levelData) async {
    final fileName = p.basename(filePath);
    final bytes = encodeLevelBytes(fileName, levelData);
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    final cacheDir = await getCacheDir();
    final cachePath = p.join(cacheDir, fileName);
    await File(cachePath).writeAsBytes(bytes, flush: true);
  }

@override
Future<String?> convertLevelFile({
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

  // ZLib compress — any file → .zlib
  if (targetExtension == '.zlib') {
    try {
      final bytes = await srcFile.readAsBytes();
      final buf = SenBuffer.fromBytes(bytes);
      final compressed = PopCapZlib.compress(buf, false);
      await File(targetPath).writeAsBytes(compressed.toBytes(), flush: true);
      return target;
    } catch (_) {
      return null;
    }
  }

  // ZLib decompress — .zlib → original
  if (sourceName.toLowerCase().endsWith('.zlib')) {
    try {
      final bytes = await srcFile.readAsBytes();
      final buf = SenBuffer.fromBytes(bytes);
      final decompressed = PopCapZlib.uncompress(buf, false);
      await File(targetPath).writeAsBytes(decompressed.toBytes(), flush: true);
      return target;
    } catch (_) {
      return null;
    }
  }

  // existing level format conversion
  final level = decodeLevelBytes(sourceName, await srcFile.readAsBytes());
  if (level == null) return null;
  final outBytes = encodeLevelBytes(target, level);
  await File(targetPath).writeAsBytes(outBytes, flush: true);
  return target;
}

  @override
  Future<bool> createLevelFromTemplate(
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
