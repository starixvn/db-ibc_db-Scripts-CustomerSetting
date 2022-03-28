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
CREATE TABLE #CustStatus_Temp  (CustID INT, IsDisabled BIT)	
DECLARE @CustStatus_TempBatch TABLE (CustID INT, IsDisabled BIT)


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
--------------------------------------------Adjust Status--------------------------------------------------
SET @BatchSize = 5000
--Correct NG Status
INSERT INTO #CustStatus_Temp(custid,IsDisabled)
SELECT c.CustID,ci.DisableNumber
FROM dbo.Dep_CustProductStatus C WITH(NOLOCK)
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitOrderNG) as isDisabled
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsHidden, @BitOrderNG) as isHidden
	INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE ci.roleid IN (1,2,3,4) 
	AND Enabled = 1
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND (isDisabled.value <> ci.DisableNumber OR isHidden.value <> 0)

WHILE 1 = 1
BEGIN
	DELETE TOP(@BatchSize) t
	OUTPUT deleted.custid,deleted.IsDisabled INTO @CustStatus_TempBatch(custid,IsDisabled)
	FROM #CustStatus_Temp t

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE cs
	SET cs.bitmapIsHidden = hid.NewBitmap,
		bitmapIsDisabled = dis.NewBitmap
	FROM [dbo].[Dep_CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @CustStatus_TempBatch ci ON cs.CustID = ci.CustID
		CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitOrderNG,0) as Hid
		CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitOrderNG,ci.IsDisabled) as Dis

	DELETE FROM @CustStatus_TempBatch
END

--Correct Keno Status
INSERT INTO #CustStatus_Temp(custid,IsDisabled)
SELECT c.CustID,cg.IsDisabled
FROM dbo.Dep_CustProductStatus C WITH(NOLOCK)
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsDisabled, @BitOrderKN) as isDisabled
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(C.bitmapIsHidden, @BitOrderKN) as isHidden
	INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
	INNER JOIN CustGameType cg WITH(NOLOCK) ON c.CustID = cg.CustID AND cg.GameTypeID = 1
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
WHERE ci.roleid IN (1,2,3,4) 
	AND Enabled = 1
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND (isDisabled.value <> cg.IsDisabled OR isHidden.value <> 0)

WHILE 1 = 1
BEGIN
	DELETE TOP(@BatchSize) t
	OUTPUT deleted.custid,deleted.IsDisabled INTO @CustStatus_TempBatch(custid,IsDisabled)
	FROM #CustStatus_Temp t

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE cs
	SET cs.bitmapIsHidden = hid.NewBitmap,
		bitmapIsDisabled = dis.NewBitmap
	FROM [dbo].[Dep_CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN @CustStatus_TempBatch ci ON cs.CustID = ci.CustID
		CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitOrderKN,0) as Hid
		CROSS APPLY dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitOrderKN,ci.IsDisabled) as Dis

	DELETE FROM @CustStatus_TempBatch
END
----------------------------------Adjust PT--------------------------------------------
SET @BatchSize = 5000

CREATE TABLE #Dep_CustPTSetting_Agent(CustID INT,SportType smallint,BetType smallint,SuperPT smallmoney,MasterPT smallmoney,AgentPT smallmoney,RoleID TINYINT,Site VARCHAR(50),Currency INT,Isfinished BIT DEFAULT 0)
CREATE TABLE #Dep_CustPTSetting_Agent_Batch(CustID INT,SportType smallint,BetType smallint,SuperPT smallmoney,MasterPT smallmoney,AgentPT smallmoney,RoleID TINYINT,Site VARCHAR(50),Currency INT)
CREATE TABLE #Dep_CustPTSetting_Member(CustID INT,SportType smallint,BetType smallint,AgentPT smallmoney,Isfinished BIT DEFAULT 0)
CREATE TABLE #Dep_CustPTSetting_Member_Batch(CustID INT,SportType smallint,BetType smallint,AgentPT smallmoney)

INSERT INTO #Dep_CustPTSetting_Agent(CustID,SportType,BetType,SuperPT,MasterPT,AgentPT,RoleID,Site,Currency)
SELECT dc.custid,dc.sporttype,dc.bettype,dc.spositiontaking,dc.mpositiontaking,dc.apositiontaking,ci.roleid,s.Site,s.Currency
FROM Dep_CustPTSetting_Agent c WITH(NOLOCK)
	INNER JOIN @SportBettype_tbl sp ON c.SportType = sp.Sporttype AND c.BetType = sp.BetType
	INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	INNER JOIN Dep_custsetting dc WITH(NOLOCK)
		ON c.CustID = dc.custid
		AND c.SportType = dc.sporttype
		AND c.BetType = dc.bettype
		AND dc.islive = 0
WHERE sp.HavePT = 1
	AND (c.AgentPT <> dc.apositiontaking OR c.MasterPT<> dc.mpositiontaking OR c.SuperPT <> dc.spositiontaking)
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND ci.Enabled = 1
--NG
UNION ALL
SELECT dc.custid,dc.sporttype,dc.bettype,dc.spositiontaking,dc.mpositiontaking,dc.apositiontaking,ci.roleid,s.Site,s.Currency
FROM Dep_CustPTSetting_Agent c WITH(NOLOCK)
	INNER JOIN @SportBettype_tbl sp ON c.SportType = sp.Sporttype AND c.BetType = sp.BetType
	INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	INNER JOIN Dep_custsetting3rd dc WITH(NOLOCK)
		ON c.CustID = dc.custid
		AND c.SportType = dc.sporttype
		AND c.BetType = dc.bettype
		AND dc.islive = 0
WHERE sp.HavePT = 1
	AND (c.AgentPT <> dc.apositiontaking OR c.MasterPT<> dc.mpositiontaking OR c.SuperPT <> dc.spositiontaking)
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND ci.Enabled = 1
--Keno
UNION ALL
SELECT dc.custid,dc.sporttype,dc.bettype,dc.spositiontaking,dc.mpositiontaking,dc.apositiontaking,ci.roleid,s.Site,s.Currency
FROM Dep_CustPTSetting_Agent c WITH(NOLOCK)
	INNER JOIN @SportBettype_tbl sp ON c.SportType = sp.Sporttype AND c.BetType = sp.BetType
	INNER JOIN custInfo ci WITH(NOLOCK) ON C.CustID = ci.custid
	INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	INNER JOIN CustSettingGame dc WITH(NOLOCK)
		ON c.CustID = dc.custid
		AND c.SportType = dc.sporttype
		AND c.BetType = dc.bettype
WHERE sp.HavePT = 1
	AND (c.AgentPT <> dc.apositiontaking OR c.MasterPT<> dc.mpositiontaking OR c.SuperPT <> dc.spositiontaking)
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND ci.Enabled = 1

--Adjust SMA PT and Group Member PT
WHILE 1 = 1
BEGIN
	UPDATE TOP(@BatchSize) t
	SET t.Isfinished = 1
	OUTPUT deleted.custid,deleted.SportType,deleted.BetType,deleted.AgentPT,deleted.MasterPT,deleted.SuperPT,deleted.Site,deleted.Currency,deleted.RoleID
	INTO #Dep_CustPTSetting_Agent_Batch(custid,SportType,BetType,AgentPT,MasterPT,SuperPT,Site,Currency,RoleID)
	FROM #Dep_CustPTSetting_Agent t
	WHERE t.Isfinished = 0

	IF @@ROWCOUNT = 0
		BREAK

	UPDATE cs
	SET cs.AgentPT = ci.AgentPT,
		cs.MasterPT = ci.MasterPT,
		cs.SuperPT = ci.SuperPT
	FROM [dbo].Dep_CustPTSetting_Agent cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #Dep_CustPTSetting_Agent_Batch ci 
			ON cs.CustID = ci.CustID 
			AND cs.SportType = ci.SportType 
			AND cs.BetType = ci.BetType

	UPDATE cs
	SET cs.AgentPT = ci.AgentPT 
	FROM [dbo].Dep_CustPTGroupSetting_Member cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #Dep_CustPTSetting_Agent_Batch ci 
			ON cs.AgentID = ci.CustID 
			AND cs.SportType = ci.SportType 
			AND cs.BetType = ci.BetType
			AND ci.RoleID = 2
			AND NOT ( ci.Site = 'asiabet88' AND ci.currency IN(3,6) AND cs.sporttype = 1 AND cs.bettype = 1 ) -- Default BA on this site/currencies
	
	INSERT INTO #Dep_CustPTSetting_Member (CustID,SportType,BetType,AgentPT)
	SELECT ci.custid,t.SportType,t.BetType,t.AgentPT
	FROM #Dep_CustPTSetting_Agent_Batch t
		INNER JOIN custInfo ci ON ci.recommend = t.CustID AND ci.Enabled = 1
		INNER JOIN Dep_CustSettingMode dc WITH(NOLOCK) ON dc.CustID = ci.custid AND dc.IsGroupedPT = 0
	WHERE t.RoleID = 2
		AND ( NOT (t.sporttype = 1 AND t.bettype = 1) 
				OR (t.Site = 'asiabet88' AND t.currency IN(3,6)) 
			)

	--Loop Member
	WHILE 1 = 1
	BEGIN
		UPDATE TOP(@BatchSize) t
		SET t.Isfinished = 1
		OUTPUT deleted.custid,deleted.SportType,deleted.BetType,deleted.AgentPT
		INTO #Dep_CustPTSetting_Member_Batch(custid,SportType,BetType,AgentPT)
		FROM #Dep_CustPTSetting_Member t
		WHERE t.Isfinished = 0

		IF @@ROWCOUNT = 0
			BREAK

		UPDATE cs
		SET cs.AgentPT = ci.AgentPT
		FROM [dbo].Dep_CustPTSetting_Member cs WITH(ROWLOCK,UPDLOCK)
			INNER JOIN #Dep_CustPTSetting_Member_Batch ci 
				ON cs.CustID = ci.CustID 
				AND cs.SportType = ci.SportType 
				AND cs.BetType = ci.BetType

		TRUNCATE TABLE #Dep_CustPTSetting_Member_Batch
	END

	TRUNCATE TABLE #Dep_CustPTSetting_Agent_Batch
END

DROP TABLE #Dummy
DROP TABLE #supers
DROP TABLE #CustComm_temp
DROP TABLE #CustStatus_Temp
DROP TABLE #Dep_CustPTSetting_Agent
DROP TABLE #Dep_CustPTSetting_Agent_Batch
PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

