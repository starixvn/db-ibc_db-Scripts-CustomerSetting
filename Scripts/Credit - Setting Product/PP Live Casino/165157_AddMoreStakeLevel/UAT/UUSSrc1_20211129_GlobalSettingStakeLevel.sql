/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Winfred
	Date: 20210806
	Task: Add more stakelevel for all currencies of Pragmatic Live Casino [ RedmineID:#165157]
	DB: DBCUST/CustDB
	P/s : Step 1 Add global setting UUS
*/ 
USE CustDB
GO

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
--UUS
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,20   UNION ALL	--UUS	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
--YNG
SELECT 3701 ,'0.1'    ,'1250'      ,0.1    ,1250.00   ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'500'       ,0.1    ,500.00    ,72   UNION ALL	--YNG	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG
SELECT 3701 ,'0.1'    ,'250'       ,0.1    ,250.00    ,72				--YNG	--Yen, UT, $US, US$, USD,MMK, EURO,UUS,YNG

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999999


INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #StakeLevel_Temp T WITH(NOLOCK)
WHERE NOT EXISTS (SELECT TOP 1 1 FROM StakeLevel WITH(ROWLOCK)
								 WHERE t.GameTypeID = GameTypeID AND t.ExchangeId = ExchangeId  
								   AND t.MinStake = MinStake AND t.MaxStake = MaxStake )
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #StakeLevel_Temp
