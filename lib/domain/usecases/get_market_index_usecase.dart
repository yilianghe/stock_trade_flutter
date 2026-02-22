import '../entities/market_index_entity.dart';
import '../repositories/market_repository.dart';

/// 获取指数行情数据用例
class GetMarketIndexUseCase {
  final MarketRepository _repository;

  GetMarketIndexUseCase(this._repository);

  Future<MarketIndexEntity> call({
    String indexCode = '000001.SH',
    String period = '1w',
  }) {
    return _repository.getIndex(indexCode: indexCode, period: period);
  }
}
