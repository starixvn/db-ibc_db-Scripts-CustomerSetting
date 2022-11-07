/*<info serverAlias="DBCTG-bodb02"></info>*/
/*
	Created: 20221107@Johnson
	Task: Migrate CWL balance data back to DBTXN from SiteDB1 [#RedmineID:#180033]
	DB: DBCTG/bodb02
*/

INSERT INTO [dbo].[Winlimit_CreditGame]
		   ([custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype])
SELECT [custid]
	   ,[winlostdate]
	   ,[Winlost]
	   ,[bettype]
FROM DBSIG.SiteDB01tmp.dbo.Winlimit_CreditGame_20221115 WITH(NOLOCK)

INSERT INTO [dbo].[Winlimit_DebitGame]
		   ([custid]
		   ,[winlostdate]
		   ,[Winlost]
		   ,[bettype])
SELECT [custid]
	   ,[winlostdate]
	   ,[Winlost]
	   ,[bettype]
FROM DBSIG.SiteDB01tmp.dbo.Winlimit_DebitGame_20221115 WITH(NOLOCK)
	   