/// 策略业务实体
class StrategyEntity {
  final String id;
  final String name;
  final String description;
  final String mode;
  final List<String> rules;
  final String lastRun;
  final bool active;

  StrategyEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.mode,
    required this.rules,
    required this.lastRun,
    required this.active,
  });
}
