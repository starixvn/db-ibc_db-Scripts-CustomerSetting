/*<info serverAlias="DBPRO.bodb02"></info>*/
/*
	Created: Winfred
	Date: 20201204
	Task:  offer Site OddAdj  SIT  RedmineID:#142532
	DB: DBPRO.bodb02
*/
USE [bodb02]
GO


UPDATE LicSiteSetting WITH (ROWLOCK, UPDLOCK) 
SET ApplySpreadAdjustment = 1
WHERE SiteId  = 4200100
