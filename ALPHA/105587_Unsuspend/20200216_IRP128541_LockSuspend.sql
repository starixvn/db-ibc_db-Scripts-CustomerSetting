/*
	Created: 20200216@Elodie
	Task: Add new table CustSuspendLockUpd and add CustDB_Customer_Info
	DB: DBCUST/CustDB
*/

USE CustDB
GO

CREATE TABLE CustSuspendLockUpd
(
	CustId		INT NOT NULL
CONSTRAINT [PK_CustSuspendLockUpd] PRIMARY KEY CLUSTERED 
(
	CustId ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
) ON [table_customer]
GO
