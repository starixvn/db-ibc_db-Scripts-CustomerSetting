/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211214@Johnson
	Task: rename dummy accounts
	DB: DBCust/CustDB
*/
exec Acc_CustomerUpdUserName @oldname = 'SupertestAthena00020102	', @newname = 'STAthena00020102'
exec Acc_CustomerUpdUserName @oldname = 'SuperTestAthena00120101	', @newname = 'STAthena00120101'