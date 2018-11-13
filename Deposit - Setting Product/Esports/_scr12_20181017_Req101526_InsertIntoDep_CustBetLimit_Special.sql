/*
	Created: Winnie
	Date: 20181113
	Task: Insert into [Dep_CustBetLimit_Special] for Esports
	DB: DBCust/CustDB
*/
 
USE [CustDB]
GO

INSERT INTO [dbo].[Dep_CustBetLimit_Special]
           ([Site]
           ,[CurrencyID]
           ,[SportType]
           ,[AgentID]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPerBall]
           ,[Bettype])
 SELECT 
			[Site]
           ,[CurrencyID]
           ,43
           ,[AgentID]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPerBall]
           ,1
FROM [Dep_CustBetLimit_Special] WITH(NOLOCK)
WHERE SportType=99 AND Bettype=1
