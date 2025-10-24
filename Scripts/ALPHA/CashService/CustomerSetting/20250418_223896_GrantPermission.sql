/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250415@Elodie
	Task: Alpha - Agency Cash Service - grant permission [#223896] 
	DB: DBGLOB/GlobCustDB 
*/
USE GlobCustDB
GO
GRANT SELECT ON StakeLevel TO asv_CashService

USE CustDB
GO
GRANT SELECT ON Age_CustSeq TO asv_CashService

USE CustDB_History
GO

GRANT INSERT TO asv_CashService;
GRANT INSERT TO wsv_CashService;
