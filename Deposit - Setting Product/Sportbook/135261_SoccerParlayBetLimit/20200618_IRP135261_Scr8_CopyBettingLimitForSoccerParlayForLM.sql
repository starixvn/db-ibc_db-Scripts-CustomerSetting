/*
	Created: 20200618@Johnson
	Task: copy bet limit from soccer hdp for soccer parlay for LM
	DB: DBCUST/CustDB
*/

INSERT INTO [dbo].[Dep_CustBetLimit_Special]
           ([Site]
           ,[CurrencyID]
           ,[SportType]
           ,[AgentID]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPerBall]
           ,[Bettype])
SELECT [Site]
	   ,[CurrencyID]
	   ,[SportType]
	   ,[AgentID]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[MaxPerBall]
	   ,9 as [Bettype]
FROM Dep_CustBetLimit_Special WITH(NOLOCK)
WHERE sportType = 1 
	AND betType = 1
	
	