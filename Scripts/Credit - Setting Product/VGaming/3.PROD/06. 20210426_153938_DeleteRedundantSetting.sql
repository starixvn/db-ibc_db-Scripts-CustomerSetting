/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Delete redundant setting of VGaming [#RM:153938]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

PRINT N'Step 6: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

DECLARE @MaxCustID INT, @Sporttype SMALLINT = 171
	
SELECT @MaxCustID = xxx
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)	
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site IN ('733333','722222','222223','222225')
	AND ci.currency <> 20

DELETE cg
FROM CustPTSetting3rd_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID
						
DELETE cg
FROM CustPTSetting3rd_Member cg WITH(ROWLOCK)		
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID
		
DELETE cg
FROM CustPTGroupSetting3rd_Member cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.AgentID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType = @Sporttype
	AND c.custid > @maxcustID
				
DELETE cg
FROM CustStakeLevel_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID

DELETE cg
FROM CustStakeLevel_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID

DELETE cg
FROM CustWinLossLimit_Agent cg WITH(ROWLOCK)	
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID

DELETE cg
FROM CustWinLossLimit_Member cg WITH(ROWLOCK)
	INNER JOIN Customer c WITH (NOLOCK) ON cg.CustID = c.custid
	INNER JOIN #supers s ON c.srecommend = s.custid	
WHERE SportType = @Sporttype
	AND cg.custid > @maxcustID	

PRINT N'Step 6: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 