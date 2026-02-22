import '../../domain/entities/market_index_entity.dart';
import '../../domain/entities/market_overview_entity.dart';
import '../../domain/repositories/market_repository.dart';
import '../datasources/remote/api_client.dart';

/// 市场数据仓库实现
class MarketRepositoryImpl implements MarketRepository {
  final ApiClient apiClient;

  MarketRepositoryImpl(this.apiClient);

  @override
  Future<MarketOverviewEntity> getOverview() async {
    final result = await apiClient.getMarketOverview();
    return MarketOverviewEntity(
      signalsCount: result.signalsCount,
      signalsChange: result.signalsChange,
      healthPercent: result.healthPercent,
      healthVerified: result.healthVerified,
      mode: result.mode,
      modeStatus: result.modeStatus,
    );
  }

  @override
  Future<MarketIndexEntity> getIndex({
    String indexCode = '000001.SH',
    String period = '1w',
  }) async {
    final result = await apiClient.getMarketIndex(
      indexCode: indexCode,
      period: period,
    );
    return MarketIndexEntity(
      indexCode: result.indexCode,
      indexName: result.indexName,
      trend: result.trend,
      dataPoints: result.dataPoints
          .map((p) => IndexDataPointEntity(
                date: p.date,
                label: p.label,
                value: p.value,
              ))
          .toList(),
    );
  }
}
