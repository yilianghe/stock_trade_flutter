import '../entities/watchlist_item_entity.dart';
import '../repositories/watchlist_repository.dart';

class AddWatchlistItemUseCase {
  final WatchlistRepository repository;

  AddWatchlistItemUseCase(this.repository);

  Future<WatchlistItemEntity> call({
    required String symbol,
    required List<String> tags,
    String? note,
  }) {
    return repository.addItem(symbol: symbol, tags: tags, note: note);
  }
}
