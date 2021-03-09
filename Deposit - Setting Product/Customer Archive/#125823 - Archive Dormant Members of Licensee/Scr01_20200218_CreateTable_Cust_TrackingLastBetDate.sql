/*
	Created: Eden
	Date: 20200218
	Task: Create table Cust_TrackingLastBetDate to keep lastest bet date [RM:#125823]
	DB: DBACC/bodb02, DBACC- Clone DB
*/
USE bodb02
GO
DROP TABLE Cust_TrackingLastBetDate
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cust_TrackingLastBetDate](
	[CustID] [int] NOT NULL,
	[LastBetDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [table_Customer]
) ON [table_Customer]

GO
CREATE NONCLUSTERED INDEX ix_Cust_TrackingLastBetDate_LastBetDate ON Cust_TrackingLastBetDate(LastBetDate) ON [table_Customer]
GO
