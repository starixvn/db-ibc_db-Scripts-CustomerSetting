/*<info serverAlias="DBCUST-NAP_UserControl"></info>*//*
	Created: Helios
	Date: 2024/04/16
	Task: Update permission for ExtGroup [#198960]
		https://nexdev.net/issues/198960
	DB: DBCUST/NAP_UserControl
*/

----Get Ext Group List

USE NAP_UserControl
GO

CREATE TABLE #PermissionMapping (PermissionFrom INT , PermissionTo INT)


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

--SELECT '#supers Affected' AS Note , * FROM #supers

SELECT DISTINCT u.GroupName
INTO #Acc_CustGroup
FROM #supers c WITH(NOLOCK)
	INNER join CustDB.dbo.Acc_CustGroup u WITH(NOLOCK) ON c.custid= u.custid

--SELECT '#Acc_CustGroup Affected' AS Note , * FROM #Acc_CustGroup

SELECT GroupID
INTO #GroupExt
FROM dbo.eaGroup WITH(NOLOCK)
WHERE GroupName IN (SELECT GroupName FROM #Acc_CustGroup)

--SELECT '#GroupExt Affected' AS Note , * FROM #Acc_CustGroup

--EnableLiveAndRNGCasino
;WITH 
EnableLiveAndRNGCasino_FromPermission AS (
	SELECT FuncID,'EnableLiveAndRNGCasino' AS FuncKey
	FROM eaFunction WITH(NOLOCK) 
	WHERE FuncKey IN ('EnableCasino','EnableLiveCasino','EnableVoidbridge','EnableVirtualGames','EnableSabaclub','EnableVGaming')
)
,EnableLiveAndRNGCasino_ToPermission AS(
	SELECT FuncID,'EnableLiveAndRNGCasino' AS FuncKey
	FROM eaFunction WITH(NOLOCK) 
	WHERE FuncKey IN ('EnableLiveAndRNGCasino')
)
INSERT INTO #PermissionMapping (PermissionFrom, PermissionTo)
SELECT 
	PermissionFrom = v.FuncID,
	PermissionTo = m.FuncID
FROM EnableLiveAndRNGCasino_FromPermission v
	INNER JOIN EnableLiveAndRNGCasino_ToPermission m ON m.FuncKey = v.FuncKey

--LiveAndRNGCasinoBetting
;WITH 
LiveAndRNGCasinoBetting_FromPermission AS (
	SELECT FuncID,'LiveAndRNGCasinoBetting' AS FuncKey
	FROM eaFunction WITH(NOLOCK) 
	WHERE FuncKey IN ('CasinoBetting','LiveCasinoBetting','VoidbridgeBetting','VirtualGamesBetting')
)
,LiveAndRNGCasinoBetting_ToPermission AS(
	SELECT FuncID,'LiveAndRNGCasinoBetting' AS FuncKey
	FROM eaFunction WITH(NOLOCK) 
	WHERE FuncKey IN ('LiveAndRNGCasinoBetting')
)
INSERT INTO #PermissionMapping (PermissionFrom, PermissionTo)
SELECT 
	PermissionFrom = v.FuncID,
	PermissionTo = m.FuncID
FROM LiveAndRNGCasinoBetting_FromPermission v
	INNER JOIN LiveAndRNGCasinoBetting_ToPermission m ON m.FuncKey = v.FuncKey

--LiveAndRNGCasino
;WITH 
LiveAndRNGCasino_FromPermission AS (
	SELECT FuncID,'LiveAndRNGCasino' AS FuncKey
	FROM eaFunction WITH(NOLOCK) 
	WHERE FuncKey IN ('LiveCasinoSetting','VoidbridgeSetting','VirtualGamesSetting','SabaclubSetting','VGamingSetting')
)
,LiveAndRNGCasino_ToPermission AS(
	SELECT FuncID,'LiveAndRNGCasino' AS FuncKey
	FROM eaFunction WITH(NOLOCK) 
	WHERE FuncKey IN ('LiveAndRNGCasino')
)
INSERT INTO #PermissionMapping (PermissionFrom, PermissionTo)
SELECT 
	PermissionFrom = v.FuncID,
	PermissionTo = m.FuncID
FROM LiveAndRNGCasino_FromPermission v
	INNER JOIN LiveAndRNGCasino_ToPermission m ON m.FuncKey = v.FuncKey

--SELECT '#PermissionMapping Affected' AS Note , * FROM #PermissionMapping

UPDATE gpt
SET gpt.Policy = gpf.Policy
--SELECT gpt.* , '______' AS '______' , gpf.*
FROM eaGroupPolicy gpf WITH (NOLOCK)
	INNER JOIN eaGroupPolicy gpt WITH (ROWLOCK) ON gpt.GroupID = gpf.GroupID
	INNER JOIN #GroupExt g ON g.GroupID = gpf.GroupID
	INNER JOIN #PermissionMapping p ON gpf.FuncID = p.PermissionFrom AND gpt.FuncID = p.PermissionTo


UPDATE upt
SET upt.Policy = upf.Policy
--SELECT upt.* , '______' AS '______' , upf.*
FROM eaUserPolicy upf WITH (NOLOCK)
	INNER JOIN eaUserPolicy upt WITH (ROWLOCK) ON upt.UserID = upf.UserID
	INNER JOIN dbo.eaUserInfo u WITH (NOLOCK) ON u.UserID = upf.UserID
	INNER JOIN #GroupExt g ON u.GroupID = g.GroupID
	INNER JOIN #PermissionMapping p ON upf.FuncID = p.PermissionFrom AND upt.FuncID = p.PermissionTo


DROP TABLE #GroupExt
DROP TABLE #PermissionMapping
DROP TABLE #Acc_CustGroup
DROP TABLE #supers

