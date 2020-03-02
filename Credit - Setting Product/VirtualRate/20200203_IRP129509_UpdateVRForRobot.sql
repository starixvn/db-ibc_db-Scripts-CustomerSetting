/*
	Created: 20200302@Johnson
	Task: update VR setting for robot list issue
	DB: DBCUST/CustDB
*/
	DECLARE @startRun datetime  
	DECLARE @endRun datetime  
	DECLARE @duration int 
		
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY,isBA BIT DEFAULT 0, isFinished BIT DEFAULT 0, isLog BIT DEFAULT 0)
	
	SET @startRun = GETDATE() 
	
	INSERT INTO #tblCust(custid)
	SELECT custid 
	FROM customer (NOLOCK)
	WHERE custid IN (
		41171310,40050331,36080439,41203788,41063524,41220662,41225552,41235554,41210804,39771212
		--,40119317,41432663,41962034
		,41403949,34065916,41205065,41398309,39242600,41086926,41478872,41509729,41509705,41315664,41079168,41493512,41561427,41526960,41697788,41686467,41723615,41725906,40977489,41724145,41448406,41748057,38982515,41631397,41731589,41157114,41695827,41605311,41840497,41729183,41848206,39016090,41774953,39243154,41891784,41905906,41749069,41903311,41948122,41917269
	)
			
	UPDATE t
	SET isBA = 1
	FROM #tblCust t
		INNER JOIN Dep_CustBAActive c WITH(NOLOCK) ON t.custid = c.custid
		
	IF (SELECT count(1) FROM #tblCust WHERE isBA = 0) = 0 
		RETURN;
		
	--PROCESSING UPDATE
	DECLARE	@tblVirtualrate		TABLE (
										SportType			INT
									,	BetType				INT
									,	IsLive				BIT
									,	VirtualMultiplier	SMALLMONEY	
									);

	INSERT INTO	@tblVirtualrate (
							SportType
						,	BetType
						,	IsLive
						,	VirtualMultiplier
					)
	SELECT	sporttype,bettype,islive, 1 
	from ProfileVirtualSetting 		
	WHERE sporttype NOT IN (1,43)

	DECLARE	@virtualXML			TABLE (
										seqNo		TINYINT PRIMARY KEY
									,	Pos			VARBINARY(64)
									,	Val			VARBINARY(64)
									);
									
	INSERT INTO @virtualXML
				(	seqNo, Pos, Val                       )
			SELECT	seqNo, p1.Pos, p2.Val
			FROM (
				SELECT	DISTINCT seqNo
				FROM	ProfileVirtualSetting WITH (NOLOCK)
			) pvs
			CROSS APPLY (
				SELECT CONVERT(VARBINARY(64), (
					SELECT	CONVERT(VARCHAR, CAST(ipvs.profileID - 64 * (ipvs.seqNo - 1) AS BINARY(1)), 2)
					FROM		@tblVirtualrate			AS tmp
						INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
							ON	tmp.sporttype	= ipvs.sporttype
								AND	tmp.bettype		= ipvs.bettype
								AND	tmp.isLive		= ipvs.islive
					WHERE	ipvs.seqNo = pvs.seqNo
					FOR XML PATH ('')						
				), 2) AS Pos
			) p1
			CROSS APPLY (
				SELECT CONVERT(VARBINARY(64), (
					SELECT	CONVERT(VARCHAR, CAST(CASE WHEN CAST(VirtualMultiplier * 100 AS INT) > 200 THEN ((CAST(VirtualMultiplier * 100 AS INT) - 200) / 5 + 200) ELSE CAST(VirtualMultiplier * 100 AS INT) END AS BINARY(1)), 2)
					FROM		@tblVirtualrate			AS tmp
						INNER JOIN	ProfileVirtualSetting	AS ipvs WITH (NOLOCK)
							ON	tmp.sporttype	= ipvs.sporttype
								AND	tmp.bettype		= ipvs.bettype
								AND	tmp.isLive		= ipvs.islive
					WHERE	ipvs.seqNo = pvs.seqNo
					FOR XML PATH ('')						
				), 2) AS Val
			) p2;
	
	DECLARE @tmp TABLE (custid INT)

	WHILE(1=1)	
	BEGIN
		UPDATE TOP (1000) c		
		SET c.isFinished = 1
		OUTPUT DELETED.custid INTO @tmp
		FROM #tblCust c
		WHERE isBA = 0 
			AND isFinished = 0
		
		IF @@ROWCOUNT = 0 BREAK;
		
		UPDATE cvs
			SET cvs.bitmapVirtual = bm.bitmap
		FROM		CustVirtualSetting	AS cvs WITH(UPDLOCK, ROWLOCK)			
			INNER JOIN	@virtualXML			AS tmp
					ON	cvs.seqNo = tmp.seqNo
			CROSS APPLY (SELECT TOP 1 bitmap FROM dbo.f_GenerateVirtualSetting_inline(cvs.bitmapVirtual, tmp.Val, tmp.Pos)) AS bm
		WHERE	cvs.custid IN (SELECT custid FROM @tmp)
		
		DELETE @tmp
		
		WAITFOR DELAY '0:0:0.28'
		
	END	
	
	--LOGGING
	DECLARE @LogSPData VARCHAR(MAX) = ''
	
	SELECT @LogSPData =
		(
			SELECT SportType
				,BetType
				,IsLive
				,VirtualMultiplier
			FROM @tblVirtualrate
			ORDER BY sporttype,isLive DESC,bettype
			FOR XML  RAW('s')
		)
	
	SELECT @LogSPData = '<R>' + @LogSPData + '</R>'
	
	SET @endRun = GETDATE()  
	SET @duration  = DATEDIFF (millisecond,@startRun,@endRun) 
	
	DECLARE @custid INT  
	  
	WHILE(1=1)
	BEGIN
		UPDATE TOP (1) t
		SET @custid = custid,
			isLog = 1	
		FROM #tblCust t
		WHERE isLog = 0
			AND isBA = 0
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		EXEC Acc_WriteLog_UserLog_RunSP_Wrapper
			@UserID = 862400,--Starix2
			@CustID = @CustID,
			@ActionID = 810,
			@TrackingValue = @LogSPData,
			@duration = @duration	
	END