/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20231120
	Task: [Diamond] Disable AdvantPlay & AdvantPlay mini - New customer
		- Disabled status for DiamondSuperINH
		https://nexdev.net/issues/196503
	DB: DBCust/CustDB
*/
----------------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
PRINT N'--------------------------------------------------------'
----------------------------------------------------------------------------------------------
DECLARE @Cust_cnt	INT,
		@max_custid INT

SELECT @max_custid = xxx
	
CREATE TABLE #Customer(CustID INT PRIMARY KEY)

---------------------------------------------------------------------------------------------
INSERT INTO #Customer(custid)
SELECT ci.custid
FROM custInfo ci WITH(NOLOCK)
INNER JOIN Dep_CustSuper cs WITH(NOLOCK) ON cs.custid=ci.srecommend
INNER JOIN Dep_CustProductStatus d WITH (NOLOCK) ON D.CustID=Ci.custid
WHERE  ci.Enabled=1 AND cs.site = 'Diamond' AND ci.currency=51
AND ci.custid>@max_custid
---------------------------------------------------------------------------------------------

SELECT @Cust_cnt = COUNT(1)
FROM #Customer

DECLARE @msg_total NVARCHAR(200) = 'Total of New Customers Affected: %d.'

RAISERROR (@msg_total, 0, 1, @Cust_cnt) WITH NOWAIT
	
DECLARE @xmlStrHidden XML
	
SET @xmlStrHidden = (
		SELECT DISTINCT
			bitmap AS '@b', 
			1 AS '@s'
		FROM (SELECT 27 AS bitmap	--Advantplay
				UNION
				SELECT 29 AS bitmap	--Advantplay Mini
			) vh 
		FOR XML PATH ('r'), ROOT ('root')
		)

UPDATE cs
SET	bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrHidden)))
FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
INNER JOIN #Customer c ON cs.CustID = c.CustID 

PRINT N'--------------------------------------------------------'
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';
GO