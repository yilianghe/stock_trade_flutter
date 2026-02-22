class ApiPaths {
  // 系统
  static const String health = '/health';

  // 监听列表
  static const String watchlist = '/watchlist';
  static const String watchlistSymbols = '/watchlist/symbols';

  // 股票
  static const String stock = '/stock';
  static const String stockSearch = '/stock/search';
  static const String stockSync = '/stock/sync';

  // 信号（旧接口：单只分析 / 批量分析 / 历史）
  static const String signalAnalyze = '/signal/analyze';
  static const String signalBatchAnalyze = '/signal/batch-analyze';
  static const String signalHistory = '/signal/history';

  // 信号列表（新接口）
  static const String signals = '/signals';

  // 市场概览（新接口）
  static const String marketOverview = '/market/overview';
  static const String marketIndex = '/market/index';

  // 策略（新接口）
  static const String strategies = '/strategies';
}
