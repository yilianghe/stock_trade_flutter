import '../entities/watchlist_item_entity.dart';
import '../repositories/watchlist_repository.dart';

class UpdateWatchlistItemUseCase {
  final WatchlistRepository repository;

  UpdateWatchlistItemUseCase(this.repository);

  Future<WatchlistItemEntity> call({
    required String symbol,
    required List<String> tags,
    String? note,
  }) {
    return repository.updateItem(symbol: symbol, tags: tags, note: note);
  }
}
