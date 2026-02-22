import '../../domain/entities/strategy_entity.dart';
import '../../domain/repositories/strategy_repository.dart';
import '../datasources/remote/api_client.dart';

/// 策略仓库实现
class StrategyRepositoryImpl implements StrategyRepository {
  final ApiClient apiClient;

  StrategyRepositoryImpl(this.apiClient);

  @override
  Future<List<StrategyEntity>> getStrategies() async {
    final result = await apiClient.getStrategies();
    return result.items
        .map((item) => StrategyEntity(
              id: item.id,
              name: item.name,
              description: item.description,
              mode: item.mode,
              rules: item.rules,
              lastRun: item.lastRun,
              active: item.active,
            ))
        .toList();
  }
}
