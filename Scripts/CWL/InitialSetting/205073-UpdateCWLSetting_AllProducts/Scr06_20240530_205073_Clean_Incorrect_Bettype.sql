/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20240530@Tacy
	Task: CWL - Clean incorrect bettype [Redmine: #205073]
	Database:	DBCUST.CustDB
*/
USE CustDB
GO

----------------------------------------------------------
----------------------------------------------------------
CREATE TABLE #tblBettype (ProductID TINYINT, BettypeId SMALLINT)

CREATE TABLE #tblBettype_batch (ProductID TINYINT, BettypeId SMALLINT)

INSERT INTO #tblBettype (ProductID, BettypeId)
SELECT wl.ProductID, wl.BetTypeID
FROM Winlimit_GameGroupSetting wl WITH (NOLOCK)
LEFT JOIN DBACC.bodb02.dbo.SportBettypeMatrix sm WITH (NOLOCK) 
		ON wl.ProductID=sm.ProductID
		AND wl.BetTypeID=sm.BetType
WHERE wl.ProductID IN (8,40,5,27,77,83,3) --LIST PRODUCT: add special setting
	AND sm.BetType IS NULL

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tblBettype_batch

	DELETE TOP (3000) T
	OUTPUT deleted.ProductID, deleted.BettypeId INTO #tblBettype_batch (ProductID, BettypeId)
	FROM #tblBettype T

	IF @@ROWCOUNT=0
		BREAK

	DELETE wl
	FROM Winlimit_GameGroupSetting wl WITH (ROWLOCK)
	INNER JOIN #tblBettype_batch t ON t.ProductID=wl.ProductID
									AND t.BettypeId=wl.BetTypeID

	WAITFOR DELAY '00:00:0.200'
END
