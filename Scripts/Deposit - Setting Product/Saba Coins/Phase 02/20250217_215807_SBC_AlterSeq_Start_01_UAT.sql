/*<info serverAlias="DBGlob-GlobCustDB"></info>*/

/*
	Created: 20250217@Tacy  
	Task : alter Seq - start 1 - UAT [Redmine: #215807]
	DB:  DBGlob-GlobCustDB
*/
USE GlobCustDB
GO

ALTER SEQUENCE dbo.SeqUsername
	RESTART WITH 1
	INCREMENT BY 1 
	MINVALUE 1  
	MAXVALUE 100000; 