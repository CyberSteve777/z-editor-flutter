import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:z_editor/util/3rdParty/sen_buffer.dart';
import 'package:z_editor/util/3rdParty/sen_rton_codec.dart';
import 'package:z_editor/util/hujson_codec.dart';
import 'package:z_editor/util/pvz2c_crypto.dart';


import '../pvz_models.dart';
export '../pvz_models.dart' show PvzLevelFile;

/// Virtual path prefix for web - files opened via picker have no real path.
const String _webPathPrefix = 'web://';

String _normalizeWebDirPath(String path) {
  if (path.isEmpty || path == _webPathPrefix) return _webPathPrefix;
  var value = path;
  if (!value.startsWith(_webPathPrefix)) {
    value = '$_webPathPrefix$value';
  }
  while (value.endsWith('/') && value.length > _webPathPrefix.length) {
    value = value.substring(0, value.length - 1);
  }
  return value;
}

String _webJoin(String dirPath, String name) {
  final dir = _normalizeWebDirPath(dirPath);
  final cleanName = name.replaceAll('\\', '/').trim();
  if (dir == _webPathPrefix) {
    return '$_webPathPrefix$cleanName';
  }
  return '$dir/$cleanName';
}

String _parentWebDir(String path) {
  final normalized = _normalizeWebDirPath(path);
  if (normalized == _webPathPrefix) return _webPathPrefix;
  final idx = normalized.lastIndexOf('/');
  if (idx < _webPathPrefix.length) return _webPathPrefix;
  return normalized.substring(0, idx);
}

String _relativeFromWebPath(String path) {
  final normalized = _normalizeWebDirPath(path);
  if (normalized == _webPathPrefix) return '';
  return normalized.substring(_webPathPrefix.length);
}

String _leafNameFromWebPath(String path) {
  final rel = path.startsWith(_webPathPrefix) ? _relativeFromWebPath(path) : path;
  final clean = rel.replaceAll('\\', '/');
  final idx = clean.lastIndexOf('/');
  return idx >= 0 ? clean.substring(idx + 1) : clean;
}

String _extensionFromName(String name) {
  final leaf = _leafNameFromWebPath(name);
  final idx = leaf.lastIndexOf('.');
  if (idx <= 0 || idx == leaf.length - 1) return '';
  return leaf.substring(idx + 1).toLowerCase();
}

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

  static final Map<String, Uint8List> _memoryCache = {};
  static final Set<String> _directories = {_webPathPrefix};
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
    return _webPathPrefix;
  }

  static Future<bool> fileExistsInDirectory(String dirPath, String fileName) async {
    final filePath = _webJoin(dirPath, fileName);
    final key = _relativeFromWebPath(filePath);
    return _memoryCache.containsKey(key);
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

  static Future<List<FileItem>> getDirectoryContents(String dirPath) async {
    if (!dirPath.startsWith(_webPathPrefix)) return [];
    final normalized = _normalizeWebDirPath(dirPath);
    _directories.add(_webPathPrefix);

    final items = <FileItem>[];

    final childDirs = _directories
        .where((d) => d != normalized && _parentWebDir(d) == normalized)
        .toList();
    for (final dir in childDirs) {
      items.add(
        FileItem(
          name: _leafNameFromWebPath(dir),
          path: dir,
          isDirectory: true,
          lastModified: 0,
          size: 0,
        ),
      );
    }

    for (final entry in _memoryCache.entries) {
      final fullPath = entry.key.startsWith(_webPathPrefix)
          ? _normalizeWebDirPath(entry.key)
          : '$_webPathPrefix${entry.key}';
      if (_parentWebDir(fullPath) != normalized) continue;
      final name = _leafNameFromWebPath(fullPath);
      if (!isSupportedLevelFileName(name)) continue;
      items.add(
        FileItem(
          name: name,
          path: fullPath,
          isDirectory: false,
          lastModified: 0,
          size: entry.value.length,
        ),
      );
    }

    items.sort((a, b) {
      if (a.isDirectory != b.isDirectory) return a.isDirectory ? -1 : 1;
      return _naturalCompare(a.name, b.name);
    });
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
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed.contains('/') || trimmed.contains('\\')) {
      return false;
    }
    final parent = _normalizeWebDirPath(parentPath);
    if (!_directories.contains(parent)) return false;
    final newDir = _webJoin(parent, trimmed);
    if (_directories.contains(newDir)) return false;
    final newKey = _relativeFromWebPath(newDir);
    if (_memoryCache.containsKey(newKey)) return false;
    _directories.add(newDir);
    return true;
  }

  static Future<bool> renameItem(
    String currentDirPath,
    String oldName,
    String newName,
    bool isDirectory,
  ) async {
    final currentDir = _normalizeWebDirPath(currentDirPath);
    final oldPath = _webJoin(currentDir, oldName);
    final newPath = _webJoin(currentDir, newName);
    if (newName.trim().isEmpty || newName.contains('/') || newName.contains('\\')) {
      return false;
    }
    if (isDirectory) {
      if (!_directories.contains(oldPath) || _directories.contains(newPath)) {
        return false;
      }
      final newKey = _relativeFromWebPath(newPath);
      if (_memoryCache.containsKey(newKey)) return false;

      final oldPrefix = '$oldPath/';
      final dirsToRename = _directories
          .where((d) => d == oldPath || d.startsWith(oldPrefix))
          .toList();
      final filesToRename = _memoryCache.entries
          .where((e) => ('$_webPathPrefix${e.key}') == oldPath || ('$_webPathPrefix${e.key}').startsWith(oldPrefix))
          .toList();

      for (final d in dirsToRename) {
        _directories.remove(d);
      }
      for (final d in dirsToRename) {
        final renamed = d == oldPath ? newPath : '$newPath/${d.substring(oldPrefix.length)}';
        _directories.add(renamed);
      }

      for (final e in filesToRename) {
        _memoryCache.remove(e.key);
      }
      for (final e in filesToRename) {
        final full = '$_webPathPrefix${e.key}';
        final renamedFull = full == oldPath ? newPath : '$newPath/${full.substring(oldPrefix.length)}';
        _memoryCache[_relativeFromWebPath(renamedFull)] = e.value;
      }
      return true;
    }

    final oldKey = _relativeFromWebPath(oldPath);
    final newKey = _relativeFromWebPath(newPath);
    if (!_memoryCache.containsKey(oldKey)) return false;
    if (_memoryCache.containsKey(newKey) || _directories.contains(newPath)) return false;
    final content = _memoryCache.remove(oldKey)!;
    _memoryCache[newKey] = content;
    return true;
  }

  static Future<void> deleteItem(
    String currentDirPath,
    String fileName,
    bool isDirectory,
  ) async {
    final currentDir = _normalizeWebDirPath(currentDirPath);
    final targetPath = _webJoin(currentDir, fileName);
    if (isDirectory) {
      final prefix = '$targetPath/';
      _directories.removeWhere((d) => d == targetPath || d.startsWith(prefix));
      _memoryCache.removeWhere((k, _) {
        final full = '$_webPathPrefix$k';
        return full == targetPath || full.startsWith(prefix);
      });
      _directories.add(_webPathPrefix);
      return;
    }
    _memoryCache.remove(_relativeFromWebPath(targetPath));
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
    final srcName = _fileNameFromPath(srcPath);
    final targetPath = _webJoin(targetDirPath, targetFileName);
    final targetKey = _relativeFromWebPath(targetPath);
    if (!_memoryCache.containsKey(srcName)) return false;
    if (_memoryCache.containsKey(targetKey)) return false;
    _memoryCache[targetKey] = _memoryCache[srcName]!;
    return true;
  }

  static Future<bool> moveFile(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    if (srcDirPath == destDirPath) return false;
    final srcKey = _relativeFromWebPath(_webJoin(srcDirPath, fileName));
    final dstKey = _relativeFromWebPath(_webJoin(destDirPath, fileName));
    if (!_memoryCache.containsKey(srcKey) || _memoryCache.containsKey(dstKey)) return false;
    _memoryCache[dstKey] = _memoryCache.remove(srcKey)!;
    return true;
  }

  static Future<bool> moveFileOverwriting(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    if (srcDirPath == destDirPath) return false;
    final srcKey = _relativeFromWebPath(_webJoin(srcDirPath, fileName));
    final dstKey = _relativeFromWebPath(_webJoin(destDirPath, fileName));
    if (!_memoryCache.containsKey(srcKey)) return false;
    _memoryCache.remove(dstKey);
    _memoryCache[dstKey] = _memoryCache.remove(srcKey)!;
    return true;
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
    final srcKey = _relativeFromWebPath(_webJoin(srcDirPath, fileName));
    final dstKey = _relativeFromWebPath(_webJoin(destDirPath, newFileName));
    if (!_memoryCache.containsKey(srcKey)) return null;
    if (_memoryCache.containsKey(dstKey)) return null;
    _memoryCache[dstKey] = _memoryCache.remove(srcKey)!;
    return newFileName;
  }

  static Future<int> clearAllInternalCache() async {
    final count = _memoryCache.length;
    _memoryCache.clear();
    _directories
      ..clear()
      ..add(_webPathPrefix);
    return count;
  }

  static Future<bool> prepareInternalCache(String sourcePath, String fileName) async {
    final sourceKey = _fileNameFromPath(sourcePath);
    if (_memoryCache.containsKey(sourceKey)) return true;
    if (_memoryCache.containsKey(fileName)) return true;
    return false;
  }

  static Future<bool> prepareInternalCacheFromString(String fileName, String content) async {
    _memoryCache[fileName] = Uint8List.fromList(utf8.encode(content));
    var dir = _parentWebDir('$_webPathPrefix$fileName');
    while (true) {
      _directories.add(dir);
      if (dir == _webPathPrefix) break;
      dir = _parentWebDir(dir);
    }
    return true;
  }

  static Future<bool> prepareInternalCacheFromBytes(String fileName, List<int> bytes) async {
    _memoryCache[fileName] = Uint8List.fromList(bytes);
    var dir = _parentWebDir('$_webPathPrefix$fileName');
    while (true) {
      _directories.add(dir);
      if (dir == _webPathPrefix) break;
      dir = _parentWebDir(dir);
    }
    return true;
  }

  static Future<PvzLevelFile?> loadLevel(String fileName) async {
    final content = _memoryCache[fileName];
    if (content == null) return null;
    return _decodeLevelBytes(fileName, content);
  }

  static Future<PvzLevelFile?> loadLevelFromPath(String filePath) async {
    final fileName = _fileNameFromPath(filePath);
    return loadLevel(fileName);
  }

  static Future<void> saveAndExport(String filePath, PvzLevelFile levelData) async {
    final fileName = _fileNameFromPath(filePath);
    _memoryCache[fileName] = _encodeLevelBytes(fileName, levelData);
    // No auto-download on save; use downloadLevel() or download button to export.
  }

  /// Triggers a download of a single level by file name (web only).
  static Future<void> downloadLevel(String fileName) async {
    Uint8List? content = _memoryCache[fileName];
    if (content == null && fileName.startsWith(_webPathPrefix)) {
      content = _memoryCache[_relativeFromWebPath(fileName)];
    }
    if (content == null) {
      final targetLeaf = _leafNameFromWebPath(fileName);
      final matches = _memoryCache.entries
          .where((e) => _leafNameFromWebPath(e.key) == targetLeaf)
          .toList();
      if (matches.length == 1) {
        content = matches.first.value;
        fileName = _leafNameFromWebPath(matches.first.key);
      }
    }
    if (content == null) return;
    final downloadName = _leafNameFromWebPath(fileName);
    final ext = _extensionFromName(downloadName);
    await FilePicker.platform.saveFile(
      dialogTitle: 'Save level',
      fileName: downloadName,
      type: FileType.custom,
      allowedExtensions: [ext.isEmpty ? 'json' : ext],
      bytes: content,
    );
  }

  /// Builds a zip of all cached levels and triggers download (web only).
  static Future<void> downloadAllLevelsAsZip() async {
    if (_memoryCache.isEmpty) return;
    final archive = Archive();
    for (final entry in _memoryCache.entries) {
      final name = entry.key;
      archive.addFile(ArchiveFile(name, entry.value.length, entry.value));
    }
    final zipBytes = ZipEncoder().encode(archive);
    await _triggerDownloadBytes('levels.zip', Uint8List.fromList(zipBytes));
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
    final filePath = _webJoin(currentDirPath, newFileName);
    final key = _relativeFromWebPath(filePath);
    if (_memoryCache.containsKey(key)) return false;
    _memoryCache[key] = Uint8List.fromList(utf8.encode(assetContent));
    return true;
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

  static Future<String?> convertLevelFile({
    required String sourcePath,
    required String sourceName,
    required String targetExtension,
    String? targetName,
  }) async {
    final srcName = _fileNameFromPath(sourcePath);
    final bytes = _memoryCache[srcName];
    if (bytes == null) return null;
    final level = _decodeLevelBytes(sourceName, bytes);
    if (level == null) return null;
    final sourceDir = _parentWebDir('$_webPathPrefix$srcName');
    final targetNameOnly = targetName ?? '${baseNameWithoutLevelExtension(sourceName)}$targetExtension';
    final target = _relativeFromWebPath(_webJoin(sourceDir, targetNameOnly));
    if (_memoryCache.containsKey(target)) return null;
    _memoryCache[target] = _encodeLevelBytes(target, level);
    return target;
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
}
