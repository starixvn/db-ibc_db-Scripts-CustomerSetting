/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240116@Tacy
	Task: initial setting for new VS setting - New Customers [Redmine: #198008]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @max_custid INT
		,@max_custid2 INT 
		,@Cust_cnt	INT
		,@NewSporttype SMALLINT = 9908

SELECT @max_custid = xxx

SELECT @max_custid2=MAX(custid)
FROM custInfo WITH (NOLOCK)

CREATE TABLE #Supers(CustID INT PRIMARY KEY)
CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)

CREATE TABLE #SMAs (CustID INT
					,RoleID TINYINT
					,SportType SMALLINT DEFAULT (9908)
					,BetType SMALLINT DEFAULT (1201)
					,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

CREATE TABLE #Members (CustID INT
						,SportType SMALLINT DEFAULT (9908)
						,BetType SMALLINT DEFAULT (1201)
						,PRIMARY KEY CLUSTERED (CustID, Sporttype, Bettype))

---------------------------------------------------------------------------------------------
CREATE TABLE #tbDep_ProductSettingNew(ProductSettingID TINYINT, SettingType TINYINT)

INSERT INTO #tbDep_ProductSettingNew (ProductSettingID, SettingType)
SELECT 182, 4 UNION --Product Status
SELECT 183, 1 UNION	--PT
SELECT 184, 2 UNION --BetLimit
SELECT 185, 9		--Comm
---------------------------------------------------------------------------------------------

INSERT INTO #Supers(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 --offered product
						AND p.ProductID IN (5) 
						AND p.ProductSettingID NOT BETWEEN 182 AND 185 --New VS setting
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1
	AND cs.username NOT LIKE '3rdSuper%'

--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
	INNER JOIN #Supers s WITH (NOLOCK) ON s.CustID=c.srecommend
WHERE c.roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID, RoleID)
SELECT c.custid, c.roleid
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Supers s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid > @max_custid AND c.custid<=@max_custid2
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1

--Members
INSERT INTO #Members (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Supers s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.custid > @max_custid AND c.custid<=@max_custid2
	AND c.roleid = 1
	AND c.Enabled=1

---------------------------------------------------------------------------------------------
SELECT @Cust_cnt = COUNT(1)
FROM #SMAs

SELECT @Cust_cnt += COUNT(1)
FROM #Members

DECLARE @msg_total NVARCHAR(200) = 'Total of New Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

---------------------------------------------------------------------------------------------
--PT
BEGIN
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT a.CustID, n.ProductSettingID
	FROM Dep_LicenseeProductSetting a WITH (NOLOCK)
		INNER JOIN #SMAs t ON t.CustID=a.CustID
		INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=a.ProductSettingID
		CROSS APPLY (SELECT n.ProductSettingID FROM #tbDep_ProductSettingNew n WHERE n.SettingType=1) n
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
					ON n.ProductSettingID = dl.ProductSettingID
					AND dl.CustID = t.CustID
	WHERE ps.ProductID=5 AND ps.SettingType=1 
		AND ps.ProductSettingID NOT BETWEEN 182 AND 185	--NEW
		AND t.RoleID=4 AND dl.CustID IS NULL

	--Dep_CustPTSetting_Agent
	DELETE a
	FROM Dep_CustPTSetting_Agent a WITH (NOLOCK)
	INNER JOIN #SMAs t
			ON a.CustID = t.CustID 
			AND a.SportType = t.sporttype
			AND a.BetType = t.bettype	

	INSERT INTO Dep_CustPTSetting_Agent ([CustID], [SportType], [BetType], [IsLive], [SuperPT], [MasterPT], [AgentPT])
	SELECT a.CustID, @NewSporttype, a.BetType, a.IsLive, a.SuperPT, a.MasterPT, a.AgentPT
	FROM Dep_CustPTSetting_Agent a WITH (NOLOCK)
	INNER JOIN #SMAs t
			ON a.CustID = t.CustID 
			AND a.SportType = 180
			AND a.BetType = t.bettype

	--Dep_CustPTGroupSetting_Member
	DELETE a
	FROM Dep_CustPTGroupSetting_Member a WITH (NOLOCK)
	INNER JOIN #SMAs t
			ON a.AgentID = t.CustID 
			AND a.SportType = t.sporttype
			AND a.BetType = t.bettype	
	WHERE t.RoleID=2

	INSERT INTO Dep_CustPTGroupSetting_Member ([AgentID], [SportType], [BetType], [IsLive], [SuperPT], [MasterPT], [AgentPT])
	SELECT a.AgentID, @NewSporttype, a.BetType, a.IsLive, a.SuperPT, a.MasterPT, a.AgentPT
	FROM Dep_CustPTGroupSetting_Member a WITH (NOLOCK)
	INNER JOIN #SMAs t
			ON a.AgentID = t.CustID 
			AND a.SportType = 180
			AND a.BetType = t.bettype	
	WHERE t.RoleID=2

	--Dep_CustPTSetting_Member
	DELETE a
	FROM Dep_CustPTSetting_Member a WITH (NOLOCK)
	INNER JOIN #Members t
			ON a.CustID = t.CustID 
			AND a.SportType = t.sporttype
			AND a.BetType = t.bettype	

	INSERT INTO Dep_CustPTSetting_Member ([CustID], [SportType], [BetType], [IsLive], [SuperPT], [MasterPT], [AgentPT])
	SELECT a.CustID, @NewSporttype, a.BetType, a.IsLive, a.SuperPT, a.MasterPT, a.AgentPT
	FROM Dep_CustPTSetting_Member a WITH (NOLOCK)
	INNER JOIN #Members t
		ON a.CustID = t.CustID 
		AND a.SportType = 180
		AND a.BetType = t.bettype	
END

--Bet Setting
BEGIN 
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT a.CustID, n.ProductSettingID
	FROM Dep_LicenseeProductSetting a WITH (NOLOCK)
		INNER JOIN #SMAs t ON t.CustID=a.CustID
		INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=a.ProductSettingID
		CROSS APPLY (SELECT n.ProductSettingID FROM #tbDep_ProductSettingNew n WHERE n.SettingType=2) n
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
					ON n.ProductSettingID = dl.ProductSettingID
					AND dl.CustID = t.CustID
	WHERE ps.ProductID=5 AND ps.SettingType=2 
		AND ps.ProductSettingID NOT BETWEEN 182 AND 185	--NEW
		AND t.RoleID=4 AND dl.CustID IS NULL

	--Dep_CustBetSetting_Agent
	DELETE a
	FROM Dep_CustBetSetting_Agent a WITH (NOLOCK)
	INNER JOIN #SMAs t
			ON a.CustID = t.CustID 
			AND a.SportType = t.sporttype
			AND a.BetType = t.bettype	

	INSERT INTO Dep_CustBetSetting_Agent ([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch])
	SELECT a.CustID, @NewSporttype, a.BetType, a.MinBet, a.MaxBet, a.MaxPerMatch
	FROM Dep_CustBetSetting_Agent a WITH (NOLOCK)
	INNER JOIN #SMAs t
			ON a.CustID = t.CustID 
			AND a.SportType = 180
			AND a.BetType = t.bettype	

	--Dep_CustBetSetting_Member
	DELETE a
	FROM Dep_CustBetSetting_Member a WITH (NOLOCK)
	INNER JOIN #Members t
			ON a.CustID = t.CustID 
			AND a.SportType = t.sporttype
			AND a.BetType = t.bettype	

	INSERT INTO Dep_CustBetSetting_Member ([CustID], [SportType], [BetType], [MinBet], [MaxBet], [MaxPerMatch])
	SELECT a.CustID, @NewSporttype, a.BetType, a.MinBet, a.MaxBet, a.MaxPerMatch
	FROM Dep_CustBetSetting_Member a WITH (NOLOCK)
	INNER JOIN #Members t
		ON a.CustID = t.CustID 
		AND a.SportType = 180
		AND a.BetType = t.bettype	
END

--Comm
BEGIN 
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT a.CustID, n.ProductSettingID
	FROM Dep_LicenseeProductSetting a WITH (NOLOCK)
		INNER JOIN #SMAs t ON t.CustID=a.CustID
		INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=a.ProductSettingID
		CROSS APPLY (SELECT n.ProductSettingID FROM #tbDep_ProductSettingNew n WHERE n.SettingType=9) n
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
					ON n.ProductSettingID = dl.ProductSettingID
					AND dl.CustID = t.CustID
	WHERE ps.ProductID=5 AND ps.SettingType=9 
		AND ps.ProductSettingID NOT BETWEEN 182 AND 185	--NEW
		AND t.RoleID=4 AND dl.CustID IS NULL

	--Dep_CustDiscountGroupSetting_Member
	DELETE a
	FROM Dep_CustDiscountGroupSetting_Member a WITH (NOLOCK)
	INNER JOIN #SMAs t
			ON a.AgentID = t.CustID 
			AND a.SportType = t.sporttype
			AND a.BetType = t.bettype	
	WHERE t.RoleID=2

	INSERT INTO Dep_CustDiscountGroupSetting_Member ([AgentID], [SportType], [BetType], [PlayerDiscount], [AgentDiscount], [MasterDiscount], [SuperDiscount])
	SELECT a.AgentID, @NewSporttype, a.BetType, a.PlayerDiscount, a.AgentDiscount, a.MasterDiscount, a.SuperDiscount
	FROM Dep_CustDiscountGroupSetting_Member a WITH (NOLOCK)
	INNER JOIN #SMAs t
			ON a.AgentID = t.CustID 
			AND a.SportType = 180
			AND a.BetType = t.bettype	
	WHERE t.RoleID=2

	--Dep_CustDiscountSetting_Member
	DELETE a
	FROM Dep_CustDiscountSetting_Member a WITH (NOLOCK)
	INNER JOIN #Members t
			ON a.CustID = t.CustID	
			AND a.SportType = t.sporttype
			AND a.BetType = t.bettype

	INSERT INTO Dep_CustDiscountSetting_Member ([CustID], [SportType], [BetType], [PlayerDiscount], [AgentDiscount], [MasterDiscount], [SuperDiscount])
	SELECT a.CustID, @NewSporttype, a.BetType, a.PlayerDiscount, a.AgentDiscount, a.MasterDiscount, a.SuperDiscount
	FROM Dep_CustDiscountSetting_Member a WITH (NOLOCK)
	INNER JOIN #Members t
			ON a.CustID = t.CustID 
			AND a.SportType = 180
			AND a.BetType = t.bettype	
END

--Status
BEGIN 
	DECLARE @bitmapOrderNew TINYINT = 42
		, @bitmapOrder	TINYINT = 4

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT a.CustID, n.ProductSettingID
	FROM Dep_LicenseeProductSetting a WITH (NOLOCK)
		INNER JOIN #SMAs t ON t.CustID=a.CustID
		INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON ps.ProductSettingID=a.ProductSettingID
		CROSS APPLY (SELECT n.ProductSettingID FROM #tbDep_ProductSettingNew n WHERE n.SettingType=4) n
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
					ON n.ProductSettingID = dl.ProductSettingID
					AND dl.CustID = t.CustID
	WHERE ps.ProductID=5 AND ps.SettingType=4 
		AND ps.ProductSettingID NOT BETWEEN 182 AND 185	--NEW
		AND t.RoleID=4 AND dl.CustID IS NULL

	--SMA
	UPDATE cs
	SET	 bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden, @bitmapOrderNew
																						, dbo.f_GetProductStatus(cs.bitmapIsHidden , @bitmapOrder)))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsDisabled, @bitmapOrderNew
																						, dbo.f_GetProductStatus(cs.bitmapIsDisabled , @bitmapOrder)))
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #SMAs b ON cs.CustID = b.CustID 

	--Member
	UPDATE cs
	SET	 bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsHidden, @bitmapOrderNew
																						, dbo.f_GetProductStatus(cs.bitmapIsHidden , @bitmapOrder)))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (cs.bitmapIsDisabled, @bitmapOrderNew
																						, dbo.f_GetProductStatus(cs.bitmapIsDisabled , @bitmapOrder)))
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #Members b ON cs.CustID = b.CustID 

END

DROP TABLE #Dummy, #Members, #SMAs, #Supers, #tbDep_ProductSettingNew
GO