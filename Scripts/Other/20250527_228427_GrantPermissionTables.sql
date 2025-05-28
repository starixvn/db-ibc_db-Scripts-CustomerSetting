/*<info serverAlias="DBGLOB-GLOBCUSTDB" executers="wsv_nap" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250527@Virgil
	Task: grant permission for 2 table CustSubMini, CustInfoMini
	DB: DBGLOB-GLOBCUSTDB
		
	Revisions:
		- 20250527@Virgil: NAP - Text to Username Enhancement - Add more rules [Redmine: #228427]
*/
USE [GlobCustDB];
GO

GRANT SELECT ON dbo.CustSubMini TO wsv_nap;
GRANT SELECT ON dbo.CustInfoMini TO wsv_nap;
GO