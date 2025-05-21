/*<info serverAlias="DBGlob-GlobCustDB"></info>*/

/*
	Created: 20250217@Tacy  
	Task : alter Seq - start Max_CustID - PROD [Redmine: #215807]
	DB:  DBGlob-GlobCustDB

	Revision:
		- 20250514@Tacy: New range min - max value
*/
USE GlobCustDB
GO

SELECT Max_CustID=MAX(CustID)
FROM CustInfoMini WITH (NOLOCK)
GO

ALTER SEQUENCE dbo.SeqUsername
	RESTART WITH xxx --REPLACE Max_CustID = 233849853
	INCREMENT BY 1 
	MINVALUE 233849853
	MAXVALUE 2147483647
; 