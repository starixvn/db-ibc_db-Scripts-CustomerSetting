/*<info serverAlias="DBCUST-CustDB"></info>*/
 /*
	Created: 20201112@Eden
	Task: Delete un-used bettype (country) of Keno - clean data on tables :
		- ProductBetSetting
		- ProductGlobalSetting
								[Redmine:#145247]	
	DB: DBCUST/CustDB 
*/
USE CustDB
GO

DELETE ProductBetSetting WITH (ROWLOCK) 
WHERE Bettype  BETWEEN 1502 AND 1514 
	AND sporttype = 202

DELETE ProductGlobalSetting WITH (ROWLOCK) 
WHERE Sporttype = 202 
	AND Bettype  BETWEEN 1502 AND 1514