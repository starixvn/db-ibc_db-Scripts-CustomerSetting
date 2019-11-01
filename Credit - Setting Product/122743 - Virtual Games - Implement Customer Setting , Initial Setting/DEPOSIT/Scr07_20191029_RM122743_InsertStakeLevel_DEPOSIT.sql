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

INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UUS', 1, 2.00, 2000.00) 
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'UUS', 1, 2.00, 2000.00) 	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'UUS', 1, 2.00, 2000.00) 
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'UUS', 1, 2.00, 2000.00) 
------------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RM', 1, 10.00, 8300.00) -- MYR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'RM', 1, 10.00, 8300.00) -- MYR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'RM', 1, 10.00, 8300.00) -- MYR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'RM', 1, 10.00, 8300.00) -- MYR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'HKK', 1, 10.00, 8300.00) -- HKD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'HKK', 1, 10.00, 8300.00) -- HKD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'HKK', 1, 10.00, 8300.00) -- HKD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'HKK', 1, 10.00, 8300.00) -- HKD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'KHR', 1, 10.00, 8300.00) -- KHR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'KHR', 1, 10.00, 8300.00) -- KHR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'KHR', 1, 10.00, 8300.00) -- KHR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'KHR', 1, 10.00, 8300.00) -- KHR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PLN', 1, 10.00, 8300.00) -- PLN
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'PLN', 1, 10.00, 8300.00) -- PLN	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'PLN', 1, 10.00, 8300.00) -- PLN
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'PLN', 1, 10.00, 8300.00) -- PLN
-------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'$US', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'$US', 1, 2.00, 2000.00) -- USD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'$US', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'$US', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'US$', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'US$', 1, 2.00, 2000.00) -- USD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'US$', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'US$', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'UT', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'UT', 1, 2.00, 2000.00) -- USD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'UT', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'UT', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'Yen', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'Yen', 1, 2.00, 2000.00) -- USD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'Yen', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'Yen', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PTU', 1, 2.00, 2000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'PTU', 1, 2.00, 2000.00) -- INR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'PTU', 1, 2.00, 2000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'PTU', 1, 2.00, 2000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'CHF', 1, 2.00, 2000.00) -- CHF
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'CHF', 1, 2.00, 2000.00) -- CHF	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'CHF', 1, 2.00, 2000.00) -- CHF
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'CHF', 1, 2.00, 2000.00) -- CHF
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'MKK', 1, 2.00, 2000.00) -- MMK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'MKK', 1, 2.00, 2000.00) -- MMK	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'MKK', 1, 2.00, 2000.00) -- MMK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'MKK', 1, 2.00, 2000.00) -- MMK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'MMK', 1, 2.00, 2000.00) -- MMK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'MMK', 1, 2.00, 2000.00) -- MMK	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'MMK', 1, 2.00, 2000.00) -- MMK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'MMK', 1, 2.00, 2000.00) -- MMK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'TH', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'TH', 1, 2.00, 2000.00) -- USD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'TH', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'TH', 1, 2.00, 2000.00) -- USD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PS', 1, 2.00, 2000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'PS', 1, 2.00, 2000.00) -- INR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'PS', 1, 2.00, 2000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'PS', 1, 2.00, 2000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'SD$', 1, 2.00, 2000.00) -- SGD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'SD$', 1, 2.00, 2000.00) -- SGD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'SD$', 1, 2.00, 2000.00) -- SGD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'SD$', 1, 2.00, 2000.00) -- SGD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'YNG', 1, 2.00, 2000.00) -- YNG
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'YNG', 1, 2.00, 2000.00) -- YNG	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'YNG', 1, 2.00, 2000.00) -- YNG
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'YNG', 1, 2.00, 2000.00) -- YNG
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'AUD', 1, 2.00, 2000.00) -- AUD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'AUD', 1, 2.00, 2000.00) -- AUD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'AUD', 1, 2.00, 2000.00) -- AUD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'AUD', 1, 2.00, 2000.00) -- AUD
-------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RMB', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'RMB', 1, 10.00, 14000.00) -- CNY	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'RMB', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'RMB', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'CY', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'CY', 1, 10.00, 14000.00) -- CNY	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'CY', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'CY', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'YUN', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'YUN', 1, 10.00, 14000.00) -- CNY	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'YUN', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'YUN', 1, 10.00, 14000.00) -- CNY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'PTH', 1, 10.00, 14000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'PTH', 1, 10.00, 14000.00) -- INR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'PTH', 1, 10.00, 14000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'PTH', 1, 10.00, 14000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'HK$', 1, 10.00, 14000.00) -- HKD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'HK$', 1, 10.00, 14000.00) -- HKD	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'HK$', 1, 10.00, 14000.00) -- HKD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'HK$', 1, 10.00, 14000.00) -- HKD
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'DKK', 1, 10.00, 14000.00) -- DKK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'DKK', 1, 10.00, 14000.00) -- DKK	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'DKK', 1, 10.00, 14000.00) -- DKK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'DKK', 1, 10.00, 14000.00) -- DKK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'SEK', 1, 10.00, 14000.00) -- SEK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'SEK', 1, 10.00, 14000.00) -- SEK	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'SEK', 1, 10.00, 14000.00) -- SEK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'SEK', 1, 10.00, 14000.00) -- SEK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'NOK', 1, 10.00, 14000.00) -- NOK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'NOK', 1, 10.00, 14000.00) -- NOK	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'NOK', 1, 10.00, 14000.00) -- NOK
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'NOK', 1, 10.00, 14000.00) -- NOK
---------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IND', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'IND', 1, 25.00, 28000.00) -- IDR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'IND', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'IND', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IDR', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'IDR', 1, 25.00, 28000.00) -- IDR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'IDR', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'IDR', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IN', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'IN', 1, 25.00, 28000.00) -- IDR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'IN', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'IN', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'IDD', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'IDD', 1, 25.00, 28000.00) -- IDR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'IDD', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'IDD', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'DDD', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'DDD', 1, 25.00, 28000.00) -- IDR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'DDD', 1, 25.00, 28000.00) -- IDR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'DDD', 1, 25.00, 28000.00) -- IDR
----------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'THB', 1, 50.00, 60000.00) -- THB
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'THB', 1, 50.00, 60000.00) -- THB	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'THB', 1, 50.00, 60000.00) -- THB
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'THB', 1, 50.00, 60000.00) -- THB
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'TB', 1, 50.00, 60000.00) -- THB
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'TB', 1, 50.00, 60000.00) -- THB	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'TB', 1, 50.00, 60000.00) -- THB
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'TB', 1, 50.00, 60000.00) -- THB
-----------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'Won', 1, 2500.00, 2350000.00) -- KRW
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'Won', 1, 2500.00, 2350000.00) -- KRW	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'Won', 1, 2500.00, 2350000.00) -- KRW
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'Won', 1, 2500.00, 2350000.00) -- KRW
--INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'KW', 1, 2500.00, 2350000.00) -- KRW
--INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'KW', 1, 2500.00, 2350000.00) -- KRW	
--INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'KW', 1, 2500.00, 2350000.00) -- KRW
--INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'KW', 1, 2500.00, 2350000.00) -- KRW
-----------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'INH', 1, 50.00, 46500.00) -- VND
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'INH', 1, 50.00, 46500.00) -- VND	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'INH', 1, 50.00, 46500.00) -- VND
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'INH', 1, 50.00, 46500.00) -- VND
----------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'INR', 1, 100.00, 140000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'INR', 1, 100.00, 140000.00) -- INR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'INR', 1, 100.00, 140000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'INR', 1, 100.00, 140000.00) -- INR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'RUB', 1, 100.00, 140000.00) -- RUB
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'RUB', 1, 100.00, 140000.00) -- RUB	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'RUB', 1, 100.00, 140000.00) -- RUB
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'RUB', 1, 100.00, 140000.00) -- RUB
---------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'GBP', 1, 1.00, 1500.00) -- GBP
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'GBP', 1, 1.00, 1500.00) -- GBP	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'GBP', 1, 1.00, 1500.00) -- GBP
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'GBP', 1, 1.00, 1500.00) -- GBP
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'EURO', 1, 1.00, 1500.00) -- EUR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'EURO', 1, 1.00, 1500.00) -- EUR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'EURO', 1, 1.00, 1500.00) -- EUR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'EURO', 1, 1.00, 1500.00) -- EUR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'EUR', 1, 1.00, 1500.00) -- EUR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'EUR', 1, 1.00, 1500.00) -- EUR	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'EUR', 1, 1.00, 1500.00) -- EUR
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'EUR', 1, 1.00, 1500.00) -- EUR
---------------
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4601, N'JPY', 1, 200.00, 215000.00) -- JPY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4602, N'JPY', 1, 200.00, 215000.00) -- JPY	
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4603, N'JPY', 1, 200.00, 215000.00) -- JPY
INSERT @DEP_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4604, N'JPY', 1, 200.00, 215000.00) -- JPY


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
     INNER JOIN Dep_StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4601
        AND s.GameGroupID = 14
        AND e.exchangeid = s.ExchangeID
WHERE Level = 1;
 
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

