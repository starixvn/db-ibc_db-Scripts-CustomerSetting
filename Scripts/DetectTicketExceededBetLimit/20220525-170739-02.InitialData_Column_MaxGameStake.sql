/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220525@Tacy
	Task: Initial data into column MaxGameStake on table StakeLevelGroupDetail, Dep_StakeLevelGroupDetail
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCUST/CustDB
*/


DECLARE @Batch_size INT;

SET @Batch_size=5000;

CREATE TABLE #tmpBuyBonus (
			StakeLevelID	INT, 
			GameTypeID		INT, 
			IsFinshed		BIT DEFAULT 0,
			PRIMARY KEY CLUSTERED (StakeLevelID, GameTypeID)
		)

CREATE TABLE #tmpBuyBonus_Batch (
			StakeLevelID	INT, 
			GameTypeID		INT,
			PRIMARY KEY CLUSTERED (StakeLevelID, GameTypeID)
		)


--Credit:
INSERT INTO #tmpBuyBonus(StakeLevelID, GameTypeID)
SELECT slg.StakeLevelID, slg.GameTypeID
FROM StakeLevelGroupDetail slg WITH (NOLOCK)
	INNER JOIN dbage.bodb02.dbo.bettype bt WITH (NOLOCK) ON bt.typeid=slg.GameTypeID
WHERE bt.typedesc='BuyBonus'
AND ((GameTypeID BETWEEN 5800 AND 5999) OR	
	 (GameTypeID BETWEEN 4001 AND 4100) OR 
	 (GameTypeID BETWEEN 6401 AND 6700) OR
	 (GameTypeID BETWEEN 4101 AND 4300) OR
	 (GameTypeID BETWEEN 6701 AND 7000) OR
	 (GameTypeID BETWEEN 4301 AND 4600))


WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpBuyBonus_Batch

	UPDATE TOP (@Batch_size) T
	SET IsFinshed=1
	OUTPUT inserted.StakeLevelID, inserted.GameTypeID 
		INTO #tmpBuyBonus_Batch(StakeLevelID, GameTypeID)
	FROM #tmpBuyBonus T WITH(NOLOCK)
	WHERE IsFinshed=0

	IF @@ROWCOUNT=0
		BREAK;

	UPDATE TOP (@Batch_size) slg
	SET slg.MaxGameStake=CASE WHEN   slg.GameTypeID BETWEEN 6401 AND 6700	THEN 98*MaxStake	--Joker
							  WHEN	(slg.GameTypeID BETWEEN 4001 AND 4100) OR
									(slg.GameTypeID BETWEEN 4101 AND 4300) OR 
									(slg.GameTypeID BETWEEN 6701 AND 7000) OR
									(slg.GameTypeID BETWEEN 4301 AND 4600) OR
									(slg.GameTypeID BETWEEN 5800 AND 5999)
																			THEN 100*MaxStake	--Macau Games, PP, SG
																			ELSE MaxStake
						END
	FROM StakeLevelGroupDetail slg WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #tmpBuyBonus_Batch bb ON bb.StakeLevelID=slg.StakeLevelID
										AND bb.GameTypeID=slg.GameTypeID

	WAITFOR DELAY '00:00:0.002'
END

TRUNCATE TABLE #tmpBuyBonus
;


--Deposit
INSERT INTO #tmpBuyBonus(StakeLevelID, GameTypeID)
SELECT dslg.StakeLevelID, dslg.GameTypeID
FROM Dep_StakeLevelGroupDetail dslg WITH (NOLOCK)
	INNER JOIN dbage.bodb02.dbo.bettype bt WITH (NOLOCK) ON bt.typeid=dslg.GameTypeID
WHERE bt.typedesc='BuyBonus'
AND ((GameTypeID BETWEEN 5800 AND 5999) OR	
	 (GameTypeID BETWEEN 4001 AND 4100) OR 
	 (GameTypeID BETWEEN 6401 AND 6700) OR
	 (GameTypeID BETWEEN 4101 AND 4300) OR
	 (GameTypeID BETWEEN 6701 AND 7000) OR
	 (GameTypeID BETWEEN 4301 AND 4600))

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpBuyBonus_Batch

	UPDATE TOP (@Batch_size) T
	SET IsFinshed=1
	OUTPUT inserted.StakeLevelID, inserted.GameTypeID 
		INTO #tmpBuyBonus_Batch(StakeLevelID, GameTypeID)
	FROM #tmpBuyBonus T WITH(NOLOCK)
	WHERE IsFinshed=0

	IF @@ROWCOUNT=0
		BREAK;

	UPDATE TOP (@Batch_size) dslg
	SET dslg.MaxGameStake=CASE WHEN  dslg.GameTypeID BETWEEN 6401 AND 6700	THEN 98*MaxStake	--Joker
							   WHEN	(dslg.GameTypeID BETWEEN 4001 AND 4100) OR
									(dslg.GameTypeID BETWEEN 4101 AND 4300) OR 
									(dslg.GameTypeID BETWEEN 6701 AND 7000) OR
									(dslg.GameTypeID BETWEEN 4301 AND 4600) OR
									(dslg.GameTypeID BETWEEN 5800 AND 5999)
																			THEN 100*MaxStake	--Macau Games, PP, SG
																			ELSE MaxStake
						END
	FROM Dep_StakeLevelGroupDetail dslg WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #tmpBuyBonus_Batch bb ON bb.StakeLevelID=dslg.StakeLevelID
										AND bb.GameTypeID=dslg.GameTypeID

	WAITFOR DELAY '00:00:0.002'
END

TRUNCATE TABLE #tmpBuyBonus

DROP TABLE #tmpBuyBonus
DROP TABLE #tmpBuyBonus_Batch
;