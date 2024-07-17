/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240423@Johnson
	Task: REDUCE the Max Bet/ Max per Match settings 
		If there are any downline settings greater than the upline one [redmine: #204108]
	DB: DBCUST/CUSTDB	
*/ 
ALTER PROCEDURE [dbo].Acc_DynamicCustSetting3rd_18
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
		@NewMaxBet MONEY
		
	CREATE TABLE #Supers (custid INT PRIMARY KEY)
	CREATE TABLE #tblCustSport (custid INT, UplineID INT, Sporttype INT, Bettype INT PRIMARY KEY (custid,sporttype,bettype))
	DECLARE @tmpCust TABLE (custid INT, UplineID INT, Sporttype INT, Bettype INT PRIMARY KEY (custid,sporttype,bettype))
	
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
	--check roleid = 3	
	INSERT INTO #tblCustSport(custid,uplineID,Sporttype,Bettype)
	SELECT ci.custid,srecommend,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting3rd_Agent cs (NOLOCK) ON cs.custid = ci.custid
		INNER JOIN CustBetSetting3rd_Agent scs (NOLOCK) ON scs.custid = ci.srecommend AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.roleid = 3
		AND ci.Enabled = 1
		AND cs.SportType IN (175,169,220,222,202,9908)
		AND ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
			OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
			)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxbet = CASE WHEN scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet THEN scs.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch THEN scs.MaxPerMatch ELSE cs.MaxPerMatch END,
			cs.MaxBet = @NewMaxbet,
			cs.MinBet = CASE WHEN cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END		
		FROM CustBetSetting3rd_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			INNER JOIN CustBetSetting3rd_Agent scs (NOLOCK) ON scs.custid = t.uplineID AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
		WHERE ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
				OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
				)
		
		DELETE @tmpCust		
	END
	
	--check roleid = 2
	INSERT INTO #tblCustSport(custid,uplineID,Sporttype,Bettype)
	SELECT ci.custid,ci.mrecommend,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting3rd_Agent cs (NOLOCK) ON cs.custid = ci.custid
		INNER JOIN CustBetSetting3rd_Agent mcs (NOLOCK) ON mcs.custid = ci.mrecommend AND cs.SportType = mcs.SportType AND cs.BetType = mcs.BetType
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.roleid = 2
		AND ci.Enabled = 1
		AND cs.SportType IN (175,169,220,222,202,9908)
		AND ((mcs.MaxBet > 0 AND cs.MaxBet > mcs.MaxBet)
			OR (mcs.MaxPerMatch > 0 AND cs.MaxPerMatch > mcs.MaxPerMatch)
			)		
			
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxbet = CASE WHEN scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet THEN scs.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch THEN scs.MaxPerMatch ELSE cs.MaxPerMatch END,
			cs.MaxBet = @NewMaxbet,
			cs.MinBet = CASE WHEN cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END	
		FROM CustBetSetting3rd_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			INNER JOIN CustBetSetting3rd_Agent scs (NOLOCK) ON scs.custid = t.uplineID AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
		WHERE ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
				OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
				)

		DELETE @tmpCust			
	END		
			
	--check roleid = 1		
	INSERT INTO #tblCustSport(custid,uplineID,Sporttype,Bettype)
	SELECT ci.custid,ci.recommend,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting3rd_Member cs (NOLOCK) ON cs.custid = ci.custid
		INNER JOIN CustBetSetting3rd_Agent acs (NOLOCK) ON acs.custid = ci.recommend AND cs.SportType = acs.SportType AND cs.BetType = acs.BetType
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.roleid = 1
		AND ci.Enabled = 1
		AND cs.SportType IN (175,169,220,222,202,9908)
		AND ((acs.MaxBet > 0 AND cs.MaxBet > acs.MaxBet)
			OR (acs.MaxPerMatch > 0 AND cs.MaxPerMatch > acs.MaxPerMatch)
			)

	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxbet = CASE WHEN scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet THEN scs.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch THEN scs.MaxPerMatch ELSE cs.MaxPerMatch END,
			cs.MaxBet = @NewMaxbet,
			cs.MinBet = CASE WHEN cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END	
		FROM CustBetSetting3rd_Member cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			INNER JOIN CustBetSetting3rd_Agent scs (NOLOCK) ON scs.custid = t.uplineID AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
		WHERE ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
				OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
				)

		DELETE @tmpCust			
	END		

	---------------------------------------------------------------------
	--update CustBetSetting_Agent
	--check roleid = 3	
	INSERT INTO #tblCustSport(custid,uplineID,Sporttype,Bettype)
	SELECT ci.custid,srecommend,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting_Agent cs (NOLOCK) ON cs.custid = ci.custid
		INNER JOIN CustBetSetting_Agent scs (NOLOCK) ON scs.custid = ci.srecommend AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.roleid = 3
		AND ci.Enabled = 1		
		AND ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
			OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch)
			OR (cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber)
			)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxbet = CASE WHEN scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet THEN scs.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch THEN scs.MaxPerMatch ELSE cs.MaxPerMatch END,
			cs.MaxBet = @NewMaxbet,
			cs.MinBet = CASE WHEN cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END,
			cs.MaxPayoutPerMatch = CASE WHEN cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch THEN scs.MaxPayoutPerMatch ELSE cs.MaxPayoutPerMatch END,
			cs.MaxPerNumber = CASE WHEN cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber THEN scs.MaxPerNumber ELSE cs.MaxPerNumber END
		FROM CustBetSetting_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			INNER JOIN CustBetSetting_Agent scs (NOLOCK) ON scs.custid = t.uplineID AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
		WHERE ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
				OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
				OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch)
				OR (cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber)
				)
		
		DELETE @tmpCust		
	END
	
	--check roleid = 2	
	INSERT INTO #tblCustSport(custid,uplineID,Sporttype,Bettype)
	SELECT ci.custid,mrecommend,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting_Agent cs (NOLOCK) ON cs.custid = ci.custid
		INNER JOIN CustBetSetting_Agent scs (NOLOCK) ON scs.custid = ci.mrecommend AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.roleid = 2
		AND ci.Enabled = 1		
		AND ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
			OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch)
			OR (cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber)
			)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxbet = CASE WHEN scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet THEN scs.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch THEN scs.MaxPerMatch ELSE cs.MaxPerMatch END,
			cs.MaxBet = @NewMaxbet,
			cs.MinBet = CASE WHEN cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END,
			cs.MaxPayoutPerMatch = CASE WHEN cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch THEN scs.MaxPayoutPerMatch ELSE cs.MaxPayoutPerMatch END,
			cs.MaxPerNumber = CASE WHEN cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber THEN scs.MaxPerNumber ELSE cs.MaxPerNumber END
		FROM CustBetSetting_Agent cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			INNER JOIN CustBetSetting_Agent scs (NOLOCK) ON scs.custid = t.uplineID AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
		WHERE ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
				OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
				OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch)
				OR (cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber)
				)
		
		DELETE @tmpCust		
	END
	
	--check roleid = 1	
	INSERT INTO #tblCustSport(custid,uplineID,Sporttype,Bettype)
	SELECT ci.custid,recommend,cs.Sporttype,cs.Bettype
	FROM custinfo ci WITH(NOLOCK)
		INNER JOIN CustBetSetting_Member cs (NOLOCK) ON cs.custid = ci.custid
		INNER JOIN CustBetSetting_Agent scs (NOLOCK) ON scs.custid = ci.recommend AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)	
		AND ci.roleid = 1
		AND ci.Enabled = 1		
		AND ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
			OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
			OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch)
			OR (cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber)
			)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(@batchNum) t
		OUTPUT DELETED.custid, DELETED.uplineID, DELETED.sporttype, DELETED.bettype
		INTO @tmpCust(custid,uplineID,sporttype,bettype)
		FROM #tblCustSport t
		
		IF @@ROWCOUNT = 0
			BREAK;
	
		UPDATE cs
		SET @NewMaxbet = CASE WHEN scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet THEN scs.MaxBet ELSE cs.MaxBet END,
			cs.MaxPerMatch = CASE WHEN scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch THEN scs.MaxPerMatch ELSE cs.MaxPerMatch END,
			cs.MaxBet = @NewMaxbet,
			cs.MinBet = CASE WHEN cs.MinBet > @NewMaxBet THEN @NewMaxBet ELSE cs.MinBet END,
			cs.MaxPayoutPerMatch = CASE WHEN cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch THEN scs.MaxPayoutPerMatch ELSE cs.MaxPayoutPerMatch END,
			cs.MaxPerNumber = CASE WHEN cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber THEN scs.MaxPerNumber ELSE cs.MaxPerNumber END
		FROM CustBetSetting_Member cs WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON cs.custid = t.custid AND cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			INNER JOIN CustBetSetting_Agent scs (NOLOCK) ON scs.custid = t.uplineID AND cs.SportType = scs.SportType AND cs.BetType = scs.BetType
		WHERE ((scs.MaxBet > 0 AND cs.MaxBet > scs.MaxBet)
				OR (scs.MaxPerMatch > 0 AND cs.MaxPerMatch > scs.MaxPerMatch)
				OR (cs.Sporttype IN (1,2,3,5,8,10,11,99,9901,9902) AND scs.MaxPayoutPerMatch > 0 AND cs.MaxPayoutPerMatch > scs.MaxPayoutPerMatch)
				OR (cs.Sporttype IN (161) AND scs.MaxPerNumber > 0 AND cs.MaxPerNumber > scs.MaxPerNumber)
				)
		
		DELETE @tmpCust		
	END
	
	DROP TABLE #supers
	DROP TABLE #tblCustSport
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

EXEC Acc_DynamicCustSetting3rd_18 @Target = @Target
GO

--End step 2