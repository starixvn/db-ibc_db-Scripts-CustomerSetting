/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230810@Tacy
	Task: Update VS3 (old) 's sport/bettype to VS3 (new) 's sport/bettype for new real licensee
	DB: DBCust/CustDB and all replicated servers
*/
DECLARE @max_custid INT = 101576345

CREATE TABLE #Super (CustID INT PRIMARY KEY)

CREATE TABLE #Agents (
					CustID INT, 
					Sporttype SMALLINT DEFAULT(231), 
					Bettype INT DEFAULT(5301),
					PRIMARY KEY CLUSTERED (CustID,Sporttype,Bettype)
					)

CREATE TABLE #Members (
					CustID INT, 
					Sporttype SMALLINT DEFAULT(231), 
					Bettype INT DEFAULT(5301),
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
						AND p.ProductID IN (77)
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1 AND l.licenseeName NOT IN ('Athena000')

--Agents
INSERT INTO #Agents (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Super s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid 
						 FROM dbo.custinfo ci WITH(NOLOCK)
						 WHERE ci.srecommend=c.srecommend 
							AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
							AND roleid=3
						)
	AND c.custid > @max_custid
	AND c.roleid=2

--Members
INSERT INTO #Members (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
INNER JOIN #Super s ON s.CustID=c.srecommend
WHERE mrecommend NOT IN (SELECT custid 
						 FROM dbo.custinfo ci WITH(NOLOCK)
						 WHERE ci.srecommend=c.srecommend 
							AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
							AND roleid=3
						)
	AND c.custid > @max_custid
	AND c.roleid=1

--Delete: members have group comm setting
DELETE c
FROM #Members c
INNER JOIN Dep_CustSettingMode m WITH (NOLOCK)
	ON c.CustID=m.CustID
WHERE m.IsGroupedComm=1

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @Cust_cnt INT

SELECT @Cust_cnt = COUNT(1)
FROM #Agents

SELECT @Cust_cnt += COUNT(1)
FROM #Members

DECLARE @msg_total NVARCHAR(200) = 'Total of New Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
DECLARE @Sporttype SMALLINT, @Bettype INT

SELECT  @Sporttype=178, @Bettype=5302

UPDATE dcs 
SET dcs.SportType=@Sporttype, dcs.BetType=@Bettype
FROM dbo.Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK)
INNER JOIN #Agents t ON t.CustID=DCS.AgentID
					AND t.Sporttype=dcs.SportType
					AND t.Bettype=dcs.BetType
OUTER APPLY (SELECT TOP 1 1 AS val
			 FROM Dep_CustDiscountGroupSetting_Member d WITH (NOLOCK)
			 WHERE d.AgentID=t.CustID AND d.SportType=178 and d.BetType=5302) d
WHERE d.val IS NULL

UPDATE dcs 
SET dcs.SportType=@Sporttype, dcs.BetType=@Bettype
FROM dbo.Dep_CustDiscountSetting_Member dcs WITH (NOLOCK)
INNER JOIN #Members t ON t.CustID=DCS.CustID
					AND t.Sporttype=dcs.SportType
					AND t.Bettype=dcs.BetType
OUTER APPLY (SELECT TOP 1 1 AS val
			 FROM Dep_CustDiscountSetting_Member d WITH (NOLOCK)
			 WHERE d.CustID=t.CustID AND d.SportType=178 and d.BetType=5302) d
WHERE d.val IS NULL

SET @msg_total = 'New Customers - Curdt: ' + CONVERT(VARCHAR(50), GETDATE(), 121)

RAISERROR (@msg_total, 0, 1) WITH NOWAIT

DROP TABLE #Agents, #Members, #Super
GO