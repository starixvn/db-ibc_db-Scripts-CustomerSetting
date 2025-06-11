/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Initial Data [223896]   
	DB: DBGLOB-GlobCustDB
*/

UPDATE a
	SET a.OfferType = 1,
	RepUpdateTime = SYSDATETIME ()
FROM DomainManagement a WITH (ROWLOCK ,UPDLOCK)
WHERE DomainID IN (100,101)