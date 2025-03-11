/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: Tacy@20250305
	Task: in-house - Clean job [Redmine:#216870] 
	DB:	DBGLOB-GlobCustDB
*/
-------------------------------------------------------------------------------
--add data
USE GlobCustDB

INSERT INTO RepInfo_CleanData (DatabaseName,TableName,Version_Key, Unique_Key)
SELECT CASE WHEN DatabaseName='CustDB' THEN 'GlobCustDB' ELSE DatabaseName END
	, TableName, Version_Key, Unique_Key
FROM CustDB.dbo.RepInfo_CleanData WITH (NOLOCK)
WHERE TableName IN ('ProfilePicture')
GO

-------------------------------------------------------------------------------
-- disable job:
USE msdb ;  

EXEC dbo.sp_update_job  
    @job_name = N'RepInhouse - Clear data marked deleted',  
    @enabled = 0 ;  
GO

-------------------------------------------------------------------------------
-- delete data on CustDB
USE CustDB

DELETE FROM RepInfo_CleanData WITH (ROWLOCK)
WHERE TableName IN ('ProfilePicture')
GO

-------------------------------------------------------------------------------
-- enable job:
USE msdb ;  

EXEC dbo.sp_update_job  
    @job_name = N'RepInhouse - Clear data marked deleted',  
    @enabled = 1 ;  
GO
