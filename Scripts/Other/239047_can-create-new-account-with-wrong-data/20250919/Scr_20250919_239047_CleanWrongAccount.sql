/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250917@Eden
	Task : Delete accounts who incorrect data created during account registration [#239047]
	DB: DBCUST-CustDB
*/
USE CUSTDB
GO
EXEC dbo.DBA_Del_Member_IncludeHistory @CustIDList = '262876438,262876843';