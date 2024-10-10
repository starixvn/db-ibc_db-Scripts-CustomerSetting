/*<info serverAlias="IRS_DBTP-bodb02"></info>*/
/*
	Created: 20241010@Helios
	Task: Scale out DBCUST - Enable RepInHouse [RedmineID: #206823]
	DB: IRS_DBTP-bodb02
*/
USE bodb02
GO
GRANT ALTER ON dbo.CustInfoMini TO [repl_ap];
GO
GRANT ALTER ON dbo.CustSubMini TO [repl_ap];
GO