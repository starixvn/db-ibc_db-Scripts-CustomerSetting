/*<info serverAlias="DBCTG-bodb02"></info>*/
/*
	Created: 20220829@Johnson
	Task: Prepare data for 2 site migrate to sitedb phase 2 [#RedmineID:#175278]
	DB: DBCTG/bodb02
*/
IF NOT EXISTS (SELECT TOP (1) 1 FROM dbo.BalancePendingCreditGame WITH(NOLOCK))
	AND NOT EXISTS (SELECT TOP (1) 1 FROM dbo.BalancePendingDebitGame WITH(NOLOCK))
BEGIN
	CREATE TABLE #tmp_cust
		(
			custid INT PRIMARY KEY
		)
		
	------------------------------------------------
	INSERT INTO #tmp_cust (custid)
	SELECT DISTINCT custid
	FROM CustDB.dbo.Customer WITH (NOLOCK)
	WHERE site IN ('Heaven','Bobo88')
		and roleid = 1
		
	SELECT [custid],[winlostdate],[Winlost],[bettype]
	INTO SiteDBtmp.dbo.Winlimit_CreditGame_20220915
	FROM dbo.Winlimit_CreditGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)

	SELECT [custid],[winlostdate],[Winlost],[bettype]
	INTO SiteDBtmp.dbo.Winlimit_DebitGame_20220915
	FROM dbo.Winlimit_DebitGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)	
END
