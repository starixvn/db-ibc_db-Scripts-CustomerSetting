/*
	Created: 20190515@Elodie	
	Task: Add CS_CustomerStatus table 
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/
USE bodb_CustomerLog
GO

INSERT INTO dbo.Task_ArchiveData_TableList (TableName)
VALUES  ('CS_UserLog_Credit'), ('CS_UserLog_Login'), ('CS_UserLog_RunSP'), ('CS_UserLog_RunSP_MultiTarget'), ('CS_UserLog_RunSP_LogTarget')

--SELECT * FROM dbo.Task_ArchiveData_TableList WHERE TableName LIKE 'CS_UserLog%'

UPDATE lt 
SET lt.LogDate = mt.LogDate
FROM dbo.CS_UserLog_RunSP_LogTarget lt WITH (ROWLOCK)
	INNER JOIN dbo.CS_UserLog_RunSP_MultiTarget mt WITH (NOLOCK) ON mt.LogID = lt.LogID

