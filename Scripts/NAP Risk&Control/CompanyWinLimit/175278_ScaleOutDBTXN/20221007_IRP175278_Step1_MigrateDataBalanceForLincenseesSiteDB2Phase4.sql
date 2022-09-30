/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20221007@Johnson
	Task: Migrate data for balance game tables for SITEDB2 to scale out DBTXN for CWL phase 4 [#RedmineID:#175278]
	DB: DBSIG/bodb02 (sitedb2)
*/
IF NOT EXISTS (SELECT TOP (1) 1 FROM DBCTG.bodb02.dbo.BalancePendingCreditGame WITH(NOLOCK))
	AND NOT EXISTS (SELECT TOP (1) 1 FROM DBCTG.bodb02.dbo.BalancePendingDebitGame WITH(NOLOCK))
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
	FROM DBCTG.SiteDB2tmp.dbo.Winlimit_CreditGame_20221013 WITH(NOLOCK)
	
	INSERT INTO [dbo].[Winlimit_DebitGame]
			   ([custid]
			   ,[winlostdate]
			   ,[Winlost]
			   ,[bettype])
	SELECT [custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype]
	FROM DBCTG.SiteDB2tmp.dbo.Winlimit_DebitGame_20221013 WITH(NOLOCK)

END		   