/*
	Created: 20190515@Elodie
	Task: Add CS_CustomerStatus_History table 
	DB: DBTP/bodb_CustHistory
*/

USE bodb_CustHistory
GO

CREATE TABLE CS_CustomerStatus_History
(
	UpdateTime		DATETIME NOT NULL CONSTRAINT [DF_CS_CustomerStatus_History_UpdateTime]  DEFAULT (GETDATE()),
	CustId			INT NOT NULL,
	InactiveInfo	TINYINT NOT NULL,
	SuspendedInfo	TINYINT NOT NULL,
	ViewOnlyInfo	TINYINT NOT NULL,
) ON [Customer_table]
GO

CREATE CLUSTERED INDEX CS_CustomerStatus_His_Index ON CS_CustomerStatus_History
(
	UpdateTime DESC,
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Customer_table]
GO
