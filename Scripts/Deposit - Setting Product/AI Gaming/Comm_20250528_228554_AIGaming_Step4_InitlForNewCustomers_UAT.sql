/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20250528
	Task: UAT - Init Comm Setting for AI Gaming [redmine: #228554]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @max_custid INT = xxx

CREATE TABLE #Super(CustID INT)

CREATE TABLE #SuperSportBettype (
					CustID INT,
					Sporttype SMALLINT, 
					Bettype INT,
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)

CREATE TABLE #Agents (
					CustID INT, 
					Sporttype SMALLINT, 
					Bettype INT,
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)

CREATE TABLE #Members (
					CustID INT, 
					Sporttype SMALLINT, 
					Bettype INT,
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)
---------------------------------------------------------------------------------------------
INSERT INTO #Super(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
						INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 
						AND p.ProductID IN (110)
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1
AND (l.licenseeName IN ('Athena000', 'spondemo') AND cs.currency=20)

INSERT INTO #SuperSportBettype (CustID, Sporttype, Bettype)
SELECT DISTINCT s.CustID, pd.SportType, pd.BetType
FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
	INNER JOIN #Super s ON s.CustID=lp.CustID
	INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID
	INNER JOIN dbo.Dep_ProductSettingDetail pd WITH (NOLOCK) ON pd.ProductSettingID = p.ProductSettingID 
WHERE p.SettingType = 4
	AND p.ProductID IN ((110))

--Agents
INSERT INTO #Agents (CustID, Sporttype, Bettype)
SELECT c.custid, s.Sporttype, s.Bettype
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #SuperSportBettype s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid 
						 FROM dbo.custinfo ci WITH(NOLOCK)
						 WHERE ci.srecommend=c.srecommend 
							AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
							AND roleid=3
						)
	AND c.custid > @max_custid
	AND c.roleid=2

--Members
INSERT INTO #Members (CustID, Sporttype, Bettype)
SELECT c.custid, s.Sporttype, s.Bettype
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #SuperSportBettype s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid 
						 FROM dbo.custinfo ci WITH(NOLOCK)
						 WHERE ci.srecommend=c.srecommend 
							AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
							AND roleid=3
						)
	AND (c.username not like '%ClearBal' and c.username not like '%CashOut' and c.username not like '%OddsAdj' and c.username not like '%OddsBoostAdj')
	AND c.custid > @max_custid
	AND c.roleid=1

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @Cust_cnt INT

SELECT @Cust_cnt = COUNT(1)
FROM #Agents

SELECT @Cust_cnt += COUNT(1)
FROM #Members

IF @Cust_cnt = 0
	RETURN;

DECLARE @msg_total NVARCHAR(200) = 'Total of New Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
--insert group comm setting
INSERT INTO dbo.Dep_CustDiscountGroupSetting_Member 
	(AgentID
	,SportType
	,BetType
	,PlayerDiscount
	,AgentDiscount
	,MasterDiscount
	,SuperDiscount	
	,RepUpdateTime
	)
SELECT t.custid, t.Sporttype, t.Bettype, 0, 0, 0, 0, dbo.f_GetDateTime2()
FROM #Agents t	
	LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
		ON dcs.AgentID = t.CustID 
		AND dcs.SportType = t.sporttype
		AND dcs.BetType = t.bettype	
WHERE dcs.AgentID IS NULL
	
-- UPDATE comm group for cust have not offered comm yet.
UPDATE cs
	SET isGroupedComm = 1
		,RepUpdateTime = dbo.f_GetDateTime2()
FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
	CROSS APPLY (SELECT TOP 1 1 AS val FROM #Members c 
				 WHERE c.CustID=cs.CustID) AS t
	OUTER APPLY (SELECT TOP 1 dcs_m.CustID 
				 FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				 WHERE dcs_m.CustID = cs.CustID
				) AS tmp
WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		
-- insert private setting if already offered comm before and not belong to comm group
INSERT INTO Dep_CustDiscountSetting_Member (CustID
					,SportType
					,BetType
					,PlayerDiscount
					,AgentDiscount
					,MasterDiscount
					,SuperDiscount
					,RepUpdateTime)  	
SELECT c.CustID, cb.sporttype, cb.bettype, 0,0,0,0, dbo.f_GetDateTime2()
FROM Dep_CustSettingMode c WITH (NOLOCK)
	INNER JOIN #Members cb ON c.CustID = cb.CustID
	LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
		ON dcs_m.CustID = c.CustID and dcs_m.SportType = cb.sporttype
		AND dcs_m.BetType = cb.bettype	
WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL

SET @msg_total = 'New Customers - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

RAISERROR (@msg_total, 0, 1) WITH NOWAIT

DROP TABLE #Agents, #Members, #Super, #SuperSportBettype
GO
