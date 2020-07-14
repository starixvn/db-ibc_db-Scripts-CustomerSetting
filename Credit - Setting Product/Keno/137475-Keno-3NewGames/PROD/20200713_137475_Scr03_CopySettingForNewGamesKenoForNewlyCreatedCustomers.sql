/*
	Created: 20200713@Eden
	Task: Copy new games settings from Max Keno for credit customers - newly created customers [Redmine:#137475]
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
--insert settings for newly customers
DECLARE @srecommend INT,
		@max_custid INT	

SELECT @max_custid = xxx
		
CREATE TABLE #Supers(CustID INT)
CREATE TABLE #tblCust(CustID INT PRIMARY KEY)
DECLARE @tmpGameType TABLE(fromGameTypeID INT, GameTypeID INT)
	
INSERT INTO @tmpGameType(fromGameTypeID,GameTypeID)
SELECT 15, 27
UNION SELECT 15, 28
UNION SELECT 15, 29
						
INSERT INTO #Supers(custid)
SELECT ci.custid 
FROM dbo.customer c WITH (Nolock) 
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
	INNER JOIN dbo.site s WITH(NOLOCK) ON c.site = s.site
WHERE ci.roleid = 4
	AND ci.custid NOT IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK))	
	AND ci.custid NOT IN (SELECT custid FROM dbo.CustSuper WITH(NOLOCK) WHERE isInternal = 1)
	AND ci.Enabled = 1
	AND s.islicensee = 0
	AND ci.currency <> 20 -- Exclude UUS
	AND c.username NOT LIKE '3rdSuper%'
	
INSERT INTO #tblCust(custid)
SELECT custid
FROM dbo.CustInfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND custid > @max_custid	

DELETE cs
FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tblCust ci ON cs.custid = ci.custid
WHERE cs.GameTypeID IN (SELECT GameTypeID FROM @tmpGameType)

INSERT INTO [dbo].[CustGameType]
           ([CustID]
           ,[GameTypeID]
           ,[StakeLevelList]
           ,[MaxPerGameType]
           ,[MinBet]
           ,[MaxBet]
           ,[IsDisabled])
SELECT cg.[CustID]
   ,s.[GameTypeID]
   ,''[StakeLevelList]
   ,cg.[MaxPerGameType]
   ,cg.[MinBet]
   ,cg.[MaxBet]
   ,cg.[IsDisabled]   
FROM dbo.CustGameType cg WITH(NOLOCK)
	INNER JOIN #tblCust t ON cg.custid = t.custid			
	INNER JOIN @tmpGameType s ON cg.GameTypeID = s.fromGameTypeID


												
	
	
	