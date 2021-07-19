/*
	Created: 20200310@Eden
	Task: Create table CustQRCode to store members are created by QR code
	DB: DBCUST/CustDB and CustDB_DR_sync publication
*/
USE [CustDB]
GO
--DROP TABLE [dbo].[CustQRCode]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustQRCode](
	[CustID] [int] NOT NULL
 CONSTRAINT [PK_CustQRCode] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [DATA]
) ON [DATA]

GO



