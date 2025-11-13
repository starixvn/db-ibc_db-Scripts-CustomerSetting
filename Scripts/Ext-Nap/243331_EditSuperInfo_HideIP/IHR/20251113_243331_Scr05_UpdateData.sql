/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20251113@Dave
	Task: EXT - Allow Headline to hide IP info of their downlines [Redmine:#243331]
	DB: DBCUST.CustDB
*/
USE CustDB
GO

-- Batch parameters
DECLARE @BatchSize INT = 2000;
DECLARE @Delay VARCHAR(12) = '00:00:00.280'; -- hh:mm:ss.fff

DECLARE @cnt INT, @__msg NVARCHAR(200) 

CREATE TABLE #tmp_CustSuper_243331 (
	CustID BIGINT NOT NULL,
	PRIMARY KEY CLUSTERED (CustID)
);

CREATE TABLE #tmp_CustSuper_243331_batch (
	CustID BIGINT NOT NULL,
	PRIMARY KEY CLUSTERED (CustID)
);

INSERT INTO #tmp_CustSuper_243331 (CustID)
SELECT CustID
FROM CustSuper WITH (NOLOCK);
--WHERE isHideIP IS NULL;

--------------------------------------------------
SELECT @cnt=COUNT(1) FROM #tmp_CustSuper_243331;
SET @__msg = 'The total of row will be synced: %d.';
RAISERROR (@__msg, 0, 1, @cnt) WITH NOWAIT;



WHILE ( 1 = 1)
BEGIN

	TRUNCATE TABLE #tmp_CustSuper_243331_batch;

	DELETE TOP(@BatchSize) #tmp_CustSuper_243331
	OUTPUT DELETED.CustID INTO #tmp_CustSuper_243331_batch;

	IF @@ROWCOUNT = 0 BREAK;

	UPDATE cs WITH (ROWLOCK, UPDLOCK)
	SET isHideIP = ISNULL(isHideIP, 0),
		RepUpdateTime = dbo.f_GetDateTime2()
	FROM CustSuper cs
	INNER JOIN #tmp_CustSuper_243331_batch b ON cs.CustID = b.CustID;

	WAITFOR DELAY @Delay;
END


DROP TABLE #tmp_CustSuper_243331;
DROP TABLE #tmp_CustSuper_243331_batch;
