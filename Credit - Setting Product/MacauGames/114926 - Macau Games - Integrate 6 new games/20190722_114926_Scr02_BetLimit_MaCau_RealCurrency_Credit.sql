/*
	Created By: Eden
	Created Date: 20190722
	Description: Stakelevel for MaCau PRO for Credit
	DB: DBCust/CustDB	
*/
USE CustDB
GO

DECLARE @CRE_Stake TABLE (
	[GameTypeID] [int] NOT NULL,
	[Currency] [nvarchar](max) NULL,
	[Level] [int] NULL,
	[MinStake] [money] NULL,
	[MaxStake] [money] NULL
) 

INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'MYR', 1, 0.2500, 62.5000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'MYR', 2, 0.2500, 125.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'MYR', 1, 0.1000, 10.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'MYR', 2, 0.1000, 20.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'MYR', 1, 0.0900, 22.5000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'MYR', 2, 0.0900, 45.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'MYR', 1, 0.5000, 125.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'MYR', 2, 0.5000, 250.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'MYR', 1, 0.1000, 100.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'MYR', 2, 0.1000, 200.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'MYR', 1, 0.1000, 1000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'MYR', 2, 0.1000, 2000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'USD', 1, 0.2500, 25.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'USD', 2, 0.2500, 50.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'USD', 1, 0.1000, 4.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'USD', 2, 0.1000, 8.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'USD', 1, 0.0900, 9.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'USD', 2, 0.0900, 18.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'USD', 1, 0.5000, 50.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'USD', 2, 0.5000, 100.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'USD', 1, 0.1000, 40.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'USD', 2, 0.1000, 80.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'USD', 1, 0.1000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'USD', 2, 0.1000, 800.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'CNY', 1, 0.5000, 125.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'CNY', 2, 0.5000, 250.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'CNY', 1, 0.2000, 20.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'CNY', 2, 0.2000, 40.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'CNY', 1, 0.1800, 45.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'CNY', 2, 0.1800, 90.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'CNY', 1, 1.0000, 250.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'CNY', 2, 1.0000, 500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'CNY', 1, 0.2000, 200.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'CNY', 2, 0.2000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'CNY', 1, 0.2000, 2000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'CNY', 2, 0.2000, 4000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'GBP', 1, 1.2500, 12.5000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'GBP', 2, 1.2500, 25.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'GBP', 1, 0.5000, 2.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'GBP', 2, 0.5000, 4.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'GBP', 1, 0.4500, 4.5000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'GBP', 2, 0.4500, 9.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'GBP', 1, 2.5000, 25.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'GBP', 2, 2.5000, 50.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'GBP', 1, 0.5000, 20.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'GBP', 2, 0.5000, 40.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'GBP', 1, 0.5000, 200.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'GBP', 2, 0.5000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'VND', 1, 1.5000, 500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'VND', 2, 1.5000, 1000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'VND', 1, 0.6000, 80.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'VND', 2, 0.6000, 160.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'VND', 1, 0.5400, 180.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'VND', 2, 0.5400, 360.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'VND', 1, 3.0000, 1000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'VND', 2, 3.0000, 2000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'VND', 1, 0.6000, 800.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'VND', 2, 0.6000, 1600.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'VND', 1, 0.6000, 8000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'VND', 2, 0.6000, 16000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'EUR', 1, 2.5000, 25.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'EUR', 2, 2.5000, 50.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'EUR', 1, 1.0000, 4.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'EUR', 2, 1.0000, 8.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'EUR', 1, 0.9000, 9.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'EUR', 2, 0.9000, 18.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'EUR', 1, 5.0000, 50.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'EUR', 2, 5.0000, 100.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'EUR', 1, 1.0000, 40.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'EUR', 2, 1.0000, 80.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'EUR', 1, 1.0000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'EUR', 2, 1.0000, 800.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'THB', 1, 2.5000, 750.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'THB', 2, 2.5000, 1500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'THB', 1, 1.0000, 120.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'THB', 2, 1.0000, 240.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'THB', 1, 0.9000, 270.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'THB', 2, 0.9000, 540.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'THB', 1, 5.0000, 1500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'THB', 2, 5.0000, 3000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'THB', 1, 1.0000, 1200.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'THB', 2, 1.0000, 2400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'THB', 1, 1.0000, 12000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'THB', 2, 1.0000, 24000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'IDR', 1, 0.7500, 250.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'IDR', 2, 0.7500, 500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'IDR', 1, 0.3000, 40.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'IDR', 2, 0.3000, 80.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'IDR', 1, 0.2700, 90.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'IDR', 2, 0.2700, 180.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'IDR', 1, 1.5000, 500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'IDR', 2, 1.5000, 1000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'IDR', 1, 0.3000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'IDR', 2, 0.3000, 800.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'IDR', 1, 0.3000, 4000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'IDR', 2, 0.3000, 8000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'INR', 1, 125.0000, 1250.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'INR', 2, 125.0000, 2500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'INR', 1, 50.0000, 200.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'INR', 2, 50.0000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'INR', 1, 45.0000, 450.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'INR', 2, 45.0000, 900.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'INR', 1, 250.0000, 2500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'INR', 2, 250.0000, 5000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'INR', 1, 50.0000, 2000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'INR', 2, 50.0000, 4000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'INR', 1, 50.0000, 20000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'INR', 2, 50.0000, 40000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'KRW', 1, 250.0000, 25000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'KRW', 2, 250.0000, 50000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'KRW', 1, 100.0000, 4000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'KRW', 2, 100.0000, 8000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'KRW', 1, 90.0000, 9000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'KRW', 2, 90.0000, 18000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'KRW', 1, 500.0000, 50000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'KRW', 2, 500.0000, 100000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'KRW', 1, 100.0000, 40000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'KRW', 2, 100.0000, 80000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'KRW', 1, 100.0000, 400000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'KRW', 2, 100.0000, 800000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'MMK', 1, 0.2500, 25.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'MMK', 2, 0.2500, 50.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'MMK', 1, 0.1000, 4.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'MMK', 2, 0.1000, 8.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'MMK', 1, 0.0900, 9.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'MMK', 2, 0.0900, 18.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'MMK', 1, 0.5000, 50.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'MMK', 2, 0.5000, 100.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'MMK', 1, 0.1000, 40.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'MMK', 2, 0.1000, 80.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'MMK', 1, 0.1000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'MMK', 2, 0.1000, 800.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'HKD', 1, 0.5000, 125.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'HKD', 2, 0.5000, 250.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'HKD', 1, 0.2000, 20.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'HKD', 2, 0.2000, 40.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'HKD', 1, 0.1800, 45.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'HKD', 2, 0.1800, 90.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'HKD', 1, 1.0000, 250.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'HKD', 2, 1.0000, 500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'HKD', 1, 0.2000, 200.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'HKD', 2, 0.2000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'HKD', 1, 0.2000, 2000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'HKD', 2, 0.2000, 4000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'KHR', 1, 0.2500, 62.5000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'KHR', 2, 0.2500, 125.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'KHR', 1, 0.1000, 10.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'KHR', 2, 0.1000, 20.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'KHR', 1, 0.0900, 22.5000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'KHR', 2, 0.0900, 45.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'KHR', 1, 0.5000, 125.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'KHR', 2, 0.5000, 250.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'KHR', 1, 0.1000, 100.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'KHR', 2, 0.1000, 200.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'KHR', 1, 0.1000, 1000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'KHR', 2, 0.1000, 2000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'JPY', 1, 250.0000, 2500.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4038, N'JPY', 2, 250.0000, 5000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'JPY', 1, 100.0000, 400.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4039, N'JPY', 2, 100.0000, 800.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'JPY', 1, 90.0000, 900.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4040, N'JPY', 2, 90.0000, 1800.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'JPY', 1, 500.0000, 5000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4041, N'JPY', 2, 500.0000, 10000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'JPY', 1, 100.0000, 4000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4042, N'JPY', 2, 100.0000, 8000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'JPY', 1, 100.0000, 40000.0000)
INSERT @CRE_Stake ([GameTypeID], [Currency], [Level], [MinStake], [MaxStake]) VALUES (4043, N'JPY', 2, 100.0000, 80000.0000)


CREATE TABLE #BetlimitCredit(
	 GameTypeID   INT NOT NULL, 
	 Level        INT NOT NULL, 
	 CurrencyID   INT NOT NULL, 
	 [MinStake]   [MONEY] NULL, 
	 [MaxStake]   [MONEY] NULL, 
	 StakeLevelID INT NOT NULL,
	 PRIMARY KEY (StakeLevelID,GameTypeID)
);

INSERT INTO #BetlimitCredit(GameTypeID,Level,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID, 
       Level,
       CASE WHEN RTRIM(LTRIM(t.Currency)) = 'UUS' THEN 20 ELSE e.exchangeid END, 
       t.MinStake, 
       t.MaxStake, 
       s.StakeLevelID
FROM @CRE_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON RTRIM(LTRIM(t.Currency)) = e.Code
     INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4001
        AND s.GameGroupID = 1
        AND t.Level = 1
        AND CASE WHEN RTRIM(LTRIM(t.Currency)) = 'UUS' THEN 20 ELSE e.exchangeid END = s.ExchangeID
WHERE t.Currency IN (SELECT Currency FROM @CRE_Stake WHERE Level = 1);

INSERT INTO #BetlimitCredit(GameTypeID,Level,CurrencyID,MinStake,MaxStake,StakeLevelID)
SELECT t.GameTypeID, 
       Level,
       CASE WHEN RTRIM(LTRIM(t.Currency)) = 'UUS' THEN 20 ELSE e.exchangeid END,  
       t.MinStake, 
       t.MaxStake, 
       s.StakeLevelID
FROM @CRE_Stake t
     LEFT JOIN exchange e WITH(NOLOCK) ON RTRIM(LTRIM(t.Currency)) = e.Code
     INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID = 4001
        AND s.GameGroupID = 2
        AND t.Level = 2
		AND CASE WHEN RTRIM(LTRIM(t.Currency)) = 'UUS' THEN 20 ELSE e.exchangeid END = s.ExchangeID
WHERE t.Currency IN (SELECT Currency FROM @CRE_Stake WHERE Level = 2)


BEGIN --/* Insert StakeLevelGroupDetail
	INSERT INTO StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
	SELECT	a.StakeLevelID,
			a.GameTypeID,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MinStake)) AS MinLabel,
			CONVERT(VARCHAR(20),CONVERT(FLOAT,a.MaxStake)) AS MaxLabel,
			CONVERT(DECIMAL(19,2),a.MinStake) AS MinStake,
			CONVERT(DECIMAL(19,2),a.MaxStake) AS MaxStake
	FROM #BetlimitCredit a
END -- Insert StakeLevelGroupDetail */

DROP TABLE #BetlimitCredit