/*
	Created: 20200303@Elodie	
	Task: initial data to archive log of new table log
	DB: DBLOG.bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

INSERT INTO dbo.Task_ArchiveData_TableList (TableName)
VALUES  ('VRCustLog')

--SELECT * FROM dbo.Task_ArchiveData_TableList WHERE TableName = 'VRCustLog'
