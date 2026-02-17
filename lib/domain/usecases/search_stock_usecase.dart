import '../entities/stock_search_item_entity.dart';
import '../repositories/stock_repository.dart';

class SearchStockUseCase {
  final StockRepository repository;

  SearchStockUseCase(this.repository);

  Future<List<StockSearchItemEntity>> call(String keyword) {
    return repository.searchStock(keyword);
  }
}
