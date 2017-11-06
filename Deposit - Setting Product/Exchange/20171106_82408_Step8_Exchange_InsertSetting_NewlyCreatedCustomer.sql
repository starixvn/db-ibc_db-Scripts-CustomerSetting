/*
	Created: 20171106@Winnie
	Task: insert the Setting of BetradarVS of new licensees into the DCS database.
	Redmine: https://redmine.nexcel.vn/issues/77274
	DB: DBCUST/CUSTDB
*/  
------------------------------------------------------

CREATE TABLE #supers (custid INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @max_custid INT, @srecommend INT,  @currency INT ,@SportType INT = 221, @bitmapOrder INT=0

SELECT   @max_custid= xxx ---input maxcustid

SET @bitmapOrder = (SELECT bitmapOrder FROM Dep_ProductStatusProfile WITH(NOLOCK) WHERE Sporttype =  @SportType )

CREATE TABLE #tblCust_member (custid INT,agentid INT, roleid INT,currency INT,srecommend INT,maxpermatch180 MONEY) 

INSERT INTO #tblCust_member (custid,agentid,roleid,currency,srecommend,maxpermatch180)			
SELECT ci.custid,ci.recommend,roleid,ci.currency, ci.srecommend,CI.maxpermatch180
FROM custInfo CI WITH(NOLOCK)
	INNER JOIN Dep_CustSuper CS WITH(NOLOCK) ON ci.srecommend = cs.custid
WHERE ci.mrecommend NOT IN (SELECT custid FROM custinfo cs1 WITH(NOLOCK)
						   WHERE cs1.srecommend=ci.srecommend and cs1.username like '%Acc%' and cs1.roleid=3 )
	AND ci.custid > @max_custid
	AND site in ('alog','12bet')	
	AND  cs.currency IN (3,20,61)-- Currency H - it is just test currency, used once in a while 

-- Update if exists
UPDATE T 
		SET bitmapIsDisabled = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsDisabled, @bitmapOrder,0)) 
			, bitmapIsHidden = (SELECT * FROM f_CustSetting_GenerateProductStatus (t.bitmapIsHidden, @bitmapOrder,0))
FROM [dbo].[Dep_CustProductStatus] T (ROWLOCK)
	INNER JOIN #tblCust_member C ON C.custid = T.custid

DROP TABLE #tblCust_member

