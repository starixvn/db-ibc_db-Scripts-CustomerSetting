/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20221007@Johnson
	Task: Migrate data for balance game tables for SITEDB2 to scale out DBTXN for CWL phase 4 [#RedmineID:#175278]
	DB: DBSIG/bodb02 (sitedb2)
*/
CREATE TABLE #tmp_cust
		(
			custid INT PRIMARY KEY
		)
		
------------------------------------------------
INSERT INTO #tmp_cust (custid)
SELECT DISTINCT custid
FROM CustDB.dbo.Customer WITH (NOLOCK)
WHERE site IN ('OneSports',
				'9Club',
				'X2Dynamic',
				'Macaubet'
				)
	and roleid = 1
	
IF NOT EXISTS (SELECT TOP (1) 1 FROM bodb02_tmp.dbo.BalancePendingCreditGame WITH(NOLOCK))
	AND NOT EXISTS (SELECT TOP (1) 1 FROM bodb02_tmp.dbo.BalancePendingDebitGame WITH(NOLOCK))
BEGIN
	INSERT INTO [dbo].[Winlimit_CreditGame]
			   ([custid]
			   ,[winlostdate]
			   ,[Winlost]
			   ,[bettype])
	SELECT [custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype]
	FROM bodb02_tmp.dbo.Winlimit_CreditGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)
	
	INSERT INTO [dbo].[Winlimit_DebitGame]
			   ([custid]
			   ,[winlostdate]
			   ,[Winlost]
			   ,[bettype])
	SELECT [custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype]
	FROM bodb02_tmp.dbo.Winlimit_DebitGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)
END		   

DROP TABLE #tmp_cust