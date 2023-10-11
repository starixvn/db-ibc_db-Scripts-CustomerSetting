/*<info serverAlias="DBEXT-bodb02,DBBOF-bodb02"></info>*/
/*
	Created by: Tacy@20230822
	Task: Remove Dep_CustBonusSharing on db05x (02-05)  [Redmine:#186192] 
	DB:	DBEXT-bodb02,DBBOF-bodb02
*/
USE bodb02
GO

--STOP
UPDATE RepInfo WITH (ROWLOCK, UPDLOCK)
SET active=0
WHERE [name]='Dep_CustBonusSharing'
GO

--Drop SP    
IF EXISTS(SELECT 1 FROM sys.objects 
		  WHERE type = 'P' AND name = 'Repl_PutDep_CustBonusSharing')
BEGIN
	DROP PROCEDURE Repl_PutDep_CustBonusSharing;
END

--Drop TVP
IF EXISTS(SELECT 1 FROM sys.types 
		  WHERE name = 'TVP_ReplDep_CustBonusSharing' 
		  AND is_table_type = 1 AND schema_id = SCHEMA_ID('dbo'))
BEGIN
	DROP TYPE [dbo].[TVP_ReplDep_CustBonusSharing];
END

--Delete RepInfo Setting:
DELETE FROM RepInfo WITH (ROWLOCK)
WHERE [name]='Dep_CustBonusSharing'

--Drop table:
DROP TABLE Dep_CustBonusSharing;
GO