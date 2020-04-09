/*
	Created: 20200409@Eden
	Task: add column ReasonNameSC of table ProblemAccountReason [redmine:#131929]
	DB: DBCUST/CUSTDB and CustDB_CustSetting Publication
*/
USE CustDB
ALTER TABLE ProblemAccountReason ADD ReasonNameSC NVARCHAR(50)

