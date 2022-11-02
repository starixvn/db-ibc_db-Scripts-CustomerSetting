/*<info serverAlias="DBTP-bodb02"></info>*/

/*
	Created: 20221102@Tacy
	Task: Update Keno's Bettype on table [CustMaxBetSetting_History]
		 https://nexdev.net/issues/180040 RedmineID: #180040
	Database: DBTP-bodb02
*/
DECLARE @BATCH_SIZE INT = 5000;

CREATE TABLE #tmp_History (
		CustID		INT NOT NULL,
		SportType	SMALLINT NOT NULL,
		BetType		INT NOT NULL,
		UpdateTime	DATETIME NOT NULL,
		IsFinished	BIT DEFAULT 0
)

CREATE TABLE #tmp_HistoryBatch (
		CustID		INT NOT NULL,
		SportType	SMALLINT NOT NULL,
		BetType		INT NOT NULL,
		UpdateTime	DATETIME NOT NULL
)

DECLARE @tmp_GameType TABLE (GameTypeID INT, IBCBettypeID INT)

BEGIN TRY		
	INSERT INTO @tmp_GameType (GameTypeID, IBCBettypeID)
	SELECT GameTypeID, IBCBettypeID 
	FROM DBAGE.bodb02.dbo.GameType WITH (NOLOCK)
	WHERE IBCBetTypeID BETWEEN 1501 AND 1599	--Keno
END TRY
BEGIN CATCH		
	INSERT INTO @tmp_GameType (GameTypeID, IBCBettypeID)
	SELECT GameTypeID, IBCBettypeID 
	FROM DBTXN.bodb02.dbo.GameType WITH (NOLOCK)
	WHERE IBCBetTypeID BETWEEN 1501 AND 1599	--Keno
END CATCH

---UPDATE
INSERT INTO #tmp_History (CustID, SportType, BetType, UpdateTime)
SELECT CustID, SportType, BetType, UpdateTime
FROM CustMaxBetSetting_History his WITH (NOLOCK)
INNER JOIN @tmp_GameType t ON t.GameTypeID=his.BetType
WHERE his.SportType=202

WHILE (1=1)
BEGIN
	UPDATE TOP (@BATCH_SIZE) T
	SET IsFinished=1
	OUTPUT inserted.CustID, inserted.SportType, inserted.BetType, inserted.UpdateTime
		INTO #tmp_HistoryBatch(CustID, SportType, BetType, UpdateTime)
	FROM #tmp_History T WITH(NOLOCK)
	WHERE IsFinished=0 

	IF @@ROWCOUNT=0
		BREAK

	UPDATE his
	SET his.BetType=t.IBCBettypeID
	FROM CustMaxBetSetting_History his WITH (ROWLOCK, UPDLOCK)
	INNER JOIN @tmp_GameType t ON t.GameTypeID=his.BetType
	WHERE EXISTS (SELECT 1 FROM #tmp_HistoryBatch a 
				  WHERE	a.CustID=his.CustID
					  AND a.SportType=his.SportType
					  AND a.BetType=his.BetType
					  AND a.UpdateTime=his.UpdateTime
		)

	TRUNCATE TABLE #tmp_HistoryBatch

	WAITFOR DELAY '00:00:0.002'
END

DROP TABLE #tmp_History, #tmp_HistoryBatch