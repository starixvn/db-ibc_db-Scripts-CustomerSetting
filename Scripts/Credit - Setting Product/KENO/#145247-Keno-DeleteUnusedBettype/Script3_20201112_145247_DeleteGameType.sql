/*<info serverAlias="DBPRO-bodb02"></info>*/
 /*
	Created: 20201112@Eden
	Task: Delete un-used bettype (country) of Keno - clean data on GameType table [Redmine:#145247]		
	DB: DBPRO/bodb02
*/
USE bodb02
GO
DELETE GameType WITH (ROWLOCK) 
WHERE GameTypeID BETWEEN 2 AND 14