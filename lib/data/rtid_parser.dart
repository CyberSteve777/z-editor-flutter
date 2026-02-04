/// RTID parser: RTID(Alias@Source) e.g. RTID(DefaultSunDropper@LevelModules)
/// Ported from Z-Editor-master data/RtidParser.kt
library;

class RtidInfo {
  RtidInfo({
    required this.alias,
    required this.source,
    required this.fullString,
  });

  final String alias;
  final String source;
  final String fullString;

  @override
  String toString() => fullString;
}

abstract class RtidParser {
  static final _regex = RegExp(r'RTID\((.*)@(.*)\)');

  /// Parses RTID(Alias@Source). Returns null if invalid.
  static RtidInfo? parse(String rtid) {
    if (rtid.trim().isEmpty) return null;
    final match = _regex.firstMatch(rtid);
    if (match == null) return null;
    return RtidInfo(
      alias: match.group(1)!,
      source: match.group(2)!,
      fullString: rtid,
    );
  }

  /// Builds standard RTID string.
  static String build(String alias, [String source = 'LevelModules']) {
    return 'RTID($alias@$source)';
  }
}
