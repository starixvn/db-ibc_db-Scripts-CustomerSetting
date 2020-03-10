/*
	Created: Eden
	Date: 20200305
	Task: Update permission for ExtGroup [#122743]
	DB: DBCUST/NAP_UserControl
*/
--Reference f_SiteBySystem

----Get Ext Group List

USE NAP_UserControl
GO

SELECT ci.custid
INTO #supers
FROM CustDB.dbo.customer ci WITH (NOLOCK) 
	INNER JOIN CustDB.dbo.site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN CustDB.dbo.custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM CustDB.dbo.Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site <> 'CN88'

SELECT DISTINCT u.GroupName
INTO #Acc_CustGroup
FROM #supers c WITH(NOLOCK)
	INNER join CustDB.dbo.Acc_CustGroup u WITH(NOLOCK) ON c.custid= u.custid

SELECT GroupID
INTO #GroupExt
FROM dbo.eaGroup WITH(NOLOCK)
WHERE GroupName IN (SELECT GroupName FROM #Acc_CustGroup)

;WITH VG_Permission AS (
	SELECT FuncID,FuncKey,
		P_Order = ROW_NUMBER() OVER (ORDER BY REPLACE(FuncKey,'VirtualGames',''))
	FROM eaFunction WITH(NOLOCK) 
	WHERE FuncKey IN ('VirtualGamesBetting','VirtualGamesSetting','EnableVirtualGames')
)
,Macau_Permission AS(
	SELECT FuncID,FuncKey,
		P_Order = ROW_NUMBER() OVER (ORDER BY REPLACE(FuncKey,'Voidbridge',''))
	FROM eaFunction WITH(NOLOCK) 
	WHERE FuncKey IN ('EnableVoidbridge','VoidbridgeSetting','VoidbridgeBetting')
)
SELECT PermissionTo = v.FuncID ,
	   PermissionFrom = m.FuncID
INTO #PermissionMapping
FROM VG_Permission v
	INNER JOIN Macau_Permission m ON m.P_Order = v.P_Order

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
DROP TABLE #Acc_CustGroup
DROP TABLE #supers

