import '../entities/market_overview_entity.dart';
import '../repositories/market_repository.dart';

/// 获取市场概览数据用例
class GetMarketOverviewUseCase {
  final MarketRepository _repository;

  GetMarketOverviewUseCase(this._repository);

  Future<MarketOverviewEntity> call() {
    return _repository.getOverview();
  }
}
