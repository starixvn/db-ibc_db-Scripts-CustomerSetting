/*
	Created By: Eden
	Created Date: 20200507
	Description: Stakelevel for Virtual Games CREDIT - Real Currency - XocDia
	DB: DBCust/CustDB	
*/
USE CustDB
GO
DELETE  
FROM StakeLevel WITH(ROWLOCK, UPDLOCK)
WHERE GameTypeID = 4602
	  AND exchangeid <> 20

DECLARE @CRE_Stake TABLE (
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL,
	[MinLabel] [varchar](20) NULL,
	[MaxLabel] [varchar](20) NULL
)
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RM', 20.00, 10450.00, '20', '10,450') -- MYR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RM', 20.00, 20750.00, '20', '20,750') -- MYR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RM', 20.00, 41500.00, '20', '41,500') -- MYR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'KHR', 20.00, 10450.00, '20', '10,450') -- KHR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'KHR', 20.00, 20750.00, '20', '20,750') -- KHR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'KHR', 20.00, 41500.00, '20', '41,500') -- KHR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'PLN', 20.00, 10450.00, '20', '10,450') -- PLN
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'PLN', 20.00, 20750.00, '20', '20,750') -- PLN
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'PLN', 20.00, 41500.00, '20', '41,500') -- PLN
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HKK', 20.00, 10450.00, '20', '10,450') -- HKD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HKK', 20.00, 20750.00, '20', '20,750') -- HKD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HKK', 20.00, 41500.00, '20', '41,500') -- HKD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Yen', 5.00, 2500.00, '5', '2,500') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Yen', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Yen', 5.00, 10000.00, '5', '10,000') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UT', 5.00, 2500.00, '5', '2,500') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UT', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'UT', 5.00, 10000.00, '5', '10,000') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'$US', 5.00, 2500.00, '5', '2,500') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'$US', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'$US', 5.00, 10000.00, '5', '10,000') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'US$', 5.00, 2500.00, '5', '2,500') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'US$', 5.00, 5000.00, '5', '5,000') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'US$', 5.00, 10000.00, '5', '10,000') -- USD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MMK', 5.00, 2500.00, '5', '2,500') -- MMK
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MMK', 5.00, 5000.00, '5', '5,000') -- MMK
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MMK', 5.00, 10000.00, '5', '10,000') -- MMK
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MKK', 5.00, 2500.00, '5', '2,500') -- MMK
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MKK', 5.00, 5000.00, '5', '5,000') -- MMK
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'MKK', 5.00, 10000.00, '5', '10,000') -- MMK
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YNG', 5.00, 2500.00, '5', '2,500') -- YNG
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YNG', 5.00, 5000.00, '5', '5,000') -- YNG
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YNG', 5.00, 10000.00, '5', '10,000') -- YNG
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RMB', 30.00, 17500.00, '30', '17,500') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RMB', 30.00, 35000.00, '30', '35,000') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RMB', 30.00, 70000.00, '30', '70,000') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'CY', 30.00, 17500.00, '30', '17,500') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'CY', 30.00, 35000.00, '30', '35,000') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'CY', 30.00, 70000.00, '30', '70,000') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YUN', 30.00, 17500.00, '30', '17,500') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YUN', 30.00, 35000.00, '30', '35,000') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'YUN', 30.00, 70000.00, '30', '70,000') -- CNY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HK$', 30.00, 17500.00, '30', '17,500') -- HKD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HK$', 30.00, 35000.00, '30', '35,000') -- HKD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'HK$', 30.00, 70000.00, '30', '70,000') -- HKD
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'DDD', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'DDD', 50.00, 70000.00, '50', '70,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'DDD', 50.00, 140000.00, '50', '140,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IND', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IND', 50.00, 70000.00, '50', '70,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IND', 50.00, 140000.00, '50', '140,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDR', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDR', 50.00, 70000.00, '50', '70,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDR', 50.00, 140000.00, '50', '140,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDD', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDD', 50.00, 70000.00, '50', '70,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IDD', 50.00, 140000.00, '50', '140,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IN', 50.00, 35000.00, '50', '35,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IN', 50.00, 70000.00, '50', '70,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'IN', 50.00, 140000.00, '50', '140,000') -- IDR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'THB', 150.00, 75000.00, '150', '75,000') -- THB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'THB', 150.00, 151000.00, '150', '151,000') -- THB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'THB', 150.00, 300000.00, '150', '300,000') -- THB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'TB', 150.00, 75000.00, '150', '75,000') -- THB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'TB', 150.00, 151000.00, '150', '151,000') -- THB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'TB', 150.00, 300000.00, '150', '300,000') -- THB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Won', 5000.00, 2935000.00, '5,000', '2,935,000') -- KRW
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Won', 5000.00, 5750000.00, '5,000', '5,750,000') -- KRW
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'Won', 5000.00, 11750000.00, '5,000', '11,750,000') -- KRW
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INH', 100.00, 57500.00, '100', '57,500') -- VND
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INH', 100.00, 115000.00, '100', '115,000') -- VND
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INH', 100.00, 232500.00, '100', '232,500') -- VND
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INR', 300.00, 175000.00, '300', '175,000') -- INR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INR', 300.00, 350000.00, '300', '350,000') -- INR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'INR', 300.00, 700000.00, '300', '700,000') -- INR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RUB', 300.00, 175000.00, '300', '175,000') -- RUB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RUB', 300.00, 350000.00, '300', '350,000') -- RUB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'RUB', 300.00, 700000.00, '300', '700,000') -- RUB
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'EURO', 3.00, 1925.00, '3', '1,925') -- EUR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'EURO', 3.00, 3750.00, '3', '3,750') -- EUR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'EURO', 3.00, 7500.00, '3', '7,500') -- EUR
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'GBP', 3.00, 1925.00, '3', '1,925') -- GBP
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'GBP', 3.00, 3750.00, '3', '3,750') -- GBP
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'GBP', 3.00, 7500.00, '3', '7,500') -- GBP
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'JPY', 500.00, 270000.00, '500', '270,000') -- JPY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'JPY', 500.00, 525000.00, '500', '525,000') -- JPY
INSERT INTO @CRE_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4602, N'JPY', 500.00, 1075000.00, '500', '1,075,000') -- JPY

BEGIN --/* Insert StakeLevel
	INSERT INTO StakeLevel(
		 GameTypeID
		,MinLabel
		,MaxLabel
		,MinStake
		,MaxStake
		,ExchangeId
		,GameGroupID
	)
	SELECT	t.GameTypeID,
			t.MinLabel,
			t.MaxLabel,
			CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
			ExchangeId = e.exchangeid,
			GameGroupID = 0
	FROM @CRE_Stake t
     INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
	ORDER BY t.GameTypeID,e.exchangeid,MaxStake
END -- Insert StakeLevel */
