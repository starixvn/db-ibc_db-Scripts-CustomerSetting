/*
	Created by: Eden
	Date: 2019-12-03
	Task: get Statistic of Bet setting for SB,NG,Keno
	Database: DBCUST/CUSTDB
*/ 

--> Get Statistic of SB MemberSportbettype level
if OBJECT_ID('tempdb..#TEMP') IS NOT NULL DROP TABLE #TEMP
SELECT a2.custid 
	,a.sporttype,a.bettype--,a.islive
	,SUM(	CASE    WHEN a.sporttype = 1					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch <> ag.maxpermatch			) THEN 1	
					WHEN a.sporttype = 2					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch2 <> ag.maxpermatch2		) THEN 1 	
					WHEN a.sporttype = 3					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch3 <> ag.maxpermatch3		) THEN 1 	
					WHEN a.sporttype = 5					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch5 <> ag.maxpermatch5		) THEN 1 	
					WHEN a.sporttype = 8					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch8 <> ag.maxpermatch8		) THEN 1 	
					WHEN a.sporttype = 10					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch10 <> ag.maxpermatch10		) THEN 1 	
					WHEN a.sporttype = 11					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch11 <> ag.maxpermatch11		) THEN 1 	
					WHEN a.sporttype = 99 and a.bettype = 1 AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch99 <> ag.maxpermatch99		) THEN 1 	
					WHEN a.sporttype = 99 and a.bettype = 9 AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.MaxPerMatch99MP <> ag.MaxPerMatch99MP	) THEN 1 	
		ELSE 0 END) AS DiffCount
		,COUNT(1) as AllCount
 INTO #temp
 FROM Dep_CustSetting a WITH(NOLOCK)
	INNER JOIN custinfo c WITH(NOLOCK) On a.custid = c.custid AND c.roleid = 1
	INNER JOIN custinfo ag WITH(NOLOCK) ON ag.custid = c.recommend
	INNER JOIN Dep_CustSetting a2 WITH(NOLOCK) ON ag.custid = a2.custid and a.sporttype = a2.sporttype and a.bettype = a2.bettype and a.islive = a2.islive
WHERE ((a.SportType IN (1,2,3,5,8,10,11,99) and a.bettype = 1 and a.islive = 0) 
		OR	(a.SportType = 99 and a.bettype = 9))
GROUP by a2.custid,a.sporttype,a.bettype
ORDER BY a2.custid,a.sporttype,a.bettype

SELECT  SUM(DiffCount)*100.00/SUM(AllCount) AS AVG_DiffBetSettingPercent
		,SUM(DiffCount) as SB_MemberSportBettypeDiffBetSetting
		,SUM(AllCount) AS SB_AllMemberSportBettype 
FROM #temp



--> Get Statistic of  SB Member level
if OBJECT_ID('tempdb..#TEMP2') IS NOT NULL DROP TABLE #TEMP2
if OBJECT_ID('tempdb..#TEMP3') IS NOT NULL DROP TABLE #TEMP3
SELECT a2.custid as custid2 ,a.custid
	,SUM(	CASE    WHEN a.sporttype = 1					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch <> ag.maxpermatch			) THEN 1	
					WHEN a.sporttype = 2					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch2 <> ag.maxpermatch2		) THEN 1 	
					WHEN a.sporttype = 3					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch3 <> ag.maxpermatch3		) THEN 1 	
					WHEN a.sporttype = 5					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch5 <> ag.maxpermatch5		) THEN 1 	
					WHEN a.sporttype = 8					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch8 <> ag.maxpermatch8		) THEN 1 	
					WHEN a.sporttype = 10					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch10 <> ag.maxpermatch10		) THEN 1 	
					WHEN a.sporttype = 11					AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch11 <> ag.maxpermatch11		) THEN 1 	
					WHEN a.sporttype = 99 and a.bettype = 1 AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.maxpermatch99 <> ag.maxpermatch99		) THEN 1 	
					WHEN a.sporttype = 99 and a.bettype = 9 AND (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet	OR c.MaxPerMatch99MP <> ag.MaxPerMatch99MP	) THEN 1 	
		ELSE 0 END) AS DiffCount
 INTO #TEMP2
 FROM Dep_CustSetting a WITH(NOLOCK)
	INNER JOIN custinfo c WITH(NOLOCK) On a.custid = c.custid AND c.roleid = 1
	INNER JOIN custinfo ag WITH(NOLOCK) ON ag.custid = c.recommend
	INNER JOIN Dep_CustSetting a2 WITH(NOLOCK) ON ag.custid = a2.custid and a.sporttype = a2.sporttype and a.bettype = a2.bettype and a.islive = a2.islive
WHERE ((a.SportType IN (1,2,3,5,8,10,11,99) and a.bettype = 1 and a.islive = 0) 
		OR	(a.SportType = 99 and a.bettype = 9))
GROUP by a2.custid,a.custid
ORDER BY a2.custid,a.custid

SELECT custid2
	 ,SUM(CONVERT(INT,CONVERT(BIT,DiffCount))) AS DiffCount
	 ,COUNT(1) AS AllCount
INTO #Temp3
FROM #TEMP2 
GROUP by custid2

SELECT  SUM(DiffCount)*100.00/SUM(AllCount) AS AVG_DiffBetSettingPercent
		,SUM(DiffCount) as SB_MemberDiffBetSetting
		,SUM(AllCount) AS SB_AllMember 
FROM #temp3


--> Get Statistic of NG
if OBJECT_ID('tempdb..#TEMP4') IS NOT NULL DROP TABLE #TEMP4
SELECT a2.custid 
	,a.sporttype,a.bettype--,a.islive
	,SUM(CASE   WHEN (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet OR c.maxpermatch161 <> ag.maxpermatch161 OR c.MaxPerBall161 <> ag.MaxPerBall161) THEN 1	
				ELSE 0 END) AS DiffCount
		,COUNT(1) as AllCount
 INTO #TEMP4
 FROM Dep_CustSetting3rd a WITH(NOLOCK)
	INNER JOIN custinfo c WITH(NOLOCK) On a.custid = c.custid AND c.roleid = 1
	INNER JOIN custinfo ag WITH(NOLOCK) ON ag.custid = c.recommend
	INNER JOIN Dep_CustSetting3rd a2 WITH(NOLOCK) ON ag.custid = a2.custid and a.sporttype = a2.sporttype and a.bettype = a2.bettype and a.islive = a2.islive
WHERE (a.SportType = 161 and a.bettype = 81 and a.islive = 0) 
GROUP by a2.custid,a.sporttype,a.bettype
ORDER BY a2.custid,a.sporttype,a.bettype

SELECT  SUM(DiffCount)*100.00/SUM(AllCount) AS AVG_DiffBetSettingPercent
		,SUM(DiffCount) as NG_MemberDiffBetSetting
		,SUM(AllCount) AS NG_AllMember 
FROM #temp4

--> Get Statistic of Keno
if OBJECT_ID('tempdb..#TEMP5') IS NOT NULL DROP TABLE #TEMP5
SELECT a2.custid 
	,a.GameTypeID
	,SUM(CASE   WHEN (a.minbet <> a2.minbet OR a.maxbet <> a2.maxbet OR a.MaxPerGameType <> a2.MaxPerGameType ) THEN 1	
				ELSE 0 END) AS DiffCount
		,COUNT(1) as AllCount
 INTO #TEMP5
 FROM CustGameType a WITH(NOLOCK)
	INNER JOIN custinfo c WITH(NOLOCK) On a.custid = c.custid AND c.roleid = 1
	INNER JOIN custinfo ag WITH(NOLOCK) ON ag.custid = c.recommend
	INNER JOIN CustGameType a2 WITH(NOLOCK) ON ag.custid = a2.custid and a.GameTypeID = a2.GameTypeID
WHERE (a.GameTypeID = 1) 
GROUP by a2.custid,a.GameTypeID
ORDER BY a2.custid,a.GameTypeID

SELECT  SUM(DiffCount)*100.00/SUM(AllCount) AS AVG_DiffBetSettingPercent
		,SUM(DiffCount) as Keno_MemberDiffBetSetting
		,SUM(AllCount) AS Keno_AllMember 
FROM #temp5