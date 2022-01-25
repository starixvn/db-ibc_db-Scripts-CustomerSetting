/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20220121
	Task:		Update setting 170	PP Live Casino (PP Live Casino) for currency INR1 RedmineID:#166295
	DB:			DBCust/CustDB
*/

DECLARE @ToCurrency INT

SELECT	@ToCurrency = 10   -- INR1
----------------StakeLevel -- product PP Live Casino
-- 5-12,500
UPDATE StakeLevel WITH(ROWLOCK, UPDLOCK) 
SET MinLabel ='5',
	MaxLabel ='12,500',
	MinStake = 5,
	MaxStake = 12500
WHERE GameTypeID = 3701 AND ExchangeId = @ToCurrency AND MinStake = 4 AND MaxStake = 100000


CREATE TABLE #StakeLevel_Temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]		[decimal](19, 8) NULL,
	[MaxStake]		[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]

GO
INSERT #StakeLevel_Temp (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake , ExchangeId )
--INR1
SELECT 3701 ,'5'    ,'25000'       ,5    ,25000    ,10   UNION ALL	--INR1
SELECT 3701 ,'5'    ,'62500'       ,5    ,62500    ,10   UNION ALL	--INR1
SELECT 3701 ,'5'    ,'125000'      ,5    ,125000   ,10				--INR1

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999


INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #StakeLevel_Temp T WITH(NOLOCK)
WHERE NOT EXISTS (SELECT TOP 1 1 FROM StakeLevel WITH(ROWLOCK)
								 WHERE t.GameTypeID = GameTypeID AND t.ExchangeId = ExchangeId  
								   AND t.MinStake = MinStake AND t.MaxStake = MaxStake )
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #StakeLevel_Temp
