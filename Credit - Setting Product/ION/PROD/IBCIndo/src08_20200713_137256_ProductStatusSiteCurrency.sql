/*
	Created: 20200713@Elodie
	Task: Update ProductStatusSiteCurrency for ION [Redmine: 137256]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 225, @Bettype = 5601

DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype AND siteid = 487






