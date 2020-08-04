/*
	Created: 20200804@Elodie
	Task: Remove IDENTITY property from Exchangeid column
	DB: DBCUST/CustDB
*/
USE bodb02
GO

-- 8.Add new Primary Key.
CREATE NONCLUSTERED INDEX [IX_Exchange_IdActualRate] ON [dbo].[exchange]
(
	[exchangeid] ASC,
	[actualrate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 30) ON [DATA]
GO

