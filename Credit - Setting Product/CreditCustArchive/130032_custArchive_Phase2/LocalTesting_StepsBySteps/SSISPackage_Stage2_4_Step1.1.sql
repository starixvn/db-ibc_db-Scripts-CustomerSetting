/*
	Created: 20200505@Helen
	Task: https://nexdev.net/issues/130032
	DB: DBACC.bodb_Report
*/
USE bodb_Report
GO
IF @@SERVERNAME NOT IN ('DB232','DB234')
	RETURN
	
TRUNCATE TABLE dbo.tmpCustArchived

INSERT INTO tmpCustArchived (Super, Master, Agent, MemCnt, recommend, IsFinished, ErrMsg)
SELECT Super, Master, Agent, MemCnt, recommend, IsFinished, ErrMsg
FROM dbcust.custdb.dbo.tmpCustArchived WITH (NOLOCK)




