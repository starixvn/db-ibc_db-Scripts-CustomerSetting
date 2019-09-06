/*
	Created: 20190906@Alvin
	Task: Update LogActionType for Problem Account Update Review Status
	DB: DBLOG/bodb_CustomerLog
*/

USE [bodb_CustomerLog]
GO

UPDATE LogAction set ActionTypeID = 4 WHERE ActionID IN (31608, 31609, 31610)
