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
		@NewMaxBet MONEY = 0,
		@NewMaxbet_tmp MONEY = 0,
		@NewMinBet MONEY = 0,
		@NewMaxPerMatch MONEY = 0,
		@NewMaxPerNumber MONEY = 0,
		@NewMaxPayoutPerMatch MONEY = 0
		
	CREATE TABLE #Supers (custid INT PRIMARY KEY)
	CREATE TABLE #tblCustSport (custid INT, Sporttype INT, Bettype INT PRIMARY KEY (custid,sporttype,bettype))
	DECLARE @tmpCust TABLE (custid INT, Sporttype INT, Bettype INT PRIMARY KEY (custid,sporttype,bettype))
	
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
	INSERT INTO #tblCustSport(custid,Sporttype,Bettype)
	SELECT cs.custid,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting3rd_Agent cs (NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)		
		AND ci.Enabled = 1
		AND cs.SportType IN (175,169,220,222,202,9908)
		AND ((cs.MinBet	<> 0 OR cs.MaxBet <> 0)
			AND cs.MinBet > cs.MaxBet
			)
		OR ((cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0)
			AND cs.MaxBet > cs.MaxPerMatch
			)
	
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxbet = CASE WHEN (cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0) AND cs.MaxBet > cs.MaxPerMatch THEN cs.MaxPerMatch ELSE cs.MaxBet END,
			cs.MaxBet = @NewMaxbet,
			cs.MinBet = CASE WHEN cs.MinBet	<> 0 AND @NewMaxbet <> 0 AND cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END		
		FROM CustBetSetting3rd_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype			
		WHERE ((cs.MinBet	<> 0 OR cs.MaxBet <> 0)
				AND cs.MinBet > cs.MaxBet
				)
			OR ((cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0)
				AND cs.MaxBet > cs.MaxPerMatch
				)
		
		DELETE @tmpCust		
	END
	
	--update CustBetSetting3rd_Member
	INSERT INTO #tblCustSport(custid,Sporttype,Bettype)
	SELECT cs.custid,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting3rd_Member cs (NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)		
		AND ci.Enabled = 1
		AND cs.SportType IN (175,169,220,222,202,9908)
		AND ((cs.MinBet	<> 0 OR cs.MaxBet <> 0)
			AND cs.MinBet > cs.MaxBet
			)
		OR ((cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0)
			AND cs.MaxBet > cs.MaxPerMatch
			)
		
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxbet = CASE WHEN (cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0) AND cs.MaxBet > cs.MaxPerMatch THEN cs.MaxPerMatch ELSE cs.MaxBet END,
			cs.MaxBet = @NewMaxbet,
			cs.MinBet = CASE WHEN cs.MinBet	<> 0 AND @NewMaxbet <> 0 AND cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END		
		FROM CustBetSetting3rd_Member cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype			
		WHERE ((cs.MinBet	<> 0 OR cs.MaxBet <> 0)
				AND cs.MinBet > cs.MaxBet
				)
			OR ((cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0)
				AND cs.MaxBet > cs.MaxPerMatch
				)
		
		DELETE @tmpCust		
	END
	
	---------------------------------------------------------------------
	--update CustBetSetting_Agent
	INSERT INTO #tblCustSport(custid,Sporttype,Bettype)
	SELECT ci.custid,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting_Agent cs (NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.Enabled = 1		
		AND (((cs.MinBet <> 0 OR cs.MaxBet <> 0)
				AND cs.MinBet > cs.MaxBet
				)
			OR ((cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0)
				AND cs.MaxBet > cs.MaxPerMatch
				)
			OR (cs.Sporttype IN (161) AND cs.MaxPerNumber <> 0
				AND (cs.MaxBet > cs.MaxPerNumber 
					OR cs.MaxPerNumber > cs.MaxPerMatch 
					)
				)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) 
				AND (cs.MaxPerMatch <> 0 OR cs.MaxPayoutPerMatch <> 0) 
				AND cs.MaxPerMatch > cs.MaxPayoutPerMatch			
				)	
			)	
				
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxPerMatch = CASE WHEN cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) 
										AND (cs.MaxPerMatch <> 0 OR cs.MaxPayoutPerMatch <> 0) 
										AND cs.MaxPerMatch > cs.MaxPayoutPerMatch	
									THEN cs.MaxPayoutPerMatch ELSE cs.MaxPerMatch END,	
			@NewMaxPerNumber = CASE WHEN cs.Sporttype IN (161) AND cs.MaxPerNumber <> 0
										AND cs.MaxPerNumber > @NewMaxPerMatch 
									THEN @NewMaxPerMatch ELSE cs.MaxPerNumber END,		
			@NewMaxbet_tmp = CASE WHEN cs.Sporttype IN (161) AND @NewMaxPerNumber <> 0
									AND cs.MaxBet > @NewMaxPerNumber THEN @NewMaxPerNumber ELSE cs.MaxBet END,
			@NewMaxbet = CASE WHEN (@NewMaxbet_tmp <> 0 OR @NewMaxPerMatch <> 0)
									AND @NewMaxbet_tmp > @NewMaxPerMatch
									THEN @NewMaxPerMatch ELSE @NewMaxbet_tmp END,
			cs.MinBet = CASE WHEN cs.MinBet	<> 0 AND @NewMaxbet <> 0 AND cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END,						
			cs.MaxBet = CASE WHEN cs.MaxBet <> @NewMaxbet THEN @NewMaxbet ELSE cs.MaxBet END,
			cs.MaxPerNumber = CASE WHEN cs.Sporttype IN (161) AND cs.MaxPerNumber <> @NewMaxPerNumber THEN @NewMaxPerNumber ELSE cs.MaxPerNumber END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch <> @NewMaxPerMatch THEN @NewMaxPerMatch ELSE cs.MaxPerMatch END
		FROM CustBetSetting_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype			
		WHERE (((cs.MinBet <> 0 OR cs.MaxBet <> 0)
				AND cs.MinBet > cs.MaxBet
				)
			OR ((cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0)
				AND cs.MaxBet > cs.MaxPerMatch
				)
			OR (cs.Sporttype IN (161) AND cs.MaxPerNumber <> 0
				AND (cs.MaxBet > cs.MaxPerNumber 
					OR cs.MaxPerNumber > cs.MaxPerMatch 
					)
				)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) 
				AND (cs.MaxPerMatch <> 0 OR cs.MaxPayoutPerMatch <> 0) 
				AND cs.MaxPerMatch > cs.MaxPayoutPerMatch			
				)	
			)
		
		DELETE @tmpCust		
	END
	
	--update CustBetSetting_Member
	INSERT INTO #tblCustSport(custid,Sporttype,Bettype)
	SELECT ci.custid,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting_Member cs (NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.Enabled = 1		
		AND (((cs.MinBet <> 0 OR cs.MaxBet <> 0)
				AND cs.MinBet > cs.MaxBet
				)
			OR ((cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0)
				AND cs.MaxBet > cs.MaxPerMatch
				)
			OR (cs.Sporttype IN (161) AND cs.MaxPerNumber <> 0
				AND (cs.MaxBet > cs.MaxPerNumber 
					OR cs.MaxPerNumber > cs.MaxPerMatch 
					)
				)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) 
				AND (cs.MaxPerMatch <> 0 OR cs.MaxPayoutPerMatch <> 0) 
				AND cs.MaxPerMatch > cs.MaxPayoutPerMatch			
				)	
			)	
				
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxPerMatch = CASE WHEN cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) 
										AND (cs.MaxPerMatch <> 0 OR cs.MaxPayoutPerMatch <> 0) 
										AND cs.MaxPerMatch > cs.MaxPayoutPerMatch	
									THEN cs.MaxPayoutPerMatch ELSE cs.MaxPerMatch END,	
			@NewMaxPerNumber = CASE WHEN cs.Sporttype IN (161) AND cs.MaxPerNumber <> 0
										AND cs.MaxPerNumber > @NewMaxPerMatch 
									THEN @NewMaxPerMatch ELSE cs.MaxPerNumber END,		
			@NewMaxbet_tmp = CASE WHEN cs.Sporttype IN (161) AND @NewMaxPerNumber <> 0
									AND cs.MaxBet > @NewMaxPerNumber THEN @NewMaxPerNumber ELSE cs.MaxBet END,
			@NewMaxbet = CASE WHEN (@NewMaxbet_tmp <> 0 OR @NewMaxPerMatch <> 0)
									AND @NewMaxbet_tmp > @NewMaxPerMatch
									THEN @NewMaxPerMatch ELSE @NewMaxbet_tmp END,
			cs.MinBet = CASE WHEN cs.MinBet	<> 0 AND @NewMaxbet <> 0 AND cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END,						
			cs.MaxBet = CASE WHEN cs.MaxBet <> @NewMaxbet THEN @NewMaxbet ELSE cs.MaxBet END,
			cs.MaxPerNumber = CASE WHEN cs.Sporttype IN (161) AND cs.MaxPerNumber <> @NewMaxPerNumber THEN @NewMaxPerNumber ELSE cs.MaxPerNumber END,
			cs.MaxPerMatch = CASE WHEN cs.MaxPerMatch <> @NewMaxPerMatch THEN @NewMaxPerMatch ELSE cs.MaxPerMatch END
		FROM CustBetSetting_Member cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype			
		WHERE (((cs.MinBet <> 0 OR cs.MaxBet <> 0)
				AND cs.MinBet > cs.MaxBet
				)
			OR ((cs.MaxBet <> 0 OR cs.MaxPerMatch <> 0)
				AND cs.MaxBet > cs.MaxPerMatch
				)
			OR (cs.Sporttype IN (161) AND cs.MaxPerNumber <> 0
				AND (cs.MaxBet > cs.MaxPerNumber 
					OR cs.MaxPerNumber > cs.MaxPerMatch 
					)
				)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) 
				AND (cs.MaxPerMatch <> 0 OR cs.MaxPayoutPerMatch <> 0) 
				AND cs.MaxPerMatch > cs.MaxPayoutPerMatch			
				)	
			)
		
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
		