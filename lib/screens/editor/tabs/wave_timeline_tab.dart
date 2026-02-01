import 'package:flutter/material.dart';
import 'package:z_editor/data/pvz_models.dart';
import 'package:z_editor/data/wave_point_analysis.dart';
 
class WaveTimelineTab extends StatelessWidget {
  const WaveTimelineTab({
    super.key,
    required this.levelFile,
    required this.parsed,
  });
 
  final PvzLevelFile levelFile;
  final ParsedLevelData parsed;
 
  int _pointsAtWave(WaveManagerModuleData module, int waveIndex) {
    if (module.dynamicZombies.isEmpty) return 0;
    final g = module.dynamicZombies.first;
    final offset = waveIndex - g.startingWave;
    final incCount = offset < 0 ? 0 : offset;
    return g.startingPoints + g.pointIncrement * incCount;
  }
 
  @override
  Widget build(BuildContext context) {
    final wm = parsed.waveManager is WaveManagerData ? parsed.waveManager as WaveManagerData : null;
    final module = parsed.waveModule is WaveManagerModuleData ? parsed.waveModule as WaveManagerModuleData : null;
    if (wm == null || module == null) {
      return Center(
        child: Icon(Icons.timeline, size: 64, color: Theme.of(context).colorScheme.outline),
      );
    }
    final waves = List.generate(wm.waveCount, (i) => i);
    return ListView.builder(
      itemCount: waves.length,
      itemBuilder: (ctx, idx) {
        final waveIndex = waves[idx];
        final points = _pointsAtWave(module, waveIndex);
        final expectation = WavePointAnalysis.calculateExpectation(points, parsed);
        final top = expectation.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));
        final top3 = top.take(3).toList();
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Wave ${waveIndex + 1}', style: Theme.of(context).textTheme.titleMedium),
                    Chip(label: Text('Points $points')),
                  ],
                ),
                const SizedBox(height: 8),
                if (top3.isEmpty)
                  Text('No dynamic zombies', style: Theme.of(context).textTheme.bodyMedium)
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: top3.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(e.key, style: Theme.of(context).textTheme.bodyLarge),
                            Text(e.value.toStringAsFixed(2)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
