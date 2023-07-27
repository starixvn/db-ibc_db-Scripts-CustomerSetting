/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231016@Johnson
	Task: delete redundant Saba Games settings for newly customers
	DB: DBCust/CustDB
*/

	DECLARE @maxcustid INT = xxx
		
	CREATE TABLE #tblSuper(CustID INT, isfinished BIT DEFAULT(0))

	INSERT INTO #tblSuper(custid)
	SELECT DISTINCT ci.custid
	FROM vw_customer ci WITH (NOLOCK) 
	    INNER JOIN custinfo cu with (nolock) on cu.custid=ci.custid
	    INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site 
	    INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4     
	    AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	    AND s.islicensee = 0    
	    AND cs.IsInternal=0       
	    AND ci.username not like '3rdSuper%'   
	    AND s.siteLabel <> '789y' 
	    AND cu.Enabled = 1 
 
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
	DECLARE @tmpCust TABLE(custid INT PRIMARY KEY)
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT ci.custid, roleid
	FROM custinfo ci WITH(NOLOCK) 
		LEFT JOIN CustPTSetting3rd_Agent pt WITH(NOLOCK) ON ci.custid = pt.custid AND pt.SportType = 200  
		LEFT JOIN CustWinLossLimit_Agent wl WITH(NOLOCK) ON ci.custid = wl.custid AND wl.SportType = 200
		LEFT JOIN CustStakeLevel_Agent sl WITH(NOLOCK) ON ci.custid = sl.custid AND sl.SportType = 200
	WHERE srecommend IN (SELECT custid FROM #tblSuper)
		AND enabled = 1
		AND ci.custid > @maxcustid
		AND (pt.custid IS NOT NULL OR wl.custid IS NOT NULL OR sl.custid IS NOT NULL)
		
	DELETE CustPTGroupSetting3rd_Member WITH(ROWLOCK)
	WHERE SportType = 200
		AND AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
		
	WHILE(1=1)
	BEGIN
		DELETE TOP (1000) t
		OUTPUT DELETED.custid into @tmpCust(custid)
		FROM #tblCust t
		WHERE roleid > 1
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		DELETE CustPTSetting3rd_Agent WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200
		
		DELETE CustWinLossLimit_Agent WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200
			
		DELETE CustStakeLevel_Agent WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200

		DELETE @tmpCust	
	END
	
	INSERT INTO #tblCust(custid,roleid)
	SELECT ci.custid, roleid
	FROM custinfo ci WITH(NOLOCK) 
		LEFT JOIN CustPTSetting3rd_Member pt WITH(NOLOCK) ON ci.custid = pt.custid AND pt.SportType = 200  
		LEFT JOIN CustWinLossLimit_Member wl WITH(NOLOCK) ON ci.custid = wl.custid AND wl.SportType = 200
		LEFT JOIN CustStakeLevel_Member sl WITH(NOLOCK) ON ci.custid = sl.custid AND sl.SportType = 200
	WHERE srecommend IN (SELECT custid FROM #tblSuper)
		AND enabled = 1
		AND ci.custid > @maxcustid
		AND (pt.custid IS NOT NULL OR wl.custid IS NOT NULL OR sl.custid IS NOT NULL)


	WHILE(1=1)
	BEGIN
		DELETE TOP (1000) t
		OUTPUT DELETED.custid into @tmpCust(custid)
		FROM #tblCust t
		WHERE roleid = 1
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		DELETE CustPTSetting3rd_Member WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200
		
		DELETE CustWinLossLimit_Member WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200
			
		DELETE CustStakeLevel_Member WITH(ROWLOCK)
		WHERE CustID IN (SELECT custid FROM @tmpCust)
			AND SportType = 200

		DELETE @tmpCust	
	END