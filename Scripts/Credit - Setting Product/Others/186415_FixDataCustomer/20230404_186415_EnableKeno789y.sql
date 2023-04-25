/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221020
	Task: Enable Product Status for all disabled customers under 789y Headline - RedmineID: #124311
	DB: DBCUST/CustDB
*/ 
--	Keno
ALTER PROCEDURE [dbo].[Acc_CustSetting_18]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	
	CREATE TABLE #DownlineTemp
	(
		CustID INT,
		IsFinishedStatus BIT DEFAULT(0)
	)	
	
	CREATE CLUSTERED INDEX CIX_DownlineTemp ON #DownlineTemp (CustID)

	INSERT INTO #DownlineTemp (CustID)
	SELECT DISTINCT ci.custid
	FROM Custinfo ci WITH (NOLOCK)
		INNER JOIN dbo.CustGameType cs WITH (NOLOCK) ON cs.CustID = ci.custid
	WHERE srecommend = @srecommend
		AND ci.HideKeno = 1
		AND Enabled = 1 
		AND cs.IsDisabled = 0
		AND cs.GameTypeID BETWEEN 1 AND 99
		AND ci.custid <= @maxcustid

	----------------------------------------BetSetting------------------------------------
	DECLARE @MemberBatch TABLE(CustId INT)
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP (5000) t 		 
		SET t.IsFinishedStatus = 1
		OUTPUT INSERTED.CustID INTO @MemberBatch
		FROM #DownlineTemp t
		WHERE IsFinishedStatus = 0
	 
		IF @@ROWCOUNT = 0
			BREAK
		
		--update disabled=0 miss update hideKeno=0 
		UPDATE g 
		SET HideKeno = 0
		FROM dbo.CustInfo g WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @MemberBatch b ON g.CustID = b.CustID 

		DELETE @MemberBatch
	END
	
	--Drop all temp tables
	DROP TABLE #DownlineTemp
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
--Create Supers temp table:
DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'
Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))
CREATE TABLE #supers_missDis (custid INT PRIMARY KEY) --update hideKeno=1, miss update disabled=1

INSERT INTO #supers_missDis(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND (  ( ci.Site IN ('611111') AND ci.currency IN (2,42))
			OR ( ci.Site IN ('722222','733333') AND ci.currency IN (13))
			OR ( ci.Site IN ('y789','y889','yOther','yUT') AND ci.currency IN (2,6))
			OR ( ci.Site IN ('7aa666') AND ci.currency IN (2))
			OR ( ci.Site IN ('BEST-ODDS') AND ci.currency IN (42)))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = ci.custid
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND ci.site IN ('y789','y889','yOther','yUT')
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.currency <> 20
	AND Enabled = 1 
		AND ci.custid NOT IN (SELECT custid FROM #supers_missDis )

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_CustSetting_18 
			@srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = @target
						
	WAITFOR DELAY '00:00:0.1'
END

--Drop all temp tables
DROP TABLE #supers
DROP TABLE #supers_missDis
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------