/// Tool card info. Ported from Z-Editor-master ToolRepository.kt
class ToolCardInfo {
  const ToolCardInfo({
    required this.id,
    required this.name,
    this.icon,
  });

  final String id;
  final String name;
  final String? icon;
}

/// Tool repository. Ported from Z-Editor-master ToolRepository.kt
class ToolRepository {
  ToolRepository._();

  static const List<ToolCardInfo> toolCards = [
    ToolCardInfo(id: 'tool_powertile_alpha', name: 'Green tile', icon: 'tool_powertile_alpha.webp'),
    ToolCardInfo(id: 'tool_powertile_beta', name: 'Red tile', icon: 'tool_powertile_beta.webp'),
    ToolCardInfo(id: 'tool_powertile_gamma', name: 'Cyan tile', icon: 'tool_powertile_gamma.webp'),
    ToolCardInfo(id: 'tool_powertile_delta', name: 'Yellow tile', icon: 'tool_powertile_delta.webp'),
    ToolCardInfo(id: 'tool_projectile_bowlingbulb1', name: 'Bowling bulb small', icon: 'tool_projectile_bowlingbulb1.webp'),
    ToolCardInfo(id: 'tool_projectile_bowlingbulb2', name: 'Bowling bulb medium', icon: 'tool_projectile_bowlingbulb2.webp'),
    ToolCardInfo(id: 'tool_projectile_bowlingbulb3', name: 'Bowling bulb large', icon: 'tool_projectile_bowlingbulb3.webp'),
    ToolCardInfo(id: 'tool_projectile_bowlingbulb_explode', name: 'Bowling bulb explode', icon: 'tool_projectile_bowlingbulb_explode.webp'),
    ToolCardInfo(id: 'tool_projectile_wallnut', name: 'Wallnut bowling', icon: 'tool_projectile_wallnut.webp'),
    ToolCardInfo(id: 'tool_projectile_wallnut_big', name: 'Big wallnut bowling', icon: 'tool_projectile_wallnut_big.webp'),
    ToolCardInfo(id: 'tool_projectile_wallnut_explode', name: 'Explode wallnut bowling', icon: 'tool_projectile_wallnut_explode.webp'),
    ToolCardInfo(id: 'tool_projectile_wallnut_primeval', name: 'Primeval wallnut bowling', icon: 'tool_projectile_wallnut_primeval.webp'),
    ToolCardInfo(id: 'tool_projectile_jackfruit', name: 'Jackfruit bowling', icon: 'tool_projectile_jackfruit.webp'),
  ];

  static ToolCardInfo? get(String id) {
    try {
      return toolCards.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<ToolCardInfo> getAll() => toolCards;
}
