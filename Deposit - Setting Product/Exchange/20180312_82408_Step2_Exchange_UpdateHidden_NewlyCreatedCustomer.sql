/*
	Created: 20170312@Winnie
	Task: Update for new cust
	Redmine: https://redmine.nexcel.vn/issues/82408
	DB: DBCUST/CUSTDB
*/  
------------------------------------------------------

DECLARE @max_custid INT,@SportType INT = 221, @bitmapOrder INT=0

SELECT   @max_custid= xxx ---input maxcustid

SET @bitmapOrder = (SELECT bitmapOrder FROM Dep_ProductStatusProfile WITH(NOLOCK) WHERE Sporttype =  @SportType )

CREATE TABLE #tblCust (custid INT, roleid INT) 

INSERT INTO #tblCust (custid,roleid)			
SELECT ci.custid,roleid
FROM custInfo CI WITH(NOLOCK)
	INNER JOIN Dep_CustSuper CS WITH(NOLOCK) ON ci.srecommend = cs.custid
WHERE ci.mrecommend NOT IN (SELECT custid FROM custinfo cs1 WITH(NOLOCK)
						   WHERE cs1.srecommend=ci.srecommend and cs1.username like '%Acc%' and cs1.roleid=3 )
	AND ci.custid > @max_custid
	AND site in ('alog','12bet')	
	AND  cs.currency IN (3,61)-- Currency H - it is just test currency, used once in a while 

-- Update if exists
UPDATE T 
		SET  bitmapIsHidden = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsHidden, @bitmapOrder,1))
FROM [dbo].[Dep_CustProductStatus] T (ROWLOCK)
	INNER JOIN #tblCust C ON C.custid = T.custid

DROP TABLE #tblCust

