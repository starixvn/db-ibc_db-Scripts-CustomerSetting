/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230328@Tacy
	Task : Add new column [FuncID] on tb [CustFeedback]
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

ALTER TABLE CustFeedback ADD FuncID INT NULL;

CREATE NONCLUSTERED INDEX IX_CustFeedback_FuncID ON CustFeedback (CustID, FuncID, CreatedDate)