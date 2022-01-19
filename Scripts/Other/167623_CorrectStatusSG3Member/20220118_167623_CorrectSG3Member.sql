/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220118
	Task:  [Spade Gaming] Wrong hidden status of 3 members RedmineID:#167623
	DB: DBCust/CustDB
*/

	DECLARE @BitmapOrder TINYINT = 39
	
	CREATE TABLE #CustList (custid int)
	
	INSERT INTO #CustList(custid)
	SELECT 1890836 AS custid UNION ALL
	SELECT 2600936 AS custid UNION ALL
	SELECT 51887849 AS custid 
	
	UPDATE cs
	SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,1))
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #CustList ci WITH(NOLOCK) ON cs.CustID = ci.CustID
		
	DROP TABLE 	#CustList