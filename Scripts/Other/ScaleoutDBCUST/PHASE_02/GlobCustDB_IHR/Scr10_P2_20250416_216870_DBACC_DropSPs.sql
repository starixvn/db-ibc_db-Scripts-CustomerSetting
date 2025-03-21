/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: 20250116@Tacy	
	Task: DROP SPs on DBACC
	DB: DBACC-bodb02
	
	Revisions:
		- 20250116@Tacy: Created [RedmineID: #216870]
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
USE bodb02
GO

DROP PROCEDURE IF EXISTS NAP_Domain_SiteMarket
GO

DROP PROCEDURE IF EXISTS NAP_Domain_SiteMarket_xpre
GO

DROP PROCEDURE IF EXISTS NAP_Domain_SiteMarket_xtest
GO

DROP PROCEDURE IF EXISTS NAP_Domain_SiteMarket_UAT1
GO

DROP PROCEDURE IF EXISTS NAP_Domain_SiteMarket_UAT2
GO

DROP PROCEDURE IF EXISTS NAP_Domain_SiteMarket_UAT3
GO

DROP PROCEDURE IF EXISTS NAP_Domain_SiteMarket_UAT4
GO
