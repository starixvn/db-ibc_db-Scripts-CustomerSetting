/*
	Created By: Eden
	Created Date: 20191029
	Description: Stakelevel for Virtual Games DEPOSIT
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DECLARE @DEP_Stake TABLE(
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[Level] [int] NOT NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL
) 

INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RM', 1, 20.00, 2090.00) -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RM', 2, 40.00, 4150.00) -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RM', 3, 50.00, 8300.00) -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'HKK', 1, 20.00, 2090.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'HKK', 2, 40.00, 4150.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'HKK', 3, 50.00, 8300.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'KHR', 1, 20.00, 2090.00) -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'KHR', 2, 40.00, 4150.00) -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'KHR', 3, 50.00, 8300.00) -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PLN', 1, 20.00, 2090.00) -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PLN', 2, 40.00, 4150.00) -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PLN', 3, 50.00, 8300.00) -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'$US', 1, 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'$US', 2, 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'$US', 3, 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'US$', 1, 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'US$', 2, 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'US$', 3, 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UT', 1, 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UT', 2, 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UT', 3, 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'Yen', 1, 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'Yen', 2, 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'Yen', 3, 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PTU', 1, 5.00, 500.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PTU', 2, 10.00, 1000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PTU', 3, 15.00, 2000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'CHF', 1, 5.00, 500.00) -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'CHF', 2, 10.00, 1000.00) -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'CHF', 3, 15.00, 2000.00) -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'MKK', 1, 5.00, 500.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'MKK', 2, 10.00, 1000.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'MKK', 3, 15.00, 2000.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'MMK', 1, 5.00, 500.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'MMK', 2, 10.00, 1000.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'MMK', 3, 15.00, 2000.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'TH', 1, 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'TH', 2, 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'TH', 3, 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PS', 1, 5.00, 500.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PS', 2, 10.00, 1000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PS', 3, 15.00, 2000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'SD$', 1, 5.00, 500.00) -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'SD$', 2, 10.00, 1000.00) -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'SD$', 3, 15.00, 2000.00) -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 1, 5.00, 500.00) -- 
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 2, 10.00, 1000.00) -- 
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 3, 15.00, 2000.00) -- 
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'YNG', 1, 5.00, 500.00) -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'YNG', 2, 10.00, 1000.00) -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'YNG', 3, 15.00, 2000.00) -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'AUD', 1, 5.00, 500.00) -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'AUD', 2, 10.00, 1000.00) -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'AUD', 3, 15.00, 2000.00) -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RMB', 1, 30.00, 3500.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RMB', 2, 50.00, 7000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RMB', 3, 100.00, 14000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'CY', 1, 30.00, 3500.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'CY', 2, 50.00, 7000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'CY', 3, 100.00, 14000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'YUN', 1, 30.00, 3500.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'YUN', 2, 50.00, 7000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'YUN', 3, 100.00, 14000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PTH', 1, 30.00, 3500.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PTH', 2, 50.00, 7000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PTH', 3, 100.00, 14000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'HK$', 1, 30.00, 3500.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'HK$', 2, 50.00, 7000.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'HK$', 3, 100.00, 14000.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'DKK', 1, 30.00, 3500.00) -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'DKK', 2, 50.00, 7000.00) -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'DKK', 3, 100.00, 14000.00) -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'SEK', 1, 30.00, 3500.00) -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'SEK', 2, 50.00, 7000.00) -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'SEK', 3, 100.00, 14000.00) -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'NOK', 1, 30.00, 3500.00) -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'NOK', 2, 50.00, 7000.00) -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'NOK', 3, 100.00, 14000.00) -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IND', 1, 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IND', 2, 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IND', 3, 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IDR', 1, 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IDR', 2, 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IDR', 3, 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IN', 1, 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IN', 2, 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IN', 3, 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IDD', 1, 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IDD', 2, 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IDD', 3, 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'DDD', 1, 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'DDD', 2, 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'DDD', 3, 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'THB', 1, 150.00, 15000.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'THB', 2, 300.00, 30200.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'THB', 3, 450.00, 60000.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'TB', 1, 150.00, 15000.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'TB', 2, 300.00, 30200.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'TB', 3, 450.00, 60000.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'Won', 1, 5000.00, 587000.00) -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'Won', 2, 10000.00, 1150000.00) -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'Won', 3, 15000.00, 2350000.00) -- KRW
--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'KW', 1, 5000.00, 587000.00) -- KRW
--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'KW', 2, 10000.00, 1150000.00) -- KRW
--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'KW', 3, 15000.00, 2350000.00) -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'INH', 1, 100.00, 11500.00) -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'INH', 2, 200.00, 23000.00) -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'INH', 3, 300.00, 46500.00) -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'INR', 1, 300.00, 35000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'INR', 2, 500.00, 70000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'INR', 3, 1000.00, 140000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RUB', 1, 300.00, 35000.00) -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RUB', 2, 500.00, 70000.00) -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RUB', 3, 1000.00, 140000.00) -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'GBP', 1, 3.00, 385.00) -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'GBP', 2, 5.00, 750.00) -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'GBP', 3, 10.00, 1500.00) -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'EURO', 1, 3.00, 385.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'EURO', 2, 5.00, 750.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'EURO', 3, 10.00, 1500.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'EUR', 1, 3.00, 385.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'EUR', 2, 5.00, 750.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'EUR', 3, 10.00, 1500.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'JPY', 1, 500.00, 54000.00) -- JPY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'JPY', 2, 1000.00, 105000.00) -- JPY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'JPY', 3, 1500.00, 215000.00) -- JPY


CREATE TABLE #BetlimitDeposit(
	 GameTypeID   INT NOT NULL, 
	 CurrencyID   INT NOT NULL, 
	 [MinStake]   [MONEY] NULL, 
	 [MaxStake]   [MONEY] NULL, 
	 StakeLevelID INT NOT NULL,
	 PRIMARY KEY (StakeLevelID,GameTypeID)
);

INSERT INTO #BetlimitDeposit(GameTypeID,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID,
       e.exchangeid, 
       t.MinStake, 
       t.MaxStake, 
       StakeLevelID
FROM @DEP_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON t.Currency = e.currency
	 CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 1 AND GroupName = 'Level 1') gg
     INNER JOIN Dep_StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = gg.GameGroupID
        AND e.exchangeid = s.ExchangeID
		AND t.Level = 1

INSERT INTO #BetlimitDeposit(GameTypeID,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID,
       e.exchangeid, 
       t.MinStake, 
       t.MaxStake, 
       StakeLevelID
FROM @DEP_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON t.Currency = e.currency
	 CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 1 AND GroupName = 'Level 2') gg
     INNER JOIN Dep_StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = gg.GameGroupID
        AND e.exchangeid = s.ExchangeID
		AND t.Level = 2

INSERT INTO #BetlimitDeposit(GameTypeID,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID,
       e.exchangeid, 
       t.MinStake, 
       t.MaxStake, 
       StakeLevelID
FROM @DEP_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON t.Currency = e.currency
	 CROSS APPLY (SELECT GameGroupID FROM GameGroup WITH(NOLOCK) WHERE RefSportType = 245 AND IsDeposit = 1 AND GroupName = 'Level 3') gg
     INNER JOIN Dep_StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = gg.GameGroupID
        AND e.exchangeid = s.ExchangeID
		AND t.Level = 3
 
BEGIN --/* Insert StakeLevelGroupDetail
	INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
	SELECT	a.StakeLevelID,
			a.GameTypeID,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MinStake)) AS MinLabel,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MaxStake)) AS MaxLabel,
			CONVERT(DECIMAL(19,2),a.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),a.MaxStake) AS MaxStake
	FROM #BetlimitDeposit a
		LEFT JOIN Dep_StakeLevelGroupDetail s WITH(NOLOCK) ON a.StakeLevelID = s.StakeLevelID AND a.GameTypeID = S.GameTypeID
	WHERE s.StakeLevelID IS NULL

END -- Insert StakeLevelGroupDetail */

DROP TABLE #BetlimitDeposit

