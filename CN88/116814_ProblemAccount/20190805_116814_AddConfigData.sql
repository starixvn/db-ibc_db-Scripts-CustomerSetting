/*
	Created: 20190826@Elodie	
	Task: Add config
	DB: DBTXN/bodb02
*/
USE bodb02
GO

DECLARE @MaxID INT

SELECT @MaxID = MAX(Id) FROM TicketVoiding_VoidedTransaction WITH (NOLOCK)

INSERT INTO SystemSettings (VName, VValue)
VALUES ('ProblemAccount_MaxId', CAST(@MaxID AS VARCHAR(10)))