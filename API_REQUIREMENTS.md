# 后端 API 需求文档

> 本文档列出 Flutter 客户端新 UI 所需的后端接口。
> 基础路径：`/api/v1`
> 所有响应遵循现有 `ApiResponse<T>` 统一格式：`{ "code": 200, "message": "ok", "data": T }`

---

## 一、已有接口（无需修改）

| 方法 | 路径 | 用途 |
|------|------|------|
| GET | `/health` | 系统健康检查 |
| GET | `/watchlist` | 获取关注列表 |
| GET | `/watchlist/symbols` | 获取关注代码列表 |
| GET | `/watchlist/{symbol}` | 获取单个关注项 |
| POST | `/watchlist` | 添加关注项 |
| PUT | `/watchlist/{symbol}` | 更新关注项 |
| DELETE | `/watchlist/{symbol}` | 删除关注项 |
| GET | `/stock/{symbol}` | 获取股票信息 |
| GET | `/stock/search/{keyword}` | 搜索股票 |
| POST | `/stock/sync` | 同步股票数据 |
| POST | `/signal/analyze` | 分析单只信号 |
| POST | `/signal/batch-analyze` | 批量分析信号 |
| GET | `/signal/history/{symbol}` | 获取信号历史 |

---

## 二、新增接口

### 1. `GET /market/overview` — 市场概览

Market 页面顶部三张摘要卡片的数据来源。

**响应 data 结构：**

```json
{
  "signals_count": 12,
  "signals_change": 3,
  "health_percent": 98,
  "health_verified": true,
  "mode": "EOD",
  "mode_status": "waiting"
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `signals_count` | int | 当前活跃信号数量 |
| `signals_change` | int | 相比前一日的变化量（可正可负） |
| `health_percent` | int | 系统健康度百分比 (0-100) |
| `health_verified` | bool | 系统是否通过校验 |
| `mode` | string | 运行模式：`EOD`（盘后）或 `INTRADAY`（盘中） |
| `mode_status` | string | 模式状态：`waiting` / `running` / `completed` |

---

### 2. `GET /market/index` — 指数行情数据

Market 页面 SSE Composite 面积图的数据来源。

**查询参数：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `index_code` | string | 否 | 指数代码，默认 `000001.SH`（上证综指） |
| `period` | string | 否 | 周期：`1w`（默认）/ `1m` / `3m` |

**响应 data 结构：**

```json
{
  "index_code": "000001.SH",
  "index_name": "SSE Composite",
  "trend": "bullish",
  "data_points": [
    { "date": "2024-05-13", "label": "Mon", "value": 3100.5 },
    { "date": "2024-05-14", "label": "Tue", "value": 3150.2 },
    { "date": "2024-05-15", "label": "Wed", "value": 3120.8 },
    { "date": "2024-05-16", "label": "Thu", "value": 3180.1 },
    { "date": "2024-05-17", "label": "Fri", "value": 3200.3 }
  ]
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `index_code` | string | 指数代码 |
| `index_name` | string | 指数名称（用于图表标题） |
| `trend` | string | 趋势判断：`bullish` / `bearish` / `neutral` |
| `data_points` | array | 行情数据点 |
| `data_points[].date` | string | 日期 (YYYY-MM-DD) |
| `data_points[].label` | string | 显示标签（Mon/Tue/... 或日期） |
| `data_points[].value` | float | 收盘点位 |

---

### 3. `GET /signals` — 信号列表

Signals 页面的信号卡片列表数据来源。

**查询参数：**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `keyword` | string | 否 | 搜索关键词（股票代码或名称模糊匹配） |
| `status` | string | 否 | 筛选状态：`triggered` / `pending` / `failed`，不传则返回全部 |
| `limit` | int | 否 | 返回条数，默认 20 |
| `offset` | int | 否 | 偏移量，用于分页，默认 0 |

**响应 data 结构：**

```json
{
  "total": 12,
  "items": [
    {
      "id": "sig-1",
      "symbol": "600519.SH",
      "name": "Kweichow Moutai",
      "price": 1720.50,
      "change": 1.25,
      "timestamp": "2024-05-20",
      "status": "triggered",
      "rules": [
        {
          "name": "MA5 > MA20",
          "description": "Short term trend above medium term",
          "satisfied": true,
          "value": "1715.2",
          "threshold": "1710.8"
        }
      ]
    }
  ]
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `total` | int | 总信号数量（用于分页） |
| `items` | array | 信号列表 |
| `items[].id` | string | 信号唯一 ID |
| `items[].symbol` | string | 股票代码 |
| `items[].name` | string | 股票名称 |
| `items[].price` | float | 当前/收盘价格 |
| `items[].change` | float | 涨跌幅百分比（正数涨，负数跌） |
| `items[].timestamp` | string | 信号时间 (YYYY-MM-DD) |
| `items[].status` | string | 信号状态：`triggered` / `pending` / `failed` |
| `items[].rules` | array | 规则列表（同下方详情接口） |

---

### 4. `GET /signals/{signal_id}` — 信号详情

Signal Detail 页面的数据来源。

**路径参数：**

| 参数 | 类型 | 说明 |
|------|------|------|
| `signal_id` | string | 信号 ID |

**响应 data 结构：**

```json
{
  "id": "sig-1",
  "symbol": "600519.SH",
  "name": "Kweichow Moutai",
  "price": 1720.50,
  "change": 1.25,
  "timestamp": "2024-05-20",
  "status": "triggered",
  "rules": [
    {
      "name": "MA5 > MA20",
      "description": "Short term trend above medium term",
      "satisfied": true,
      "value": "1715.2",
      "threshold": "1710.8"
    },
    {
      "name": "Volume Surge",
      "description": "Volume exceeds 20-day average by 50%",
      "satisfied": true,
      "value": "1.8x",
      "threshold": "> 1.5x"
    },
    {
      "name": "MACD Golden",
      "description": "MACD line crosses above signal line",
      "satisfied": true,
      "value": "0.45",
      "threshold": "> 0"
    }
  ],
  "trend_30d": [
    { "day": 1, "price": 1680.0 },
    { "day": 5, "price": 1695.0 },
    { "day": 10, "price": 1670.0 },
    { "day": 15, "price": 1710.0 },
    { "day": 20, "price": 1705.0 },
    { "day": 25, "price": 1720.0 }
  ]
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `rules[].name` | string | 规则名称 |
| `rules[].description` | string | 规则描述 |
| `rules[].satisfied` | bool | 是否满足 |
| `rules[].value` | string | 实际值（字符串以支持各种格式） |
| `rules[].threshold` | string | 阈值/目标值 |
| `trend_30d` | array | 30 天价格趋势数据 |
| `trend_30d[].day` | int | 天数（1-30） |
| `trend_30d[].price` | float | 当日价格 |

---

### 5. `GET /strategies` — 策略列表

Strategies 页面的数据来源。

**响应 data 结构：**

```json
{
  "items": [
    {
      "id": "strat-1",
      "name": "MA Golden Cross (EOD)",
      "description": "Daily MA5 crosses above MA20 with volume confirmation.",
      "mode": "EOD",
      "rules": ["MA5 > MA20", "Volume > 1.5x Avg"],
      "last_run": "2024-05-20 15:30",
      "active": true
    }
  ]
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| `items[].id` | string | 策略唯一 ID |
| `items[].name` | string | 策略名称 |
| `items[].description` | string | 策略描述 |
| `items[].mode` | string | 运行模式：`EOD` / `INTRADAY` |
| `items[].rules` | array[string] | 规则表达式列表（显示用） |
| `items[].last_run` | string | 最近一次运行时间 (YYYY-MM-DD HH:mm) |
| `items[].active` | bool | 是否处于激活状态 |

---

### 6. `POST /strategies` — 创建策略

**请求体：**

```json
{
  "name": "My New Strategy",
  "description": "A custom trading strategy",
  "mode": "EOD",
  "rules": ["MA5 > MA20", "Volume > 1.5x Avg"]
}
```

**响应：** 返回创建的策略对象（同上方列表中的单个 item 结构）

---

### 7. `PUT /strategies/{strategy_id}` — 更新策略

**路径参数：** `strategy_id` — 策略 ID

**请求体：** 同创建接口

**响应：** 返回更新后的策略对象

---

### 8. `PUT /strategies/{strategy_id}/toggle` — 切换策略启停

**路径参数：** `strategy_id` — 策略 ID

**响应 data 结构：**

```json
{
  "id": "strat-1",
  "active": false
}
```

---

### 9. `DELETE /strategies/{strategy_id}` — 删除策略

**路径参数：** `strategy_id` — 策略 ID

**响应 data 结构：**

```json
{
  "deleted": true,
  "id": "strat-1"
}
```

---

## 三、接口优先级

| 优先级 | 接口 | 页面依赖 |
|--------|------|----------|
| P0 (高) | `GET /signals` | Signals 列表页 + Market 最近信号 |
| P0 (高) | `GET /signals/{id}` | Signal Detail 详情页 |
| P0 (高) | `GET /market/overview` | Market 摘要卡片 |
| P1 (中) | `GET /market/index` | Market 指数图表 |
| P1 (中) | `GET /strategies` | Strategies 列表页 |
| P1 (中) | `POST /strategies` | 创建新策略 |
| P2 (低) | `PUT /strategies/{id}` | 编辑策略 |
| P2 (低) | `PUT /strategies/{id}/toggle` | 启停策略 |
| P2 (低) | `DELETE /strategies/{id}` | 删除策略 |

---

## 四、备注

1. **认证方式**：目前暂无认证要求。如后续增加用户体系，建议使用 Bearer Token。
2. **错误处理**：建议统一返回 `{ "code": 4xx/5xx, "message": "错误描述", "data": null }`。
3. **分页约定**：使用 `limit` + `offset` 参数方式。
4. **时区**：所有时间字段统一使用北京时间 (UTC+8)。
5. **跨域**：如部署在不同域名，需配置 CORS 允许客户端请求。
