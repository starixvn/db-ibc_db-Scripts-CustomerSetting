/*
	Created By: Eden
	Created Date: 20191029
	Description: Stakelevel for Virtual Games DEPOSIT - Real Currency
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
	[MaxStake] [money] NULL,
	[MinLabel] [varchar](20) NULL,
	[MaxLabel] [varchar](20) NULL
) 
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 2090.00, '20', '2,090') -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 4150.00, '20', '4,150') -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RM', 20.00, 8300.00, '20', '8,300') -- MYR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 2090.00, '20', '2,090') -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 4150.00, '20', '4,150') -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HKK', 20.00, 8300.00, '20', '8,300') -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 2090.00, '20', '2,090') -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 4150.00, '20', '4,150') -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KHR', 20.00, 8300.00, '20', '8,300') -- KHR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 2090.00, '20', '2,090') -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 4150.00, '20', '4,150') -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PLN', 20.00, 8300.00, '20', '8,300') -- PLN
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 500.00, '5', '500') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 1000.00, '5', '1,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'$US', 5.00, 2000.00, '5', '2,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 500.00, '5', '500') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 1000.00, '5', '1,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'US$', 5.00, 2000.00, '5', '2,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 500.00, '5', '500') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 1000.00, '5', '1,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UT', 5.00, 2000.00, '5', '2,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 500.00, '5', '500') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 1000.00, '5', '1,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Yen', 5.00, 2000.00, '5', '2,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 500.00, '5', '500') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 1000.00, '5', '1,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTU', 5.00, 2000.00, '5', '2,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 500.00, '5', '500') -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 1000.00, '5', '1,000') -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CHF', 5.00, 2000.00, '5', '2,000') -- CHF
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 500.00, '5', '500') -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 1000.00, '5', '1,000') -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MKK', 5.00, 2000.00, '5', '2,000') -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 500.00, '5', '500') -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 1000.00, '5', '1,000') -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'MMK', 5.00, 2000.00, '5', '2,000') -- MMK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 500.00, '5', '500') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 1000.00, '5', '1,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TH', 5.00, 2000.00, '5', '2,000') -- USD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 500.00, '5', '500') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 1000.00, '5', '1,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PS', 5.00, 2000.00, '5', '2,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 500.00, '5', '500') -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 1000.00, '5', '1,000') -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SD$', 5.00, 2000.00, '5', '2,000') -- SGD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 500.00, '5', '500') -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 1000.00, '5', '1,000') -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YNG', 5.00, 2000.00, '5', '2,000') -- YNG
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 500.00, '5', '500') -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 1000.00, '5', '1,000') -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'AUD', 5.00, 2000.00, '5', '2,000') -- AUD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 3500.00, '30', '3,500') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 7000.00, '30', '7,000') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RMB', 30.00, 14000.00, '30', '14,000') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 3500.00, '30', '3,500') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 7000.00, '30', '7,000') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'CY', 30.00, 14000.00, '30', '14,000') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 3500.00, '30', '3,500') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 7000.00, '30', '7,000') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'YUN', 30.00, 14000.00, '30', '14,000') -- CNY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 3500.00, '30', '3,500') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 7000.00, '30', '7,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'PTH', 30.00, 14000.00, '30', '14,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 3500.00, '30', '3,500') -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 7000.00, '30', '7,000') -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'HK$', 30.00, 14000.00, '30', '14,000') -- HKD
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 3500.00, '30', '3,500') -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 7000.00, '30', '7,000') -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DKK', 30.00, 14000.00, '30', '14,000') -- DKK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 3500.00, '30', '3,500') -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 7000.00, '30', '7,000') -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'SEK', 30.00, 14000.00, '30', '14,000') -- SEK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 3500.00, '30', '3,500') -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 7000.00, '30', '7,000') -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'NOK', 30.00, 14000.00, '30', '14,000') -- NOK
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 7000.00, '50', '7,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 14000.00, '50', '14,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IND', 50.00, 28000.00, '50', '28,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 7000.00, '50', '7,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 14000.00, '50', '14,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDR', 50.00, 28000.00, '50', '28,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 7000.00, '50', '7,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 14000.00, '50', '14,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IN', 50.00, 28000.00, '50', '28,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 7000.00, '50', '7,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 14000.00, '50', '14,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'IDD', 50.00, 28000.00, '50', '28,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 7000.00, '50', '7,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 14000.00, '50', '14,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'DDD', 50.00, 28000.00, '50', '28,000') -- IDR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 15000.00, '150', '15,000') -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 30200.00, '150', '30,200') -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'THB', 150.00, 60000.00, '150', '60,000') -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 15000.00, '150', '15,000') -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 30200.00, '150', '30,200') -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'TB', 150.00, 60000.00, '150', '60,000') -- THB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 587000.00, '5,000', '587,000') -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 1150000.00, '5,000', '1,150,000') -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'Won', 5000.00, 2350000.00, '5,000', '2,350,000') -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 587000.00, '5,000', '587,000') -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 1150000.00, '5,000', '1,150,000') -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'KW', 5000.00, 2350000.00, '5,000', '2,350,000') -- KRW
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 11500.00, '100', '11,500') -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 23000.00, '100', '23,000') -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INH', 100.00, 46500.00, '100', '46,500') -- VND
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 35000.00, '300', '35,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 70000.00, '300', '70,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'INR', 300.00, 140000.00, '300', '140,000') -- INR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 35000.00, '300', '35,000') -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 70000.00, '300', '70,000') -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'RUB', 300.00, 140000.00, '300', '140,000') -- RUB
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 385.00, '3', '385') -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 750.00, '3', '750') -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'GBP', 3.00, 1500.00, '3', '1,500') -- GBP
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 385.00, '3', '385') -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 750.00, '3', '750') -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EURO', 3.00, 1500.00, '3', '1,500') -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 385.00, '3', '385') -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 750.00, '3', '750') -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'EUR', 3.00, 1500.00, '3', '1,500') -- EUR
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 54000.00, '500', '54,000') -- JPY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 105000.00, '500', '105,000') -- JPY
INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'JPY', 500.00, 215000.00, '500', '215,000') -- JPY

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
			t.MinLabel,
			t.MaxLabel,
			CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
			ExchangeId = e.exchangeid,
			GameGroupID = 0,
			StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY e.exchangeid)
	FROM @DEP_Stake t
     INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
END -- Insert StakeLevel */
