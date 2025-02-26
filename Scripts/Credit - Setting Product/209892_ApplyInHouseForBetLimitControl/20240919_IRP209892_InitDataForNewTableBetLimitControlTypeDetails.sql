/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240919@Johnson
	Task: Add new table BetLimitControlTypeDetails for Bet Limit Control [redmine: #209892]
	DB: DBCUST/CUSTDB	
*/ 

--69 rows
INSERT INTO [dbo].[BetLimitControlTypeDetails]
           ([BetLimitTypeID]
           ,[ProductID]
           ,[Sporttype]
           ,[Bettype]
           ,[LeagueGroupID]
           ,[LeagueID]
           ,[RepUpdateTime])
SELECT [BetLimitTypeID]
	   ,[ProductID]
	   ,[Sporttype]
	   ,[Bettype]
	   ,[LeagueGroupID]
	   ,[LeagueID]
	   ,SYSDATETIME()
FROM BetLimitControlTypeDetail WITH(NOLOCK)

