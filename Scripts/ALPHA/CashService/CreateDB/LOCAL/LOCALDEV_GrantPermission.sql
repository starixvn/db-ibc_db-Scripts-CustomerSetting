/*<info serverAlias="DBCUST-AgencyCashService"></info>*/
/*
	Created: 20250417@Helios
	Task: Alpha - Agency Cash Service -  Create new DATABASE  AgencyCashService  [223896]  
	DB: DBCUST/CustDB
*/


USE AgencyCashService
GO
--grant permission for web accounts
CREATE USER [asv_CashService] FOR LOGIN [asv_CashService] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO asv_CashService
GO

CREATE USER [wsv_CashService] FOR LOGIN [wsv_CashService] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT TO wsv_CashService
GO
