/*
	Created: Johnson
	Date: 2018-04-11
	Task: Delete Athena, Spondemo test accounts new sports Betradar settings
	DB: DBCUST/CUSTDB
*/
	CREATE TABLE #tblCust (custid INT PRIMARY KEY,roleid TINYINT)
	
	INSERT INTO @super
	SELECT custid
	FROM dbo.Dep_CustSuper (NOLOCK)
	WHERE site IN ('spondemo','athena000')
		and currency = 20
	
	--1k3 accounts affected
	INSERT INTO #tblCust (custid,roleid)			
	SELECT custid,roleid
	FROM dbo.Customer WITH(NOLOCK)
	WHERE srecommend IN (SELECT custID FROM @super)
	
	DELETE 	Dep_CustBetSetting_Agent WITH(UPDLOCK,ROWLOCK) 
	WHERE CustID IN (SELECT custid from #tblCust) 
		AND SportType IN (192,193)
		
	DELETE 	Dep_CustBetSetting_Member WITH(UPDLOCK,ROWLOCK) 
	WHERE CustID IN (SELECT custid from #tblCust) 
		AND SportType IN (192,193)
	
	--delete profile setting while before initial settings
	DELETE [dbo].[Dep_ProductSettingDetail]	WITH(UPDLOCK,ROWLOCK)
	WHERE ProductSettingID = 13
           AND SportType IN (192,193)
		   
	--check data	
	SELECT TOP (1) * 
	FROM Dep_CustBetSetting_Agent WITH(NOLOCK)
	WHERE SportType IN (192,193)	
	
	
	SELECT TOP (1) * 
	FROM Dep_CustBetSetting_Member WITH(NOLOCK)
	WHERE SportType IN (192,193)