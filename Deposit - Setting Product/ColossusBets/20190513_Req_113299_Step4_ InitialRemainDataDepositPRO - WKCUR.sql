/*
	Created: Winnie
	Date: 2019-05-13
	Task: Insert colossus settings for deposit customers
	DB: DBCUST/CustDB
*/ 

------------------------------------------------------	
DECLARE @max_custid INT

SELECT @max_custid = xxx

CREATE TABLE #tempCust(custid int,roleid int)
CREATE TABLE #tempBettype(bettype INT, Rate DECIMAL(9,8))
DECLARE @Sporttype SMALLINT
	
SELECT @Sporttype=204

INSERT INTO #tempBettype(bettype,Rate)
VALUES (18001,0.1215)
INSERT INTO #tempBettype(bettype,Rate)
VALUES (18002,0.45)

INSERT INTO #tempCust(custid,roleid)
SELECT custid,c.roleid
FROM dbo.custInfo c WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK) WHERE site='WKCUR'  AND currency IN (4,13,20,51))	 
	AND Enabled=1
	AND custid > @max_custid

INSERT INTO dbo.Dep_AgentCommRate 
			([CustID]
			,[SportType]
			,[BetType]
			,[CommRate])
SELECT  custid,@Sporttype,bettype,Rate
FROM #tempCust
	CROSS APPLY #tempBettype
WHERE roleid IN (2,3,4)

INSERT INTO dbo.[Dep_CustCommRate]
			([CustId]
			,[Sporttype]
			,[Bettype]
			,[sdiscount]
			,[adiscount]
			,[discount]
			,[playerdiscount])    
SELECT  custid,@Sporttype,bettype,Rate,Rate,Rate,0
FROM #tempCust
	CROSS APPLY #tempBettype
WHERE roleid = 1
-------------------------------------------------

UPDATE dbo.custInfo WITH(ROWLOCK,UPDLOCK)	
SET DisableColossusBet = 0, HideColossusBet = 0
WHERE srecommend IN (	SELECT custid 
						FROM dbo.Dep_CustSuper cs WITH(NOLOCK)							
						WHERE cs.site ='WKCUR'  AND currency IN (4,13,20,51))
	AND Enabled=1 AND custid > @max_custid