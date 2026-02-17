import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/watchlist_entity.dart';
import 'providers.dart';

final watchlistProvider = FutureProvider<WatchlistEntity>((ref) async {
  return ref.watch(getWatchlistUseCaseProvider).call();
});
