/*
	Created: 20200728@Elodie
	Task: update ActionTypeId for Keno
	DB: DBLOG/bodb_CustomerLog
*/
USE bodb_CustomerLog
GO

UPDATE LogAction
SET ActionTypeID = 1
WHERE ActionID between 442 AND 447

UPDATE LogAction
SET ActionTypeID = 1
WHERE ActionID = 506

UPDATE LogAction
SET ActionTypeID = 3
WHERE ActionID between 379 AND 382

UPDATE LogAction
SET ActionTypeID = 2
WHERE ActionID between 233 AND 236