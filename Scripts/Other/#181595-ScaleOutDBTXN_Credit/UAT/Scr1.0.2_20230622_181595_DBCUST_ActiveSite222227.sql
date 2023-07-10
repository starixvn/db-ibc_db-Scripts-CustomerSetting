/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230622@Eden
	Task: Update Site.isActive, SiteLabel  - 222227 [RedmineID:#181595]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.isActive = 1, 
	s.SiteLabel = 'Nova88',
	s.RepUpdateTime = Sysdatetime()
FROM Site s WITH (ROWLOCK)
WHERE s.site = '222227'

/*
SELECT *
FROM Site s WITH (NOLOCK)
WHERE s.site = '222227'

*/






