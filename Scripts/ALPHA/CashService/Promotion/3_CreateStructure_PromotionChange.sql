/*<info serverAlias="DBSIC-bodb02"></info>*/
/*
	Created: 20250725@Elodie
	Task: Alpha - Agency Cash Service - Caculate bonus - [232347]  
	DB: DBSIC-bodb02
*/
USE bodb02
GO

IF OBJECT_ID('CashTransactionError', 'U') IS NOT NULL
BEGIN
    DROP TABLE CashTransactionError
END

CREATE TABLE CashTransactionError (
	LogId BIGINT IDENTITY(1,1),
	CustId INT NOT NULL,
	TransactionTypeID TINYINT NOT NULL,
	StatusId TINYINT NOT NULL,
	Amount MONEY,
	CreatedTime DATE NOT NULL,
	Creator INT NOT NULL,
	SiteDBGroupID TINYINT NOT NULL,
	ExtraInfo NVARCHAR(1000),
	PromotionID INT NOT NULL,
	CONSTRAINT PK_CashTransactionError PRIMARY KEY NONCLUSTERED (LogId)
);

-- Tạo clustered index trên CustId và TransactionTypeID
CREATE CLUSTERED INDEX CIX_CashTransactionError
ON CashTransactionError (CreatedTime, CustId, TransactionTypeID)
