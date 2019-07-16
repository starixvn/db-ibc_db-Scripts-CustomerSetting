/*
	Created: Eden
	Date: 2019/07/16
	Task: Insert ProductBetSetting for Keno UAT 
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
	   ,[Currency]
	   ,[MinBet]
	   ,[IsDep]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[DefaultMinBet]
	   ,[DefaultMaxBet]
	   ,[DefaultMaxPerMatch]	
FROM [dbo].[ProductBetSetting] p WITH(NOLOCK)
	CROSS APPLY (SELECT 1525 as Bettype
			UNION SELECT 1526 as Bettype			
			) t
WHERE p.sporttype = 202 
	AND p.bettype = 1515
	AND currency = 20 


