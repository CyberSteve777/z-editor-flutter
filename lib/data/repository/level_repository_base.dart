import 'dart:convert';
import 'dart:typed_data';

import 'package:z_editor/util/3rdParty/sen_buffer.dart';
import 'package:z_editor/util/3rdParty/sen_rton_codec.dart';
import 'package:z_editor/util/hujson_codec.dart';
import 'package:z_editor/util/pvz2c_crypto.dart';

import '../pvz_models.dart';

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

abstract class LevelRepositoryBase {
  static const Set<String> levelExtensions = {'.json', '.hujson', '.rton', '.zlib', '.bin'};

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

  Future<String?> getSavedFolderPath();
  Future<void> setSavedFolderPath(String path);
  Future<void> setLastOpenedLevelDirectory(String path);
  Future<String?> getLastOpenedLevelDirectory();
  Future<String> getCacheDir();
  Future<bool> fileExistsInDirectory(String dirPath, String fileName);
  Future<List<FileItem>> getDirectoryContents(String dirPath);
  Future<bool> createDirectory(String parentPath, String name);
  Future<bool> renameItem(
    String currentDirPath,
    String oldName,
    String newName,
    bool isDirectory,
  );
  Future<void> deleteItem(
    String currentDirPath,
    String fileName,
    bool isDirectory,
  );
  Future<bool> copyLevelToTarget(
    String srcPath,
    String targetDirPath,
    String targetFileName,
  );
  Future<bool> moveFile(String srcDirPath, String fileName, String destDirPath);
  Future<bool> moveFileOverwriting(
    String srcDirPath,
    String fileName,
    String destDirPath,
  );
  Future<String?> moveFileWithName(
    String srcDirPath,
    String fileName,
    String destDirPath,
    String newFileName,
  );
  Future<int> clearAllInternalCache();
  Future<bool> prepareInternalCache(String sourcePath, String fileName);
  Future<bool> prepareInternalCacheFromBytes(String fileName, List<int> bytes);
  Future<bool> prepareInternalCacheFromString(String fileName, String content);
  Future<PvzLevelFile?> loadLevel(String fileName);
  Future<PvzLevelFile?> loadLevelFromPath(String filePath);
  Future<void> saveAndExport(String filePath, PvzLevelFile levelData);
  Future<void> downloadLevel(String fileName);
  Future<void> downloadAllLevelsAsZip();
  Future<bool> createLevelFromTemplate(
    String currentDirPath,
    String templateName,
    String newFileName,
    String assetContent,
  );
  Future<String?> convertLevelFile({
    required String sourcePath,
    required String sourceName,
    required String targetExtension,
    String? targetName,
  });

  bool isSupportedLevelFileName(String name) {
    final lower = name.toLowerCase();
    return levelExtensions.any(lower.endsWith);
  }

  String baseNameWithoutLevelExtension(String name) {
    final lower = name.toLowerCase();
    for (final ext in levelExtensions) {
      if (lower.endsWith(ext)) {
        return name.substring(0, name.length - ext.length);
      }
    }
    final idx = name.lastIndexOf('.');
    if (idx <= 0) return name;
    return name.substring(0, idx);
  }

  Future<String> getNextAvailableNameForTemplate(
    String dirPath,
    String defaultBaseName,
  ) async {
    final items = await getDirectoryContents(dirPath);
    final existing = items
        .map((f) => baseNameWithoutLevelExtension(f.name).toLowerCase())
        .toSet();
    final base = defaultBaseName;
    if (!existing.contains(base.toLowerCase())) return base;
    var candidate = '${base}_copy';
    if (!existing.contains(candidate.toLowerCase())) return candidate;
    var n = 1;
    while (existing.contains('${base}_copy$n'.toLowerCase())) {
      n++;
    }
    return '${base}_copy$n';
  }

  Future<String> getNextAvailableCopyName(
    String dirPath,
    String baseNameWithoutExt,
  ) async {
    final items = await getDirectoryContents(dirPath);
    final existing = items
        .map((f) => baseNameWithoutLevelExtension(f.name).toLowerCase())
        .toSet();
    var candidate = '${baseNameWithoutExt}_copy';
    if (!existing.contains(candidate.toLowerCase())) return candidate;
    var n = 2;
    while (existing.contains('${candidate}$n'.toLowerCase())) {
      n++;
    }
    return '$candidate$n';
  }

  Future<String?> moveFileAsCopy(
    String srcDirPath,
    String fileName,
    String destDirPath,
  ) async {
    final baseName = baseNameWithoutLevelExtension(fileName);
    final suggested = await getNextAvailableCopyName(destDirPath, baseName);
    final newFileName = '$suggested.json';
    return moveFileWithName(srcDirPath, fileName, destDirPath, newFileName);
  }

  Future<List<String>> getTemplateList() async {
    return List.from(defaultTemplateList);
  }

  List<String> parseTemplateManifest(String jsonString) {
    try {
      final list = jsonDecode(jsonString) as List<dynamic>?;
      if (list == null) return [];
      return list
          .map((e) => e.toString())
          .where((s) => s.endsWith('.json'))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<String> getFirstAvailableIndexedName(
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

  int naturalCompare(String a, String b) {
    int i = 0;
    int j = 0;
    while (i < a.length && j < b.length) {
      final c1 = a[i];
      final c2 = b[j];
      if (_isDigit(c1) && _isDigit(c2)) {
        int num1 = 0;
        while (i < a.length && _isDigit(a[i])) {
          num1 = num1 * 10 + int.parse(a[i++]);
        }
        int num2 = 0;
        while (j < b.length && _isDigit(b[j])) {
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

  PvzLevelFile? decodeLevelBytes(String fileName, Uint8List bytes) {
    final lower = fileName.toLowerCase();
    try {
      if (lower.endsWith('.json')) {
        return PvzLevelFile.fromJson(
          jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>,
        );
      }
      if (lower.endsWith('.hujson')) {
        final plain = HuJsonCodec.decode(bytes);
        return PvzLevelFile.fromJson(
          jsonDecode(utf8.decode(plain)) as Map<String, dynamic>,
        );
      }
      if (lower.endsWith('.rton')) {
        final buf = SenBuffer.fromBytes(bytes);
        final rton = ReflectionObjectNotation();
        final jsonMap = rton.decodeRTON(
          buf,
          true,
          RijndaelC.defaultValue(),
          null,
        );
        return PvzLevelFile.fromJson(Map<String, dynamic>.from(jsonMap as Map));
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  Uint8List encodeLevelBytes(String fileName, PvzLevelFile data) {
    final lower = fileName.toLowerCase();
    final jsonText = const JsonEncoder.withIndent('\t').convert(data.toJson());
    final jsonBytes = Uint8List.fromList(utf8.encode(jsonText));
    if (lower.endsWith('.json')) return jsonBytes;
    if (lower.endsWith('.hujson')) return HuJsonCodec.encode(jsonBytes);
    if (lower.endsWith('.rton')) {
      final rton = ReflectionObjectNotation();
      final senOut = rton.encodeRTON(
        data.toJson(),
        true,
        RijndaelC.defaultValue(),
        null,
      );
      return senOut.toBytes();
    }
    return jsonBytes;
  }

  bool _isDigit(String c) => c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
}
