/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20210602
	Task: Insert Comm Setting - New acc [Redmine: #154048]   
	DB: DBCUST/CUSTDB 

	Notes: 
	ProductName		ProductID	SportType	BetType
	WM				51			233			3401
	Joker			56			234			6401
	BG				57			239			3501
	Sports Lottery	63			169			3611
	GDG				59			236			5701
	Habanero		61			238			7001
*/

DECLARE @max_custid INT	 = xxx
	
CREATE TABLE #Super(CustID INT)
CREATE TABLE #tblCust(CustID INT PRIMARY KEY)
	
INSERT INTO #Super(custid)
SELECT DISTINCT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	INNER JOIN dbo.Dep_LicenseeProductSetting lp WITH (NOLOCK) ON lp.CustID = cs.custid
	INNER JOIN dbo.Dep_ProductSetting p WITH (NOLOCK) ON p.ProductSettingID = lp.ProductSettingID
	INNER JOIN dbo.Dep_ProductSettingDetail pd WITH (NOLOCK) ON pd.ProductSettingID = p.ProductSettingID
WHERE  l.IsActive = 1
	AND p.SettingType = 4
	AND P.ProductID IN (51,56,57,63,59,61)   
			
INSERT INTO #tblCust(Custid)
SELECT ci.custid
FROM dbo.CustInfo ci WITH(NOLOCK)
	INNER JOIN dbo.Dep_CustSettingMode cs WITH(NOLOCK) ON ci.custid = cs.CustID
WHERE srecommend IN (SELECT custid FROM #super)
	AND mrecommend NOT IN ( SELECT custid 
							FROM dbo.custinfo WITH(NOLOCK)
							WHERE srecommend IN (SELECT custid FROM #super)
								AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%' )
								AND roleid=3
						)
	AND ci.custid > @max_custid
	AND isGroupedComm = 0
	AND roleid = 1
		
-- UPDATE comm group for cust have not offered comm yet.
UPDATE cs
	SET isGroupedComm = 1
FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tblCust cb ON cb.CustID = cs.CustID
	OUTER APPLY (	SELECT TOP 1 dcs_m.CustID 
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
					,SuperDiscount)  	
SELECT c.CustID, tmp.sporttype, tmp.bettype, 0,0,0,0
FROM Dep_CustSettingMode c WITH (NOLOCK)
	INNER JOIN #tblCust cb ON c.CustID = cb.CustID
	CROSS APPLY (	SELECT 233 sporttype, 3401	bettype UNION ALL
					SELECT 234, 6401	UNION ALL
					SELECT 239, 3501	UNION ALL
					SELECT 169, 3611	UNION ALL
					SELECT 236, 5701	UNION ALL
					SELECT 238, 7001
					) AS tmp
	LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
		ON dcs_m.CustID = c.CustID 
		AND dcs_m.SportType = tmp.sporttype
		AND dcs_m.BetType = tmp.bettype												
WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
	
DROP TABLE #Super
DROP TABLE #tblCust	 
