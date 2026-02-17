# API 接口详细说明

**版本**: v1  
**基础路径**: `/api/v1`  
**统一响应结构**: 所有接口使用 `APIResponse` 包裹。

## 统一响应结构

**成功响应示例**:
```json
{
  "code": 200,
  "message": "success",
  "data": {},
  "disclaimer": "本结果不构成任何投资建议，仅为规则计算与数据分析结果。"
}
```

**失败响应示例**:
```json
{
  "detail": "错误原因"
}
```

## 系统接口

### GET /health
**说明**: 健康检查  
**请求参数**: 无  
**响应 data**:
```json
{
  "status": "healthy",
  "app": "StockTradeAnalyzer",
  "disclaimer": "本系统不构成任何投资建议。"
}
```

## 关注列表

### GET /watchlist
**说明**: 获取关注列表  
**请求参数**: 无  
**响应 data**:
```json
{
  "total": 2,
  "watchlist": [
    {
      "id": 1,
      "symbol": "000001.SZ",
      "stock_name": "平安银行",
      "tags": ["自选1"],
      "note": "备注信息",
      "added_at": "2026-02-16T10:00:00",
      "updated_at": "2026-02-16T10:00:00"
    }
  ]
}
```

### GET /watchlist/symbols
**说明**: 获取关注股票代码列表  
**请求参数**: 无  
**响应 data**:
```json
{
  "total": 2,
  "symbols": ["000001.SZ", "000002.SZ"]
}
```

### POST /watchlist
**说明**: 添加股票到关注列表  
**请求体**:
```json
{
  "symbol": "000001.SZ",
  "tags": ["自选1"],
  "note": "备注信息"
}
```
**响应 data**:
```json
{
  "id": 1,
  "symbol": "000001.SZ",
  "stock_name": "平安银行",
  "tags": ["自选1"],
  "note": "备注信息",
  "added_at": "2026-02-16T10:00:00"
}
```
**可能错误**:
- 400: 股票已在关注列表中

### PUT /watchlist/{symbol}
**说明**: 更新关注列表  
**路径参数**:
- symbol: 股票代码
**请求体**:
```json
{
  "tags": ["自选2"],
  "note": "更新备注"
}
```
**响应 data**:
```json
{
  "id": 1,
  "symbol": "000001.SZ",
  "stock_name": "平安银行",
  "tags": ["自选2"],
  "note": "更新备注",
  "updated_at": "2026-02-16T10:05:00"
}
```
**可能错误**:
- 404: 股票不在关注列表中

### DELETE /watchlist/{symbol}
**说明**: 移除关注股票  
**路径参数**:
- symbol: 股票代码  
**响应 data**:
```json
{
  "symbol": "000001.SZ",
  "success": true
}
```
**可能错误**:
- 404: 股票不在关注列表中

### GET /watchlist/{symbol}
**说明**: 查询单只股票关注信息  
**路径参数**:
- symbol: 股票代码  
**响应 data**:
```json
{
  "id": 1,
  "symbol": "000001.SZ",
  "stock_name": "平安银行",
  "tags": ["自选1"],
  "note": "备注信息",
  "added_at": "2026-02-16T10:00:00",
  "updated_at": "2026-02-16T10:00:00"
}
```
**可能错误**:
- 404: 股票不在关注列表中

## 股票信息

### GET /stock/{symbol}
**说明**: 获取股票基础信息  
**路径参数**:
- symbol: 股票代码  
**响应 data**:
```json
{
  "symbol": "000001.SZ",
  "name": "平安银行",
  "industry": "银行",
  "market": "主板",
  "list_date": "19910403"
}
```
**可能错误**:
- 404: 股票未找到

### GET /stock/search/{keyword}
**说明**: 按名称模糊搜索  
**路径参数**:
- keyword: 搜索关键词  
**响应 data**:
```json
[
  {
    "symbol": "000001.SZ",
    "name": "平安银行",
    "industry": "银行"
  }
]
```

### POST /stock/sync
**说明**: 同步股票列表到本地数据库  
**请求体**: 无  
**响应 data**:
```json
{
  "synced_count": 120
}
```

## 信号分析

### POST /signal/analyze
**说明**: 单股信号分析  
**请求体**:
```json
{
  "symbol": "000001.SZ",
  "target_date": "2026-02-16",
  "strategy_name": "trend_following"
}
```
**响应 data**:
```json
{
  "symbol": "000001.SZ",
  "mode": "EOD",
  "target_date": "2026-02-16",
  "signal_status": "condition_met",
  "passed_rules": ["MA5_above_MA10"],
  "failed_rules": [],
  "rule_details": [],
  "explanation": "满足条件：MA5_above_MA10",
  "strategy_name": "trend_following",
  "executed_at": "2026-02-16T10:00:00",
  "disclaimer": "本结果不构成任何投资建议，仅为规则计算与数据分析结果。"
}
```
**可能错误**:
- 500: 分析过程出错

### POST /signal/batch-analyze
**说明**: 批量分析  
**请求体**:
```json
{
  "symbols": ["000001.SZ", "000002.SZ"],
  "target_date": "2026-02-16",
  "strategy_name": "trend_following"
}
```
**响应 data**:
```json
[
  {
    "symbol": "000001.SZ",
    "mode": "EOD",
    "target_date": "2026-02-16",
    "signal_status": "condition_met",
    "passed_rules": ["MA5_above_MA10"],
    "failed_rules": [],
    "rule_details": [],
    "explanation": "满足条件：MA5_above_MA10",
    "strategy_name": "trend_following",
    "executed_at": "2026-02-16T10:00:00",
    "disclaimer": "本结果不构成任何投资建议，仅为规则计算与数据分析结果。"
  },
  {
    "symbol": "000002.SZ",
    "error": "分析过程出错"
  }
]
```

### GET /signal/history/{symbol}
**说明**: 查询历史信号  
**路径参数**:
- symbol: 股票代码  
**查询参数**:
- limit: 返回条数，默认 30  
**响应 data**:
```json
[
  {
    "symbol": "000001.SZ",
    "target_date": "2026-02-16",
    "signal_status": "condition_met",
    "strategy_name": "trend_following",
    "explanation": "满足条件：MA5_above_MA10",
    "executed_at": "2026-02-16 10:00:00"
  }
]
```

## 字段说明

**signal_status**:
- condition_met
- partially_met
- not_met
- error
- insufficient_data
