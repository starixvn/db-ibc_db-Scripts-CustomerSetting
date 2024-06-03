/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Creator: 20231204@Tacy
	Task: CWL - Clean incorrect bettype for Number Game [Redmine: #205073]
	Database:	DBCUST.CustDB
*/
USE CustDB
GO

----------------------------------------------------------
----------------------------------------------------------
CREATE TABLE #tblBettype (BettypeId SMALLINT)

CREATE TABLE #tblBettype_batch (ProductID TINYINT DEFAULT (3), BettypeId SMALLINT)

INSERT INTO #tblBettype (BettypeId)
SELECT wl.BetTypeID
FROM Winlimit_GameGroupSetting wl WITH (NOLOCK)
WHERE ProductID =3
AND wl.BetTypeID NOT IN (SELECT sm.BetType
						  FROM DBACC.bodb02.dbo.SportBettypeMatrix sm WITH (NOLOCK)
						  WHERE sm.ProductID=3)

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tblBettype_batch

	DELETE TOP (3000) T
	OUTPUT deleted.BettypeId INTO #tblBettype_batch (BettypeId)
	FROM #tblBettype T

	IF @@ROWCOUNT=0
		BREAK

	DELETE wl
	FROM Winlimit_GameGroupSetting wl WITH (ROWLOCK)
	INNER JOIN #tblBettype_batch t ON t.ProductID=wl.ProductID
									AND t.BettypeId=wl.BetTypeID

	WAITFOR DELAY '00:00:0.200'
END
