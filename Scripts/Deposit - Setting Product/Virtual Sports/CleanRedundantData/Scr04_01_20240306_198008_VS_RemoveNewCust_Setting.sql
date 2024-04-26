/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: Tacy@20240306
	Task: Deposit - Clean VS1, VS2, VS3 - New Customers Setting - [redmine: #198008]
	DB: DBCUST/CUSTDB
*/
----------------------------------------------------------------------------------------------
PRINT N'New Customers -Setting: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
CREATE TABLE #supers (custid INT PRIMARY KEY)
CREATE TABLE #Member (CustID INT PRIMARY KEY)
CREATE TABLE #SMA (CustID INT PRIMARY KEY, roleid TINYINT)
CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT)

DECLARE @max_custid INT

SELECT @max_custid = xxx

-----------------------------------------------------------------------------------------------
INSERT INTO #Dep_ProductSettingDetail(ProductSettingID,SettingType, SportType, BetType)
SELECT psd.ProductSettingID, SettingType, SportType, BetType
FROM Dep_ProductSettingDetail psd WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE ps.ProductID IN (5,27,77,49) 
	AND ps.ProductSettingID NOT BETWEEN 182 AND 185 --New VS setting

INSERT INTO #supers(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN #Dep_ProductSettingDetail p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 --offered product
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)

INSERT INTO #Member (CustID)
SELECT c.custid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE roleid = 1 AND c.custid > @max_custid
	
INSERT INTO #SMA (CustID, roleid)
SELECT c.custid, roleid
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE c.roleid IN (2,3,4) AND c.custid > @max_custid 

-----------------------------------------------------------------------------------------------
DECLARE @batch int = 3000

--Dep_LicenseeProductSetting
BEGIN
	CREATE TABLE #Dep_LicenseeProductSetting (CustID INT, ProductSettingID INT
											  ,PRIMARY KEY CLUSTERED (CustID, ProductSettingID))

	INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT d.CustID
			,d.ProductSettingID
	FROM Dep_LicenseeProductSetting d WITH(NOLOCK) 
		INNER JOIN #supers ci WITH(NOLOCK) ON d.CustID = ci.custid
		CROSS APPLY (SELECT TOP 1 ProductSettingID
						 FROM #Dep_ProductSettingDetail s 
						 WHERE d.ProductSettingID=s.ProductSettingID) T

	IF EXISTS (SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
	BEGIN
		CREATE TABLE #Dep_LicenseeProductSettingTemp (CustID INT, ProductSettingID INT
													  ,PRIMARY KEY CLUSTERED (CustID, ProductSettingID))
		
		WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
		BEGIN
			DELETE TOP (@batch) #Dep_LicenseeProductSetting 
			OUTPUT deleted.CustID, deleted.ProductSettingID
				INTO #Dep_LicenseeProductSettingTemp(CustID, ProductSettingID)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE lps
			FROM dbo.Dep_LicenseeProductSetting lps WITH(ROWLOCK)		
				INNER JOIN #Dep_LicenseeProductSettingTemp ci ON ci.custid = lps.CustID AND ci.ProductSettingID = lps.ProductSettingID

			TRUNCATE TABLE #Dep_LicenseeProductSettingTemp
		END
	END

	DROP TABLE #Dep_LicenseeProductSetting
	DROP TABLE #Dep_LicenseeProductSettingTemp
END

--PositionTaking
IF EXISTS(SELECT TOP 1 1 FROM #Dep_ProductSettingDetail WHERE SettingType IN (1))
BEGIN
	CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(CustID,Sporttype,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_Member(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(CustID,Sporttype,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_Member(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(AgentID ,Sporttype,Bettype ,IsLive))

	CREATE TABLE #Dep_CustPTSetting_AgentTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(CustID,Sporttype,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTSetting_MemberTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(CustID,Sporttype,Bettype ,IsLive))
	CREATE TABLE #Dep_CustPTGroupSetting_MemberTemp(AgentID INT, SportType SMALLINT, BetType SMALLINT, IsLive BIT, 
											PRIMARY KEY(AgentID ,Sporttype,Bettype ,IsLive))
		
	INSERT INTO #Dep_CustPTSetting_Agent(CustID, SportType, BetType, IsLive)
	SELECT a.CustID, a.SportType, a.BetType, a.IsLive
	FROM Dep_CustPTSetting_Agent a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE t.SettingType IN (1)
		
	INSERT INTO #Dep_CustPTSetting_Member(CustID, SportType, BetType, IsLive)
	SELECT a.CustID, a.SportType, a.BetType, a.IsLive
	FROM Dep_CustPTSetting_Member a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE t.SettingType IN (1)

	INSERT INTO #Dep_CustPTGroupSetting_Member(AgentID, SportType, BetType, IsLive)
	SELECT a.AgentID, a.SportType, a.BetType, a.IsLive
	FROM Dep_CustPTGroupSetting_Member a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMA ci WITH(NOLOCK) ON a.AgentID = ci.custid
	WHERE t.SettingType IN (1) AND ci.roleid = 2
		
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustPTSetting_Agent OUTPUT deleted.CustID, deleted.SportType,deleted.BetType,deleted.IsLive
		INTO #Dep_CustPTSetting_AgentTemp(CustID, SportType, BetType, IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

		TRUNCATE TABLE #Dep_CustPTSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustPTSetting_Member OUTPUT deleted.CustID, deleted.SportType,deleted.BetType,deleted.IsLive
		INTO #Dep_CustPTSetting_MemberTemp(CustID, SportType, BetType, IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTSetting_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

		TRUNCATE TABLE #Dep_CustPTSetting_MemberTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustPTGroupSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member OUTPUT deleted.AgentID, deleted.SportType,deleted.BetType,deleted.IsLive 
		INTO #Dep_CustPTGroupSetting_MemberTemp(AgentID, SportType, BetType, IsLive)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustPTGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustPTGroupSetting_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType AND ci.IsLive = cg.IsLive

		TRUNCATE TABLE #Dep_CustPTGroupSetting_MemberTemp
	END

	DROP TABLE #Dep_CustPTSetting_Agent
	DROP TABLE #Dep_CustPTSetting_Member
	DROP TABLE #Dep_CustPTGroupSetting_Member
	DROP TABLE #Dep_CustPTSetting_AgentTemp
	DROP TABLE #Dep_CustPTSetting_MemberTemp
	DROP TABLE #Dep_CustPTGroupSetting_MemberTemp
END
	
--Commission		
IF EXISTS(SELECT TOP 1 1 FROM #Dep_ProductSettingDetail WHERE SettingType IN (3,5,9))
BEGIN
	CREATE TABLE #Dep_CustDiscountSetting_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
	CREATE TABLE #Dep_CustDiscountGroupSetting_Member(AgentID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(AgentID ,Sporttype,Bettype))

	CREATE TABLE #Dep_CustDiscountSetting_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
	CREATE TABLE #Dep_CustDiscountGroupSetting_MemberTemp(AgentID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(AgentID ,Sporttype,Bettype))
		
	INSERT INTO #Dep_CustDiscountSetting_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM Dep_CustDiscountSetting_Member a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE t.SettingType IN (3,5,9)
		
	INSERT INTO #Dep_CustDiscountGroupSetting_Member(AgentID, SportType, BetType)
	SELECT a.AgentID, a.SportType, a.BetType
	FROM Dep_CustDiscountGroupSetting_Member a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMA ci WITH(NOLOCK) ON a.AgentID = ci.custid
	WHERE t.SettingType IN (3,5,9) AND ci.roleid = 2

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustDiscountSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustDiscountSetting_Member OUTPUT deleted.CustID, deleted.SportType,deleted.BetType
		INTO #Dep_CustDiscountSetting_MemberTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustDiscountSetting_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #Dep_CustDiscountSetting_MemberTemp
	END

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustDiscountGroupSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustDiscountGroupSetting_Member OUTPUT deleted.AgentID, deleted.SportType,deleted.BetType 
		INTO #Dep_CustDiscountGroupSetting_MemberTemp(AgentID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustDiscountGroupSetting_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #Dep_CustDiscountGroupSetting_MemberTemp
	END

	DROP TABLE #Dep_CustDiscountSetting_Member
	DROP TABLE #Dep_CustDiscountGroupSetting_Member
	DROP TABLE #Dep_CustDiscountSetting_MemberTemp
	DROP TABLE #Dep_CustDiscountGroupSetting_MemberTemp
END

--Bet Setting
IF EXISTS(SELECT TOP 1 1 FROM #Dep_ProductSettingDetail WHERE SettingType IN (2,11))
BEGIN
	CREATE TABLE #Dep_CustBetSetting_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
	CREATE TABLE #Dep_CustBetSetting_Member(CustID INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))

	CREATE TABLE #Dep_CustBetSetting_AgentTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
	CREATE TABLE #Dep_CustBetSetting_MemberTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
		
	INSERT INTO #Dep_CustBetSetting_Agent(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM Dep_CustBetSetting_Agent a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE t.SettingType IN (2,11)
		
	INSERT INTO #Dep_CustBetSetting_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM Dep_CustBetSetting_Member a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE t.SettingType IN (2,11)
		
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustBetSetting_Agent OUTPUT deleted.CustID, deleted.SportType,deleted.BetType
		INTO #Dep_CustBetSetting_AgentTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSetting_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType 

		TRUNCATE TABLE #Dep_CustBetSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustBetSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustBetSetting_Member OUTPUT deleted.CustID, deleted.SportType,deleted.BetType
		INTO #Dep_CustBetSetting_MemberTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustBetSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustBetSetting_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType 

		TRUNCATE TABLE #Dep_CustBetSetting_MemberTemp
	END
	
	DROP TABLE #Dep_CustBetSetting_Agent
	DROP TABLE #Dep_CustBetSetting_Member
	DROP TABLE #Dep_CustBetSetting_AgentTemp
	DROP TABLE #Dep_CustBetSetting_MemberTemp
END


DROP TABLE #Dep_ProductSettingDetail
DROP TABLE #Member
DROP TABLE #SMA
DROP TABLE #supers

PRINT N'--------------------------------------------------------'
PRINT N'New Customers - Setting: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO