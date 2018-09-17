/*
	Created By: Winnie
	Created Date: 20180912
	Description: Stakelevel for MaCau PRO
	DB: DBCust/CustDB	
*/
USE CustDB
GO
CREATE TABLE #Betlimit(
	GameType varchar(50) NULL,
	Game varchar(50) NULL,
	Level varchar(50) NULL,
	Currency varchar(50) NULL,
	BetLimit varchar(50) NULL
)
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' MYR ', N'0.15 - 37.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' MYR ', N'0.25 - 62.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' MYR ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' MYR ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' MYR ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' MYR ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' USD ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' USD ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' USD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' USD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' USD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' USD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' CNY ', N'0.3 - 75')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' CNY ', N'0.5 - 125')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' CNY ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' CNY ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' CNY ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' CNY ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' GBP ', N'0.15 - 7.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' GBP ', N'0.25 - 12.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' GBP ', N'0.09 - 4.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' GBP ', N'0.09 - 4.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' GBP ', N'0.09 - 4.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' GBP ', N'0.09 - 4.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' VND ', N'0.9 - 300')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' VND ', N'1.5 - 500')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' VND ', N'0.54 - 180')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' VND ', N'0.54 - 180')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' VND ', N'0.54 - 180')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' VND ', N'0.54 - 180')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' EUR ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' EUR ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' EUR ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' EUR ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' EUR ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' EUR ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' THB ', N'1.5 - 450')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' THB ', N'2.5  - 750')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' THB ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' THB ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' THB ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' THB ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' IDR ', N'0.45 - 150')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' IDR ', N'0.75 - 250')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' IDR ', N'0.27 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' IDR ', N'0.27 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' IDR ', N'0.27 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' IDR ', N'0.27 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' INR ', N'7.5 - 750')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' INR ', N'12.5 - 1250')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' INR ', N'4.5 - 450')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' INR ', N'4.5 - 450')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' INR ', N'4.5 - 450')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' INR ', N'4.5 - 450')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' KRW ', N'150 - 15000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' KRW ', N'250 - 25000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' KRW ', N'90 - 9000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' KRW ', N'90 - 9000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' KRW ', N'90 - 9000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' KRW ', N'90 - 9000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' MMK ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' MMK ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' MMK ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' MMK ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' MMK ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' MMK ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' HKD ', N'0.3 - 75')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' HKD ', N'0.50 - 125')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' HKD ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' HKD ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' HKD ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' HKD ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' KHR ', N'0.15 - 37.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' KHR ', N'0.25 - 62.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' KHR ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' KHR ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' KHR ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' KHR ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' JPY ', N'15 - 1500')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' JPY ', N'25 - 2500')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' JPY ', N'9 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' JPY ', N'9 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' JPY ', N'9 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' JPY ', N'9 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' PLN ', N'0.15 - 37.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' PLN ', N'0.25 - 62.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' PLN ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' PLN ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' PLN ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' PLN ', N'0.09 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' CAD ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' CAD ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' CAD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' CAD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' CAD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' CAD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' AUD ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' AUD ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' AUD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' AUD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' AUD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' AUD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' BND ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' BND ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' BND ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' BND ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' BND ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' BND ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' SGD ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' SGD ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' SGD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' SGD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' SGD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' SGD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' TWD ', N'1.5 - 450')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' TWD ', N'2.5  - 750')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' TWD ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' TWD ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' TWD ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' TWD ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' CHF ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' CHF ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' CHF ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' CHF ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' CHF ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' CHF ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' PHP ', N'1.5 - 450')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' PHP ', N'2.5  - 750')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' PHP ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' PHP ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' PHP ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' PHP ', N'0.9 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' DKK ', N'0.3 - 75')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' DKK ', N'0.5 - 125')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' DKK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' DKK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' DKK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' DKK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' SEK ', N'0.3 - 75')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' SEK ', N'0.5 - 125')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' SEK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' SEK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' SEK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' SEK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' NOK ', N'0.3 - 75')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' NOK ', N'0.5 - 125')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' NOK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' NOK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' NOK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' NOK ', N'0.18 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' RUB ', N'4.5 - 450')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' RUB ', N'7.5 - 750')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' RUB ', N'2.7 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' RUB ', N'2.7 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' RUB ', N'2.7 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' RUB ', N'2.7 - 270')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' RON ', N'0.15 - 37.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' RON ', N'0.01 - 62.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' RON ', N'0.01 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' RON ', N'0.01 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' RON ', N'0.01 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' RON ', N'0.01 - 22.5')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'1', N' NZD ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'1', N' NZD ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'1', N' NZD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'1', N' NZD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'1', N' NZD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'1', N' NZD ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' MYR ', N'0.15 - 75')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' MYR ', N'0.25 - 125')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' MYR ', N'0.09 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' MYR ', N'0.09 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' MYR ', N'0.09 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' MYR ', N'0.09 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' USD ', N'0.15 - 30')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' USD ', N'0.25 - 50')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' USD ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' USD ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' USD ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' USD ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' CNY ', N'0.3 - 150')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' CNY ', N'0.25 - 250')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' CNY ', N'0.18 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' CNY ', N'0.18 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' CNY ', N'0.18 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' CNY ', N'0.18 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' GBP ', N'0.15 - 15')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' GBP ', N'0.25 - 25')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' GBP ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' GBP ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' GBP ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' GBP ', N'0.09 - 9')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' VND ', N'0.9 - 600')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' VND ', N'1.5 - 1000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' VND ', N'0.54 - 360')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' VND ', N'0.54 - 360')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' VND ', N'0.54 - 360')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' VND ', N'0.54 - 360')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' EUR ', N'0.15 - 30')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' EUR ', N'0.25 - 50')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' EUR ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' EUR ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' EUR ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' EUR ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' THB ', N'1.5 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' THB ', N'2.5 - 1500')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' THB ', N'0.9 - 540')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' THB ', N'0.9 - 540')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' THB ', N'0.9 - 540')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' THB ', N'0.9 - 540')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' IDR ', N'0.45 - 300')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' IDR ', N'0.75 - 500')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' IDR ', N'0.27 - 180')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' IDR ', N'0.27 - 180')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' IDR ', N'0.27 - 180')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' IDR ', N'0.27 - 180')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' INR ', N'7.5 - 1500')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' INR ', N'12.5 - 2500')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' INR ', N'4.5 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' INR ', N'4.5 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' INR ', N'4.5 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' INR ', N'4.5 - 900')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' KRW ', N'150 - 30000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' KRW ', N'250 - 50000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' KRW ', N'90 - 18000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' KRW ', N'90 - 18000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' KRW ', N'90 - 18000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' KRW ', N'90 - 18000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' MMK ', N'0.15 - 30')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' MMK ', N'0.25 - 50')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' MMK ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' MMK ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' MMK ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' MMK ', N'0.09 - 18')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' HKD ', N'0.30 - 150')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' HKD ', N'0.50 - 250')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' HKD ', N'0.18 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' HKD ', N'0.18 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' HKD ', N'0.18 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' HKD ', N'0.18 - 90')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' KHR ', N'0.15 - 75')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' KHR ', N'0.25 - 125')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' KHR ', N'0.09 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' KHR ', N'0.09 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' KHR ', N'0.09 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' KHR ', N'0.09 - 45')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4031', N'Caishen''s Quest', N'2', N' JPY ', N'15 - 3000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4032', N'Lucky Dragons', N'2', N' JPY ', N'25 - 5000')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4033', N'Highway Cash', N'2', N' JPY ', N'9 - 1800')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4035', N'Goldbeard''s Treasure', N'2', N' JPY ', N'9 - 1800')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4036', N'Double Triple 8', N'2', N' JPY ', N'9 - 1800')
GO
INSERT #Betlimit ([GameType], [Game], [Level], [Currency], [BetLimit]) VALUES (N'4037', N'Gods of Fortune', N'2', N' JPY ', N'9 - 1800')
GO

CREATE TABLE #BetlimitDeposit(	
	GameType		INT			NOT NULL,		
	CurrencyID		INT			NOT NULL,
	BetLimit		VARCHAR(50)	NOT NULL,
	StakeLevelID	INT			NOT NULL
) 
CREATE TABLE #BetlimitCredit(
	GameType		INT				NOT NULL,		
	Level			INT				NOT NULL,
	CurrencyID		INT				NOT NULL,
	BetLimit		VARCHAR(50)		NOT NULL,
	StakeLevelID	INT				NOT NULL
) 
INSERT INTO #BetlimitDeposit(GameType,CurrencyID,BetLimit,StakeLevelID)
SELECT	GameType,
		CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END,		
		BetLimit,
		StakeLevelID
FROM #Betlimit t
	LEFT JOIN exchange e WITH(NOLOCK) 
		ON RTRIM(LTRIM(t.Currency))=e.Code
	INNER JOIN Dep_StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID=4001 AND s.GameGroupID=3
			AND CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END=s.ExchangeID
WHERE Level=1 

INSERT INTO #BetlimitCredit(GameType,Level,CurrencyID,BetLimit,StakeLevelID)
SELECT	GameType,
		Level,
		CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END,		
		BetLimit,
		s.StakeLevelID
FROM #Betlimit t
	LEFT JOIN exchange e WITH(NOLOCK) ON RTRIM(LTRIM(t.Currency))=e.Code
	INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID=4001 AND s.GameGroupID=1 AND t.Level=1
			AND CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END=s.ExchangeID
WHERE t.Currency IN (SELECT Currency FROM #Betlimit WHERE Level=2 )

INSERT INTO #BetlimitCredit(GameType,Level,CurrencyID,BetLimit,StakeLevelID)
SELECT	GameType,
		Level,
		CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END,		
		BetLimit,
		s.StakeLevelID
FROM #Betlimit t
	LEFT JOIN exchange e WITH(NOLOCK) ON RTRIM(LTRIM(t.Currency))=e.Code
	INNER JOIN StakeLevel s WITH(NOLOCK) 
		ON s.GameTypeID=4001 AND s.GameGroupID=2 AND t.Level=2
			AND CASE WHEN RTRIM(LTRIM(t.Currency))='UUS' THEN 20 ELSE e.exchangeid END=s.ExchangeID
WHERE t.Currency IN (SELECT Currency FROM #Betlimit WHERE Level=2 ) 

INSERT INTO StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT	StakeLevelID,
		GameType,
		REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,1,CHARINDEX('-',BetLimit) - 1))),',','') AS MinLabel,
		CAST(CONVERT(FLOAT, REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,CHARINDEX('-',BetLimit) + 1,LEN(BetLimit)))),',','')) AS VARCHAR(100)) AS MaxLabel,
		CONVERT(DECIMAL(19,2),REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,1,CHARINDEX('-',BetLimit) - 1))),',','')) AS Min,
		CONVERT(DECIMAL(19,2), REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,CHARINDEX('-',BetLimit) + 1,LEN(BetLimit)))),',','')) AS Max
FROM #BetlimitCredit

INSERT INTO Dep_StakeLevelGroupDetail(StakeLevelID,GameTypeID,MinLabel,MaxLabel,MinStake,MaxStake)
SELECT	StakeLevelID,
		GameType,
		REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,1,CHARINDEX('-',BetLimit) - 1))),',','') AS MinLabel,
		CAST(CONVERT(FLOAT, REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,CHARINDEX('-',BetLimit) + 1,LEN(BetLimit)))),',','')) AS VARCHAR(100)) AS MaxLabel,
		CONVERT(DECIMAL(19,2),REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,1,CHARINDEX('-',BetLimit) - 1))),',','')) AS Min,
		CONVERT(DECIMAL(19,2), REPLACE(LTRIM(RTRIM(SUBSTRING (BetLimit,CHARINDEX('-',BetLimit) + 1,LEN(BetLimit)))),',','')) AS Max
FROM #BetlimitDeposit

DROP TABLE #BetlimitDeposit
DROP TABLE #BetlimitCredit
DROP TABLE #Betlimit
