/*
	Created: 20200611@Max
	Task: https://nexdev.net/issues/130032
	DB: DBSPARE.bodb_Report
*/
USE bodb_Report
GO
IF @@SERVERNAME NOT IN ('DBSPARE')
	RETURN
	
TRUNCATE TABLE dbo.tmpCustArchived

INSERT INTO tmpCustArchived (Super, Master, Agent, MemCnt, recommend, IsFinished, ErrMsg)
SELECT Super, Master, Agent, MemCnt, recommend, IsFinished, ErrMsg
FROM CustDB.dbo.tmpCustArchived WITH (NOLOCK)




