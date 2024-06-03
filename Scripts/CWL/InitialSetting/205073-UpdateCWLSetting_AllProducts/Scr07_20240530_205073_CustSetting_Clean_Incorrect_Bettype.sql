/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20240530@Tacy
	Task: CWL - Clean Customer data - Incorrect bettype [Redmine: #205073]
	Database:	DBCUST.CustDB
*/
USE CustDB
GO

----------------------------------------------------------
----------------------------------------------------------
--WinLimit_CustGameMonitoring
DELETE wl
FROM WinLimit_CustGameMonitoring wl WITH (ROWLOCK)
CROSS APPLY (SELECT CAST(VALUE AS INT) bettype 
			 FROM STRING_SPLIT(wl.BettypeIDList,',')) bt
LEFT JOIN Winlimit_GameGroupSetting gg WITH (NOLOCK) 
		ON wl.ProductID=gg.ProductID
		AND bt.BetType=gg.BetTypeID
WHERE wl.WinlostDate='2024-05-29'
	AND wl.ProductID IN (8,40,5,27,77,83,3) --LIST PRODUCT: add special setting
	AND gg.BetTypeID IS NULL


--WinLimit_CustGameMonitoring_History
DELETE wl
FROM WinLimit_CustGameMonitoring_History wl WITH (ROWLOCK)
CROSS APPLY (SELECT CAST(VALUE AS INT) bettype 
			 FROM STRING_SPLIT(wl.BettypeIDList,',')) bt
LEFT JOIN Winlimit_GameGroupSetting gg WITH (NOLOCK) 
		ON wl.ProductID=gg.ProductID
		AND bt.BetType=gg.BetTypeID
WHERE wl.WinlostDate='2024-05-29'
	AND wl.ProductID IN (8,40,5,27,77,83,3) --LIST PRODUCT: add special setting
	AND gg.BetTypeID IS NULL


--WinLimit_CustGameStatus
CREATE TABLE #tmpWinLimit_CustGameStatus
(	CustID	int,
	ProductID	tinyint,
	BettypeID	smallint,
	PRIMARY KEY CLUSTERED (CustID, ProductID, BettypeID)
)

CREATE TABLE #tmpWinLimit_CustGameStatus_batch
(	CustID	int,
	ProductID	tinyint,
	BettypeID	smallint,
	PRIMARY KEY CLUSTERED (CustID, ProductID, BettypeID)
)

--48030
INSERT INTO #tmpWinLimit_CustGameStatus (CustID, ProductID, BettypeID)
SELECT wl.CustID, wl.ProductID, wl.BettypeID
FROM WinLimit_CustGameStatus wl WITH (NOLOCK)
LEFT JOIN Winlimit_GameGroupSetting gg WITH (NOLOCK) 
		ON wl.ProductID=gg.ProductID
		AND wl.BettypeID=gg.BetTypeID
WHERE wl.ProductID IN (8,40,5,27,77,83,3) --LIST PRODUCT: add special setting
	AND gg.BetTypeID IS NULL
	AND wl.ModifiedDate BETWEEN '2024-05-29' AND '2024-05-30'

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpWinLimit_CustGameStatus_batch

	DELETE TOP (3000) T
	OUTPUT deleted.CustID, deleted. ProductID, deleted.BettypeID
		INTO #tmpWinLimit_CustGameStatus_batch (CustID, ProductID, BettypeID)
	FROM #tmpWinLimit_CustGameStatus T
	
	IF @@ROWCOUNT=0
		BREAK

	DELETE wl
	FROM WinLimit_CustGameStatus wl WITH (ROWLOCK)
	INNER JOIN #tmpWinLimit_CustGameStatus_batch t
		ON t.CustID=wl.CustID
		AND t.ProductID=wl.ProductID
		AND t.BettypeID=wl.BettypeID

	WAITFOR DELAY '00:00:0.200'
END

DROP TABLE #tmpWinLimit_CustGameStatus, #tmpWinLimit_CustGameStatus_batch
GO