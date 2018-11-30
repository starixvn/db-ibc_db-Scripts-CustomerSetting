/*
	Created: 20181122@Elodie
	Task: Rename unused SP
	DB: DB053
*/

IF @@SERVERNAME NOT IN ('DB053','DB215\SQLSERVER2008R2','DB231\SQLSERVER2008R2') RETURN

USE bodb02
GO

EXEC sp_rename 'Acc_CustomerUpdUserSearch', 'DEL_Acc_CustomerUpdUserSearch'


