/*
	Created: 20200713@Eden
	Task: Insert ProductBetSetting for Keno Real Currencies [Redmine:#137475]	
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO 
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
	   ,[Currency]
	   ,[MinBet]
	   ,[IsDep]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[DefaultMinBet]
	   ,[DefaultMaxBet]
	   ,[DefaultMaxPerMatch]	
FROM [dbo].[ProductBetSetting] p WITH(NOLOCK)
	CROSS APPLY (SELECT 1527 as Bettype
			UNION SELECT 1528 as Bettype	
			UNION SELECT 1529 as Bettype		
			) t
WHERE p.sporttype = 202 
	AND p.bettype = 1515
	AND currency <> 20 

