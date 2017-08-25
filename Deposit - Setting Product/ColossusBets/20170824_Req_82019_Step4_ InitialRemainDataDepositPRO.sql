/*
	Created: Winnie
	Date: 2017-08-24
	Task: Insert colossus settings for deposit customers
	DB: DBCUST/CustDB
*/ 

------------------------------------------------------	
CREATE TABLE #tempCust(custid int,roleid int)
CREATE TABLE #tempBettype(bettype INT, Rate DECIMAL(9,8))
DECLARE @Sporttype INT
	SELECT @Sporttype=204

INSERT INTO #tempBettype(bettype,Rate)
VALUES (18001,0.1215)
INSERT INTO #tempBettype(bettype,Rate)
VALUES (18002,0.45)

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid= xxx

INSERT INTO #tempCust(custid,roleid)
SELECT custid,c.roleid
FROM dbo.custInfo c WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM dbo.Dep_CustSuper WITH(NOLOCK) WHERE site in ('Leon','Sungame') )	 
	AND Enabled=1
	AND custid NOT IN (SELECT Custid FROM dbo.Dep_AgentCommRate  da WITH(NOLOCK) WHERE SportType=204)
	AND custid NOT IN (SELECT Custid FROM dbo.Dep_CustCommRate  da WITH(NOLOCK) WHERE SportType=204)
	AND custid>@max_custid

INSERT INTO dbo.Dep_AgentCommRate 
			([CustID]
			,[SportType]
			,[BetType]
			,[CommRate])
SELECT  custid,@Sporttype,bettype,Rate
FROM #tempCust
CROSS APPLY #tempBettype
WHERE roleid IN(2,3,4)

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
WHERE roleid =1
-------------------------------------------------

