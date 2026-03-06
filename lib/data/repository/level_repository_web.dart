import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

import '../pvz_models.dart';
export '../pvz_models.dart' show PvzLevelFile;

/// Virtual path prefix for web - files opened via picker have no real path.
const String _webPathPrefix = 'web://';

/// Returns the cache key (file name) for a path. Strips [_webPathPrefix] so we never
/// use "web://filename" as a cache key, which would create duplicate list entries.
String _fileNameFromPath(String filePath) {
  if (filePath.startsWith(_webPathPrefix)) {
    return filePath.substring(_webPathPrefix.length);
  }
  return p.basename(filePath);
}

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

/// Web implementation of LevelRepository. No path_provider or dart:io.
/// Uses in-memory cache and file picker for PWA compatibility.
class LevelRepository {
  static const _prefsFolderKey = 'folder_path';
  static const _prefsLastLevelDirKey = 'last_level_directory';

  static final Map<String, String> _memoryCache = {};

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
    return _webPathPrefix;
  }

  static Future<bool> fileExistsInDirectory(String dirPath, String fileName) async {
    return _memoryCache.containsKey(fileName);
  }

  static Future<List<FileItem>> getDirectoryContents(String dirPath) async {
    if (!dirPath.startsWith(_webPathPrefix)) return [];
    final items = _memoryCache.keys.map((name) => FileItem(
      name: name,
      path: '$_webPathPrefix$name',
      isDirectory: false,
      lastModified: 0,
      size: (_memoryCache[name]?.length ?? 0) * 2,
    )).toList();
    items.sort((a, b) => _naturalCompare(a.name, b.name));
    return items;
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
    return false;
  }

  static Future<bool> renameItem(
    String currentDirPath,
    String oldName,
    String newName,
    bool isDirectory,
  ) async {
    if (isDirectory) return false;
    if (!_memoryCache.containsKey(oldName)) return false;
    if (_memoryCache.containsKey(newName)) return false;
    final content = _memoryCache.remove(oldName)!;
    _memoryCache[newName] = content;
    return true;
  }

  static Future<void> deleteItem(
    String currentDirPath,
    String fileName,
    bool isDirectory,
  ) async {
    if (isDirectory) return;
    _memoryCache.remove(fileName);
  }

  static Future<String> getNextAvailableNameForTemplate(
    String dirPath,
    String defaultBaseName,
  ) async {
    final items = await getDirectoryContents(dirPath);
    final existing = items
        .map((f) => f.name.toLowerCase().replaceFirst(RegExp(r'\.json$'), ''))
        .toSet();
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
    final existing = items
        .map((f) => f.name.toLowerCase().replaceFirst(RegExp(r'\.json$'), ''))
        .toSet();
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
    final srcName = _fileNameFromPath(srcPath);
    if (!_memoryCache.containsKey(srcName)) return false;
    if (_memoryCache.containsKey(targetFileName)) return false;
    _memoryCache[targetFileName] = _memoryCache[srcName]!;
    return true;
  }

  static Future<bool> moveFile(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    if (srcDirPath == destDirPath) return false;
    if (!_memoryCache.containsKey(fileName)) return false;
    return true;
  }

  static Future<bool> moveFileOverwriting(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    if (srcDirPath == destDirPath) return false;
    if (!_memoryCache.containsKey(fileName)) return false;
    return true;
  }

  static Future<String?> moveFileAsCopy(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    final baseName = fileName.replaceFirst(RegExp(r'\.json$', caseSensitive: false), '');
    final suggested = await getNextAvailableCopyName(destDirPath, baseName);
    final newFileName = suggested.toLowerCase().endsWith('.json') ? suggested : '$suggested.json';
    return moveFileWithName(srcDirPath, fileName, destDirPath, newFileName);
  }

  static Future<String?> moveFileWithName(
    String srcDirPath,
    String fileName,
    String destDirPath,
    String newFileName,
  ) async {
    if (srcDirPath == destDirPath) return null;
    if (!_memoryCache.containsKey(fileName)) return null;
    if (_memoryCache.containsKey(newFileName)) return null;
    _memoryCache[newFileName] = _memoryCache.remove(fileName)!;
    return newFileName;
  }

  static Future<int> clearAllInternalCache() async {
    final count = _memoryCache.length;
    _memoryCache.clear();
    return count;
  }

  static Future<bool> prepareInternalCache(String sourcePath, String fileName) async {
    return _memoryCache.containsKey(fileName);
  }

  static Future<bool> prepareInternalCacheFromBytes(String fileName, List<int> bytes) async {
    return prepareInternalCacheFromString(fileName, String.fromCharCodes(bytes));
  }

  static Future<bool> prepareInternalCacheFromString(String fileName, String content) async {
    _memoryCache[fileName] = content;
    return true;
  }

  static Future<PvzLevelFile?> loadLevel(String fileName) async {
    final content = _memoryCache[fileName];
    if (content == null) return null;
    try {
      final json = jsonDecode(content) as Map<String, dynamic>;
      return PvzLevelFile.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  static Future<PvzLevelFile?> loadLevelFromPath(String filePath) async {
    final fileName = _fileNameFromPath(filePath);
    return loadLevel(fileName);
  }

  static Future<void> saveAndExport(String filePath, PvzLevelFile levelData) async {
    final fileName = _fileNameFromPath(filePath);
    final content = const JsonEncoder.withIndent('  ').convert(levelData.toJson());
    _memoryCache[fileName] = content;
    // No auto-download on save; use downloadLevel() or download button to export.
  }

  /// Triggers a download of a single level by file name (web only).
  static Future<void> downloadLevel(String fileName) async {
    final content = _memoryCache[fileName];
    if (content == null) return;
    await _triggerDownload(fileName, content);
  }

  /// Builds a zip of all cached levels and triggers download (web only).
  static Future<void> downloadAllLevelsAsZip() async {
    if (_memoryCache.isEmpty) return;
    final archive = Archive();
    for (final entry in _memoryCache.entries) {
      final name = entry.key;
      final content = entry.value;
      final bytes = Uint8List.fromList(content.codeUnits);
      archive.addFile(ArchiveFile(name, bytes.length, bytes));
    }
    final zipBytes = ZipEncoder().encode(archive);
    await _triggerDownloadBytes('levels.zip', Uint8List.fromList(zipBytes));
  }

  static Future<void> _triggerDownload(String fileName, String content) async {
    await FilePicker.platform.saveFile(
      dialogTitle: 'Save level',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: ['json'],
      bytes: Uint8List.fromList(content.codeUnits),
    );
  }

  static Future<void> _triggerDownloadBytes(String fileName, Uint8List bytes) async {
    await FilePicker.platform.saveFile(
      dialogTitle: 'Save file',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: const ['zip'],
      bytes: bytes,
    );
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
    if (_memoryCache.containsKey(newFileName)) return false;
    _memoryCache[newFileName] = assetContent;
    return true;
  }
}
