/*<info serverAlias="DBLOG-bodb02"></info>*/
/*
	Created: 20250804@Helios
	Task: View Log - Agency Cash Service - [Redmine: #233474]  
	DB: DBLOG-bodb02
*/

USE bodb02
GO

--Other tables: Customer , custinfo
GRANT SELECT ON [dbo].Customer TO wsv_CashService;  
GRANT SELECT ON [dbo].custinfo TO wsv_CashService;
