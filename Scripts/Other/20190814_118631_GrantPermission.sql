/*
Created: 20190814@Winnie
Task : NAP - UI did not show history of Virtual Rate with CN88 account.[Redmine: #118631]	
DB: DBLOG.bodb_CustomerLog_Archive
*/

USE bodb_CustomerLog_Archive
GO

GRANT SELECT ON CS_UserLog_RunSP TO bodbAdminNet;  
GO 

GRANT INSERT ON CS_UserLog_RunSP TO bodbAdminNet;  
GO 