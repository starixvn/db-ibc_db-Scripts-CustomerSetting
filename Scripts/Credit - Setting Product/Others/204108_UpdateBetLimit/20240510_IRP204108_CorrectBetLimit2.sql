/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240510@Johnson
	Task:Adjust betlimit if break rule MinBet<=Maxbet<=MPM<=MaxPayoutPerMatch [redmine: #204108]
	DB: DBCUST/CUSTDB	
*/ 
ALTER PROCEDURE [dbo].Acc_DynamicCustSetting3rd_19
	 @Target VARCHAR(50) 
AS
BEGIN
	SET NOCOUNT ON
	
	IF NOT (dbo.f_CheckRepTable('Custinfo') = 1 
		AND dbo.f_CheckRepTable('Customer') = 1 
		AND dbo.f_CheckRepTable('Dep_CustSuper') = 1 
		AND dbo.f_CheckRepTable('custSuper') = 1 
		AND dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 1
		AND dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 1
		AND dbo.f_CheckRepTable('CustBetSetting_Member') = 1
		AND dbo.f_CheckRepTable('CustBetSetting_Agent') = 1
	   )
		RETURN
	
	DECLARE @BatchNum INT = 5000,
			@MinBet MONEY = 0
		
	CREATE TABLE #Supers (custid INT PRIMARY KEY)
	CREATE TABLE #tblCustSport (custid INT, roleid TINYINT, UplineID INT, Sporttype INT, Bettype INT, isUpdated BIT DEFAULT(0) PRIMARY KEY (custid,sporttype,bettype))
	DECLARE @tmpCust TABLE (custid INT, roleid TINYINT, UplineID INT, Sporttype INT, Bettype INT PRIMARY KEY (custid,sporttype,bettype))
	
	INSERT INTO #Supers(custid)
	SELECT ci.custid
	FROM		dbo.custInfo AS ci WITH (NOLOCK)
	INNER JOIN	dbo.Customer AS c WITH (NOLOCK)
			ON	ci.custid = c.custid
	INNER JOIN	dbo.custSuper AS s WITH (NOLOCK)
			ON	ci.custid = s.custid
	WHERE	ci.RoleID = 4  
		AND	NOT EXISTS (SELECT custid FROM dbo.Dep_CustSuper AS dcs WITH (NOLOCK) WHERE ci.custid = dcs.CustId)
		AND	ci.Enabled = 1
		AND	s.IsInternal = 0
		AND	NOT (	ci.username LIKE '%Acc%'
			OR	ci.username LIKE '%3rdSuper%'
			OR	ci.username LIKE 'STEST%'
			OR	(	ci.username LIKE 'SM%'
				AND	ci.custid < 100
				)
			)
			
	---------------------------------------------------------------------
	--update CustBetSetting3rd_Agent
	INSERT INTO #tblCustSport(custid,roleid,uplineID,Sporttype,Bettype)
	SELECT cs.custid, roleid,
		CASE WHEN roleid = 2 THEN mrecommend
			WHEN roleid = 3 THEN srecommend END,
		cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting3rd_Agent cs (NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND roleid IN (2,3)
		AND ci.Enabled = 1
		AND cs.SportType IN (175,169,220,222,202,9908)
		AND (cs.MinBet > cs.MaxBet			
			OR cs.MaxBet > cs.MaxPerMatch
			)		
	
	WHILE(1=1)
	BEGIN
		UPDATE TOP(@batchNum) t
		SET isUpdated = 1
		OUTPUT DELETED.custid, DELETED.roleid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,roleid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		WHERE roleid = 3
			AND isUpdated = 0
				
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @MinBet = ucs.MinBet,
			cs.MinBet = @MinBet,
			cs.MaxBet = @MinBet,
			cs.MaxPerMatch = @MinBet
		FROM CustBetSetting3rd_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype			
			INNER JOIN CustBetSetting3rd_Agent ucs WITH(NOLOCK) ON ucs.custid = t.UplineID AND t.sporttype = ucs.sporttype AND t.bettype = ucs.bettype
				
		DELETE @tmpCust		
	END
	
	--get agent downlines of master
	INSERT INTO #tblCustSport(custid,roleid,uplineID,Sporttype,Bettype)
	SELECT ci.custid, ci.roleid, ci.mrecommend, t.Sporttype,t.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN #tblCustSport t ON ci.mrecommend = t.custid
	WHERE ci.roleid IN (2)
		AND t.roleid = 3
		AND ci.Enabled = 1
		AND NOT EXISTS (SELECT 1 FROM #tblCustSport t2 
						WHERE t2.custid = ci.custid
							AND t2.sporttype = t.sporttype
							AND t2.bettype = t.bettype
						)
					
	WHILE(1=1)
	BEGIN
		UPDATE TOP(@batchNum) t
		SET isUpdated = 1
		OUTPUT DELETED.custid, DELETED.roleid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,roleid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		WHERE roleid = 2
			AND isUpdated = 0
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET cs.MinBet = 0,
			cs.MaxBet = 0.1,
			cs.MaxPerMatch = 0.1
		FROM CustBetSetting3rd_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype						
				
		DELETE @tmpCust		
	END
	
	--get member downlines of master/agent
	INSERT INTO #tblCustSport(custid,roleid,uplineID,Sporttype,Bettype)
	SELECT ci.custid, ci.roleid, ci.recommend, t.Sporttype,t.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN #tblCustSport t ON ci.mrecommend = t.custid
	WHERE ci.roleid = 1
		AND t.roleid = 3
		AND ci.Enabled = 1
	UNION 
	SELECT ci.custid, ci.roleid, ci.recommend, t.Sporttype,t.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN #tblCustSport t ON ci.recommend = t.custid
	WHERE ci.roleid = 1
		AND t.roleid = 2
		AND ci.Enabled = 1
				
	--get members break rule
	INSERT INTO #tblCustSport(custid,roleid,uplineID,Sporttype,Bettype)
	SELECT ci.custid,ci.roleid,ci.recommend,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting3rd_Member cs (NOLOCK) ON cs.custid = ci.custid
		LEFT JOIN #tblCustSport t ON ci.custid = t.custid
									AND cs.sporttype = t.sporttype
									AND cs.bettype = t.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)		
		AND ci.Enabled = 1
		AND t.custid IS NULL
		AND ci.roleid = 1
		AND cs.SportType IN (175,169,220,222,202,9908)
		AND (cs.MinBet > cs.MaxBet			
			OR cs.MaxBet > cs.MaxPerMatch
			)	
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,sporttype,bettype)
		FROM #tblCustSport t
		WHERE roleid = 1
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET cs.MinBet = 0,
			cs.MaxBet = 0.1,
			cs.MaxPerMatch = 0.1
		FROM CustBetSetting3rd_Member cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype			
				
		DELETE @tmpCust		
	END
	
	DELETE #tblCustSport
	
	---------------------------------------------------------------------
	--update CustBetSetting_Agent
	INSERT INTO #tblCustSport(custid,roleid,uplineID,Sporttype,Bettype)
	SELECT cs.custid, roleid,
		CASE WHEN roleid = 2 THEN mrecommend
			WHEN roleid = 3 THEN srecommend END,
		cs.sporttype, cs.bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting_Agent cs (NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.Enabled = 1	
		AND roleid IN (2,3)
		AND (cs.MinBet > cs.MaxBet				
			OR cs.MaxBet > cs.MaxPerMatch				
			OR (cs.Sporttype IN (161) 
				AND (cs.MaxBet > cs.MaxPerNumber 
					OR cs.MaxPerNumber > cs.MaxPerMatch 
					)
				)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) 				
				AND cs.MaxPerMatch > cs.MaxPayoutPerMatch			
				)	
			)	
				
	WHILE(1=1)
	BEGIN
		UPDATE TOP(@batchNum) t
		SET isUpdated = 1
		OUTPUT DELETED.custid, DELETED.roleid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,roleid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		WHERE roleid = 3
			AND isUpdated = 0
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @MinBet = ucs.MinBet,
			cs.MinBet = @MinBet,
			cs.MaxBet = @MinBet,
			cs.MaxPerNumber = CASE WHEN cs.Sporttype IN (161) THEN @MinBet ELSE cs.MaxPerNumber END,
			cs.MaxPerMatch = @MinBet,
			cs.MaxPayoutPerMatch = CASE WHEN cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) THEN @MinBet ELSE cs.MaxPayoutPerMatch END
		FROM CustBetSetting_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype			
			INNER JOIN CustBetSetting_Agent ucs WITH(NOLOCK) ON ucs.custid = t.UplineID AND t.sporttype = ucs.sporttype AND t.bettype = ucs.bettype
				
		DELETE @tmpCust		
	END
	
	--get agent downlines of master
	INSERT INTO #tblCustSport(custid,roleid,uplineID,Sporttype,Bettype)
	SELECT ci.custid, ci.roleid, ci.mrecommend, t.Sporttype,t.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN #tblCustSport t ON ci.mrecommend = t.custid
	WHERE ci.roleid = 2
		AND t.roleid = 3
		AND ci.Enabled = 1
		AND NOT EXISTS (SELECT 1 FROM #tblCustSport t2 
						WHERE t2.custid = ci.custid
							AND t2.sporttype = t.sporttype
							AND t2.bettype = t.bettype
						)					
					
	WHILE(1=1)
	BEGIN
		UPDATE TOP(@batchNum) t
		SET isUpdated = 1
		OUTPUT DELETED.custid, DELETED.roleid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,roleid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		WHERE roleid = 2
			AND isUpdated = 0
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET cs.MinBet = 0,
			cs.MaxBet = 0.1,
			cs.MaxPerNumber = CASE WHEN cs.Sporttype IN (161) THEN 0.1 ELSE cs.MaxPerNumber END,
			cs.MaxPerMatch = 0.1,
			cs.MaxPayoutPerMatch = CASE WHEN cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) THEN 0.1 ELSE cs.MaxPayoutPerMatch END
		FROM CustBetSetting_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype						
				
		DELETE @tmpCust		
	END
	
	--get member downlines of master/agent
	INSERT INTO #tblCustSport(custid,roleid,uplineID,Sporttype,Bettype)
	SELECT ci.custid, ci.roleid, ci.recommend, t.Sporttype,t.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN #tblCustSport t ON ci.mrecommend = t.custid
	WHERE ci.roleid = 1
		AND t.roleid = 3
		AND ci.Enabled = 1
	UNION 
	SELECT ci.custid, ci.roleid, ci.recommend, t.Sporttype,t.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN #tblCustSport t ON ci.recommend = t.custid
	WHERE ci.roleid = 1
		AND t.roleid = 2
		AND ci.Enabled = 1
		
	--update CustBetSetting_Member
	INSERT INTO #tblCustSport(custid,roleid,Sporttype,Bettype)
	SELECT ci.custid,ci.roleid,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting_Member cs (NOLOCK) ON cs.custid = ci.custid
		LEFT JOIN #tblCustSport t ON ci.custid = t.custid
									AND cs.sporttype = t.sporttype
									AND cs.bettype = t.bettype
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.Enabled = 1		
		AND ci.roleid = 1
		AND t.custid IS NULL
		AND (cs.MinBet > cs.MaxBet				
			OR cs.MaxBet > cs.MaxPerMatch				
			OR (cs.Sporttype IN (161) 
				AND (cs.MaxBet > cs.MaxPerNumber 
					OR cs.MaxPerNumber > cs.MaxPerMatch 
					)
				)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) 				
				AND cs.MaxPerMatch > cs.MaxPayoutPerMatch			
				)	
			)	
				
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,sporttype,bettype)
		FROM #tblCustSport t
		WHERE roleid = 1
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET cs.MinBet = 0,
			cs.MaxBet = 0.1,
			cs.MaxPerNumber = CASE WHEN cs.Sporttype IN (161) THEN 0.1 ELSE cs.MaxPerNumber END,
			cs.MaxPerMatch = 0.1,
			cs.MaxPayoutPerMatch = CASE WHEN cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902)  THEN 0.1 ELSE cs.MaxPayoutPerMatch END
		FROM CustBetSetting_Member cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype			
				
		DELETE @tmpCust		
	END
	
	DROP TABLE #tblCustSport
	DROP TABLE #Supers
END

GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------
------------------------------------------------------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at DBCUST & replicated DB -----

DECLARE @Target VARCHAR(30)
	
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DBSPARE')
	SELECT @Target = 'DBCUST'
ELSE 
	SELECT @Target = 'REPLICATED'	

EXEC Acc_DynamicCustSetting3rd_19 @Target = @Target
GO

--End step 2		
		