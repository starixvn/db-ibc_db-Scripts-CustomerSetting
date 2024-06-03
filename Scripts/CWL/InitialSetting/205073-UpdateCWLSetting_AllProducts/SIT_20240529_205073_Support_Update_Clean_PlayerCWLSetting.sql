/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20240529@Tacy
	Task: CWL - Update setting [Redmine: #205073]
	Database:	DBCUST.CustDB
*/
USE CustDB
GO

--Number Game 
UPDATE WinLimit_ProductSettingDetail WITH (ROWLOCK, UPDLOCK)
SET IsBlockedTransfer=0
	,IsBlockedPlaceBet=0
WHERE ProductID=3
AND (IsBlockedPlaceBet=1 OR IsBlockedTransfer=1)
GO

--Clean CWL setting: CustID=24954755
DELETE FROM WinLimit_CustGameMonitoring WITH (ROWLOCK)
WHERE CustID=24954755
GO

CREATE TABLE #tmpWinLimit_CustGameStatus(
	[CustID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[BettypeID] [smallint] NOT NULL)

CREATE TABLE #tmpWinLimit_CustGameStatus_batch(
	[CustID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[BettypeID] [smallint] NOT NULL)

INSERT INTO #tmpWinLimit_CustGameStatus (CustID, ProductID, BettypeID)
SELECT CustID, ProductID, BettypeID
FROM WinLimit_CustGameStatus WITH (NOLOCK)
WHERE CustID=24954755

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpWinLimit_CustGameStatus_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID, deleted.ProductID, deleted.BettypeID
		INTO #tmpWinLimit_CustGameStatus_batch(CustID, ProductID, BettypeID)
	FROM #tmpWinLimit_CustGameStatus T

	IF @@ROWCOUNT=0
		BREAK

	DELETE p
	FROM WinLimit_CustGameStatus p WITH (ROWLOCK)
	INNER JOIN #tmpWinLimit_CustGameStatus_batch t
		ON t.CustID=p.CustID 
		AND t.ProductID=p.ProductID
		AND t.BettypeID=p.BettypeID

	WAITFOR DELAY '00:00:0.200'
END