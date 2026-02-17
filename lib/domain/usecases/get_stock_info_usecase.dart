import '../entities/stock_info_entity.dart';
import '../repositories/stock_repository.dart';

class GetStockInfoUseCase {
  final StockRepository repository;

  GetStockInfoUseCase(this.repository);

  Future<StockInfoEntity> call(String symbol) {
    return repository.getStockInfo(symbol);
  }
}
