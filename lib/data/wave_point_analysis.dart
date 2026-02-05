import 'pvz_models.dart';
import 'rtid_parser.dart';
import 'zombie_properties_repository.dart';
 
class WavePointAnalysis {
  static Map<String, double> calculate(
    List<InputEntry> entries,
    int totalPoints,
  ) {
    if (totalPoints <= 0 || entries.isEmpty) {
      return {for (final e in entries) e.id: 0.0};
    }
    final valid = entries.where((e) => e.weight > 0 && e.cost >= 0).toList();
    if (valid.isEmpty) return {};
 
    final safePoints = totalPoints.clamp(0, 20000);
    final n = valid.length;
    final exp = List.generate(n, (_) => List<double>.filled(safePoints + 1, 0.0));
 
    for (var p = 1; p <= safePoints; p++) {
      var weightSum = 0.0;
      final affordable = List<bool>.filled(n, false);
      for (var i = 0; i < n; i++) {
        final canAfford = valid[i].cost >= 1 && valid[i].cost <= p;
        affordable[i] = canAfford;
        if (canAfford) weightSum += valid[i].weight;
      }
      if (weightSum <= 0.0) {
        for (var j = 0; j < n; j++) {
          exp[j][p] = exp[j][p - 1];
        }
        continue;
      }
      for (var j = 0; j < n; j++) {
        var sum = 0.0;
        for (var k = 0; k < n; k++) {
          if (affordable[k]) {
            final prob = valid[k].weight / weightSum;
            final costK = valid[k].cost;
            var term = exp[j][p - costK];
            if (k == j) term += 1.0;
            sum += prob * term;
          }
        }
        exp[j][p] = sum;
      }
    }
 
    final result = <String, double>{};
    for (var i = 0; i < n; i++) {
      result[valid[i].id] = exp[i][safePoints];
    }
    for (final e in entries) {
      result.putIfAbsent(e.id, () => 0.0);
    }
    return result;
  }
 
  static Map<String, double> calculateExpectation(int points, ParsedLevelData parsed) {
    if (points <= 0) return {};
    final waveModule = parsed.waveModule is WaveManagerModuleData ? parsed.waveModule as WaveManagerModuleData : null;
    if (waveModule == null || waveModule.dynamicZombies.isEmpty) return {};
    final dynamicGroup = waveModule.dynamicZombies[0];
    final pool = dynamicGroup.zombiePool;
    if (pool.isEmpty) return {};
 
    final inputs = pool.map((rtid) {
      final alias = RtidParser.parse(rtid)?.alias ?? rtid;
      final typeName = ZombiePropertiesRepository.getTypeNameByAlias(alias);
      final stats = ZombiePropertiesRepository.getStats(typeName);
      return InputEntry(id: typeName, cost: stats.cost, weight: stats.weight.toDouble());
    }).toList();

    return calculate(inputs, points);
  }
}

class InputEntry {
  InputEntry({required this.id, required this.cost, required this.weight});
  final String id;
  final int cost;
  final double weight;
}
