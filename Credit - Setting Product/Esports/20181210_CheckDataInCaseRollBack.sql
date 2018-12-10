
DECLARE @Sporttype INT
SELECT @Sporttype=43	
DECLARE @BitmapOrder INT
SELECT @BitmapOrder= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype

CREATE TABLE #temp (CustID INT PRIMARY KEY)
CREATE TABLE #temp2 (CustID INT PRIMARY KEY)

INSERT INTO #temp(CustID)
select Distinct custid from DBLOG.bodb_CustomerLog.dbo.UserLog_RunSP WITH(NOLOCK)
 where ActionID IN(638,629,630,1207,400,402,401) 
 AND logdate>'2018-12-10'

INSERT INTO #temp2(CustID)
SELECT ci.custid
FROM [dbo].[CustProductStatus] cs WITH(NOLOCK)
	INNER JOIN #temp c  ON cs.CustID = c.CustID	
	INNER JOIN dbo.custInfo ci WITH(ROWLOCK,UPDLOCK)  ON cs.CustID = ci.CustID	
WHERE 	bitmapIsDisabled <>  (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(bitmapIsDisabled, @BitmapOrder, ISNULL(ci.DisableEsports,1)))

UPDATE ci
	SET DisableEsports = dbo.f_GetProductStatus(bitmapIsDisabled,@BitmapOrder)
FROM [dbo].[CustProductStatus] cs WITH(NOLOCK)
	INNER JOIN #temp2 c WITH(NOLOCK) ON cs.CustID = c.CustID	
	INNER JOIN dbo.custInfo ci WITH(ROWLOCK,UPDLOCK) ON cs.CustID = ci.CustID	

DROP TABLE #temp
DROP TABLE #temp2