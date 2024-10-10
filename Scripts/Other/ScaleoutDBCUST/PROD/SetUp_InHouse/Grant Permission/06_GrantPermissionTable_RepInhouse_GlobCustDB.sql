/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20241010@Helios
	Task: Scale out DBCUST - Enable RepInHouse [RedmineID: #206823]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO
GRANT ALTER ON dbo.CustInfoMini TO [repl_ap];
GO
GRANT ALTER ON dbo.CustSubMini TO [repl_ap];
GO