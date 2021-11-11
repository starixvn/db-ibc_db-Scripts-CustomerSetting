/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211111@Johnson
	Task: add global settings for new games keno for UUS currency
	DB: DBCust/CustDB
*/

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
SELECT [Sporttype]
           ,t.[Bettype]
           ,[Currency]
           ,[MinBet]
           ,[IsDep]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[DefaultMinBet]
           ,[DefaultMaxBet]
           ,[DefaultMaxPerMatch]
FROM ProductBetSetting cs WITH(NOLOCK)
	CROSS APPLY (SELECT 1530 as bettype UNION SELECT 1531) t
WHERE Sporttype = 202
	AND cs.Bettype = 1515
	AND cs.Currency = 20