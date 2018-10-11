/*
	Created: Winnie
	Task: Copy Status for Esports RedmineID: #101526
	DB: DBCUST/CustDB
	Date: 20180920
*/ 

DECLARE @maxcustid INT
	
SELECT @maxcustid = xxx
CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND cs.isinternal = 0
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0


DECLARE @Sporttype INT
SELECT @Sporttype=43	
DECLARE @BitOrder INT
SELECT @BitOrder= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype
	
UPDATE cs
SET								
		bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
		bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,[DisableEsports])
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN custInfo CI WITH (NOLOCK) ON cs.CustID = ci.CustID
WHERE ci.srecommend IN(SELECT custid FROM #supers)
	AND ci.custid>@maxcustid AND ci.Enabled=1	

DROP TABLE #supers
