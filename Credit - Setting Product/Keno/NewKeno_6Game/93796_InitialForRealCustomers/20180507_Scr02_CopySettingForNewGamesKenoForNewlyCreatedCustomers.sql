/*
	Created: Johnson
	Date: 2018-05-07
	Task: copy settings for new games of Keno for newly created customers (in UM)
	DB: DBCUST/CUSTDB
*/
--insert global settings
INSERT INTO [dbo].[ProductBetSetting]
           ([Sporttype]
           ,[Bettype]
           ,[Currency]
           ,[MinBet]
           ,[IsDep]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[DefaultMinBet]
           ,[DefaultMaxBet]
           ,[DefaultMaxPerMatch])
SELECT 	[Sporttype]
	   ,t.[Bettype]
	   ,[Currency]
	   ,[MinBet]
	   ,[IsDep]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[DefaultMinBet]
	   ,[DefaultMaxBet]
	   ,[DefaultMaxPerMatch]	
FROM [dbo].[ProductBetSetting] p WITH(NOLOCK)
	CROSS APPLY (SELECT 1517 as Bettype
			UNION SELECT 1519 as Bettype
			UNION SELECT 1520 as Bettype
			UNION SELECT 1521 as Bettype
			UNION SELECT 1522 as Bettype
			UNION SELECT 1524 as Bettype			
			) t
WHERE p.sporttype = 202 
	AND p.bettype = 1515
	AND currency <> 20
GO

--insert settings for newly customers
DECLARE @srecommend INT,
		@max_custid INT	

SELECT @max_custid = xxx
		
CREATE TABLE #Supers(CustID INT)
CREATE TABLE #tblCust(CustID INT PRIMARY KEY)
DECLARE @tmpGameType TABLE(fromGameTypeID INT, GameTypeID INT)
	
INSERT INTO @tmpGameType(fromGameTypeID,GameTypeID)
SELECT 15, 17
UNION SELECT 15, 19
UNION SELECT 15, 20
UNION SELECT 15, 21
UNION SELECT 15, 22
UNION SELECT 15, 24
						
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
	AND ci.currency <> 20--exclude UUS
	AND c.username NOT LIKE '3rdSuper%'
	
INSERT INTO #tblCust(custid)
SELECT custid
FROM dbo.CustInfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #Supers)
	AND custid > @max_custid	

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
   ,[MaxPerGameType]
   ,[MinBet]
   ,[MaxBet]
   ,[IsDisabled]   
FROM dbo.CustGameType cg WITH(NOLOCK)
	INNER JOIN #tblCust t ON cg.custid = t.custid			
	INNER JOIN @tmpGameType s ON cg.GameTypeID = s.fromGameTypeID
	LEFT JOIN dbo.CustGameType cg2 WITH(NOLOCK) ON cg2.custid = t.custid
												AND cg2.GameTypeID = s.GameTypeID
WHERE cg2.custid IS NULL


												
	
	
	