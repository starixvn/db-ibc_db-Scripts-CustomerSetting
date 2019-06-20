/*
	Created: 20190515@Elodie	
	Task: Add CS_CustomerStatus table 
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/
USE bodb_CustomerLog
GO

INSERT INTO dbo.Task_ArchiveData_TableList (TableName)
VALUES  ('CS_UserLog_Credit'), ('CS_UserLog_Login'), ('CS_UserLog_RunSP'), ('CS_UserLog_RunSP_MultiTarget')


SELECT * FROM dbo.Task_ArchiveData_TableList
