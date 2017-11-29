/*
	Created: Johnson
	Date: 20171129
	Task: support DCS settings for Bobo88
	DB: DBCust/CustDB
*/

INSERT INTO dbo.Dep_CustPTSetting_Agent([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT])
SELECT 	t.[CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[IsLive]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT]	
FROM dbo.Dep_CustPTSetting_Agent cs WITH(NOLOCK)
	CROSS APPLY (SELECT 28031433 as CustID	--	Bobo88RMB02
				UNION SELECT 	28031438	--	Bobo88RMB03
				UNION SELECT 	28031443	--	Bobo88RMB04
				)t
WHERE cs.custid = 26663397	--	Bobo88RMB01
	AND sporttype between 180 AND 199 -- VS			
	

INSERT INTO [dbo].[Dep_CustBetSetting_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[MinBet]
           ,[MaxBet]
           ,[MaxPerMatch])	
SELECT t.[CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
FROM dbo.Dep_CustBetSetting_Agent cs WITH(NOLOCK)
	CROSS APPLY (SELECT 28031433 as CustID	--	Bobo88RMB02
				UNION SELECT 	28031438	--	Bobo88RMB03
				UNION SELECT 	28031443	--	Bobo88RMB04
				)t
WHERE cs.custid = 26663397	--	Bobo88RMB01
	AND sporttype between 180 AND 199 -- VS		

INSERT INTO [dbo].[Dep_CustProductStatus]
           ([CustID]
           ,[bitmapIsHidden]
           ,[bitmapIsDisabled])	
SELECT	t.[CustID]
	   ,[bitmapIsHidden]
	   ,[bitmapIsDisabled]	   
FROM dbo.Dep_CustProductStatus cs WITH(NOLOCK)
	CROSS APPLY (SELECT 28031433 as CustID	--	Bobo88RMB02
				UNION SELECT 	28031438	--	Bobo88RMB03
				UNION SELECT 	28031443	--	Bobo88RMB04
				)t
WHERE cs.custid = 26663397	--	Bobo88RMB01
			   