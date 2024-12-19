/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241210@Johnson
	Task: Init Comm Setting for new customers [redmine: #214980]
	DB: DBCUST/CustDB
*/

DECLARE @max_custid BIGINT = xxx
					
CREATE TABLE #tblCust(CustID INT PRIMARY KEY, roleid TINYINT)
CREATE TABLE #tmp(CustID INT PRIMARY KEY)
DECLARE @BatchCust TABLE (CustID INT PRIMARY KEY)

CREATE TABLE #Super(CustID INT, isfinished BIT DEFAULT(0))

INSERT INTO #Super(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	CROSS APPLY (SELECT TOP (1) 1 
				FROM dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) 
					INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) 
						ON p.ProductSettingID = lp.ProductSettingID 
						AND p.SettingType = 4 
						AND p.ProductID IN (100,48,90)
				WHERE  lp.CustID = cs.custid							
				)
				AS tmp (_sb)
WHERE  l.IsActive = 1

INSERT INTO #tblCust(Custid,roleid)
SELECT custid, roleid
FROM dbo.CustInfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Super)
	AND mrecommend NOT IN (SELECT custid 
							FROM dbo.custinfo WITH(NOLOCK)
							WHERE srecommend IN (SELECT custid FROM #Super)
								AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
								AND roleid=3
						)
	AND (ci.username not like '%ClearBal' and ci.username not like '%CashOut' and ci.username not like '%OddsAdj' and ci.username not like '%OddsBoostAdj')
	AND custid > @max_custid
	
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
SELECT t.custid, sb.Sporttype, sb.Bettype, 0, 0, 0, 0, dbo.f_GetDateTime2()
FROM #tblCust t	
	CROSS APPLY (
				SELECT 148 Sporttype, 12500 Bettype					
				UNION SELECT 145, 11400
				UNION SELECT 144, 11500	
		)sb
	LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
		ON dcs.AgentID = t.CustID 
			AND dcs.SportType = sb.sporttype
			AND dcs.BetType = sb.bettype
WHERE roleid = 2 AND dcs.AgentID IS NULL		

INSERT INTO #tmp(custid)
SELECT cs.custid
FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t ON t.CustID = cs.CustID
		OUTER APPLY (SELECT TOP 1 dcs_m.CustID FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
					 WHERE dcs_m.CustID = cs.CustID
						AND dcs_m.SportType IN (144,145,148)
					) AS tmp
WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
	AND t.roleid = 1
	
WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT deleted.custid INTO @BatchCust(custid)
	FROM #tmp t		
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	INSERT INTO Dep_CustDiscountSetting_Member (CustID
						,SportType
						,BetType
						,PlayerDiscount
						,AgentDiscount
						,MasterDiscount
						,SuperDiscount
						,RepUpdateTime)  	
	SELECT c.CustID, tmp.sporttype, tmp.bettype,0,0,0,0, dbo.f_GetDateTime2()
	FROM Dep_CustSettingMode c WITH (NOLOCK)
		INNER JOIN @BatchCust cb ON c.CustID = cb.CustID
		CROSS APPLY (SELECT 148 Sporttype, 12500 Bettype					
					UNION SELECT 145, 11400
					UNION SELECT 144, 11500											
					) AS tmp
		LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
			ON dcs_m.CustID = c.CustID and dcs_m.SportType = tmp.sporttype
			AND dcs_m.BetType = tmp.bettype	
																
	WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
	
	DELETE @BatchCust	
	
	WAITFOR DELAY '0:0:0.05'	
END		