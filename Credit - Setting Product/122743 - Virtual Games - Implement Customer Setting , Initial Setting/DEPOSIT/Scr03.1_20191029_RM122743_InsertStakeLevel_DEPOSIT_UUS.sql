/*
	Created By: Eden
	Created Date: 20191029
	Description: Stakelevel for Virtual Games DEPOSIT - UUS
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DELETE  
FROM DEP_StakeLevel WITH(ROWLOCK, UPDLOCK)
WHERE GameTypeID = 4601
	  AND exchangeid <> 20

DECLARE @DEP_Stake TABLE (
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL
) 
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RM', 20.00, 2090.00) -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RM', 40.00, 4150.00) -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RM', 50.00, 8300.00) -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'HKK', 20.00, 2090.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'HKK', 40.00, 4150.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'HKK', 50.00, 8300.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'KHR', 20.00, 2090.00) -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'KHR', 40.00, 4150.00) -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'KHR', 50.00, 8300.00) -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PLN', 20.00, 2090.00) -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PLN', 40.00, 4150.00) -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PLN', 50.00, 8300.00) -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'$US', 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'$US', 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'$US', 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'US$', 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'US$', 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'US$', 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UT', 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UT', 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'UT', 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'Yen', 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'Yen', 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'Yen', 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PTU', 5.00, 500.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PTU', 10.00, 1000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PTU', 15.00, 2000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'CHF', 5.00, 500.00) -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'CHF', 10.00, 1000.00) -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'CHF', 15.00, 2000.00) -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'MKK', 5.00, 500.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'MKK', 10.00, 1000.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'MKK', 15.00, 2000.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'MMK', 5.00, 500.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'MMK', 10.00, 1000.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'MMK', 15.00, 2000.00) -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'TH', 5.00, 500.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'TH', 10.00, 1000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'TH', 15.00, 2000.00) -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PS', 5.00, 500.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PS', 10.00, 1000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PS', 15.00, 2000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'SD$', 5.00, 500.00) -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'SD$', 10.00, 1000.00) -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'SD$', 15.00, 2000.00) -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'YNG', 5.00, 500.00) -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'YNG', 10.00, 1000.00) -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'YNG', 15.00, 2000.00) -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'AUD', 5.00, 500.00) -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'AUD', 10.00, 1000.00) -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'AUD', 15.00, 2000.00) -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RMB', 30.00, 3500.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RMB', 50.00, 7000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RMB', 100.00, 14000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'CY', 30.00, 3500.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'CY', 50.00, 7000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'CY', 100.00, 14000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'YUN', 30.00, 3500.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'YUN', 50.00, 7000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'YUN', 100.00, 14000.00) -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PTH', 30.00, 3500.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PTH', 50.00, 7000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'PTH', 100.00, 14000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'HK$', 30.00, 3500.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'HK$', 50.00, 7000.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'HK$', 100.00, 14000.00) -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'DKK', 30.00, 3500.00) -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'DKK', 50.00, 7000.00) -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'DKK', 100.00, 14000.00) -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'SEK', 30.00, 3500.00) -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'SEK', 50.00, 7000.00) -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'SEK', 100.00, 14000.00) -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'NOK', 30.00, 3500.00) -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'NOK', 50.00, 7000.00) -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'NOK', 100.00, 14000.00) -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IND', 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IND', 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IND', 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IDR', 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IDR', 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IDR', 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IN', 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IN', 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IN', 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IDD', 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IDD', 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'IDD', 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'DDD', 50.00, 7000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'DDD', 100.00, 14000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'DDD', 200.00, 28000.00) -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'THB', 150.00, 15000.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'THB', 300.00, 30200.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'THB', 450.00, 60000.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'TB', 150.00, 15000.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'TB', 300.00, 30200.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'TB', 450.00, 60000.00) -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'Won', 5000.00, 587000.00) -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'Won', 10000.00, 1150000.00) -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'Won', 15000.00, 2350000.00) -- KRW
--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'KW', 5000.00, 587000.00) -- KRW
--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'KW', 10000.00, 1150000.00) -- KRW
--INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'KW', 15000.00, 2350000.00) -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'INH', 100.00, 11500.00) -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'INH', 200.00, 23000.00) -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'INH', 300.00, 46500.00) -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'INR', 300.00, 35000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'INR', 500.00, 70000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'INR', 1000.00, 140000.00) -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RUB', 300.00, 35000.00) -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RUB', 500.00, 70000.00) -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'RUB', 1000.00, 140000.00) -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'GBP', 3.00, 385.00) -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'GBP', 5.00, 750.00) -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'GBP', 10.00, 1500.00) -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'EURO', 3.00, 385.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'EURO', 5.00, 750.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'EURO', 10.00, 1500.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'EUR', 3.00, 385.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'EUR', 5.00, 750.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'EUR', 10.00, 1500.00) -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'JPY', 500.00, 54000.00) -- JPY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'JPY', 1000.00, 105000.00) -- JPY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake]) VALUES (4601, N'JPY', 1500.00, 215000.00) -- JPY

DECLARE @MaxStakeLevelID INT
SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

BEGIN --/* Insert StakeLevel
	INSERT INTO DEP_StakeLevel(
		 GameTypeID
		,MinLabel
		,MaxLabel
		,MinStake
		,MaxStake
		,ExchangeId
		,GameGroupID
		,StakeLevelID
	)
	SELECT	t.GameTypeID,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,t.MinStake)) AS MinLabel,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,t.MaxStake)) AS MaxLabel,
			CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
			ExchangeId = e.exchangeid,
			GameGroupID = 0,
			StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY e.exchangeid)
	FROM @DEP_Stake t
     INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
END -- Insert StakeLevel */
