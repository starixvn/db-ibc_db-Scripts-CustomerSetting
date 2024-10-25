/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240715@Helios
	Task: Scale out DBCUST - Credit Customer in GlobCustDB - Migrate all custid in Dep_Customer_Archived to CustInfoMini [#206823]  
		https://nexdev.net/issues/207704
	DB: DBCust/CustDB
*/

------ info for deployer
DECLARE @StartRow		INT 
	, @StopRow		INT 
	, @MinRow		INT
	, @MaxRow		INT	-- Keep the total row of your data
	, @Threshold	INT   -- the number of each batch
	, @StartDTS		DATETIME2;
		
DECLARE @debug_message VARCHAR(500);
SET @Threshold		= 4000;


SET @MinRow			= (SELECT MIN (CustID) FROM Dep_Customer_Archived da WITH (NOLOCK) WHERE da.Status = 'completed');
SET @MaxRow			= (SELECT MAX (CustID) FROM Dep_Customer_Archived da WITH (NOLOCK) WHERE da.Status = 'completed');

SET @StartDTS		= xxx													-- As StartDTS  From CustInfoMini From "2_2_1_GetMin_CustID_SubAccID"

IF @Threshold >= @MaxRow
	SET @Threshold = @MaxRow;

---- SET for first batch
SELECT @StartRow = @MinRow, @StopRow = @MinRow + @Threshold;

---- Part 1: Get Cust Not Finish ReActive Yet

WHILE (@MaxRow IS NOT NULL)
BEGIN
	
		PRINT @StartRow
		PRINT @StopRow
		
		-- YOUR CODE PROCESS FOR DATA FROM @StartRow & @StopRow
		INSERT INTO CustInfoMini
			(
				CustID
			    , username
			    , username2
			    , recommend
			    , mrecommend
			    , srecommend
			    , roleid
			    , Site
			    , Currency
			)
		SELECT 
				da.CustID ,
				da.Username ,
				da.Username2 ,
				c.recommend ,
				c.mrecommend ,
				c.srecommend ,
				1 AS RoleID ,
				c.site ,
				c.currency
		FROM Dep_Customer_Archived da WITH (NOLOCK)
		INNER JOIN Customer c WITH (NOLOCK) ON da.Recommend = c.custid
		WHERE da.Status = 'completed'
		AND da.custid BETWEEN @StartRow AND @StopRow
		AND da.CustID NOT IN(	25035624
								,25056471
								,25044062
								,26037650
								,26038587
								,25114822
								,26322830
								,69898802
								,47452545
								,49129992
								,26955376
								,40588893
								,35180028
								,32717116
								,60465560
								,61209018
								,26909556
								,36315047
								,74072182
								,60610414
								,77793985
								,26458109
								,26489599
								,27595391
								,25194994
								,42840824
								,35183948
								,58149536
								,74423748
								,69284429)
	
		SET @debug_message = CONVERT(VARCHAR(50), GETDATE(), 121)			
		RAISERROR (@debug_message, 0, 1) WITH NOWAIT
		
		IF @StopRow = @MaxRow BREAK

		WAITFOR DELAY '00:00:00.100' --optional

		SET @StartRow = @StopRow + 1
		SET @StopRow = @StopRow + @Threshold
		IF @StopRow >= @MaxRow
			SET @StopRow = @MaxRow
END
SET @debug_message = 'Curdt End Part 1: ' + CONVERT(VARCHAR(50), GETDATE(), 121)			
	RAISERROR (@debug_message, 0, 1) WITH NOWAIT


---- Part 2: Get all custs have just reactivated when migrating

DECLARE @TempReActive_CustID TABLE (CustID INT);

INSERT INTO @TempReActive_CustID 
	(
		CustID
	)
SELECT DISTINCT da.CustID
FROM DBLOG.bodb_CustomerLog.dbo.[DBALog_Archive_Dep_Cust_Process] da WITH(NOLOCK)
WHERE da.status = 'DONE'
AND da.action = 'REACTIVATION'
AND da.LogTime >= @StartDTS


-- Just leave Cust ReActived and Not Exist In CustInfoMini
DELETE temp_Cust
FROM @TempReActive_CustID temp_Cust
INNER JOIN  CustInfoMini  cmn WITH (NOLOCK) ON temp_Cust.CustID = cmn.CustID

-- Migrate Cust ReActive. Maybe Exist in Customer or Dep_Customer_Archived
IF EXISTS (SELECT TOP 1 1 FROM @TempReActive_CustID)
BEGIN
	INSERT INTO CustInfoMini
	(
		CustID
	    , username
	    , username2
	    , recommend
	    , mrecommend
	    , srecommend
	    , roleid
	    , Site
	    , currency
	)
	
	SELECT
		temp.CustID
	    , c.username
	    , c.username2
	    , c.recommend
	    , c.mrecommend
	    , c.srecommend
	    , c.roleid
	    , c.site
	    , c.currency
	FROM @TempReActive_CustID temp 
	INNER JOIN Customer c WITH (NOLOCK) ON temp.CustID = c.custid
	WHERE NOT EXISTS (SELECT 1 FROM CustInfoMini cimh WITH (NOLOCK) WHERE temp.CustID = cimh.CustID)

	UNION 

	SELECT
		dca.CustID
	    , dca.username
	    , dca.username2
	    , c.recommend
	    , c.mrecommend
	    , c.srecommend
	    , 1 AS Roleid
	    , c.site
	    , c.currency
	FROM @TempReActive_CustID temp 
	INNER JOIN Dep_Customer_Archived dca WITH (NOLOCK) ON temp.CustID = dca.CustID
	INNER JOIN Customer c WITH (NOLOCK) ON dca.Recommend = c.custid
	WHERE dca.Status <> 'completed'
	AND NOT EXISTS (SELECT 1 FROM CustInfoMini cimh WITH (NOLOCK) WHERE temp.CustID = cimh.CustID)
	
	SET @debug_message = 'Curdt End Part 2: ' + CONVERT(VARCHAR(50), GETDATE(), 121)			
	RAISERROR (@debug_message, 0, 1) WITH NOWAIT
END


---- Part 3: Get all custs Archived Fail or another status when migrating

DECLARE @TempArchived_CustID TABLE (CustID INT , Recommend INT , username VARCHAR(30) , username2 VARCHAR(50) );

INSERT INTO @TempArchived_CustID 
	(
		CustID,
		Recommend,
		username,
		username2
	)
SELECT dca.CustID , dca.Recommend , dca.Username , dca.Username2
FROM	Dep_Customer_Archived dca WITH (NOLOCK)
WHERE dca.Status NOT IN ('completed','reactivation')


-- Just leave Cust Archived Fail or another status and Not Exist In CustInfoMini
DELETE temp_Cust
FROM @TempArchived_CustID temp_Cust
INNER JOIN  CustInfoMini  cmn WITH (NOLOCK) ON temp_Cust.CustID = cmn.CustID

IF EXISTS (SELECT TOP 1 1 FROM @TempArchived_CustID)
BEGIN
	INSERT INTO CustInfoMini 
	(
		CustID
	    , username
	    , username2
	    , recommend
	    , mrecommend
	    , srecommend
	    , roleid
	    , Site
	    , Currency
	)

	SELECT 
		temp.CustID
	    , temp.username
	    , temp.username2
	    , c.recommend
	    , c.mrecommend
	    , c.srecommend
	    , 1 AS roleid
	    , c.site
	    , c.currency
	FROM @TempArchived_CustID temp
	INNER JOIN Customer c WITH (NOLOCK) ON temp.Recommend = c.custid
	WHERE NOT EXISTS (SELECT 1 FROM CustInfoMini cimh WITH (NOLOCK) WHERE temp.CustID = cimh.CustID)
END
