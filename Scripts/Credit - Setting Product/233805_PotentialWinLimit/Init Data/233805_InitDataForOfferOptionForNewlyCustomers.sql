/*<info serverAlias="DBCUST-CustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250725@Johnson	
	Task: Update OfferOption = 0 for customers [redmine:#230652]
	DB: DBCUST-CustDB
*/
set NOCOUNT on ;

CREATE TABLE #supers (custid int,isfinished bit default(0))
CREATE TABLE #tblCust(CustID INT PRIMARY KEY CLUSTERED)
CREATE TABLE #tmpCust (CustID INT PRIMARY KEY CLUSTERED)

DECLARE @__waiforDelayStr VARCHAR(50)
SELECT @__waiforDelayStr = [dbo].[f_DelayTime]('CS_Adhoc')

DECLARE @max_custid INT

SELECT @max_custid = xxx

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
	--AND ci.custid <= @max_custid
	--AND ci.currency = 20

INSERT INTO #tblCust (CustID)
SELECT ci.custid
FROM Custinfo ci WITH (NOLOCK)
    INNER JOIN CustPotentialWinLimit cs WITH(NOLOCK) ON ci.custid = cs.custid
WHERE ci.srecommend IN (SELECT custid FROM #supers)
    AND ci.Enabled = 1 
    AND ci.custid > @max_custid
    AND cs.OfferOption IS NULL
    
WHILE(1=1)
BEGIN
    DELETE TOP (1000) t
    OUTPUT DELETED.CustID INTO #tmpCust(custid)
    FROM #tblCust t        

    IF @@ROWCOUNT = 0 BREAK 

    UPDATE CustPotentialWinLimit WITH (ROWLOCK)
    SET OfferOption = 0,
        RepUpdateTime = dbo.f_GetDateTime2()
    WHERE custid IN (SELECT CustID FROM #tmpCust)           

    DELETE FROM #tmpCust   

    WAITFOR DELAY @__waiforDelayStr -- waifor adhoc script 
END			    		

DROP TABLE #tblCust
DROP TABLE #tmpCust
DROP TABLE #supers
GO

