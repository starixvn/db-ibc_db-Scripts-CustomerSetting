/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200506@Eden
	Task: Correct missing data of StakeLevel of SA Gaming ,Sexy Gaming, BBIN [Redmine: 132323]
	DB: DBCUST/CustDB
*/
CREATE TABLE #MemberTemp(CustID INT PRIMARY KEY CLUSTERED,currency INT,recommend INT)
CREATE TABLE #SportBettype (SportType INT , Bettype INT)

INSERT INTO #SportBettype (SportType,Bettype)
SELECT 244,3001 --SA Gaming 
UNION ALL SELECT 243,3101 --Sexy Gaming
UNION ALL SELECT 241,3300 --BBIN

--List member wrong StakeLevel
INSERT INTO #MemberTemp (CustID,recommend)
SELECT custid,recommend
FROM Custinfo WITH (NOLOCK)
WHERE roleid = 1  
	AND Enabled = 1 
	AND custid IN (
					42675447
					,42675469
					,42675496
					,42675511
					,42675830
					,42488781
					,42488941
					,42489093
					,42489608
					,42489630
					,42489652
					,42489826
					,42489835
					,42490285
					,42490303
					,42490316
					,42490321
					,42490343
					,42490391
					,42490405
					,42490534
					,42487950
					,42487979
					,42488062
					,42488781
					,42488941
					,42489093
					,42489608
					,42489630
					,42489652
					,42489826
					,42489835
					,42490285
					,42490303
					,42490316
					,42490321
					,42490343
					,42490534
					)

SELECT t.custid,s.SportType,s.BetType,ISNULL(CONVERT(VARCHAR,NULLIF(MIN(CONVERT(INT,st.val)),0)),'') as [StakeLevelList]
INTO #TmpStakelevel
FROM #MemberTemp t 
	INNER JOIN CustStakeLevel_Agent s WITH(NOLOCK) on t.recommend = s.CustID
	CROSS APPLY dbo.f_StringSplit(s.StakeLevelList,',') st
	INNER JOIN #SportBettype sb ON s.SportType = sb.SportType AND s.BetType = sb.Bettype
GROUP BY t.custid,s.SportType,s.BetType

INSERT INTO dbo.CustStakeLevel_Member([CustID],[SportType],[BetType],[StakeLevelList],LastUpdated) 
SELECT t.[CustID],t.[SportType],t.[BetType],t.[StakeLevelList],GETDATE() AS LastUpdated
FROM #TmpStakelevel t
	LEFT JOIN CustStakeLevel_Member c WITH(NOLOCK) ON  t.SportType = c.SportType AND t.BetType = c.BetType AND c.CustID = t.CustID
WHERE c.CustID IS NULL

DROP TABLE #MemberTemp
DROP TABLE #SportBettype
DROP TABLE #TmpStakelevel

