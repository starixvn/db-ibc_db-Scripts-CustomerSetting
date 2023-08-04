/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230802
	Task: YeeBet - Change Bet Limit [Redmine: #191947]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @max_custid INT = xxx

CREATE TABLE #stakelevel(excludedStakeLevelID INT, lowerStakeLevelID INT, currency INT)

INSERT INTO #stakeLevel(excludedStakeLevelID, lowerStakeLevelID, currency)
SELECT stakelevelid, NULL AS lowerStakeLevelID, ExchangeId
FROM dbo.StakeLevel WITH (NOLOCK)																
WHERE ExchangeId IN (67, 5, 2, 13, 16, 64, 3, 69, 45, 43)
	AND GameTypeID = 3151
	AND MinStake = CASE WHEN exchangeid IN (67, 5, 2, 13) THEN 100	--HKK, HK$, RM, RMB
						WHEN exchangeid IN (16, 64, 3, 69) THEN 50	--Yen, UT, US$, MMK
						WHEN exchangeid = 45 THEN 30000 			--Won
						WHEN exchangeid = 43 THEN 800 END			--THB
	AND MaxStake = CASE WHEN exchangeid IN (67, 5, 2, 13) THEN 40000
						WHEN exchangeid IN (16, 64, 3, 69) THEN 10000 
						WHEN exchangeid = 45 THEN 10000000
						WHEN exchangeid = 43 THEN 200000 END
UPDATE t 
SET t.lowerStakeLevelID = s.StakeLevelID
FROM #stakeLevel t 	
	CROSS APPLY dbo.StakeLevel s														
		WHERE GameTypeID = 3151
		AND t.currency = s.ExchangeId
		AND MinStake = CASE WHEN exchangeid IN (67, 5, 2, 13) THEN 50	--HKK, HK$, RM, RMB
							WHEN exchangeid IN (16, 64, 3, 69) THEN 20	--Yen, UT, US$, MMK
							WHEN exchangeid = 45 THEN 20000 			--Won
							WHEN exchangeid = 43 THEN 400 END			--THB
		AND MaxStake = CASE WHEN exchangeid IN (67, 5, 2, 13) THEN 20000
							WHEN exchangeid IN (16, 64, 3, 69) THEN 5000 
							WHEN exchangeid = 45 THEN 5000000 
							WHEN exchangeid = 43 THEN 100000 END

CREATE TABLE #supers(custid INT PRIMARY KEY, currency INT, excludedStakeLevelID INT, lowerStakeLevelID INT)

INSERT INTO #supers(custid, currency, excludedStakeLevelID, lowerStakeLevelID)
SELECT ci.custid, ci.currency, sl.excludedStakeLevelID, sl.lowerStakeLevelID
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN CustSuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN dbo.CustStakeLevel_Agent ca WITH (NOLOCK) ON ci.custid = ca.CustID				
	CROSS APPLY strSplit(ISNULL(StakelevelList,''),',') st
	CROSS APPLY #stakeLevel sl
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.roleid = 4
	AND ci.Enabled = 1
	AND ci.currency IN (67, 5, 2, 13, 16, 64, 3, 69, 45, 43)
	AND ca.Sporttype = 159 AND ca.Bettype = 3151
	AND st.val IN (SELECT excludedStakeLevelID FROM #stakeLevel)
	AND sl.currency = ci.currency

CREATE TABLE #CustStakeLevelDownlines_Agent(
				CustID INT 
				,srecommend INT
				,DirectUplineID INT		
				,roleid TINYINT
				,Bettype SMALLINT
				,StakeLevelList VARCHAR(100)
				,StakeLevelList_new VARCHAR(100)							
				, PRIMARY KEY CLUSTERED(CustID,Bettype)
		)

CREATE TABLE #CustStakeLevelDownlines_Member(
			CustID INT 
			,srecommend INT
			,DirectUplineID INT		
			,roleid TINYINT
			,Bettype SMALLINT
			,StakeLevelList VARCHAR(100)
			,StakeLevelList_new VARCHAR(100)							
			, PRIMARY KEY CLUSTERED(CustID,Bettype)
	)		

INSERT INTO #CustStakeLevelDownlines_Agent(CustID, srecommend, DirectUplineID, roleid, Bettype, StakeLevelList, StakeLevelList_new)
SELECT ci.custid, ci.srecommend,
		CASE 
			WHEN ci.roleid = 3 THEN srecommend
			WHEN ci.roleid = 2 THEN mrecommend				 	
		END AS DirectUplineID,		
		ci.roleid,cs.Bettype,cs.StakeLevelList,cs.StakeLevelList
FROM dbo.custinfo ci WITH(NOLOCK)
	INNER JOIN dbo.CustStakeLevel_Agent cs WITH(NOLOCK) ON ci.custid = cs.custid		
	INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE
	ci.roleid IN (2,3,4)
	AND ci.custid > @max_custid
	AND cs.SportType = 159
	AND cs.Bettype = 3151
		
INSERT INTO #CustStakeLevelDownlines_Member(CustID, srecommend, DirectUplineID, roleid, Bettype, StakeLevelList, StakeLevelList_new)
SELECT ci.custid, ci.srecommend,
		recommend as DirectUplineID,		
		ci.roleid,cs.bettype,cs.StakeLevelList,cs.StakeLevelList
FROM dbo.custinfo ci WITH(NOLOCK)
	INNER JOIN dbo.CustStakeLevel_Member cs WITH(NOLOCK) ON ci.custid = cs.custid		
	INNER JOIN #supers s ON ci.srecommend = s.custid
WHERE
	ci.roleid = 1
	AND ci.custid > @max_custid
	AND cs.SportType = 159
	AND cs.Bettype = 3151

--Current customer is assigned several bet limits which contain the removed bet limit => Remove the required bet limit
--Agent
UPDATE cs
SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(excludedStakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
FROM #CustStakeLevelDownlines_Agent cs											
	CROSS APPLY #supers s 
WHERE s.custid = cs.srecommend

--Member
UPDATE cs
SET cs.StakeLevelList_new = ISNULL(REVERSE(STUFF(REVERSE(REPLACE(cs.StakeLevelList+',',CAST(excludedStakeLevelID as VARCHAR(10))+',','')),1,1,'')),'')
FROM #CustStakeLevelDownlines_Member cs											
		CROSS APPLY #supers s 
WHERE s.custid = cs.srecommend

--Current customer is assigned only the bet limit which needs to be removed => Remove it and assign the adjacent lower bet limit from the upline
--Current customer is super => Remove and assign adjacent lower bet limit in gdoc
UPDATE cs
SET cs.StakeLevelList_new = CAST(lowerStakeLevelID as VARCHAR(10)) 
FROM #CustStakeLevelDownlines_Agent cs						
	CROSS APPLY #supers s
WHERE s.custid = cs.srecommend
	AND StakeLevelList <> StakeLevelList_new
	AND StakeLevelList_new = ''
	AND cs.roleid = 4

--Current customer is assigned only the bet limit which needs to be removed => Remove it and assign the adjacent lower bet limit from the upline
--Master	
UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevelDownlines_Agent T
	INNER JOIN #CustStakeLevelDownlines_Agent Upline ON t.DirectUplineID = Upline.CustID 
											AND Upline.StakeLevelList_new <> ''			 		
	CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
				FROM (SELECT CAST(val AS INT) AS val
						FROM strSplit(Upline.StakeLevelList_new,','))  cd
						INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID					
						WHERE SL.MinStake <> 0 AND SL.MaxStake <> 0
					ORDER BY SL.maxstake DESC
				) T1 -- Direct Upline
WHERE t.roleid = 3
	AND T.StakeLevelList_new = ''
	AND T.StakeLevelList <> T.StakeLevelList_new

--Agent		
UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevelDownlines_Agent T
	INNER JOIN #CustStakeLevelDownlines_Agent Upline ON t.DirectUplineID = Upline.CustID 
											AND Upline.StakeLevelList_new <> ''			 
		
	CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
				FROM (SELECT CAST(val AS INT) AS val
						FROM strSplit(Upline.StakeLevelList_new,','))  cd
						INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID					
						WHERE SL.MinStake <> 0 AND SL.MaxStake <> 0
					ORDER BY SL.maxstake DESC
				) T1 -- Direct Upline
WHERE t.roleid = 2
	AND T.StakeLevelList_new = ''
	AND T.StakeLevelList <> T.StakeLevelList_new

--Member		
UPDATE T
	SET StakeLevelList_new = T1.DownlineStakeLevelList_new
FROM #CustStakeLevelDownlines_Member T
	INNER JOIN #CustStakeLevelDownlines_Agent Upline ON t.DirectUplineID = Upline.CustID								
											AND Upline.StakeLevelList_new <> ''			 
		
	CROSS APPLY(SELECT TOP 1 ISNULL(CONVERT(varchar(20),SL.StakeLevelID),'') AS DownlineStakeLevelList_new
				FROM (SELECT CAST(val AS INT) AS val
						FROM strSplit(Upline.StakeLevelList_new,','))  cd
						INNER JOIN dbo.StakeLevel SL WITH(NOLOCK) ON cd.val = sl.StakeLevelID							
						WHERE SL.MinStake <> 0 AND SL.MaxStake <> 0
					ORDER BY SL.maxstake DESC
				) T1 -- Direct Upline
WHERE t.roleid = 1
	AND T.StakeLevelList_new = ''
	AND T.StakeLevelList <> T.StakeLevelList_new
	
--Current customer doesn't have bet limit => Unchange
--Agent
DELETE t											
FROM #CustStakeLevelDownlines_Agent t
WHERE t.StakeLevelList = t.StakeLevelList_new

--Member
DELETE t											
FROM #CustStakeLevelDownlines_Member t
WHERE t.StakeLevelList = t.StakeLevelList_new

UPDATE cs
SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
FROM dbo.CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)									
	INNER JOIN #CustStakeLevelDownlines_Agent dl ON cs.CustID = dl.CustID 
											AND cs.bettype = dl.bettype


UPDATE cs
SET cs.StakeLevelList = ISNULL(dl.StakeLevelList_new,'')
FROM dbo.CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)								
	INNER JOIN #CustStakeLevelDownlines_Member dl ON cs.CustID = dl.CustID 
											AND cs.bettype = dl.bettype

DROP TABLE #CustStakeLevelDownlines_Agent
			,#CustStakeLevelDownlines_Member
			,#stakelevel
			,#supers