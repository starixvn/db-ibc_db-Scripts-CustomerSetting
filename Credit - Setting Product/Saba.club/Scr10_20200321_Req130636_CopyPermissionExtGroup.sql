/*	
	Creator: Elodie
	Date: 20170801
	Task: Copy permission Lottery from Keno for Ext Group
	DB: DBEAS/bodb_EAS
*/
--Reference f_SiteBySystem

----Get Ext Group List
--CREATE TABLE #supers (custid int,isfinished bit default(0))

--INSERT INTO #supers(custid)
--SELECT ci.custid
--FROM customer ci WITH (NOLOCK) 
--	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
--	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
--WHERE ci.roleid = 4  
--	AND ci.username NOT LIKE '3rdSuper%'
--	AND cs.isinternal = 0
--	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
--	AND s.islicensee = 0
--	AND ci.site IN ('755555', 'Indo', 'KORIBC', '733333', '222223', '222225', '222227')

--SELECT  DISTINCT u.GroupName
--FROM #supers c WITH(NOLOCK)
--	INNER join DBAGE.bodb_AGE.dbo.Acc_CustGroup u WITH(NOLOCK) ON c.custid= u.custid

USE bodb_EAS
GO

CREATE TABLE #GroupExt (GroupID INT)
CREATE TABLE #PermissionMapping (PermissionFrom SMALLINT, PermissionTo SMALLINT)

INSERT INTO #GroupExt (GroupID)
SELECT GroupID
FROM dbo.eaGroup WITH(NOLOCK)
WHERE GroupName IN ('ACCYEN888','ACCUSD','ACCUT2','ACCUT','ACCUSDOTH','ACCIRR','ACCUUS','ACCYEN668','ACCYEN789','ACCYEN889','ACCNTD','ACCYEN','ACCTEST')

--input Permission To
INSERT INTO #PermissionMapping (PermissionFrom, PermissionTo)
SELECT 100, 127 --Keno ==> Edit Lottery Setting
UNION ALL SELECT 99, 129 --Enable Keno ==> Enable Lottery Status
UNION ALL SELECT 101, 128 --Keno Bet Setting ==> Edit Lottery Betting Limit

UPDATE gpt
SET gpt.Policy = gpf.Policy
--SELECT *
FROM eaGroupPolicy gpf WITH (NOLOCK)
	INNER JOIN eaGroupPolicy gpt WITH (NOLOCK) ON gpt.GroupID = gpf.GroupID
	INNER JOIN #GroupExt g ON g.GroupID = gpf.GroupID
	INNER JOIN #PermissionMapping p ON gpf.FuncID = p.PermissionFrom AND gpt.FuncID = p.PermissionTo

UPDATE upt
SET upt.Policy = upf.Policy
--SELECT *
FROM eaUserPolicy upf WITH (NOLOCK)
	INNER JOIN eaUserPolicy upt WITH (NOLOCK) ON upt.UserID = upf.UserID
	INNER JOIN dbo.eaUserInfo u WITH (NOLOCK) ON u.UserID = upf.UserID
	INNER JOIN #GroupExt g ON u.GroupID = g.GroupID
	INNER JOIN #PermissionMapping p ON upf.FuncID = p.PermissionFrom AND upt.FuncID = p.PermissionTo

DROP TABLE #GroupExt
DROP TABLE #PermissionMapping