/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20221214
	Task: Deposit - Delete settings for new created users
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 

CREATE TABLE #supers (custid INT PRIMARY KEY CLUSTERED)
CREATE TABLE #Member (CustID INT PRIMARY KEY CLUSTERED, isfinished BIT DEFAULT(0), bitmapOrder	VARCHAR(100))
CREATE TABLE #SMA (CustID INT PRIMARY KEY CLUSTERED, roleid TINYINT, isfinished BIT DEFAULT(0), bitmapOrder VARCHAR(100))
CREATE TABLE #Dep_ProductSettingDetail (ProductSettingID INT, SettingType SMALLINT, SportType SMALLINT, BetType SMALLINT, IsLive bit, ProductID TINYINT)

DECLARE @max_custid INT, @bitmapOrder varchar(100)

SELECT @max_custid = xxx

SET @bitmapOrder='3,26'

INSERT INTO #Dep_ProductSettingDetail(ProductSettingID,SettingType, SportType, BetType, IsLive, ProductID)
SELECT psd.ProductSettingID, SettingType, SportType, BetType, IsLive, ProductID
FROM Dep_ProductSettingDetail psd WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting ps WITh(NOLOCK) ON psd.ProductSettingID=ps.ProductSettingID
WHERE ps.ProductID IN (24,59)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
WHERE ci.roleid = 4  
	AND ci.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))

INSERT INTO #Member (CustID, bitmapOrder)
SELECT c.custid, @bitmapOrder
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE roleid = 1 AND c.custid > @max_custid
	
INSERT INTO #SMA (CustID, roleid, bitmapOrder)
SELECT c.custid, roleid, @bitmapOrder
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #supers s ON c.srecommend = s.custid
WHERE c.roleid IN (2,3,4) AND c.custid > @max_custid 

DECLARE @batch int = 3000

--LicenseeProductSetting
CREATE TABLE #Dep_LicenseeProductSetting (CustID INT, ProductSettingID INT)

INSERT INTO #Dep_LicenseeProductSetting(CustID,ProductSettingID)
SELECT d.CustID
		,d.ProductSettingID
FROM Dep_LicenseeProductSetting d WITH(NOLOCK) 
	INNER JOIN #SMA ci WITH(NOLOCK) ON d.CustID = ci.custid
	INNER JOIN #Dep_ProductSettingDetail dps WITH(NOLOCK) ON dps.ProductSettingID = d.ProductSettingID 
WHERE ci.roleid=4

IF EXISTS (SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
BEGIN
	CREATE TABLE #Dep_LicenseeProductSettingTemp (CustID INT, ProductSettingID INT)
		
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_LicenseeProductSetting)
	BEGIN
		DELETE TOP (@batch) #Dep_LicenseeProductSetting OUTPUT DELETED.CustID, DELETED.ProductSettingID
		INTO #Dep_LicenseeProductSettingTemp(CustID, ProductSettingID)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE lps
		FROM dbo.Dep_LicenseeProductSetting lps WITH(ROWLOCK)		
			INNER JOIN #Dep_LicenseeProductSettingTemp ci ON ci.custid = lps.CustID AND ci.ProductSettingID = lps.ProductSettingID

		TRUNCATE TABLE #Dep_LicenseeProductSettingTemp
	END
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
		DELETE TOP (@batch) #Dep_CustPTSetting_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
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
		DELETE TOP (@batch) #Dep_CustPTSetting_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType,DELETED.IsLive
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
		DELETE TOP (@batch) #Dep_CustPTGroupSetting_Member OUTPUT DELETED.AgentID, DELETED.SportType,DELETED.BetType,DELETED.IsLive 
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
	CREATE TABLE #Dep_CustDiscountSetting_Agent(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype ))
	CREATE TABLE #Dep_CustDiscountSetting_Member(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
	CREATE TABLE #Dep_CustDiscountGroupSetting_Member(AgentID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(AgentID ,Sporttype,Bettype))

	CREATE TABLE #Dep_CustDiscountSetting_AgentTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype ))
	CREATE TABLE #Dep_CustDiscountSetting_MemberTemp(CustID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
	CREATE TABLE #Dep_CustDiscountGroupSetting_MemberTemp(AgentID	INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(AgentID ,Sporttype,Bettype))
		
	INSERT INTO #Dep_CustDiscountSetting_Agent(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM Dep_CustDiscountSetting_Agent a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE t.SettingType IN (3,5,9)
		
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

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustDiscountSetting_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustDiscountSetting_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #Dep_CustDiscountSetting_AgentTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountSetting_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustDiscountSetting_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #Dep_CustDiscountSetting_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustDiscountSetting_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustDiscountSetting_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
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
		DELETE TOP (@batch) #Dep_CustDiscountGroupSetting_Member OUTPUT DELETED.AgentID, DELETED.SportType,DELETED.BetType 
		INTO #Dep_CustDiscountGroupSetting_MemberTemp(AgentID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustDiscountGroupSetting_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustDiscountGroupSetting_MemberTemp ci ON ci.AgentID = cg.AgentID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #Dep_CustDiscountGroupSetting_MemberTemp
	END

	DROP TABLE #Dep_CustDiscountSetting_Agent
	DROP TABLE #Dep_CustDiscountSetting_Member
	DROP TABLE #Dep_CustDiscountGroupSetting_Member
	DROP TABLE #Dep_CustDiscountSetting_AgentTemp
	DROP TABLE #Dep_CustDiscountSetting_MemberTemp
	DROP TABLE #Dep_CustDiscountGroupSetting_MemberTemp
END

--Stake Level		
IF EXISTS(SELECT TOP 1 1 FROM #Dep_ProductSettingDetail WHERE SettingType IN (7,8))
BEGIN
	CREATE TABLE #Dep_CustStakeLevel_Agent(CustID INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
	CREATE TABLE #Dep_CustStakeLevel_Member(CustID INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))

	CREATE TABLE #Dep_CustStakeLevel_AgentTemp(CustID INT, SportType SMALLINT, BetType SMALLINT, 
											PRIMARY KEY(CustID,Sporttype,Bettype))
	CREATE TABLE #Dep_CustStakeLevel_MemberTemp(CustID INT, SportType SMALLINT, BetType SMALLINT,  
											PRIMARY KEY(CustID,Sporttype,Bettype))
		
	INSERT INTO #Dep_CustStakeLevel_Agent(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #SMA ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE t.SettingType IN (7,8)
		
	INSERT INTO #Dep_CustStakeLevel_Member(CustID, SportType, BetType)
	SELECT a.CustID, a.SportType, a.BetType
	FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
		INNER JOIN #Dep_ProductSettingDetail t  WITH(NOLOCK) ON a.SportType = t.SportType and a.BetType = t.BetType
		INNER JOIN #Member ci WITH(NOLOCK) ON a.CustID = ci.custid
	WHERE t.SettingType IN (7,8)

	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Agent)
	BEGIN
		DELETE TOP (@batch) #Dep_CustStakeLevel_Agent OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #Dep_CustStakeLevel_AgentTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Agent cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustStakeLevel_AgentTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #Dep_CustStakeLevel_AgentTemp
	END
	
	WHILE EXISTS(SELECT TOP 1 1 FROM #Dep_CustStakeLevel_Member)
	BEGIN
		DELETE TOP (@batch) #Dep_CustStakeLevel_Member OUTPUT DELETED.CustID, DELETED.SportType,DELETED.BetType
		INTO #Dep_CustStakeLevel_MemberTemp(CustID, SportType, BetType)

		IF @@ROWCOUNT=0
			BREAK		

		DELETE cg
		FROM dbo.Dep_CustStakeLevel_Member cg WITH(ROWLOCK)		
			INNER JOIN #Dep_CustStakeLevel_MemberTemp ci ON ci.custid = cg.CustID AND ci.SportType = cg.Sporttype AND ci.BetType = cg.betType

		TRUNCATE TABLE #Dep_CustStakeLevel_MemberTemp
	END

	DROP TABLE #Dep_CustStakeLevel_Agent
	DROP TABLE #Dep_CustStakeLevel_Member
	DROP TABLE #Dep_CustStakeLevel_AgentTemp
	DROP TABLE #Dep_CustStakeLevel_MemberTemp
END

-- Update Status 
CREATE TABLE #AllUsers (CustID INT PRIMARY KEY, XmlDisable VARCHAR(MAX))
CREATE TABLE #Dep_CustProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32),bitmapIsDisabled BINARY(32),isfinished BIT DEFAULT(0))
CREATE TABLE #TempProductStatus(CustID INT PRIMARY KEY,bitmapIsHidden BINARY(32),bitmapIsDisabled BINARY(32))

INSERT INTO #AllUsers (CustID,XmlDisable)
SELECT DISTINCT SMA.CustID, c.zxml FROM #SMA SMA WITH (NOLOCK)
CROSS APPLY ( SELECT DISTINCT
					bitmap AS '@b', 
					1 AS '@s'
				FROM (SELECT value AS bitmap
					FROM STRING_SPLIT(SMA.bitmapOrder,',')
					WHERE value <> '') vh 
				FOR XML PATH ('r'), ROOT ('root')) c (zxml)
UNION 
SELECT DISTINCT M.CustID, c.zxml FROM #Member M WITH (NOLOCK)
CROSS APPLY ( SELECT DISTINCT
					bitmap AS '@b', 
					1 AS '@s'
				FROM (SELECT value AS bitmap
					FROM STRING_SPLIT(M.bitmapOrder,',')
					WHERE value <> '') vh 
				FOR XML PATH ('r'), ROOT ('root')) c (zxml)

INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
SELECT cs.CustID
	,bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),a.XmlDisable)))
	,bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),a.XmlDisable)))
FROM Dep_CustProductStatus cs WITH(NOLOCK)
	INNER JOIN  #AllUsers a ON a.CustID = cs.custid

WHILE 1 = 1 
BEGIN
	TRUNCATE TABLE #TempProductStatus

	UPDATE TOP (@batch) a WITH (ROWLOCK)
	SET a.isfinished = 1
	OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	FROM #Dep_CustProductStatus a 
	WHERE a.isfinished = 0
		 
	IF @@ROWCOUNT = 0 
		BREAK;

	UPDATE c 
	SET  c.bitmapIsHidden = tmp.bitmapIsHidden
		,c.bitmapIsDisabled = tmp.bitmapIsDisabled
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

	WAITFOR DELAY '00:00:00.100'
END

DROP TABLE #Dep_ProductSettingDetail	
DROP TABLE #Member
DROP TABLE #SMA
DROP TABLE #supers
DROP TABLE #TempProductStatus
DROP TABLE #Dep_CustProductStatus
DROP TABLE #AllUsers