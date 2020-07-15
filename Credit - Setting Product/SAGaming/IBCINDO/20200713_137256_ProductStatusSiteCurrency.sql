/*
	Created: 20200713@Elodie
	Task: Update ProductStatusSiteCurrency for ION [Redmine: 137256]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT
SELECT @Sporttype = 244

UPDATE ps 
SET IsDisabled = 0
FROM ProductStatusSiteCurrency ps WITH (ROWLOCK) 
WHERE SportType = @Sporttype AND siteid = 487






