/*
	Created: 20171215@Winnie
	Task: insert the Setting of Exchange of new licensees into the DCS database. UAT
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
	AND site in ('alog','12bet','spondemo','Athena000')	
	AND  cs.currency =20 -- Currency H - it is just test currency, used once in a while 

-- Update if exists
UPDATE T 
		SET bitmapIsDisabled = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsDisabled, @bitmapOrder,0)) 
			, bitmapIsHidden = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsHidden, @bitmapOrder,0))
FROM [dbo].[Dep_CustProductStatus] T (ROWLOCK)
	INNER JOIN #tblCust C ON C.custid = T.custid

INSERT INTO [dbo].[Dep_CustDiscountSetting_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[Discount])
SELECT c.custid,221,8001,0.02
FROM #tblCust c WITH(NOLOCK)
WHERE c.roleid IN(2,3,4)

DROP TABLE #tblCust

