/*
	Created: Elodie
	Date: 20220224
	Task: Insert ProductBetSetting for YNG
	DB: DBCUST/CUSTDB
*/

--insert global settings
INSERT INTO [dbo].[ProductBetSetting]
           ([Sporttype]
           ,[Bettype]
           ,[Currency]
           ,[MinBet]
           ,[IsDep]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[DefaultMinBet]
           ,[DefaultMaxBet]
           ,[DefaultMaxPerMatch])
SELECT 	[Sporttype]
	   ,t.[Bettype]
	   ,72
	   ,[MinBet]
	   ,[IsDep]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[DefaultMinBet]
	   ,[DefaultMaxBet]
	   ,[DefaultMaxPerMatch]	
FROM [dbo].[ProductBetSetting] p WITH(NOLOCK)
WHERE BetType BETWEEN 1501 AND 1599
	AND currency = 20 

