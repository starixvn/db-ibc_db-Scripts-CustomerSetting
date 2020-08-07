/*
	Created By: Eden
	Created Date: 20200807
	Description: Update Stakelevel for Virtual Games CREDIT - Real Currency
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DECLARE @CRE_Stake TABLE (
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL,
	[MinLabel] [varchar](20) NULL,
	[MaxLabel] [varchar](20) NULL
) 
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RM', 5.00, 10450.00, '5', '10,450') -- MYR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RM', 10.00, 20750.00, '10', '20,750') -- MYR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RM', 50.00, 41500.00, '50', '41,500') -- MYR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'KHR', 5.00, 10450.00, '5', '10,450') -- KHR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'KHR', 10.00, 20750.00, '10', '20,750') -- KHR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'KHR', 50.00, 41500.00, '50', '41,500') -- KHR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'PLN', 5.00, 10450.00, '5', '10,450') -- PLN
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'PLN', 10.00, 20750.00, '10', '20,750') -- PLN
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'PLN', 50.00, 41500.00, '50', '41,500') -- PLN
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'HKK', 5.00, 10450.00, '5', '10,450') -- HKD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'HKK', 10.00, 20750.00, '10', '20,750') -- HKD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'HKK', 50.00, 41500.00, '50', '41,500') -- HKD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'USD', 1.00, 2500.00, '1', '2,500') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'USD', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'USD', 10.00, 10000.00, '10', '10,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'Yen', 1.00, 2500.00, '1', '2,500') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'Yen', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'Yen', 10.00, 10000.00, '10', '10,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'UT', 1.00, 2500.00, '1', '2,500') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'UT', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'UT', 10.00, 10000.00, '10', '10,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'$US', 1.00, 2500.00, '1', '2,500') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'$US', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'$US', 10.00, 10000.00, '10', '10,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'US$', 1.00, 2500.00, '1', '2,500') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'US$', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'US$', 10.00, 10000.00, '10', '10,000') -- USD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'MMK', 1.00, 2500.00, '1', '2,500') -- MMK
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'MMK', 5.00, 5000.00, '5', '5,000') -- MMK
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'MMK', 10.00, 10000.00, '10', '10,000') -- MMK
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'MKK', 1.00, 2500.00, '1', '2,500') -- MMK
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'MKK', 5.00, 5000.00, '5', '5,000') -- MMK
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'MKK', 10.00, 10000.00, '10', '10,000') -- MMK
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'YNG', 1.00, 2500.00, '1', '2,500') -- YNG
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'YNG', 5.00, 5000.00, '5', '5,000') -- YNG
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'YNG', 10.00, 10000.00, '10', '10,000') -- YNG
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RMB', 10.00, 17500.00, '10', '17,500') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RMB', 50.00, 35000.00, '50', '35,000') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RMB', 100.00, 70000.00, '100', '70,000') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'CY', 10.00, 17500.00, '10', '17,500') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'CY', 50.00, 35000.00, '50', '35,000') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'CY', 100.00, 70000.00, '100', '70,000') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'YUN', 10.00, 17500.00, '10', '17,500') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'YUN', 50.00, 35000.00, '50', '35,000') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'YUN', 100.00, 70000.00, '100', '70,000') -- CNY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'HK$', 10.00, 17500.00, '10', '17,500') -- HKD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'HK$', 50.00, 35000.00, '50', '35,000') -- HKD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'HK$', 100.00, 70000.00, '100', '70,000') -- HKD
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'DDD', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'DDD', 100.00, 70000.00, '100', '70,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'DDD', 500.00, 140000.00, '500', '140,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IND', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IND', 100.00, 70000.00, '100', '70,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IND', 500.00, 140000.00, '500', '140,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IDR', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IDR', 100.00, 70000.00, '100', '70,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IDR', 500.00, 140000.00, '500', '140,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IDD', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IDD', 100.00, 70000.00, '100', '70,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IDD', 500.00, 140000.00, '500', '140,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IN', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IN', 100.00, 70000.00, '100', '70,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'IN', 500.00, 140000.00, '500', '140,000') -- IDR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'THB', 50.00, 75000.00, '50', '75,000') -- THB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'THB', 150.00, 151000.00, '150', '151,000') -- THB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'THB', 500.00, 300000.00, '500', '300,000') -- THB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'TB', 50.00, 75000.00, '50', '75,000') -- THB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'TB', 150.00, 151000.00, '150', '151,000') -- THB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'TB', 500.00, 300000.00, '500', '300,000') -- THB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'Won', 1000.00, 2935000.00, '1,000', '2,935,000') -- KRW
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'Won', 5000.00, 5750000.00, '5,000', '5,750,000') -- KRW
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'Won', 10000.00, 11750000.00, '10,000', '11,750,000') -- KRW
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'INH', 10.00, 57500.00, '10', '57,500') -- VND
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'INH', 50.00, 115000.00, '50', '115,000') -- VND
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'INH', 100.00, 232500.00, '100', '232,500') -- VND
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'INR', 100.00, 175000.00, '100', '175,000') -- INR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'INR', 300.00, 350000.00, '300', '350,000') -- INR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'INR', 500.00, 700000.00, '500', '700,000') -- INR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RUB', 100.00, 175000.00, '100', '175,000') -- RUB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RUB', 300.00, 350000.00, '300', '350,000') -- RUB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'RUB', 500.00, 700000.00, '500', '700,000') -- RUB
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'EURO', 1.00, 1925.00, '1', '1,925') -- EUR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'EURO', 5.00, 3750.00, '5', '3,750') -- EUR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'EURO', 10.00, 7500.00, '10', '7,500') -- EUR
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'GBP', 1.00, 1925.00, '1', '1,925') -- GBP
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'GBP', 5.00, 3750.00, '5', '3,750') -- GBP
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'GBP', 10.00, 7500.00, '10', '7,500') -- GBP
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'JPY', 100.00, 270000.00, '100', '270,000') -- JPY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'JPY', 500.00, 525000.00, '500', '525,000') -- JPY
INSERT INTO @CRE_Stake ([Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (N'JPY', 1000.00, 1075000.00, '1,000', '1,075,000') -- JPY 
 
SELECT	t.MinLabel,
		t.MaxLabel,
		CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
		CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
		ExchangeId = e.exchangeid
INTO #StakeLevel
FROM @CRE_Stake t
    INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency

UPDATE s
SET s.MinLabel = t.MinLabel,
	s.MinStake = t.MinStake
FROM StakeLevel s WITH(ROWLOCK)
	INNER JOIN #StakeLevel t ON s.ExchangeId = t.ExchangeId AND s.MaxStake = t.MaxStake
WHERE s.GameTypeID IN (4601,4602)

DROP TABLE #StakeLevel

