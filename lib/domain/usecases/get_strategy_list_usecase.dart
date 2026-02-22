import '../entities/strategy_entity.dart';
import '../repositories/strategy_repository.dart';

/// 获取策略列表用例
class GetStrategyListUseCase {
  final StrategyRepository _repository;

  GetStrategyListUseCase(this._repository);

  Future<List<StrategyEntity>> call() {
    return _repository.getStrategies();
  }
}
