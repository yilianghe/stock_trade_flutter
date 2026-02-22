import '../entities/market_index_entity.dart';
import '../entities/market_overview_entity.dart';

/// 市场数据仓库接口
abstract class MarketRepository {
  /// 获取市场概览（摘要卡片数据）
  Future<MarketOverviewEntity> getOverview();

  /// 获取指数行情数据
  Future<MarketIndexEntity> getIndex({
    String indexCode,
    String period,
  });
}
