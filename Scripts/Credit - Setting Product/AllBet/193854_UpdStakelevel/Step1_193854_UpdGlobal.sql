/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230918
	Task: Allbet - Change Play Currency - Change bet limit for RM,HK$, RMB, HKK, USD and re-open Credit Markets [Redmine: 193854]
	DB: DBCust/CustDB
	Step 1 : Update Global
*/
USE CustDB
GO

DECLARE @betType SMALLINT,@sportType SMALLINT

SELECT @sportType = 211 , @betType = 2401 	
--============================Bet Setting
--US$,Yen,$US,UT,USTM,USD
DELETE StakeLevel WHERE MinStake = 2 AND MaxStake = 200 AND GameTypeID = @betType AND ExchangeId IN (3,16,35,64,11,95)
DELETE StakeLevel WHERE MinStake = 2 AND MaxStake = 1000 AND GameTypeID = @betType AND ExchangeId IN (3,16,35,64,11,95)
DELETE StakeLevel WHERE MinStake = 25 AND MaxStake = 2499 AND GameTypeID = @betType AND ExchangeId IN (3,16,35,64,11,95)
 

--SELECT * FROM StakeLevel WHERE MinStake = 2 AND MaxStake = 200 AND GameTypeID = @betType AND ExchangeId IN (3,16,35,64,11,95)
--SELECT * FROM StakeLevel WHERE MinStake = 2 AND MaxStake = 1000 AND GameTypeID = @betType AND ExchangeId IN (3,16,35,64,11,95)
--SELECT * FROM StakeLevel WHERE MinStake = 25 AND MaxStake = 2500 AND GameTypeID = @betType AND ExchangeId IN (3,16,35,64,11,95)
GO

--CREATE TABLE #StakeLevel_Temp(
--	GameTypeID		INT,
--	[MinLabel]		NVARCHAR(50),
--	[MaxLabel]		NVARCHAR(50),
--	[MinStake]		[decimal](19, 8) NULL,
--	[MaxStake]		[decimal](19, 8) NULL,
--	[ExchangeId]	[int] 
--) ON [PRIMARY]

--INSERT #StakeLevel_Temp (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake , ExchangeId )
--SELECT 2401 ,'500'    ,'20000'      ,500    ,20000   ,2   UNION ALL	--RM
--SELECT 2401 ,'500'    ,'20000'      ,500    ,20000   ,67			--HKK

--UPDATE t
--SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
--FROM #StakeLevel_Temp t
--WHERE MaxStake > 999


--INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
--SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
--FROM #StakeLevel_Temp T WITH(NOLOCK)
--WHERE NOT EXISTS (SELECT TOP 1 1 FROM StakeLevel WITH(ROWLOCK)
--								 WHERE t.GameTypeID = GameTypeID AND t.ExchangeId = ExchangeId  
--								   AND t.MinStake = MinStake AND t.MaxStake = MaxStake )
--ORDER BY GameTypeID,ExchangeId,MaxStake

--DROP TABLE #StakeLevel_Temp


