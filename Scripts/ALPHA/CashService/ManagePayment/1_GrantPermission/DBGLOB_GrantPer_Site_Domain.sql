/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]  
	DB: DBGLOB-GlobCustDB
*/

-- Grant Permission table
GRANT SELECT ON [dbo].[Site]			TO wsv_CashService;
GRANT SELECT ON [dbo].[DomainManagement]  TO wsv_CashService;