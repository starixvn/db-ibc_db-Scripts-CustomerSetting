/*<info serverAlias="DBGlob-GlobCustDB"></info>*/

/*
	Created: 20250505@Tacy  
	Task : alter Seq - start 43915 - UAT [Redmine: #215807]
	DB:  DBGlob-GlobCustDB

	*** Cause: Before generating Username's Shadow with RealCustID format, usernames were generated using [f_LAS_GenerateUsername]. 
	When we used a sequence range of [1; 100k], duplicate usernames were generated starting from number 100.
*/
USE GlobCustDB
GO

ALTER SEQUENCE dbo.SeqUsername
	RESTART WITH 43915
	INCREMENT BY 1 
	MINVALUE 43915  
	MAXVALUE 100000; 