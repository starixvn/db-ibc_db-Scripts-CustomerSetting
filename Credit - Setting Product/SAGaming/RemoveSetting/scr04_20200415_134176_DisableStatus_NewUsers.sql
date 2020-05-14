/*
	Created: 20200514@Tiara
	Date: 20200514
	Task:  Disable status of SA Gaming for HK$, RMB, HKK - New users[Redmine: #134176]
	DB: DBCUST/CustDB
*/
PRINT N'Step 7: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @ProductID TINYINT = 41, @Sporttype INT = 244
DECLARE @MaxCustID INT, @fSportType SMALLINT, @fBetType SMALLINT


SELECT @MaxCustID = xxx

CREATE TABLE #supers (custid int)

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
			AND ci.Site<>'CN88'
			AND ci.currency IN (5,13,67)--HK$, RMB, HKK


/*******************************CUST PRODUCTSTATUS TABLE*******************************/
DECLARE @BitmapOrder TINYINT = 20

SELECT custid, ci.roleid, ci.srecommend
INTO #CustList
FROM dbo.custInfo ci WITH (NOLOCK)
WHERE ci.srecommend IN (SELECT custid FROM #supers) AND custid > @MaxCustID AND Enabled = 1

UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,1)),
		bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,1)) 	
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 20) as isDisabled
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsHidden, 20) as IsHidden
WHERE isDisabled.value = 0 OR IsHidden.value = 0



DROP TABLE #supers
DROP TABLE #CustList

PRINT N'Step 7: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
