
import 'package:z_editor/data/pvz_models.dart';

/// JSON sync utilities. Ported from Z-Editor-master EditorUtils.kt
/// Provides helpers for syncing typed data with PvzObject.objData.

/// Parses int flexibly from JSON (handles both number and string).
int? parseFlexibleInt(dynamic json) {
  if (json == null) return null;
  if (json is int) return json;
  if (json is num) return json.toInt();
  if (json is String) return int.tryParse(json);
  return null;
}

/// Parses double flexibly from JSON (handles both number and string).
double? parseFlexibleDouble(dynamic json) {
  if (json == null) return null;
  if (json is num) return json.toDouble();
  if (json is String) return double.tryParse(json);
  return null;
}

/// Merges UI data into base JSON and writes back to obj.objData.
/// Used when you have a typed model and want to sync changes to PvzObject.
void syncObjData(PvzObject obj, Map<String, dynamic> uiData) {
  final current = obj.objData;
  Map<String, dynamic> base;
  if (current is Map) {
    base = Map<String, dynamic>.from(current);
  } else {
    base = {};
  }
  for (final e in uiData.entries) {
    base[e.key] = e.value;
  }
  obj.objData = base;
}
