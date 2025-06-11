/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - Initial Data [223896]   
	DB: DBGLOB-GlobCustDB
*/

SET NOCOUNT ON;

IF EXISTS (SELECT TOP 2 dm.DomainID FROM DomainManagement dm WITH (NOLOCK) WHERE dm.Domain IN ('168933.net','7755778.net'))
BEGIN
	UPDATE dm
		SET OfferType = 1,
		RepUpdateTime = SYSDATETIME ()
	FROM DomainManagement dm WITH (ROWLOCK, UPDLOCK) 
	WHERE dm.Domain IN ('168933.net','7755778.net')
END