CREATE TABLE CustomerAssetUnified (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId NVARCHAR(50) NOT NULL,           -- 客戶 ID
    Source NVARCHAR(50),                        -- BANK / SECURITIES / INSURANCE
    SourceStatus NVARCHAR(50),                  -- SUCCESS / FAILED
    AssetName NVARCHAR(200),                    -- 資產名稱，如 "高收益儲蓄 2"、"均衡 FND-1000"
    AssetType NVARCHAR(50),                     -- fund / bond / stock / policy / account / etc
    Currency NVARCHAR(10),                      -- 原幣別，如 EUR / TWD / USD
    SourceCurrency NVARCHAR(10),                -- 來源幣別（通常與上欄位相同）
    ExchangeRate DECIMAL(18,6),                 -- 匯率（折算為 baseCurrency）
    BaseCurrency NVARCHAR(10),                  -- 統一幣別，例如 TWD
    AmountInBase DECIMAL(18,2),                 -- 此來源折算後總金額
    Balance DECIMAL(18,2) NULL,                 -- 銀行餘額
    MarketValue DECIMAL(18,2) NULL,             -- 證券市值
    Coverage DECIMAL(18,2) NULL,                -- 保險保障金額
    PolicyNumber NVARCHAR(50) NULL,             -- 保單號
    PolicyType NVARCHAR(50) NULL,               -- 保單類型（health、life...）
    PremiumStatus NVARCHAR(50) NULL,            -- 保費狀態（paid、overdue）
    RiskLevel NVARCHAR(50) NULL,                -- 風險等級（LOW / MEDIUM / HIGH）
    Symbol NVARCHAR(50) NULL,                   -- 股票/基金代碼
    Holdings DECIMAL(18,4) NULL,                -- 持有數量
    AccountId NVARCHAR(50) NULL,                -- 銀行帳號 ID
    FetchedAt DATETIME2 NULL,                   -- 資料抓取時間
    AggregatedAt DATETIME2 NULL,                -- 資料彙總時間
    TraceId UNIQUEIDENTIFIER NULL,              -- 追蹤 ID
    PayloadRefId NVARCHAR(100) NULL,            -- 原始來源參考 ID
    TotalAssetValue DECIMAL(18,2) NULL,         -- 客戶總資產（若為同一 Trace 可重複）
    AggregationStatus NVARCHAR(50) NULL,        -- COMPLETED / PARTIAL
    CreatedAt DATETIME2 DEFAULT SYSDATETIME()
);
