/*
	Created By: 20200428@Eden
	Description: Update MaxSatke,MaxLabel Stakelevel for Virtual Games Deposit
	DB: DBCust/CustDB	
*/
USE CustDB
GO
DECLARE @Dep_Stake TABLE (
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL,
	[NewMaxStake] [money] NULL,
	[NewMaxLabel] [varchar](20) NULL
) 
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RM', 20.00, 2090.00, 10450.00, '10,450') -- MYR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RM', 20.00, 4150.00, 20750.00, '20,750') -- MYR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RM', 20.00, 8300.00, 41500.00, '41,500') -- MYR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'HKK', 20.00, 2090.00, 10450.00, '10,450') -- HKD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'HKK', 20.00, 4150.00, 20750.00, '20,750') -- HKD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'HKK', 20.00, 8300.00, 41500.00, '41,500') -- HKD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'KHR', 20.00, 2090.00, 10450.00, '10,450') -- KHR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'KHR', 20.00, 4150.00, 20750.00, '20,750') -- KHR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'KHR', 20.00, 8300.00, 41500.00, '41,500') -- KHR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PLN', 20.00, 2090.00, 10450.00, '10,450') -- PLN
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PLN', 20.00, 4150.00, 20750.00, '20,750') -- PLN
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PLN', 20.00, 8300.00, 41500.00, '41,500') -- PLN
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'$US', 5.00, 500.00, 2500.00, '2,500') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'$US', 5.00, 1000.00, 5000.00, '5,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'$US', 5.00, 2000.00, 10000.00, '10,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'US$', 5.00, 500.00, 2500.00, '2,500') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'US$', 5.00, 1000.00, 5000.00, '5,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'US$', 5.00, 2000.00, 10000.00, '10,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'UT', 5.00, 500.00, 2500.00, '2,500') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'UT', 5.00, 1000.00, 5000.00, '5,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'UT', 5.00, 2000.00, 10000.00, '10,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'Yen', 5.00, 500.00, 2500.00, '2,500') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'Yen', 5.00, 1000.00, 5000.00, '5,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'Yen', 5.00, 2000.00, 10000.00, '10,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PTU', 5.00, 500.00, 2500.00, '2,500') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PTU', 5.00, 1000.00, 5000.00, '5,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PTU', 5.00, 2000.00, 10000.00, '10,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'CHF', 5.00, 500.00, 2500.00, '2,500') -- CHF
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'CHF', 5.00, 1000.00, 5000.00, '5,000') -- CHF
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'CHF', 5.00, 2000.00, 10000.00, '10,000') -- CHF
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'MKK', 5.00, 500.00, 2500.00, '2,500') -- MMK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'MKK', 5.00, 1000.00, 5000.00, '5,000') -- MMK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'MKK', 5.00, 2000.00, 10000.00, '10,000') -- MMK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'MMK', 5.00, 500.00, 2500.00, '2,500') -- MMK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'MMK', 5.00, 1000.00, 5000.00, '5,000') -- MMK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'MMK', 5.00, 2000.00, 10000.00, '10,000') -- MMK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'TH', 5.00, 500.00, 2500.00, '2,500') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'TH', 5.00, 1000.00, 5000.00, '5,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'TH', 5.00, 2000.00, 10000.00, '10,000') -- USD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PS', 5.00, 500.00, 2500.00, '2,500') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PS', 5.00, 1000.00, 5000.00, '5,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PS', 5.00, 2000.00, 10000.00, '10,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'SD$', 5.00, 500.00, 2500.00, '2,500') -- SGD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'SD$', 5.00, 1000.00, 5000.00, '5,000') -- SGD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'SD$', 5.00, 2000.00, 10000.00, '10,000') -- SGD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'UUS', 5.00, 500.00, 2500.00, '2,500') -- UUS
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'UUS', 5.00, 1000.00, 5000.00, '5,000') -- UUS
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'UUS', 5.00, 2000.00, 10000.00, '10,000') -- UUS
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'YNG', 5.00, 500.00, 2500.00, '2,500') -- YNG
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'YNG', 5.00, 1000.00, 5000.00, '5,000') -- YNG
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'YNG', 5.00, 2000.00, 10000.00, '10,000') -- YNG
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'AUD', 5.00, 500.00, 2500.00, '2,500') -- AUD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'AUD', 5.00, 1000.00, 5000.00, '5,000') -- AUD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'AUD', 5.00, 2000.00, 10000.00, '10,000') -- AUD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RMB', 30.00, 3500.00, 17500.00, '17,500') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RMB', 30.00, 7000.00, 35000.00, '35,000') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RMB', 30.00, 14000.00, 70000.00, '70,000') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'CY', 30.00, 3500.00, 17500.00, '17,500') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'CY', 30.00, 7000.00, 35000.00, '35,000') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'CY', 30.00, 14000.00, 70000.00, '70,000') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'YUN', 30.00, 3500.00, 17500.00, '17,500') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'YUN', 30.00, 7000.00, 35000.00, '35,000') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'YUN', 30.00, 14000.00, 70000.00, '70,000') -- CNY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PTH', 30.00, 3500.00, 17500.00, '17,500') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PTH', 30.00, 7000.00, 35000.00, '35,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'PTH', 30.00, 14000.00, 70000.00, '70,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'HK$', 30.00, 3500.00, 17500.00, '17,500') -- HKD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'HK$', 30.00, 7000.00, 35000.00, '35,000') -- HKD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'HK$', 30.00, 14000.00, 70000.00, '70,000') -- HKD
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'DKK', 30.00, 3500.00, 17500.00, '17,500') -- DKK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'DKK', 30.00, 7000.00, 35000.00, '35,000') -- DKK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'DKK', 30.00, 14000.00, 70000.00, '70,000') -- DKK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'SEK', 30.00, 3500.00, 17500.00, '17,500') -- SEK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'SEK', 30.00, 7000.00, 35000.00, '35,000') -- SEK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'SEK', 30.00, 14000.00, 70000.00, '70,000') -- SEK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'NOK', 30.00, 3500.00, 17500.00, '17,500') -- NOK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'NOK', 30.00, 7000.00, 35000.00, '35,000') -- NOK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'NOK', 30.00, 14000.00, 70000.00, '70,000') -- NOK
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IND', 50.00, 7000.00, 35000.00, '35,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IND', 50.00, 14000.00, 70000.00, '70,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IND', 50.00, 28000.00, 140000.00, '140,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IDR', 50.00, 7000.00, 35000.00, '35,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IDR', 50.00, 14000.00, 70000.00, '70,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IDR', 50.00, 28000.00, 140000.00, '140,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IN', 50.00, 7000.00, 35000.00, '35,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IN', 50.00, 14000.00, 70000.00, '70,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IN', 50.00, 28000.00, 140000.00, '140,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IDD', 50.00, 7000.00, 35000.00, '35,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IDD', 50.00, 14000.00, 70000.00, '70,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'IDD', 50.00, 28000.00, 140000.00, '140,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'DDD', 50.00, 7000.00, 35000.00, '35,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'DDD', 50.00, 14000.00, 70000.00, '70,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'DDD', 50.00, 28000.00, 140000.00, '140,000') -- IDR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'THB', 150.00, 15000.00, 75000.00, '75,000') -- THB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'THB', 150.00, 30200.00, 151000.00, '151,000') -- THB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'THB', 150.00, 60000.00, 300000.00, '300,000') -- THB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'TB', 150.00, 15000.00, 75000.00, '75,000') -- THB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'TB', 150.00, 30200.00, 151000.00, '151,000') -- THB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'TB', 150.00, 60000.00, 300000.00, '300,000') -- THB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'Won', 5000.00, 587000.00, 2935000.00, '2,935,000') -- KRW
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'Won', 5000.00, 1150000.00, 5750000.00, '5,750,000') -- KRW
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'Won', 5000.00, 2350000.00, 11750000.00, '11,750,000') -- KRW
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'KW', 5000.00, 587000.00, 2935000.00, '2,935,000') -- KRW
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'KW', 5000.00, 1150000.00, 5750000.00, '5,750,000') -- KRW
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'KW', 5000.00, 2350000.00, 11750000.00, '11,750,000') -- KRW
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'INH', 100.00, 11500.00, 57500.00, '57,500') -- VND
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'INH', 100.00, 23000.00, 115000.00, '115,000') -- VND
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'INH', 100.00, 46500.00, 232500.00, '232,500') -- VND
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'INR', 300.00, 35000.00, 175000.00, '175,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'INR', 300.00, 70000.00, 350000.00, '350,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'INR', 300.00, 140000.00, 700000.00, '700,000') -- INR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RUB', 300.00, 35000.00, 175000.00, '175,000') -- RUB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RUB', 300.00, 70000.00, 350000.00, '350,000') -- RUB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'RUB', 300.00, 140000.00, 700000.00, '700,000') -- RUB
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'GBP', 3.00, 385.00, 1925.00, '1,925') -- GBP
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'GBP', 3.00, 750.00, 3750.00, '3,750') -- GBP
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'GBP', 3.00, 1500.00, 7500.00, '7,500') -- GBP
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'EURO', 3.00, 385.00, 1925.00, '1,925') -- EUR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'EURO', 3.00, 750.00, 3750.00, '3,750') -- EUR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'EURO', 3.00, 1500.00, 7500.00, '7,500') -- EUR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'EUR', 3.00, 385.00, 1925.00, '1,925') -- EUR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'EUR', 3.00, 750.00, 3750.00, '3,750') -- EUR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'EUR', 3.00, 1500.00, 7500.00, '7,500') -- EUR
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'JPY', 500.00, 54000.00, 270000.00, '270,000') -- JPY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'JPY', 500.00, 105000.00, 525000.00, '525,000') -- JPY
INSERT INTO @Dep_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake], [NewMaxStake],[NewMaxLabel]) VALUES (4601, N'JPY', 500.00, 215000.00, 1075000.00, '1,075,000') -- JPY

BEGIN --Update MaxStake, MaxLabel
	UPDATE s
	SET s.MaxLabel = t.NewMaxLabel,
		s.MaxStake = t.NewMaxStake
	FROM @Dep_Stake t
		INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
		INNER JOIN DEP_StakeLevel s WITH(ROWLOCK) ON S.ExchangeId = E.exchangeid and S.GameTypeID = T.GameTypeID AND S.MinStake = T.MinStake AND t.MaxStake = s.MaxStake
END 


--SELECT * FROM DEP_StakeLevel WHERE GAMETYPEID = 4601