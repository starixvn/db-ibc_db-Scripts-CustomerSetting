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
FROM dbo.custInfo ci WITH(NOLOCK)
WHERE ci.custid NOT IN (SELECT CustID FROM Dep_CustSuper)
 AND ci.roleid=4 
 AND ci.Enabled=1

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
