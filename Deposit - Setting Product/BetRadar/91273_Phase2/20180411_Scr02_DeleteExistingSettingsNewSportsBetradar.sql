/*
	Created: Johnson
	Date: 2018-04-11
	Task: Delete existing settings for new sports Betradar for real licensees if any
	DB: DBCUST/CUSTDB
*/
	--delete profile setting while before initial settings
	DELETE [dbo].[Dep_ProductSettingDetail]	WITH(UPDLOCK,ROWLOCK)
	WHERE ProductSettingID = 13
           AND SportType IN (192,193)
	GO
	
	--delete existings setting for real licensees if any
	CREATE TABLE #tblCust (custid INT PRIMARY KEY)
	CREATE TABLE #supers (custid INT PRIMARY KEY)
	
	INSERT INTO #supers
	SELECT custid
	FROM dbo.Dep_CustSuper (NOLOCK)
	WHERE currency <> 20
	
	INSERT INTO #tblCust (custid)
	SELECT DISTINCT ci.custid
	FROM dbo.Dep_CustBetSetting_Agent cs WITH(NOLOCK)
		INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND roleid IN (2,3,4)
		AND cs.sporttype IN (192,193)
		
	DELETE 	dbo.Dep_CustBetSetting_Agent WITH(UPDLOCK,ROWLOCK) 
	WHERE CustID IN (SELECT custid from #tblCust) 
		AND SportType IN (192,193)
	
	--delete temp dummy SMA
	DELETE #tblCust
	
	INSERT INTO #tblCust (custid)
	SELECT DISTINCT ci.custid
	FROM dbo.Dep_CustBetSetting_Member cs WITH(NOLOCK)
		INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND roleid = 1
		AND cs.sporttype IN (192,193)
		
	DELETE 	Dep_CustBetSetting_Member WITH(UPDLOCK,ROWLOCK) 
	WHERE CustID IN (SELECT custid from #tblCust) 
		AND SportType IN (192,193)
	GO
	
	--check data	
	SELECT COUNT(1)
	FROM dbo.Dep_CustBetSetting_Agent cs WITH(NOLOCK)
		INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND roleid IN (2,3,4)
		AND cs.sporttype IN (192,193)	
	
	
	SELECT COUNT(1)
	FROM dbo.Dep_CustBetSetting_Member cs WITH(NOLOCK)
		INNER JOIN dbo.CustInfo ci WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE srecommend IN (SELECT custid FROM #supers)
		AND roleid = 1
		AND cs.sporttype IN (192,193)