/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service - [223896]   
	DB: DBCUST-CustDB
*/

-- Grant Permission view
GRANT SELECT ON [dbo].[Site]			TO wsv_CashService;
GRANT SELECT ON [dbo].[DomainManagement]  TO wsv_CashService;

GRANT SELECT ON [dbo].[Site]			TO asv_CashService;
GRANT SELECT ON [dbo].[DomainManagement]  TO asv_CashService; 
