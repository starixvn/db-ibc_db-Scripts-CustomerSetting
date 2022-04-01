/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20220321
	Task: Adjust Setting for SB,NG,Keno DCS - UUS[Redmine:#167898]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
-----------------------------------------------------
PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
CREATE TABLE #supers (custid int,Site VARCHAR(50),Currency INT,isfinished bit default(0))

INSERT INTO #supers(custid,Site,Currency)
SELECT ci.custid,cu.site,ci.currency
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN customer cu WITH(NOLOCK) ON cu.custid = ci.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled=1 
	AND cs.site IN('spondemo','Athena000')	
	AND Ci.currency  IN (20)
ORDER BY ci.custid 

DECLARE @currency INT, @BitOrderNG TINYINT = 12, @BitOrderKN TINYINT = 13
DECLARE @BatchSize SMALLINT = 700

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #CustComm_temp (CustID INT, recommend INT)	
DECLARE @CustComm_TempBatch TABLE (CustID INT, recommend INT)

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN(SELECT CustID FROM #supers) AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

DECLARE @SportBettype_tbl Table(Sporttype SMALLINT, BetType SMALLINT, HavePT BIT, HaveComm BIT, HaveBetSetting BIT, HaveBetSettingGame BIT,ProductID TINYINT)
INSERT INTO @SportBettype_tbl(Sporttype,BetType,HavePT,HaveComm,HaveBetSetting,HaveBetSettingGame,ProductID)
SELECT a.SportType,a.BetType,
	MAX(CASE WHEN b.SettingType = 1 THEN 1 ELSE 0 END) AS HavePT,
	MAX(CASE WHEN b.SettingType = 9 THEN 1 ELSE 0 END) AS HaveComm,
	MAX(CASE WHEN b.SettingType IN (2,11) THEN 1 ELSE 0 END) AS HaveBetSetting,
	MAX(CASE WHEN b.SettingType IN (10,12) THEN 1 ELSE 0 END) AS HaveBetSettingGame,
	MAX(b.ProductID) AS ProductID
FROM Dep_ProductSettingDetail a WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
WHERE b.ProductID IN(1,3,8)
GROUP BY a.SportType,a.BetType

-------------Comm----------------------------------------
SET @BatchSize = 700 

--> get all customers apply player comm for SB/Keno/NG
INSERT INTO #CustComm_temp(CustID,recommend)
SELECT co.custid,ci.recommend
FROM bodb_Licensee.dbo.licenseeCustComm co WITH(NOLOCK) 
	INNER JOIN Custinfo ci WITH(NOLOCK) ON co.CustID = ci.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE NOT(co.SBComm = 0 AND co.Parlaycomm = 0 AND co.NGComm = 0 AND co.KenoComm = 0)
	AND ci.roleid = 1
	AND ci.Enabled = 1
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

--Correct Player comm
WHILE (1=1)
BEGIN
	DELETE TOP (@BatchSize) c 
	OUTPUT DELETED.CustID,deleted.recommend INTO @CustComm_TempBatch(CustID,recommend)
	FROM #CustComm_temp c 
		
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET isGroupedComm = 0
	FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON cb.CustID = cs.CustID
		INNER JOIN bodb_Licensee.dbo.licenseeCustComm co WITH(NOLOCK) 
			ON cs.CustID = co.CustID
	WHERE cs.IsGroupedComm = 1
		AND NOT(co.SBComm = 0 AND co.Parlaycomm = 0 AND co.NGComm = 0 AND co.KenoComm = 0)

	--> insert comm on private tables if not exists (get all sport offered from agent)
	INSERT INTO Dep_CustDiscountSetting_Member (
		CustID
		,SportType
		,BetType
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount
	)
	SELECT c.CustID, ag.Sporttype, ag.BetType,ag.PlayerDiscount,ag.AgentDiscount,ag.MasterDiscount,ag.SuperDiscount
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON c.CustID = cb.CustID
		INNER JOIN Dep_CustDiscountGroupSetting_Member ag WITH(NOLOCK)
			ON cb.recommend = ag.AgentID
		LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
			ON dcs_m.CustID = c.CustID 
			and dcs_m.SportType = ag.Sporttype
			AND dcs_m.BetType = ag.BetType			
	WHERE c.IsGroupedComm = 0 
		AND dcs_m.custid IS NULL
		
	--> UpdatePlayer comm on private Tables (insert if not exist)
	UPDATE dcs_m
	SET dcs_m.PlayerDiscount = CASE WHEN sp.Sporttype IN (1,2) AND sp.BetType <> 9 THEN co.SBComm
									WHEN sp.Sporttype = 1 AND sp.BetType = 9 THEN co.Parlaycomm
									WHEN sp.Sporttype = 161 AND sp.BetType = 81 THEN co.NGComm
									WHEN sp.Sporttype = 202 AND sp.BetType = 1501 THEN co.KenoComm
								END
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON c.CustID = cb.CustID
		INNER JOIN bodb_Licensee.dbo.licenseeCustComm co WITH(NOLOCK) 
			ON c.CustID = co.CustID
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustDiscountSetting_Member dcs_m WITH (ROWLOCK,UPDLOCK) 
			ON dcs_m.CustID = c.CustID 
			and dcs_m.SportType = sp.Sporttype
			AND dcs_m.BetType = sp.BetType			
	WHERE c.IsGroupedComm = 0
		AND sp.HaveComm = 1
			
	DELETE FROM @CustComm_TempBatch
END

--> get all BA customers ( have licensee Comm)
INSERT INTO #CustComm_temp(CustID,recommend)
SELECT co.custid,ci.recommend
FROM Dep_CustBAActive co WITH(NOLOCK) 
	INNER JOIN Custinfo ci WITH(NOLOCK) ON co.CustID = ci.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE ci.roleid = 1
	AND ci.Enabled = 1
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

--Correct Licensee comm for BA members
WHILE (1=1)
BEGIN
	DELETE TOP (@BatchSize) c 
	OUTPUT DELETED.CustID,deleted.recommend INTO @CustComm_TempBatch(CustID,recommend)
	FROM #CustComm_temp c 
		
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET isGroupedComm = 0
	FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON cb.CustID = cs.CustID
		INNER JOIN Dep_CustBAActive co WITH(NOLOCK) 
			ON cs.CustID = co.CustID
	WHERE cs.IsGroupedComm = 1

	--> insert comm on private tables if not exists (get all sport offered from agent)
	INSERT INTO Dep_CustDiscountSetting_Member (
		CustID
		,SportType
		,BetType
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount
	)
	SELECT c.CustID, ag.Sporttype, ag.BetType,ag.PlayerDiscount,ag.AgentDiscount,ag.MasterDiscount,ag.SuperDiscount
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON c.CustID = cb.CustID
		INNER JOIN Dep_CustDiscountGroupSetting_Member ag WITH(NOLOCK)
			ON cb.recommend = ag.AgentID
		LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
			ON dcs_m.CustID = c.CustID 
			and dcs_m.SportType = ag.Sporttype
			AND dcs_m.BetType = ag.BetType			
	WHERE c.IsGroupedComm = 0 
		AND dcs_m.custid IS NULL
		
	--> UpdatePlayer comm on private Tables (insert if not exist)
	UPDATE dcs_m
	SET dcs_m.AgentDiscount = co.discount,
		dcs_m.MasterDiscount = co.adiscount,
		dcs_m.SuperDiscount = co.sdiscount
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @CustComm_TempBatch cb 
			ON c.CustID = cb.CustID
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN dbo.Dep_CustSetting co WITH(NOLOCK) 
			ON c.CustID = co.CustID
			AND co.sporttype = sp.Sporttype
			AND co.bettype = sp.BetType
			AND co.islive = 0
		INNER JOIN Dep_CustDiscountSetting_Member dcs_m WITH (ROWLOCK,UPDLOCK) 
			ON dcs_m.CustID = c.CustID 
			and dcs_m.SportType = sp.Sporttype
			AND dcs_m.BetType = sp.BetType			
	WHERE c.IsGroupedComm = 0
		AND sp.HaveComm = 1
			
	DELETE FROM @CustComm_TempBatch
END

DROP TABLE #Dummy
DROP TABLE #supers
DROP TABLE #CustComm_temp
PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

