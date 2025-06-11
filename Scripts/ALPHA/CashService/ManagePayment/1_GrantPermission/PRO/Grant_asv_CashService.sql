/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - GRANT PERMISSION [asv_CashService]  [223896]  
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB

GRANT SELECT ON dbo.DomainManagement TO asv_CashService;
GRANT SELECT ON dbo.Site TO asv_CashService;
 