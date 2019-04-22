/*
	Created: 20190422@Elodie
	Task: Add username2 column for CustSub
	DB: DBCUST/CustDB and all replicated server of CustDB_Customer_Info pub
*/

USE CustDB
GO

ALTER TABLE dbo.custSub ADD UserName2 VARCHAR(50) NULL
GO

--Create index on DBCUST.CustDB
CREATE NONCLUSTERED INDEX [IX_UserName2] ON [dbo].[custSub]
(
	[username2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_customer]
GO


