/*
	Created: 20210402@Johnson
	Task:  backup NG settings for the list of headlines
	DB: DBCUST/CustDB
*/


CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @tmpBetSetting TABLE(currency INT, MaxBet MONEY, MPM MONEY, MPB MONEY, MaxLoss MONEY)

INSERT INTO @tmpBetSetting(currency,MaxBet,MPM,MPB,MaxLoss)
SELECT 2, 50, 500, 100, 1500 --RM
UNION SELECT 5, 90, 900,180,2700 --HK$
UNION SELECT 13, 90, 900,180,2700 --RMB
UNION SELECT 33, 180,1800,360,5400 --IDD
UNION SELECT 43, 500, 5000,1000,15000 --THB
UNION SELECT 67, 50, 500, 100, 1500 --HKK

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM vw_CustAccount ca WITH(NOLOCK)
	INNER JOIN vw_customer ci WITH(NOLOCK) ON ca.custid = ci.custid
	INNER JOIN custinfo c WITH(NOLOCK) ON ca.custid = c.custid
WHERE ca.groupid in (
	SELECT 	groupID 
	FROM vw_custAccount WITH(NOLOCK)
	WHERE custid IN (SELECT custid 
					FROM custinfo WITH (NOLOCK) 
					WHERE username IN ('CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'))
		   )
	AND ci.roleid = 4
	AND c.enabled = 1
	AND site NOT IN ('789y','IBCIndo','76666b')
	AND ci.currency IN (SELECT currency FROM @tmpBetSetting)

CREATE TABLE tmpCustsetting3rd (custid INT, sporttype INT, maxbet MONEY PRIMARY KEY (custid,sporttype))
	
INSERT INTO tmpCustsetting3rd(custid,sporttype,maxbet)	
SELECT custid, sporttype, maxbet 
FROM custdb.dbo.custsetting3rd with (nolock) 
WHERE custid IN (SELECT custid 
				FROM custdb.dbo.customer WITH (NOLOCK) 
				WHERE srecommend IN (SELECT custid FROM #supers))
	AND sporttype IN (161,164) 
	AND bettype IN (81,8101)	
	
	