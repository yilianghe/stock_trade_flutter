import '../entities/strategy_entity.dart';

/// 策略仓库接口
abstract class StrategyRepository {
  /// 获取策略列表
  Future<List<StrategyEntity>> getStrategies();
}
